@def title = "Poster at SNUFA '21"
@def published = "26 November 2021"
@def desc = """
    I presented my work on biologically plausible learning with the information bottleneck at SNUFA '21 (poster).
    """

I presented my work on a biologically plausible learning rule as a [poster](/assets/publications/SNUFA21 Poster.pdf) at the [Spiking Neural networks as Universal Function Approximators (SNUFA '21)](http://snufa.net). There were many great talks and posters presented, but I was most excited by the presentations on spiking neural networks (SNNs) being applied to solve real problems:
- the European Space Agency is looking at SNNs to solve graph problems (first time I've seen a graph neural network (GNN) equivalent for spikes!)
- [StereoSpike](https://arxiv.org/abs/2109.13751) uses two event-based cameras with a U-Net architecture to perceive depth. This work was especially cool for me, because I briefly looked at stereoscopic perception using conventional computer vision algorithms at the start of my Ph.D. We were trying to build a bitstream computing circuit as a stepping stone to SNNs, so it's cool to see someone find a solution to the problem years later.

# Our work

I presented our work on learning in biological networks by optimizing the information bottleneck. The success of deep learning has emphasized the importance of depth when training networks to solve complex problems. Depth isn't an issue for artificial neural networks (ANNs), because back-propagation provides a systematic way to assigning credit regardless of depth. Currently, there is not an accepted, biologically plausible back-propagation equivalent for SNNs, though we can use [surrogate gradients](https://ieeexplore.ieee.org/document/8891809) when the plausibility constraint is removed.

Our work took inspiration from [HSIC training](https://arxiv.org/abs/1908.01580) for ANNs. Instead of computing a loss at the very end of the network, then propagating the loss backwards, HSIC training optimizes each layer independently. Every layer is updated to minimize
$$
\mathcal{L}_{\text{HSIC}} = \mathrm{HSIC}(\vecb{z}^\ell, \vecb{x}) - \gamma \mathrm{HSIC}(\vecb{z}^\ell, \vecb{y})
$$
where $\vecb{z}^\ell$ is the output of the layer $\ell$, and $\vecb{x}$/$\vecb{y}$ are the input/output of the entire network, respectively. We show the gradient descent update for this objective can be decomposed into two components --- a local Hebbian component and a layer-wise global modulatory signal.

One challenge to applying this rule for SNNs directly is that the HSIC is computed over a batch of samples, but biological networks see samples sequentially, one-at-a-time. To overcome this, we encode a batch as a window of samples over time (i.e. a batch size of $N$ corresponds to the last $N$ samples presented to the network). We show that the local component depends only on the current sample, and the global component depends on the prior samples. Then, we propose using an auxiliary reservoir network to compute the global component as shown below.

![Our learning rule is a [three-factor Hebbian rule](http://journal.frontiersin.org/Article/10.3389/fncir.2015.00085/abstract). It contains a local component that depends on the current sample, and a global component that depends on past samples. A reservoir is used to compute the global component.](/assets/articles/hsic-rule.png)

Note that the reservoir can be trained a priori using random data, and it does not need to be trained during the main learning task (though it can be). Check out our [poster](/assets/publications/SNUFA21 Poster.pdf) for more details! An arXiv preprint should be available soon as well.