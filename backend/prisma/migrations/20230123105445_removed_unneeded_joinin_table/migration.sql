/*
  Warnings:

  - You are about to drop the `collection_element` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "collection_element" DROP CONSTRAINT "collection_element_collection_id_fkey";

-- DropForeignKey
ALTER TABLE "collection_element" DROP CONSTRAINT "collection_element_elementId_fkey";

-- DropTable
DROP TABLE "collection_element";

-- CreateTable
CREATE TABLE "_CollectionToElement" (
    "A" VARCHAR(256) NOT NULL,
    "B" VARCHAR(256) NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_CollectionToElement_AB_unique" ON "_CollectionToElement"("A", "B");

-- CreateIndex
CREATE INDEX "_CollectionToElement_B_index" ON "_CollectionToElement"("B");

-- AddForeignKey
ALTER TABLE "_CollectionToElement" ADD CONSTRAINT "_CollectionToElement_A_fkey" FOREIGN KEY ("A") REFERENCES "collection"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CollectionToElement" ADD CONSTRAINT "_CollectionToElement_B_fkey" FOREIGN KEY ("B") REFERENCES "element"("id") ON DELETE CASCADE ON UPDATE CASCADE;
