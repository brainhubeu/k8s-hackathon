import {MigrationInterface, QueryRunner} from "typeorm";

export class InitialMigration1600356350318 implements MigrationInterface {
    name = 'InitialMigration1600356350318'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "user" ("id" SERIAL NOT NULL, "username" character varying NOT NULL, "email" character varying NOT NULL, "bio" character varying NOT NULL DEFAULT '', "image" character varying NOT NULL DEFAULT '', CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY ("id"))`, undefined);
        await queryRunner.query(`CREATE TABLE "comment" ("id" SERIAL NOT NULL, "body" character varying NOT NULL, "article_id" integer, CONSTRAINT "PK_0b0e4bbc8415ec426f87f3a88e2" PRIMARY KEY ("id"))`, undefined);
        await queryRunner.query(`CREATE TABLE "article" ("id" SERIAL NOT NULL, "slug" character varying NOT NULL, "title" character varying NOT NULL, "description" character varying NOT NULL DEFAULT '', "body" character varying NOT NULL DEFAULT '', "created" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, "updated" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, "tag_list" text NOT NULL, "favorite_count" integer NOT NULL DEFAULT 0, "author_id" integer, CONSTRAINT "PK_40808690eb7b915046558c0f81b" PRIMARY KEY ("id"))`, undefined);
        await queryRunner.query(`CREATE TABLE "follows" ("id" SERIAL NOT NULL, "follower_id" integer NOT NULL, "following_id" integer NOT NULL, CONSTRAINT "PK_8988f607744e16ff79da3b8a627" PRIMARY KEY ("id"))`, undefined);
        await queryRunner.query(`CREATE TABLE "tag" ("id" SERIAL NOT NULL, "tag" character varying NOT NULL, CONSTRAINT "PK_8e4052373c579afc1471f526760" PRIMARY KEY ("id"))`, undefined);
        await queryRunner.query(`CREATE TABLE "user_favorites_article" ("user_id" integer NOT NULL, "article_id" integer NOT NULL, CONSTRAINT "PK_b75ce2ec659c899063699ccd53c" PRIMARY KEY ("user_id", "article_id"))`, undefined);
        await queryRunner.query(`CREATE INDEX "IDX_ab24b5af3df3b3d90c9f137cd5" ON "user_favorites_article" ("user_id") `, undefined);
        await queryRunner.query(`CREATE INDEX "IDX_6785d865ca00e3c8baaac56e18" ON "user_favorites_article" ("article_id") `, undefined);
        await queryRunner.query(`ALTER TABLE "comment" ADD CONSTRAINT "FK_03a590c26b0910b0bb49682b1e3" FOREIGN KEY ("article_id") REFERENCES "article"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`, undefined);
        await queryRunner.query(`ALTER TABLE "article" ADD CONSTRAINT "FK_16d4ce4c84bd9b8562c6f396262" FOREIGN KEY ("author_id") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`, undefined);
        await queryRunner.query(`ALTER TABLE "user_favorites_article" ADD CONSTRAINT "FK_ab24b5af3df3b3d90c9f137cd5c" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE NO ACTION`, undefined);
        await queryRunner.query(`ALTER TABLE "user_favorites_article" ADD CONSTRAINT "FK_6785d865ca00e3c8baaac56e188" FOREIGN KEY ("article_id") REFERENCES "article"("id") ON DELETE CASCADE ON UPDATE NO ACTION`, undefined);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "user_favorites_article" DROP CONSTRAINT "FK_6785d865ca00e3c8baaac56e188"`, undefined);
        await queryRunner.query(`ALTER TABLE "user_favorites_article" DROP CONSTRAINT "FK_ab24b5af3df3b3d90c9f137cd5c"`, undefined);
        await queryRunner.query(`ALTER TABLE "article" DROP CONSTRAINT "FK_16d4ce4c84bd9b8562c6f396262"`, undefined);
        await queryRunner.query(`ALTER TABLE "comment" DROP CONSTRAINT "FK_03a590c26b0910b0bb49682b1e3"`, undefined);
        await queryRunner.query(`DROP INDEX "IDX_6785d865ca00e3c8baaac56e18"`, undefined);
        await queryRunner.query(`DROP INDEX "IDX_ab24b5af3df3b3d90c9f137cd5"`, undefined);
        await queryRunner.query(`DROP TABLE "user_favorites_article"`, undefined);
        await queryRunner.query(`DROP TABLE "tag"`, undefined);
        await queryRunner.query(`DROP TABLE "follows"`, undefined);
        await queryRunner.query(`DROP TABLE "article"`, undefined);
        await queryRunner.query(`DROP TABLE "comment"`, undefined);
        await queryRunner.query(`DROP TABLE "user"`, undefined);
    }

}
