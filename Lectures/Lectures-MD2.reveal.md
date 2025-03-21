---
title: EMSC 2022 11.2
separator: '<--o-->  '
verticalSeparator: '<--v-->'
revealOptions:
#    transition: 'fade'

    slideNumber: true
    width:  1100
    height: 750
    margin: 0.07
---

# EMSC 2022

## Mantle convection and plate motions (ii)

  - Louis Moresi, Australian National University

![Globe](images/AuWorldEQ.png) <!-- .element style="float: right; width:30%" -->

<div style="width: 60%">

</br>

*In which we concern ourselves with the observation of signals from the convecting mantle at the surface of the Earth and, perhaps, of the other terrestrial planets. We will see how mantle convection naturally
produces the pattern of heat flow in the oceans that we discussed in earlier lectures.*

</div>

<--o-->

## Observables

Quantitative information we can obtain about the dynamics of planetary interiors from remote sensing.

Which remote observations tell us what information ? 

  - **Gravity measurements**: density distribution
  - **Surface topography**: surface stress field
  - **Surface heat flow**: near surface temperature gradients
  - **Seismology**: elastic wave speed distribution
  - **Morphology**: deformation styles / relative ages
  - **E/M**: conductivity / magnetic susceptibility

None of these tells us directly what the flow is doing at depth —how to solve this and the uncertainty of rheological parameters.

<--o-->

## Oceans v. Continents v. Boundary Layers

<center>

![BoundaryLayers](images/PlateMotionsMollweide.png) <!-- .element style="width:80%;" -->

</center>

The ocean basins have a systematic variation in heat flow and thickness from mid ocean ridge to trench that we can  interpret in terms of the cooling boundary layer model. The continents do not fit that model at all because they are not part of the global 3D circulation.


<--o-->

## Recap from previous lecture

We assume the geometry of fully developed convection is as follows
  - Thin horizontal boundary layers where heat diffuses into the layer and is carried away by horizontal advection. 
  - These are connected by vertical boundary layers of similar dimension.
  - Approximately isothermal core, passively rotating, driven by the boundary layers.

<center>

![BoundaryLayers](images/blt.png) <!-- .element style="height:200px;" -->

</center>

Making all of these assumptions allows us to derive the relationships: 

$$ \mathrm{Nu} \propto \mathrm{Ra}^{1/3}  \quad \quad \textrm{and}  \quad \quad  \mathrm{V}_\mathrm{mean} \propto \mathrm{Ra}^{2/3} $$

<--v-->


## Recap from previous lecture


We saw that the we could predict the global heat flow by understanding the basic fluid dynamics of the convecting mantle. **How can we verify if our theoretical picture has anything to do with the real Earth ?**

<center>

![Taverage](images/ConvectionTgrads.png) <!-- .element style="height:300px; " -->
![Nusselt](images/NuExperiment.png) <!-- .element style="height:300px; "-->

</center>

We might try to look at the global heat flow to see if the numbers match, but, if we want to identify the convection patterns as well, we might need to look at variations in the heat flow.(e.g. can we see cold and hot regions ?). The problem is … 

<--o-->

## Global Heat Flow

<center>

![Taverage](images/GlobalHeatFlowPoints.png) <!-- .element style="height:500px; " -->

</center>



Raw data compiled by Davies & Davies 2013. *There are really not very many reliable measurements*.

<--o-->

## Boundary Layer Theory

<center>

![Taverage](images/blt2.png) <!-- .element style="height:300px; " -->

</center>


We can look a little bit harder at the convection model we have been using and try to take it one step further.

Consider what actually happens as the hot material arrives at the surface (on the left) and spreads out horizontally (to the right). It begins to cool off as it moves. Because the horizontal length scale of the boundary layer is larger than the vertical scale, this is almost like a 1d problem. 

<--o-->

## Boundary Layers and the Cooling 1/2 Space

<center>

![Taverage](images/blt2.png) <!-- .element style="height:300px; " -->

</center>

Time and space are not independent in a moving-plate model. If you know the age of the plate and the plate velocity, you also know how far from the ridge you are. 

So we can imagine standing on the plate and measuring the geotherm. From this perspective, the plate looks flat and the geotherm is the same all around us. We can model this as a cooling "half-space"


<--o-->


## Cooling lithosphere = Error Function

<center>
</video>
<video autoplay controls loop height="400">
    <source src="movies/OceanCooling2.mov"
            type="video/mp4">

    Sorry, your browser doesn't support embedded videos.
</video>
</center>
Any point riding along with the plate sees a 1D cooling pattern underneath associated with the aging of the plate. This is a good approximation because lateral heat flow is small (small temperature gradients)

<--v-->

## Cooling lithosphere = Error Function

If we take a uniformly hot region and suddenly cool the boundary, the equation for the temperature as a function of time and space is:

$$ \frac{T-T_s}{T_0-T_s}  = \mathrm{erf} \left(  \frac{z}{2\sqrt{\kappa t}} \right) $$


*What is the erf  ?* -  It comes from probability theory and describes the probability of a value in a gaussian distribution having a value between -x and x. It might be hard to calculate, but it is easy enough to differentiate:

$$\textrm{erf}(x) = \int_{-x}^{x} e^{-t^2} dt $$

See https://en.wikipedia.org/wiki/Error_function for a discussion. 


<--o-->

## Cooling Lithosphere: structure

<center>

![Taverage](images/LithosphereCooling.png) <!-- .element style="height:400px; " -->

</center>

Lithosphere / boundary layer thickness — pick an isotherm and follow it from ridge to trench.
Thickness $\delta$ changes systematically:

$$ \delta \propto \sqrt{\kappa t} \quad \quad \textrm{a.k.a} \quad \quad  \delta \propto \sqrt{\kappa x / V} $$

<--o-->

## Observations - Ocean Lithosphere Thickness


<center>

![Taverage](images/TS-LithosphereThicknessAge.png) <!-- .element style="height:400px; " -->

</center>


This predicts the thickness of the thermal boundary layer which can be measured by seismology.
**NB:** the thermal boundary layer is a fuzzy thing without a sharp boundary - seismic methods are not always good at determining this kind of structure. 

<--v-->

## Observations - Ocean Lithosphere Thickness
<center>

![Taverage](images/LABDepth.png) <!-- .element style="height:400px; " -->

</center>

Modern data from the Litho 1.0 global lithosphere model. We can see that there is a signal in the oceans but still this model only sees at a resolution of 1 degree (about 100km). 

Colour scale 5km (red); >200km (blue)

<--o-->

## Observations - Oceanic Heat Flow


![Taverage](images/TS-LithosphereHeatFluxAge.png) <!-- .element style="width:35%; float:right; border-left:30px" -->


<div style="width:60%">
We can differentiate the cooling half-space model to give the temperature gradient at the surface, and hence the heat flux.

The oceanic heat flux is hard to measure at very young ages, but heat flux agrees quite well (at least until about 80-100 Myr)

That is still not a very large number of data points !

Is there a way to turn our boundary layer prediction into a measurement that we can make easily / everywhere ?

_Hint: **YES** (but it may take a little work)_
</div>


<--v-->

## Observations - Oceanic Heat Flow

<center>

![Taverage](images/DaviesSquared-HeatFlow.png) <!-- .element style="height:400px; " -->

</center>

Global heat flow estimate by Davies & Davies 2013 which includes various geological assumptions for different types of heat flow province. **These are not raw / independent data because they use models to interpolate where data are scarce.


<--o-->

## Predictions of the Cooling model 

<center>

![Litho80](images/80-80-001.png) <!-- .element style="height:500px; " -->

</center>


The strength, density plot oceanic lithosphere at 80Myr

<--v-->

## Predictions of the Cooling model 

<center>

![Litho120](images/120-80-001.png) <!-- .element style="height:500px; " -->

</center>


The strength, density plot oceanic lithosphere at 120Myr. (Thicker, denser, stronger)

<--o-->

## Global Gravity Anomalies

Can we see these density anomalies in the Earth's gravity field ?

<center>

![FreeAirGrav](images/BGI_WGM2012_FREEAIR_Anomaly_fancybox.png) <!-- .element style="height:450px; " -->

</center>

<small>
WGM2012 — Bonvalot, S., Balmino, G., Briais, A., M. Kuhn, Peyrefitte, A., Vales N., Biancale, R., Gabalda, G., Reinquin, F., Sarrailh, M., 2012. World Gravity Map. Commission for the Geological Map of the World. Eds. BGI-CGMW-CNES-IRD, Paris
</small>

<--o-->

## Isostasy and Ocean Depth

We have trouble identifying mass variations for the Earth because of **Isostasy** which is the phenomenon in which topography and density are causally correlated.

<center>

![Isostasy1](images/Isostasy1.png) <!-- .element style="height:350px; " -->

</center>

The lack of gravity (anomaly) signature associated with continental topography on Earth is explained simply by ISOSTASY — wherever there is a topographic high, there is a corresponding crustal root which produces a gravitational dipole. 

<--v-->

## Isostasy and Ocean Depth


If the density varies in a predictable way, then we should be able to see this in an isostatic change in the topography. 

$$ \int_0^{d_c} \rho(z) dz = \textrm{constant} $$

<center>

![Isostasy2](images/Isostasy2.png) <!-- .element style="height:200px; " -->

</center>

Although we usually think about isostasy as the light crust floating on the mantle, the same approach works for any density variations near the surface (e.g. thermal anomalies). If we integrate every density anomaly in adjacent columns, they balance out in the asthenosphere.  **This is the Pratt model of isostasy.** 

<--o-->

## Isostasy and Cooling 

Isostasy means that density variations are visible in the Earth's topography. This is a good thing for us because topography (bathymetry) is much easier to measure than the other observables.

<center>

![Sea Floor Isostasy](images/SeaFloorDepthIsostasy.png) <!-- .element style="width:40%; float:right; " -->

</center>


<div style="width:50%">

$$\int_{d_r}^{d_c} \rho(z) dz = \rho_m (d_c - d_r)$$

Assume no density variations in the water column or beneath the boundary layer and compare the density column at any given ￼ with the column at ￼

$$ w \rho_w + \int_{w}^{z_L} \rho(z) dz = \rho_m z_L $$

</div>

<--v-->

## Isostasy and Cooling (Advanced)

We can re-arrange this and pull the water layer out from the integral 

$$ w\left(\rho_w - \rho_m\right) + \int_{d_r}^{z_L}\left( \rho(z)-\rho_m\right) dz = 0 $$

But we also know $￼\left( \rho -\rho_m\right) = \rho_m \alpha \left(T_1 - T \right) $ and ￼$T(z)$ we calculated earlier. So if we combine these pieces of information we have

$$ w\left(\rho_w - \rho_m\right) = \rho_m \alpha \int_0^\infty \textrm{erfc} \left[ \frac{z}{2} \left(\frac{v}{\kappa x}\right)^{1/2}\right] $$ 

and the bathymetry as a function of age / distance from the ridge is given by 

$$ \color{blue}{w = \frac{2 \rho_m \alpha \left(T_1 - T_0\right) }{ \rho_m-\rho_w} \left(\frac{\kappa x}{\pi v}\right)^{1/2}} $$

<--o-->

## Isostasy and Sea Floor Age / Depth


![Sea Floor Depth](images/LithosphereDepthAge.png) <!-- .element style="width:60%; float:right; " -->


<div style="width:30%">

Suppose we know how to integrate the Half-Space Cooling equations, then we can compute the water depth as a function of lithospheric age and make a testable prediction

<br>


$$ w = \frac{2 \rho_m \alpha \left(T_1 - T_0\right) }{
\rho_m-\rho_w} \left(\frac{\kappa t}{\pi }\right)^{1/2} $$

</div>

<--o-->

## Summary 

The first-order indication of mantle convection is actually the thermal structure of the (oceanic plates) which are thermal boundary layers.

Heat flow data are very noisy and sparse but the thermal structure implies density variations and these can be imaged seismically and also through their buoyancy.

Sea floor topography (bathymetry) is related to buoyancy and hence thermal structure. Boundary layer theory says the sea floor should subside as the square root of its age.

<--o-->

## Accompanying Lab 

In the lab this week, we will use the available data to make an up to date version of this graph and someof the other maps from this lecture.

<center>

![Sea Floor Depth](images/LithosphereDepthAge.png) <!-- .element style="height:300px;" --> 
![Sea Floor Depth](images/Lab-MD1-MyTargetPlot.png) <!-- .element style="width:300px;" -->

</center>


<--o-->

## Advertisement

<center>

![EMSC3034](images/EMSC3034.png) <!-- .element style="width:40%; " --> &nbsp; &nbsp; 
![EMSC3002](images/EMSC3002.png) <!-- .element style="width:40%; " -->


</center>

If this section of the course has grabbed your attention, consider the *Geodynamics* course in 3rd year, and the Global Tectonics & Structure class. 