% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/net.inputs.R
\name{control.net}
\alias{control.net}
\title{Control Settings for Stochastic Network Models}
\usage{
control.net(
  type,
  nsteps,
  start = 1,
  nsims = 1,
  ncores = 1,
  resimulate.network = FALSE,
  tergmLite = FALSE,
  attr.rules,
  epi.by,
  initialize.FUN = initialize.net,
  resim_nets.FUN = resim_nets,
  infection.FUN = NULL,
  recovery.FUN = NULL,
  departures.FUN = NULL,
  arrivals.FUN = NULL,
  nwupdate.FUN = nwupdate.net,
  prevalence.FUN = prevalence.net,
  verbose.FUN = verbose.net,
  module.order = NULL,
  set.control.ergm,
  set.control.stergm,
  save.nwstats = TRUE,
  nwstats.formula = "formation",
  save.other,
  verbose = TRUE,
  verbose.int = 1,
  skip.check = FALSE,
  raw.output = FALSE,
  ...
)
}
\arguments{
\item{type}{Disease type to be modeled, with the choice of \code{"SI"} for
Susceptible-Infected diseases, \code{"SIR"} for
Susceptible-Infected-Recovered diseases, and \code{"SIS"} for
Susceptible-Infected-Susceptible diseases.}

\item{nsteps}{Number of time steps to simulate the model over. This must be a
positive integer that is equal to the final step of a simulation. If
simulation is restarted with \code{start} argument, this number must
be at least one greater than that argument's value.}

\item{start}{For models with network resimulation , time point to start up simulation.
For restarted simulations, this must be one greater than the final time
step in the prior simulation and must be less than the value in
\code{nsteps}.}

\item{nsims}{The total number of disease simulations.}

\item{ncores}{Number of processor cores to run multiple simulations
on, using the \code{foreach} and \code{doParallel} implementations.}

\item{resimulate.network}{If \code{TRUE}, resimulate the network at each time
step. This is required when the epidemic or demographic processes impact
the network structure (e.g., vital dynamics).}

\item{tergmLite}{Logical indicating usage of either \code{tergm} (\code{tergmLite = FALSE}),
or \code{tergmLite} (\code{tergmLite = TRUE}). Default of \code{FALSE}.}

\item{attr.rules}{A list containing the  rules for setting the attributes of
incoming nodes, with one list element per attribute to be set (see
details below).}

\item{epi.by}{A character vector of length 1 containing a nodal attribute for
which subgroup epidemic prevalences should be calculated. This nodal
attribute must be contained in the network model formation formula,
otherwise it is ignored.}

\item{initialize.FUN}{Module to initialize the model at time 1, with the
default function of \code{\link{initialize.net}}.}

\item{resim_nets.FUN}{Module to resimulate the network at each time step,
with the default function of \code{\link{resim_nets}}.}

\item{infection.FUN}{Module to simulate disease infection, with the default
function of \code{\link{infection.net}}.}

\item{recovery.FUN}{Module to simulate disease recovery, with the default
function of \code{\link{recovery.net}}.}

\item{departures.FUN}{Module to simulate departure or exit, with the default function
of \code{\link{departures.net}}.}

\item{arrivals.FUN}{Module to simulate arrivals or entries, with the default
function of \code{\link{arrivals.net}}.}

\item{nwupdate.FUN}{Module to handle updating of network structure and nodal
attributes due to exogenous epidemic model processes, with the default
function of \code{\link{nwupdate.net}}.}

\item{prevalence.FUN}{Module to calculate disease prevalence at each time step,
with the default function of \code{\link{prevalence.net}}.}

\item{verbose.FUN}{Module to print simulation progress to screen, with the
default function of \code{\link{verbose.net}}.}

\item{module.order}{A character vector of module names that lists modules the
order in which they should be evaluated within each time step. If
\code{NULL}, the modules will be evaluated as follows: first any
new modules supplied through \code{...} in the order in which they are
listed, then the built-in modules in their order of the function listing.
The \code{initialize.FUN} will always be run first and the
\code{verbose.FUN} always last.}

\item{set.control.ergm}{Control arguments passed to simulate.ergm. See the
help file for \code{\link{netdx}} for details and examples on specifying
this parameter.}

\item{set.control.stergm}{Control arguments passed to simulate.stergm. See the
help file for \code{\link{netdx}} for details and examples on specifying
this parameter.}

\item{save.nwstats}{If \code{TRUE}, save network statistics in a data frame.
The statistics to be saved are specified in the \code{nwstats.formula}
argument.}

\item{nwstats.formula}{A right-hand sided ERGM formula that includes network
statistics of interest, with the default to the formation formula terms.}

\item{save.other}{A vector of elements on the \code{dat} master data list
to save out after each simulation. One example for base models is
the attribute list, "attr", at the final time step.}

\item{verbose}{If \code{TRUE}, print model progress to the console.}

\item{verbose.int}{Time step interval for printing progress to console, where
0 prints completion status of entire simulation and positive integer
\code{x} prints progress after each \code{x} time steps. The default
is to print progress after each time step.}

\item{skip.check}{If \code{TRUE}, skips the default error checking for the
structure and consistency of the parameter values, initial conditions,
and control settings before running base epidemic models. Setting
this to \code{FALSE} is recommended when running models with new modules
specified.}

\item{raw.output}{If \code{TRUE}, \code{netsim} will output a list of nestsim
data (one per simulation) instead of a formatted \code{netsim} object.}

\item{...}{Additional control settings passed to model.}
}
\description{
Sets the controls for stochastic network models simulated with
             \code{\link{netsim}}.
}
\details{
\code{control.net} sets the required control settings for any network model
solved with the \code{\link{netsim}} function. Controls are required for both
base model types and when passing original process modules. For an overview
of control settings for base models, consult the
\href{http://statnet.github.io/tut/BasicNet.html}{Basic Network Models} tutorial.
For all base models, the \code{type} argument is a necessary parameter
and it has no default.
}
\section{The attr.rules Argument}{

The \code{attr.rules} parameter is used to specify the rules for how nodal
attribute values for incoming nodes should be set. These rules are only
necessary for models in which there are incoming nodes (i.e., arrivals) There
are three rules available for each attribute value:
\itemize{
 \item \strong{"current":} new nodes will be assigned this attribute in
       proportion to the distribution of that attribute among existing nodes
       at that current time step.
 \item \strong{"t1":} new nodes will be assigned this attribute in proportion
       to the distribution of that attribute among nodes at time 1 (that is,
       the proportions set in the original network for \code{\link{netest}}).
 \item \strong{<Value>:} all new nodes will be assigned this specific value,
       with no variation.
}
For example, the rules list
\code{attr.rules = list(race = "t1", sex = "current", status = "s")}
specifies how the race, sex, and status attributes should be set for incoming
nodes. By default, the rule is "current" for all attributes except status,
in which case it is "s" (that is, all incoming nodes are susceptible).
}

\section{New Modules}{

Base network models use a set of module functions that specify how the
individual nodes in the network are subjected to infection, recovery,
demographics, and other processes. Core modules are those listed in the
\code{.FUN} arguments. For each module, there is a default function used in
the simulation. The default infection module, for example, is contained in
the \code{\link{infection.net}} function.

For original models, one may substitute replacement module functions for any of
the default functions. New modules may be added to the workflow at each time
step by passing a module function via the \code{...} argument. Consult the
\href{http://statnet.github.io/tut/NewNet.html}{New Network Models} tutorial.
One may remove existing modules, such as \code{arrivals.FUN}, from the workflow
by setting the parameter value for that argument to \code{NULL}.
}

\seealso{
Use \code{\link{param.net}} to specify model parameters and
         \code{\link{init.net}} to specify the initial conditions. Run the
         parameterized model with \code{\link{netsim}}.
}
\keyword{parameterization}
