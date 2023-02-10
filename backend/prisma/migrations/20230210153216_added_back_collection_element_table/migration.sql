/*
  Warnings:

  - You are about to drop the `_CollectionToElement` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_CollectionToElement" DROP CONSTRAINT "_CollectionToElement_A_fkey";

-- DropForeignKey
ALTER TABLE "_CollectionToElement" DROP CONSTRAINT "_CollectionToElement_B_fkey";

-- DropTable
DROP TABLE "_CollectionToElement";

-- CreateTable
CREATE TABLE "collection_element" (
    "id" VARCHAR(256) NOT NULL,
    "collection_id" TEXT NOT NULL,
    "element_id" TEXT NOT NULL,
    "position" TEXT NOT NULL,

    CONSTRAINT "collection_element_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "collection_element" ADD CONSTRAINT "collection_element_collection_id_fkey" FOREIGN KEY ("collection_id") REFERENCES "collection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "collection_element" ADD CONSTRAINT "collection_element_element_id_fkey" FOREIGN KEY ("element_id") REFERENCES "element"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
