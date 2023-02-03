# An Overview of COVID Cases and Vaccinations Around the World From 2/2020 - 1/2023

# Introduction
It's been 3 years since the COVID Pandemic occured. Finally, we have a more  complete picture of the spread, a better understanding of what happened and how the world handled the situation. Let's dig in the statistics of the COVID Cases and Vaccinations Program Around The World from OurWorldInData.org.

We need to acknowledge that these data is only as good as the source that provided them. If countries didn't not provide the data or manipulate them, then we would not be able to give the correct insights. 

# Insights
Overall, around the world, there were 
- 666,545,568 case reported 
- 6,697,002 deaths
- 1% avg. death per case. 

This showed that COVID had very low death rates compared to other pandemics happened prior such as SARS (2002) 15%, MERS(2012) 34%, H5N1/H7N9 (2005, 2006) 40-60% [Source](https://www.news-medical.net/health/How-does-the-COVID-19-Pandemic-Compare-to-Other-Pandemics.aspx#:~:text=The%20global%20case%20rates%20and,estimates%20due%20to%20ongoing%20pandemic).  This is a cool statistic of pandemic and logics that HIGH death rates means LOW spreads and vice versa.



Europian cities and countries had the highest infection percentage in population led by Cyprus, San Marino (Italy), and Austria. This high infection percentage was caused by `herd immunity` strategy by these EU countries. This seem like a good strategy because over 70% of the population was infected while only less than 3% deaths.

USA, Brazil, India, Russia, and Mexico were the top five countries that had the highest deaths. China was ranked the 89th in deaths with only ~5,000 deaths which were highly un-correlated to India which had a similar population. China stopped sharing the data with other countries so this could explained why. In reality, China should be in the top 5 deaths along with others. 

For deaths by continent:
1. North America	1,103,681
2. South America	  695,615
3. Asia	              530,728
4. Europe	          386,626
5. Africa	          102,568
6. Oceania	           18,023

In reality, China and India combined should have higher deaths in Asia than North America
# Citation
Use this bibtex to cite this repository:

```
@misc{thai22011_covid_analysis,
  title={An Overview of COVID Cases and Vaccinations Around the World From 2/2020 - 1/2023},
  author={Thai Nguyen},
  year={2022},
  publisher={Github},
  journal={GitHub repository},
  howpublished={\url{https://github.com/thai22011/covid_analysis}},
}
```
# Requirements
The project used `Microsoft SQL Server 2022` and `Microsoft SQL Server Management Studio`. If you use those 2, you can download the `.xlx` file from OurWorldInData.org. SSMS helped load the dataset instantly while it took MySQL a long time to load.

If you use other RDMS like MySQL or PostgreSQL, you may need to download the `.csv` file. 

