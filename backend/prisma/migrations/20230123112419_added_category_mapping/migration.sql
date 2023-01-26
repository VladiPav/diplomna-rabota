/*
  Warnings:

  - You are about to drop the `Category` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "collection" DROP CONSTRAINT "collection_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "element" DROP CONSTRAINT "element_category_id_fkey";

-- DropTable
DROP TABLE "Category";

-- CreateTable
CREATE TABLE "category" (
    "id" VARCHAR(256) NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "collection" ADD CONSTRAINT "collection_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "element" ADD CONSTRAINT "element_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
