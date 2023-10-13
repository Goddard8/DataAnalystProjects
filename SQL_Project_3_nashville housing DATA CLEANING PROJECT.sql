-- Cleaning Data in SQL Queries
Standardize Date Format
Select saleDateConverted, convert(Date,SaleDate)
From nashvillehousing

Update nashvillehousing
set SaleDate = convert(Date,SaleDate)

Alter Table nashvillehousing
Add SaleDateConverted Date;

Update nashvillehousing
add SaleDateConverted Date; 

Populate Property Address Data
select *
from nashvillehousing
where PropertyAddress is null
order by ParcelID;

Select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
From nashvillehousing a
join nashvillehousing b
	on a.ParcelID = b.ParcelID
    and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null;

Update a
set	ProperyAddress = isnull(a.PropertyAddress,b.PropertyAddress)
From nashvillehousing a
join nashvillehousing b
	on a.ParcelID = b.ParcelID
    and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null;

-- Breaking out address into individual columns (Address, City, State)

Select PropertyAddress
from nashvillehousing;
-- order by ParcelID

Select 
substring(PropertyAddress,1,locate(',',PropertyAddress)-1) as Address 
,substring(PropertyAddress,locate(',',PropertyAddress)+1,length(PropertyAddress)) as Address 
from nashvillehousing;


ALTER TABLE nashvillehousing
ADD PropertySplitCity VARCHAR(255);

UPDATE nashvillehousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1);

ALTER TABLE nashvillehousing
ADD PropertySplitAddress VARCHAR(255);

UPDATE nashvillehousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1);

select PropertySplitCity,PropertySplitAddress
from nashvillehousing;

-- Breaking out  Owner address into individual columns (Address, City , State)
select OwnerAddress
from nashvillehousing;

-- another syntax for separating addresses

SELECT
    SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 1), ',', -1), -- for address
    SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1), -- for City
    SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 3), ',', -1)  -- for state
FROM
    nashvillehousing;

-- creating another column for the corresponding new address , city and state
ALTER TABLE nashvillehousing
ADD OwnerSplitAddress VARCHAR(255);

UPDATE nashvillehousing
SET OwnerSplitAddress =SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 1), ',', -1);

ALTER TABLE nashvillehousing
ADD OwnerSplitCity VARCHAR(255);

UPDATE nashvillehousing
SET OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1);

ALTER TABLE nashvillehousing
ADD OwnerSplitState VARCHAR(255);

UPDATE nashvillehousing
SET OwnerSplitState = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 3), ',', -1);

select OwnerSplitAddress,OwnerSplitCity,OwnerSplitState
from nashvillehousing;

select *
from nashvillehousing;

-- CHANGING Y AND N TO YES AND NO in "SOLD AS VACANT" FIELD

select distinct (SoldAsVacant), count(SoldAsVacant)
from nashvillehousing
group by SoldAsVacant
order by 2;

select SoldAsVacant
, case when SoldAsVacant = 'Y' then 'Yes'
	   when SoldAsVacant = 'N' then 'No'
       else SoldAsVacant
       end
from nashvillehousing;

UPDATE nashvillehousing
SET SoldAsVacant = CASE 
    WHEN SoldAsVacant = 'Y' THEN 'Yes'
    WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant
END;

SELECT DISTINCT SoldAsVacant, COUNT(SoldAsVacant)
FROM nashvillehousing
GROUP BY SoldAsVacant
ORDER BY 2;

#### Remove Duplicates
WITH RowNumCte AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY ParcelID,
                         PropertyAddress,
                         SalePrice,
                         SaleDate,
                         LegalReference
            ORDER BY UniqueID
        ) AS row_num
    FROM nashvillehousing
)
DELETE *
FROM RowNumCte
WHERE row_num > 1
# ORDER BY PropertyAddress;

## Delete unused columns

select * 
from nashvillehousing;

alter table nashvillehousing
drop column OwnerAddress,TaxDistrict,PropertyAddress;

alter table nashvillehousing
drop column SaleDate;

#### END ####
#### P.C DOLOR ####