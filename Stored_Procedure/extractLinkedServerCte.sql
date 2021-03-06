use [DatabaseName]
go

-- Set ansi nulls
set ansi_nulls on
go

-- Set quoted identifier
set quoted_identifier on
go

-- ======================================
--        File: extractLinkedServerCte
--     Created: 08/06/2020
--     Updated: 08/06/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Extract linked server cte
-- ======================================
alter procedure [dbo].[extractLinkedServerCte]
  -- Parameters
  @optionMode as nvarchar(255)
as
begin
  -- Set nocount on added to prevent extra result sets from interfering with select statements
  set nocount on

  -- Omit characters
  set @optionMode = dbo.OmitCharacters(@optionMode, '48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122')

  -- Check if empty string
  if @optionMode = ''
    begin
      -- Set parameter to null if empty string
      set @optionMode = nullif(@optionMode, '')
    end

  -- Check if option mode is select linked server entries
  if @optionMode = 'extractLinkedServerEntries'
    begin
      -- Store records in CTE
      ; with linkedServerData as
      (
        -- Select records
        select
        ls.serialNumber as [serialNumber],
        ls.serialNumberTwo as [serialNumberTwo],
        ls.partNumber as [partNumber],
        ls.datetimeValue as [datetimeValue]
        from openquery
        (
          -- Select linked server records
          "LinkedServerName",
          'select
          serialNumber as serialNumber,
          serialNumberTwo as serialNumberTwo,
          partNumber as partNumber,
          datetimeValue as datetimeValue,
          from public.linkedServerView
          where
          esn is not null and
          (
            trim(serialNumberTwo) ~ ''^([0-9])+$'' or
            trim(serialNumberTwo) ~* ''^([a|A])([0-9]+)$''
          ) and
          trim(partNumber) ~ ''^([0-9])+$'''
        ) ls
      )

      -- Select records
      select
      cast(lsd.serialNumber as bigint) as [Serial Number],
      iif(ltrim(rtrim(lsd.serialNumberTwo)) = '', null, ltrim(rtrim(lsd.serialNumberTwo))) as [Serial Number Two],
      iif(ltrim(rtrim(lsd.partNumber)) = '', null, ltrim(rtrim(lsd.partNumber))) as [Part Number],
      iif(ltrim(rtrim(lsd.datetimeValue)) = '', null, cast(lsd.datetimeValue as datetime2(7))) as [Date Time Value]
      from linkedServerData lsd
    end
end