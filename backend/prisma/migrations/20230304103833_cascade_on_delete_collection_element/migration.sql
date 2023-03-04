-- DropForeignKey
ALTER TABLE "collection_element" DROP CONSTRAINT "collection_element_collection_id_fkey";

-- AddForeignKey
ALTER TABLE "collection_element" ADD CONSTRAINT "collection_element_collection_id_fkey" FOREIGN KEY ("collection_id") REFERENCES "collection"("id") ON DELETE CASCADE ON UPDATE CASCADE;
