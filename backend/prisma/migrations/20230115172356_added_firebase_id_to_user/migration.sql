/*
  Warnings:

  - You are about to drop the column `collectionId` on the `collection_element` table. All the data in the column will be lost.
  - You are about to drop the column `categoryId` on the `element` table. All the data in the column will be lost.
  - You are about to drop the column `followedId` on the `relationship` table. All the data in the column will be lost.
  - You are about to drop the column `followerId` on the `relationship` table. All the data in the column will be lost.
  - Added the required column `collection_id` to the `collection_element` table without a default value. This is not possible if the table is not empty.
  - Added the required column `category_id` to the `element` table without a default value. This is not possible if the table is not empty.
  - Added the required column `followed_id` to the `relationship` table without a default value. This is not possible if the table is not empty.
  - Added the required column `follower_id` to the `relationship` table without a default value. This is not possible if the table is not empty.
  - Added the required column `firebase_id` to the `user` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "collection_element" DROP CONSTRAINT "collection_element_collectionId_fkey";

-- DropForeignKey
ALTER TABLE "element" DROP CONSTRAINT "element_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "relationship" DROP CONSTRAINT "relationship_followedId_fkey";

-- DropForeignKey
ALTER TABLE "relationship" DROP CONSTRAINT "relationship_followerId_fkey";

-- AlterTable
ALTER TABLE "collection_element" DROP COLUMN "collectionId",
ADD COLUMN     "collection_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "element" DROP COLUMN "categoryId",
ADD COLUMN     "category_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "relationship" DROP COLUMN "followedId",
DROP COLUMN "followerId",
ADD COLUMN     "followed_id" TEXT NOT NULL,
ADD COLUMN     "follower_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "user" ADD COLUMN     "firebase_id" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "element" ADD CONSTRAINT "element_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "collection_element" ADD CONSTRAINT "collection_element_collection_id_fkey" FOREIGN KEY ("collection_id") REFERENCES "collection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "relationship" ADD CONSTRAINT "relationship_follower_id_fkey" FOREIGN KEY ("follower_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "relationship" ADD CONSTRAINT "relationship_followed_id_fkey" FOREIGN KEY ("followed_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
