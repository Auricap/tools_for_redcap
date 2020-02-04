# tools_for_redcap
Includes different pieces of code to use with Redcap (external modules, hooks, etc.)
# Translations
The file translations_vx.R includes a function that can be run in R to create a data dictionnary for the Multilingual External Module in Redcap.
The principle is the following:
One creates the project in Redcap in the main language -for instance, english- and then downloads the data dictionnary (or creates the data dictionnary directly). Then one needs to copy this file as many times as desired languages and translate the columns "Field Label" (questions) and "Choices, Calculations, OR Slider Labels" (answers). One should save these files in the csv (Comme Separated Variable) format. Once this is done, one is ready to call the function "translate_multilingual()" that will take all the translations in the created files and combine them to generate the power tags necessary to add the translations in the redcap interface through the Multilingual External Module.
## Prerequisites
- Install the Multilingual External Module in Redcap
- Have the csv files (copies of the original data dictionnary) containing the translations
## Instructions
1. Open translations_vx.R in R and check the box "source on save" and save the file. This will load the function into the workspace.
2. Call the function: 
> translate_multilingual()
3. The function will ask you to enter the path to the files you want to append. You can copy/paste it from the explorer. All characters "\" will be replaced by "/" automatically by the function.
4. The function will then ask the list of languages to translate separated by spaces. This could be for instance:
> Greek English German
5. Then the function will ask for the files containing the translations for each one of these languages. One file name will be asked at a time. For instance: 
> Language "Greek"Enter file name with extension:

And one should enter the csv file name with its extension:

> mygreekdatadic.csv

6. The function will generate the data dictionnary in the same path as the one set as input. It will call it "translations_date.csv"
7. Upload this file to Redcap
## Note
As the Multilingual External Module is not able to translate headers and matrix headers, the function will create a single string containing the name of the language set in step 4 and then the header translation. This will be done for all languages set in step 4. For instance, if the user set "FR EN ES" in step 4, the result of one example header will be:
Header:
FR: titre en français
EN: english title
ES: titulo en español 
