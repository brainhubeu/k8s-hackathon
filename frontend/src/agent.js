import superagentPromise from 'superagent-promise';
import _superagent from 'superagent';
import { contentApiUrl, usersApiUrl } from './config'

const superagent = superagentPromise(_superagent, global.Promise);

const encode = encodeURIComponent;
const responseBody = res => res.body;

let token = null;
const tokenPlugin = req => {
  if (token) {
    req.set('authorization', `Bearer ${token}`);
  }
}

const contentApi = {
  del: url =>
    superagent.del(`${contentApiUrl}${url}`).use(tokenPlugin).then(responseBody),
  get: url =>
    superagent.get(`${contentApiUrl}${url}`).use(tokenPlugin).then(responseBody),
  put: (url, body) =>
    superagent.put(`${contentApiUrl}${url}`, body).use(tokenPlugin).then(responseBody),
  post: (url, body) =>
    superagent.post(`${contentApiUrl}${url}`, body).use(tokenPlugin).then(responseBody)
};

const usersApi = {
  post: (url, body) =>
      superagent.post(`${usersApiUrl}${url}`, body).use(tokenPlugin).then(responseBody)
};

const Auth = {
  current: () =>
      contentApi.get('/user'),
  register: (username, email, password) =>
      usersApi.post('/users', { user: { username, email, password } }),
  save: user =>
      contentApi.put('/user', { user })
};

const Tags = {
  getAll: () => contentApi.get('/tags')
};

const limit = (count, p) => `limit=${count}&offset=${p ? p * count : 0}`;
const omitSlug = article => Object.assign({}, article, { slug: undefined })
const Articles = {
  all: page =>
    contentApi.get(`/articles?${limit(10, page)}`),
  byAuthor: (author, page) =>
    contentApi.get(`/articles?author=${encode(author)}&${limit(5, page)}`),
  byTag: (tag, page) =>
    contentApi.get(`/articles?tag=${encode(tag)}&${limit(10, page)}`),
  del: slug =>
    contentApi.del(`/articles/${slug}`),
  favorite: slug =>
    contentApi.post(`/articles/${slug}/favorite`),
  favoritedBy: (author, page) =>
    contentApi.get(`/articles?favorited=${encode(author)}&${limit(5, page)}`),
  feed: () =>
    contentApi.get('/articles/feed?limit=10&offset=0'),
  get: slug =>
    contentApi.get(`/articles/${slug}`),
  unfavorite: slug =>
    contentApi.del(`/articles/${slug}/favorite`),
  update: article =>
    contentApi.put(`/articles/${article.slug}`, { article: omitSlug(article) }),
  create: article =>
    contentApi.post('/articles', { article })
};

const Comments = {
  create: (slug, comment) =>
    contentApi.post(`/articles/${slug}/comments`, { comment }),
  delete: (slug, commentId) =>
    contentApi.del(`/articles/${slug}/comments/${commentId}`),
  forArticle: slug =>
    contentApi.get(`/articles/${slug}/comments`)
};

const Profile = {
  follow: username =>
    contentApi.post(`/profiles/${username}/follow`),
  get: username =>
    contentApi.get(`/profiles/${username}`),
  unfollow: username =>
    contentApi.del(`/profiles/${username}/follow`)
};

export default {
  Articles,
  Auth,
  Comments,
  Profile,
  Tags,
  setToken: _token => { token = _token; }
};
