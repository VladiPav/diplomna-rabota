/*
  Warnings:

  - The primary key for the `collection_element` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `collection_element` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[collection_id,element_id]` on the table `collection_element` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "collection_element" DROP CONSTRAINT "collection_element_pkey",
DROP COLUMN "id";

-- CreateIndex
CREATE UNIQUE INDEX "collection_element_collection_id_element_id_key" ON "collection_element"("collection_id", "element_id");
