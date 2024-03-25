### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 2a5d2458-9958-4c9b-a183-d7029b6360c9
# ╠═╡ show_logs = false
begin
	using StaticArrays
	using Plots
	using LaTeXStrings
	using PlutoUI
	using Parameters
	using LinearAlgebra
	using PlutoTeachingTools
	using CalculusWithJulia
end

# ╔═╡ 9ade0bbc-0b04-4e6d-92cf-54062b638cfe
md"""
# Practical K-Matrix Applications

This educational material introduces the K-matrix formalism, focusing on its practical application in describing scattering amplitude observables. The K-matrix approach provides a robust framework for analyzing scattering processes, essential for understanding resonance phenomena in hadron physics. One of the main challenges in employing this formalism lies in the initial estimation of the bare parameters, which requires a thorough comprehension of the underlying principles and mechanics of the model.

On the plot below one can find illustration of the ab->cd scattering process with resonance which has mass $m_{0}$ and width $Г_{0}$. This process can be described with K-matrix:

$K_{ij} = \frac{g_i g_j}{m_0^2-s}$

where $g_{i} g_j$ indicates different possible channels of the scattering process and $s=m^{2}$. K-matrix has to be real and symmetric by construction.

Then, one can introduce transition T-matrix:

$T = [I -i  K \rho]^{-1} K$
where $I$ is identity matrix of three dimensions and $\rho$ being a diagonal matrix of phase space factors$.
"""

# ╔═╡ 437d3bf9-cf44-40a8-97bc-8aee4b62d069
RobustLocalResource("",	joinpath("..","figures","1x1_scattering.png"))

# ╔═╡ e8ba4b4e-2d21-4bfe-bf32-02969f9b2970
md"""
The provided examples are designed to facilitate this understanding by illustrating the connection between the K-matrix parameters and observable quantities.


**Exapmle 1 (3x3 one pole):** The connection between the K-matrix and the multichannel Breit-Wigner model, demonstrating the generation of resonance widths.

**Example 2 (2x2 two poles):** The analysis of a 2x2 problem highlighting the dynamics of weakly coupled resonances.

**Example 3 (1x1 two poles):** The examination of a single-channel production amplitude involving two interfering resonances.

These examples provide insights into estimating parameters, understanding resonance behavior, and interpreting observable phenomena within the K-matrix framework.
"""

# ╔═╡ cb9fdca3-db42-4501-a2fe-c3ff099b2d83
TableOfContents()

# ╔═╡ a4750e66-b448-479e-a5dd-b9aec0f3a857
aside(RobustLocalResource("",	joinpath("..","figures","3x3_scattering.png")))

# ╔═╡ c2a0a8bc-c1e6-4a48-91dc-590ca79383ff
md"""
## Example 1: Multichannel Breit-Wigner Model and Resonance Widths

The first example explains the relationship between the K-matrix and the multichannel Breit-Wigner (BW) model. It demonstrates how resonance widths are generated within this framework, offering insight into the dynamic nature of resonances. This example is pivotal for appreciating how the K-matrix formalism can be used to describe complex resonance structures in multichannel scattering processes.
"""

# ╔═╡ 798f53e9-d871-42d1-a81c-d35adc7ece21
md"""
### Setup

Let's consider 3 coupled channels, the scattering amplitude T is a 3x3 matrix:

$T = \begin{pmatrix}
T_{1\to1} & T_{1\to2} & T_{1\to3}\\
T_{2\to1} & T_{2\to2} & T_{2\to3}\\
T_{3\to1} & T_{3\to2} & T_{3\to3}\\
\end{pmatrix}$

We model it with the simplest **one-pole** K-matrix.

$K = \frac{1}{m_0^2-s}
\begin{pmatrix}
g_1^2 & g_1 g_2 & g_1 g_3\\
g_2 g_1 & g_2^2 & g_2 g_3\\
g_3 g_1 & g_3 g_2 & g_3^2\\
\end{pmatrix}$ 

and $\rho=\text{Diag}(\rho_1,\rho_2,\rho_3)$
"""

# ╔═╡ 7b717c8f-1fb8-4892-a250-c77e5e088445
aside(tip(md"$T = [1-iK\rho]^{-1}K$"))

# ╔═╡ 1215bc85-4760-473b-93d0-5d6a8952e27e
question_box(md"""
**E1.Q1:** When $K$ is degenerate and has rank 1, the expression for T is simple. Figure it out for 3x3 matrix.

**Extra difficult:** Can you prove it for general case?
""")

# ╔═╡ 1273bd41-9986-4b9f-9e06-b3bed7ab65f0
answer_box(
md"$T_{ij} = \frac{g_i g_j}{m_0^2-s-ig_1^2 \rho_1-ig_2^2 \rho_2-ig_3^2 \rho_3}$

This is expression known as the [Flatte formula](https://inspirehep.net/literature/108884)
")

# ╔═╡ 6d5acd0c-dbcf-4d0a-a94c-76ac59006fc8
md"""

## Compare to BW

Let's compare to the BW parametrization

$\text{BW} = \frac{m_0\Gamma_0}{m_0^2-s-im_0 \Gamma_0}$

"""

# ╔═╡ fe35af83-4910-48e4-b9de-5b8a1f85fb72
md"""
Cross section of certain channel calculated as 

$\frac{\mathrm{d}\sigma}{\mathrm{d}m} = \frac{1}{J_i} |T_{ij}|^2 \frac{\mathrm{d}\Phi_j}{\mathrm{d}m}$

with
- the flux $J_i$ set to 1, and
- the $\mathrm{d}\Phi_j / \mathrm{d}m = 2m\rho_j$ is a phase space per certain energy, and
- the $\rho_j$ is zero below the threshold of the j channel.
"""

# ╔═╡ 3fde6651-a704-4757-b282-3a7cfcd36f6e
md"""
Let's setup couplings for three channels, that we can adjust:
- g₁ = $(@bind g1_T1 Slider(range(0,4,101), default=1.2, show_value=true)) GeV for the first channel,
- g₂ = $(@bind g2_T1 Slider(range(0,4,101), default=0.5, show_value=true)) GeV for the second channel, and 
- g₃ = $(@bind g3_T1 Slider(range(0,4,101), default=1.6, show_value=true)) GeV for the third channel.
- m₀ = $(@bind M Slider(range(0,10,101), default=5.3, show_value=true)) GeV/c² pole of the K-matrix.
"""

# ╔═╡ ad74e82b-b2f4-4b8d-99ea-2fe295bb018d
md"""
### Calculation of the width

We can relate the approximate width to coupling using the Breit-Wigner expression, $1/(m_0^2-s-im_0\Gamma_0)$, where $\Gamma_0$ gives the width of the peak.
Hence

```math
\begin{align}
\Gamma_0 = \frac{g_1^2 \rho_1 (m_0) + g_2^2 \rho_2(m_0)+g_3^2 \rho_3(m_0)}{m_0}\\
\end{align}
```
"""

# ╔═╡ f880fd7c-d93d-4f76-9454-9fd59bcacff6
md"""

Now, otherwise, it is possible to estimate K-matrix parameters when one knows FWHM and $m_{0}$ from the peak:

$g_{i}\approx\sqrt\frac{Г_{0}m_{0}}{\rho_{i}(m_0)}$

"""

# ╔═╡ 915f987d-9bb5-4e0b-9cf0-f52e3937695a
md"""
## Example 2: The 2x2 Problem with Weakly Coupled Resonances

In the second example, we explore the 2x2 problem, focusing on scenarios with weakly coupled resonances. This case study sheds light on the interactions between resonances in a two-dimensional parameter space, emphasizing the effects of weak coupling. It is an essential exploration for understanding how resonance coupling influences scattering amplitudes and observable resonance characteristics.
"""

# ╔═╡ 2486eb34-a858-4ea9-99e1-f17627589461
RobustLocalResource("",	joinpath("..","figures","2x2_scattering.png"))

# ╔═╡ 1663348b-ed67-4851-9365-9641e6379fcd
md"""

$K = \frac{1}{m_{(1)}^2-s}
\begin{pmatrix}
g_1^2 & g_1 g_2\\
g_2 g_1 & g_2^2
\end{pmatrix} + 
\frac{1}{m_{(2)}^2-s}
\begin{pmatrix}
h_1^2 & h_1 h_2\\
h_2 h_1 & h_2^2
\end{pmatrix}$

We start with setting off-diagonal parameters described coupling to zeros $g_{2}=h_{1}=0$:

$K =
\begin{pmatrix}
\frac{g_1^2}{m_{(1)}^2-s} & 0\\
0 & \frac{h_2^2}{m_{(2)}^2-s}
\end{pmatrix}$

"""

# ╔═╡ 96dc5bd2-c84e-4c6d-872d-e33c1e89758a
md"""

In that case, the T-matrix would be simply:

"""

# ╔═╡ a223cbff-88b0-4a28-af53-c139e7b9108a
tip(md"For single resonance:

$T =
\frac{1}{m_{(1)}^2-s-ig_1^2\rho_1-ig_2^2\rho_2}
\begin{pmatrix}
g_1^2 & g_1g_2\\
g_2g_1 & g_2^2
\end{pmatrix}$

")

# ╔═╡ 9d9a89ed-76f3-4e76-a3cc-0d33c747fbb5
answer_box(md"""
$T =
\begin{pmatrix}
\frac{g_1^2}{m_{(1)}^2-s-ig_1^2\rho_1} & 0\\
0 & \frac{h_2^2}{m_{(2)}^2-s-ih_2^2\rho_2}
\end{pmatrix}$
""")

# ╔═╡ 729c86ab-cf81-48bf-82be-b89cf28eaee6
md"""

### Demo
Non-diagonal couplings make the system coupled. The channels start talking to each other.
- g₂ = $(@bind g2_T2 Slider(range(-1,3,81), default=0.0, show_value=true)) GeV for the first channel,
- h₁ = $(@bind h1_T2 Slider(range(-1,3,81), default=0.0, show_value=true)) GeV for the second channel, and 
"""

# ╔═╡ a7a68629-bf6f-435e-9a97-de9a02a31160
question_box(md"""
Let's find the first expansion term to reflect on how a weakly coupled resonances show up in the second channel. For that put $g_2=\epsilon$, $h_1 = 0$.

Then,

$K = K^{(1)} + K^{(2)}$

$K^{(1)} = \frac{1}{m_{(1)}^2-s}
\begin{pmatrix}
g_1^2 & g_1 \epsilon\\
\epsilon g_1 & \epsilon^2
\end{pmatrix}
\approx \frac{1}{m_{(1)}^2-s}
\begin{pmatrix}
g_1^2 & g_1 \epsilon\\
\epsilon g_1 & 0
\end{pmatrix}$ 
""")

# ╔═╡ cce481eb-13a8-4e49-b20e-23ec4395072d
md"""

The T-matrix in that case would be:

$T \approx
\begin{pmatrix}
\frac{g_1^2}{m_{(1)}^2-s-ig_1^2\rho_1} & \frac{g_1\epsilon}{m_{(1)}^2-s-ig_1^2\rho_1}\\
\frac{\epsilon g_1}{m_{(1)}^2-s-ig_1^2\rho_1} & \frac{h_2^2}{m_{(2)}^2-s-ih_2^2\rho_2}
\end{pmatrix}$

"""

# ╔═╡ ac9ea1cd-1026-4d39-ac17-3881db54ea75
md"""

One can notice that:

(1) $T^{(0)}_{11}=T^{(\epsilon)}_{11}$ and $T^{(0)}_{22}=T^{(\epsilon)}_{22}$

(2) $\frac{T^{(\epsilon)}_{12}}{T^{(\epsilon)}_{11}}=\frac{\epsilon}{g_{1}}$

Hence one will see effects of channel couplings only when $g_{2}$ will be in order of $g_{1}$

"""

# ╔═╡ 0e899f67-adec-4837-9993-c9fe22f788d1
md"""
## Example 3: Single-Channel Production Amplitude with Interfering Resonances

The third example examines a single-channel problem featuring two prominent resonances. The focus is on the production amplitude and the investigation of interference effects between resonances. This scenario is critical for comprehending how overlapping resonances interact within the K-matrix formalism, affecting the overall scattering amplitude and observable patterns in the data.
"""

# ╔═╡ 12a615bb-97b8-4fde-bd66-ac7083970e0e
RobustLocalResource("", joinpath("..","figures", "1x1_production.png"), cache=false)

# ╔═╡ 27f0ae17-b61c-49c5-b4fc-6de5d2ddda94
md"""
### Scattering amplitude
"""

# ╔═╡ 8b92df7f-d97b-43fa-8ac3-fed8ee974f5f
md"""

$K = \frac{g^2}{m_{(1)}^2-s}+
\frac{h^2}{m_{(2)}^2-s}$

$T = [1-iK\rho ]^{-1} K$

If K is zero for $s=s_\text{z}$, T is zero.
"""

# ╔═╡ e6f501d6-14f8-4f04-8711-1cbccce3a60c
md"""

Why does it happen?

For explanation let's have a look at K-matrix in these case.

"""

# ╔═╡ 91db142a-109f-414a-8d2c-9d3cd92bae40
md"""
### Production amplitude

The difference between production and scattering is that now one replace K-matrix with vector:

$A = [1-iK\rho]^{-1}
\begin{pmatrix}
\frac{\alpha_1 g}{m_{(1)}^2-s}\\
\frac{\alpha_2 h}{m_{(2)}^2-s}
\end{pmatrix}$

Where $a_1$ and $a_2$ are production factors which might be complex.
"""

# ╔═╡ f9dad52e-d6a2-46c4-a5b3-91a50c9425c1
md"""
Production couplings
- α₁ = $(@bind α1_E3 Slider(range(0.01,2,61), default=1.0, show_value=true))
- |α₂| = $(@bind α2_E3 Slider(range(-1,2,61), default=0.1, show_value=true))
- Arg(α₂) = $(@bind ϕ2_E3 Slider(range(0,2π,100), default=0.0, show_value=true))
"""

# ╔═╡ 3019d77e-a41e-4fa5-a0bf-b91d3d72e96f
md"""
## Implementation
"""

# ╔═╡ 25758574-5da4-4fbe-946d-d55f6210b7e2
theme(:wong2, frame=:box, grid=false, minorticks=true,
    guidefontvalign=:top, guidefonthalign=:right,
    foreground_color_legend=nothing,
    xlim=(:auto, :auto), ylim=(:auto, :auto),
	lab="", xlab="Mass of system [GeV]")

# ╔═╡ ae68a0e2-46ce-4186-97b3-4b03b5f2d8ce
begin
	struct TwoBodyChannel
	    m1::Complex{Float64}
	    m2::Complex{Float64}
	    L::Int
	end
	TwoBodyChannel(m1, m2; L::Int=0) = TwoBodyChannel(m1, m2, L)
	# 
	function ρ(ch::TwoBodyChannel, m; ϕ=-π / 2)
	    ch.L != 0 && error("not implemented")
	    sqrt(cis(ϕ) * (m - (ch.m1 + ch.m2))) * cis(-ϕ / 2) *
	    sqrt(m + (ch.m1 + ch.m2)) *
	    sqrt((m^2 - (ch.m1 - ch.m2)^2)) /
	    m^2
	end
end

# ╔═╡ 0360447c-c6c7-4ba6-8e5f-a20d5797995b
begin
	struct Kmatrix{N,V}
	    poles::SVector{V,NamedTuple{(:M, :gs),Tuple{Float64,SVector{N,Float64}}}}
	    nonpoles::SMatrix{N,N,Float64}
	end
	function Kmatrix(_poles)
		V, N = length(_poles), length(first(_poles).gs)
		poles = map(_poles) do p
			(; M=p.M, gs=SVector{N}(p.gs))
		end |> SVector{V}
		nonpoles = SMatrix{N,N}(fill(0.0, (N,N)))
		return Kmatrix(poles, nonpoles)
	end
	#
	amplitude(K::Kmatrix, m) =
	    sum((gs * gs') ./ (M^2 - m^2) for (M, gs) in K.poles) + K.nonpoles
	# 
	npoles(X::Kmatrix{N,V}) where {N,V} = V
	nchannels(X::Kmatrix{N,V}) where {N,V} = N
	#
end

# ╔═╡ fb45f5a8-15c4-4695-b36b-f21aab1e3d80
begin
	struct ProductionAmplitude{N,V}
	    T::Tmatrix{N,V}
	    αpoles::SVector{V,<:Number}
	    αnonpoles::SVector{N,<:Number}
	end
	#
	npoles(X::ProductionAmplitude{N,V}) where {N,V} = V
	nchannels(X::ProductionAmplitude{N,V}) where {N,V} = N
	detD(X::ProductionAmplitude, m; ϕ=-π / 2) = detD(X.T, m; ϕ)
	channels(X::ProductionAmplitude) = channels(X.T)
	# 
	ProductionAmplitude(T::Tmatrix{N,V}) where {N,V} =
	    ProductionAmplitude(T, SVector{V}(ones(V)), SVector{N}(ones(N)))
	# 
	function amplitude(A::ProductionAmplitude, m; ϕ=-π / 2)
	    @unpack T, αpoles, αnonpoles = A
	    P = αnonpoles
	    for (α, Mgs) in zip(αpoles, A.T.K.poles)
	        @unpack M, gs = Mgs
	        P += α .* gs ./ (M^2 - m^2)
	    end
	    D⁻¹ = inv(Dmatrix(T, m; ϕ))
	    return D⁻¹ * P
	end
end

# ╔═╡ 1072afe6-bad7-4de3-9ad2-6dcef2b924bb
begin
	struct Tmatrix{N,V}
	    K::Kmatrix{N,V}
	    channels::SVector{N,TwoBodyChannel}
	end
	#	
	function Dmatrix(T::Tmatrix{N,V}, m; ϕ=-π / 2) where {N,V}
	    𝕀 = Matrix(I, (N, N))
	    iρv = 1im .* ρ.(T.channels, m; ϕ) .* 𝕀
	    K = amplitude(T.K, m)
	    D = 𝕀 - K * iρv
	end
	detD(T::Tmatrix, m; ϕ=-π / 2) = det(Dmatrix(T, m; ϕ))
	amplitude(T::Tmatrix, m; ϕ=-π / 2) = inv(Dmatrix(T, m; ϕ)) * amplitude(T.K, m)
	# 
	npoles(X::Tmatrix{N,V}) where {N,V} = V
	nchannels(X::Tmatrix{N,V}) where {N,V} = N
	channels(X::Tmatrix) = X.channels
end

# ╔═╡ 0ff7e560-37ca-4016-bc01-741322402679
T1 = let
	# thhree channels
	channels = SVector(
			TwoBodyChannel(1.1, 1.1),
	        TwoBodyChannel(2.2, 2.2),
	        TwoBodyChannel(1.3, 1.3))
	# one bare pole
	MG = [(M, gs=[g1_T1, g2_T1, g3_T1])]
	# 
	K = Kmatrix(MG)
	T = Tmatrix(K, channels)
end;

# ╔═╡ ce2c280e-6a55-4766-a0f9-941b448c41c9
begin
	Γv_T1 = map(zip(T1.K.poles[1].gs, T1.channels)) do (g, ch)
		m0 = T1.K.poles[1].M
		Γi = g^2*ρ(ch, m0) / m0
		round(Γi, digits=2)
	end |> real
	Markdown.parse("The sum: $(round(sum(Γv_T1), digits=2)) GeV = $(join(string.(Γv_T1), " + ")*" GeV"), that corresponds to $(join(string.(round.(100*Γv_T1./sum(Γv_T1), digits=1)) .*"%", ", ")), respectively.")
end

# ╔═╡ a6fd628c-86db-4d3f-836b-ff376cac7f1d
T2 = let
	# two channels
	channels = SVector(
			TwoBodyChannel(1.1, 1.1),
	        TwoBodyChannel(1.3, 1.3))
	# two bare pole
	g1_T2 = 2.1
	h2_T2 = 2.5
	MG = [
		(M=4.3, gs=[g1_T2, g2_T2]),
		(M=6.3, gs=[h1_T2, h2_T2])]
	# 
	K = Kmatrix(MG)
	T = Tmatrix(K, channels)
end;

# ╔═╡ fbfc0e6c-775e-4025-ad06-e3f6e291ec52
let
	plot(title=["Scattering cross section" ""], yaxis=nothing,
		layout=grid(2,1, heights=(0.5,0.5)), size=(700,500))
	plot!(2.6, 8, sp=1, lab="Tₖ[1,1]") do e
		A = amplitude(T2, e)[1,1]
		phsp = real(ρ(T2.channels[1], e)) * e
		abs2(A) * phsp
	end
	vline!(sp=1, [T2.K.poles[1].M])
	plot!(2.6, 8, sp=2, lab="Tₖ[2,2]") do e
		A = amplitude(T2, e)[2,2]
		phsp = real(ρ(T2.channels[1], e)) * e
		abs2(A) * phsp
	end
	vline!(sp=2, [T2.K.poles[2].M])
	plot!(2.6, 8, sp=2, lab="Tₖ[1,2]") do e
		A = amplitude(T2, e)[1,2]
		phsp = real(ρ(T2.channels[1], e)) * e
		abs2(A) * phsp
		abs2(A) * phsp
	end
end

# ╔═╡ babfbc1f-7beb-44d1-b3c8-75309e8b817c
T3 = let
	# one channels
	channels = SVector(
			TwoBodyChannel(1.1, 1.1))
	# two bare pole
	MG = [
		(M=4.3, gs=[2.1]),
		(M=6.3, gs=[2.5])]
	# 
	K = Kmatrix(MG)
	T = Tmatrix(K, channels)
end;

# ╔═╡ 8556c8f4-89e4-4544-ad73-4da8b43a7051
p = let
	f1(x)=1/(T3.K.poles[1].M-x)
	f2(x)=1/(T3.K.poles[2].M-x)
	f3(x)=f1(x)+f2(x)
	plot(title="K-matrix parameter")
	plot!(rangeclamp(f1), 3, 7, lab="First pole, K1")
	plot!(rangeclamp(f2), 3, 7, lab="Second pole, K2")
	plot!(rangeclamp(f3), 3, 7, lab="Total")
	vline!([T3.K.poles[1].M, T3.K.poles[2].M], linestyle=:dash)
	hline!([0], color=:black, size=(500,300), leg=:top)
end

# ╔═╡ e9c0d423-793d-4997-a0fd-5c67b41fffb2
answer_box(
TwoColumn(md"Here is my comments for the plot", plot(p))
)

# ╔═╡ ff61d6e1-5681-4d15-8164-62baee4613ba
A_E3 = ProductionAmplitude(T3, SVector{2}(α1_E3, α2_E3*cis(ϕ2_E3)), SVector{1}(0));

# ╔═╡ 7b4fa73c-1075-4271-8d2f-1668d98904ab
let
	plot(title="Scattering cross section", yaxis=nothing)
	plot!(2.6, 8, lab="Tₖ") do e
		A = amplitude(T3, e)[1,1]
		phsp = real(ρ(T3.channels[1], e)) * e
		abs2(A) * phsp
	end
	vline!([T3.K.poles[1].M, T3.K.poles[2].M])
end

# ╔═╡ ebf8b842-99ce-40e8-9bf4-931471879bf9
function productionpole(T::Tmatrix, m, iR::Int; ϕ=-π / 2)
    @unpack M, gs = T.K.poles[iR]
    P = gs ./ (M^2 - m^2)
    return inv(Dmatrix(T, m; ϕ)) * P
end

# ╔═╡ 9a2e8210-c140-4689-bb16-2aab3c3b2aaa
productionnonpole(T::Tmatrix{N,K}, m; ϕ=-π / 2) where {N,K} =
    inv(Dmatrix(T, m; ϕ)) * ones(N)
#

# ╔═╡ 474e5d19-b537-42d2-9e92-2a26996cee2d
const iϵ = 1e-7im

# ╔═╡ 3e76dfec-e83c-46df-8838-b299a7aaa5e3
let
	m0 = T1.K.poles[1].M
	plot(title="Scattering cross section 1 → 1", yaxis=nothing)
	# K-matrix
	plot!(2.6, 8, lab="Tₖ[1,1]") do e
		A = amplitude(T1, e)[1,1]
		phsp = real(ρ(T1.channels[1], e)) * e
		abs2(A) * phsp
	end
	vline!([m0], lab="m₀ (K-matrix pole)")
	# BW
	N_peak = abs2(amplitude(T1, m0+iϵ)[1,1])
	plot!(2.6, 8, lab="BW₀") do e
		Γ0=sum(Γv_T1)
		A = m0*Γ0/(m0^2-e^2-1im*m0*Γ0)
		phsp = real(ρ(T1.channels[1], e)) * e
		N_peak * abs2(A) * phsp
	end
	vline!(map(T1.channels) do ch
		real(ch.m1+ch.m2)
	end, lab="thresholds", ls=:dash)
end

# ╔═╡ 35b9a451-5fac-46e2-97bb-ebc19d4b3418
function productionpole(A::ProductionAmplitude{N,V}, m, iR::Int; ϕ=-π / 2) where {N,V}
    αnonpoles = SVector{N}(zeros(N))
    αpoles = zeros(Complex{Float64}, V)
    αpoles[iR] = A.αpoles[iR]
    A = ProductionAmplitude(A.T, SVector{V}(αpoles), αnonpoles)
    return amplitude(A, m; ϕ)
end

# ╔═╡ b90a1c10-8e57-4b2a-b48a-ccb78010a4f5
let
	plot()
	plot!(title="Production cross section", 2.6, 8, sp=1, lab="Total production", yaxis=nothing) do e
		A = amplitude(A_E3, e)[1]
		phsp = real(ρ(T3.channels[1], e)) * e
		abs2(A) * phsp
	end
	map([1,2]) do ind
		plot!(2.6, 8, sp=1, fill=0, alpha=0.2, lab="from R$(ind)") do e
			A = productionpole(A_E3, e, ind)[1]
			phsp = real(ρ(T3.channels[1], e)) * e
			abs2(A) * phsp
		end
	end
	vline!([T3.K.poles[1].M, T3.K.poles[2].M])
	plot!()
end

# ╔═╡ 2aef1bd5-7a81-417b-a090-77644fc5f640
function productionnonpole(A::ProductionAmplitude{N,V}, m; ϕ=-π / 2) where {N,V}
    @unpack T, αnonpoles = A
    αpoles = SVector{V}(zeros(V))
    A = ProductionAmplitude(T, αpoles, αnonpoles)
    return amplitude(A, m; ϕ)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CalculusWithJulia = "a2e0e22d-7d4c-5312-9169-8b992201a882"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Parameters = "d96e819e-fc66-5662-9728-84c9c7592b0a"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[compat]
CalculusWithJulia = "~0.1.4"
LaTeXStrings = "~1.3.1"
Parameters = "~0.12.3"
Plots = "~1.39.0"
PlutoTeachingTools = "~0.2.14"
PlutoUI = "~0.7.58"
StaticArrays = "~1.9.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.1"
manifest_format = "2.0"
project_hash = "6ae51dbecc45796d31d4f3f87590513ec17217d5"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "0f748c81756f2e5e6854298f11ad8b2dfae6911a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.0"

[[deps.Accessors]]
deps = ["CompositionsBase", "ConstructionBase", "Dates", "InverseFunctions", "LinearAlgebra", "MacroTools", "Markdown", "Test"]
git-tree-sha1 = "c0d491ef0b135fd7d63cbc6404286bc633329425"
uuid = "7d9f7c33-5ae7-4f3b-8dc6-eff91059b697"
version = "0.1.36"

    [deps.Accessors.extensions]
    AccessorsAxisKeysExt = "AxisKeys"
    AccessorsIntervalSetsExt = "IntervalSets"
    AccessorsStaticArraysExt = "StaticArrays"
    AccessorsStructArraysExt = "StructArrays"
    AccessorsUnitfulExt = "Unitful"

    [deps.Accessors.weakdeps]
    AxisKeys = "94b1ba4f-4ee9-5380-92f1-94cde586c3c5"
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    Requires = "ae029012-a4dd-5104-9daa-d747884805df"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    StructArrays = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "2dc09997850d68179b69dafb58ae806167a32b1b"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.8"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a4c43f59baa34011e303e76f5c8c91bf58415aaf"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.0+1"

[[deps.CalculusWithJulia]]
deps = ["Base64", "Contour", "ForwardDiff", "HCubature", "IntervalSets", "JSON", "LinearAlgebra", "PlotUtils", "Random", "RecipesBase", "Reexport", "Requires", "Roots", "SpecialFunctions", "SplitApplyCombine", "Test"]
git-tree-sha1 = "df0608635021120c3d2e19a70edbb6506549fe14"
uuid = "a2e0e22d-7d4c-5312-9169-8b992201a882"
version = "0.1.4"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "575cd02e080939a33b6df6c5853d14924c08e35b"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.23.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "c0216e792f518b39b22212127d4a84dc31e4e386"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.3.5"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "59939d8a997469ee05c4b4944560a820f9ba0d73"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.4"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "67c1f244b991cad9b0aa4b7540fb758c2488b129"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.24.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "c955881e3c981181362ae4088b35995446298b80"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.14.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.CompositionsBase]]
git-tree-sha1 = "802bb88cd69dfd1509f6670416bd4434015693ad"
uuid = "a33af91c-f02d-484b-be07-31d278c5ca2b"
version = "0.1.2"
weakdeps = ["InverseFunctions"]

    [deps.CompositionsBase.extensions]
    CompositionsBaseInverseFunctionsExt = "InverseFunctions"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "6cbbd4d241d7e6579ab354737f4dd95ca43946e1"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.1"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "260fd2400ed2dab602a7c15cf10c1933c59930a2"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.5"
weakdeps = ["IntervalSets", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "0f4b5d62a88d8f59003e43c25a8a90de9eb76317"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.18"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Dictionaries]]
deps = ["Indexing", "Random", "Serialization"]
git-tree-sha1 = "573c92ef22ee0783bfaa4007c732b044c791bc6d"
uuid = "85a47980-9c8c-11e8-2b9f-f7ca1fa99fb4"
version = "0.4.1"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "dcb08a0d93ec0b1cdc4af184b26b591e9695423a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.10"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "466d45dc38e15794ec7d5d63ec03d776a9aff36e"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.4+1"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Format]]
git-tree-sha1 = "f3cf88025f6d03c194d73f5d13fee9004a108329"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.6"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "cf0fe81336da9fb90944683b8c41984b08793dad"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.36"
weakdeps = ["StaticArrays"]

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d8db6a5a2fe1381c1ea4ef2cab7c69c2de7f9ea0"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.1+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "ff38ba61beff76b8f4acad8ab0c97ef73bb670cb"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.9+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "27442171f28c952804dede8ff72828a96f2bfc1f"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.10"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "025d171a2847f616becc0f84c8dc62fe18f0f6dd"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.10+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "359a1ba2e320790ddbe4ee8b4d54a305c0ea2aff"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.80.0+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HCubature]]
deps = ["Combinatorics", "DataStructures", "LinearAlgebra", "QuadGK", "StaticArrays"]
git-tree-sha1 = "10f37537bbd83e52c63abf6393f209dbd641fedc"
uuid = "19dc6840-f33b-545b-b366-655c7e3ffd49"
version = "1.6.0"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "995f762e0182ebc50548c434c171a5bb6635f8e4"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.4"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[deps.Indexing]]
git-tree-sha1 = "ce1566720fd6b19ff3411404d4b977acd4814f9f"
uuid = "313cdc1a-70c2-5d6a-ae34-0150d3930a38"
version = "1.1.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IntervalSets]]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"
weakdeps = ["Random", "RecipesBase", "Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "896385798a8d49a255c398bd49162062e4a4c435"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.13"
weakdeps = ["Dates"]

    [deps.InverseFunctions.extensions]
    DatesExt = "Dates"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "a53ebe394b71470c7f97c2e7e170d51df21b17af"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.7"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3336abae9a713d2210bb57ab484b1e065edd7d23"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.2+0"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "7b762d81887160169ddfc93a47e5fd7a6a3e78ef"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.29"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d986ce2d884d49126836ea94ed5bfb0f12679713"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "cad560042a7cc108f5a4c24ea1431a9221f22c1b"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.2"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "dae976433497a2f841baadea93d27e68f1a12a97"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.39.3+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0a04a1318df1bf510beb2562cf90fb0c386f58c4"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.39.3+1"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "18144f3e9cbe9b15b070288eef858f71b291ce37"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.27"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "31e27f0b0bf0df3e3e951bfcc43fe8c730a219f6"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "2.4.5"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "af81a32750ebc831ee28bdaaba6e1067decef51e"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.2"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "60e3045590bd104a16fefb12836c00c0ef8c7f8c"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.13+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "7b1a9df27f072ac4c9c7cbe5efb198489258d1f5"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.1"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "ccee59c6e48e6f2edf8a5b64dc817b6729f99eb5"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.39.0"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "8f5fa7056e6dcfb23ac5211de38e6c03f6367794"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.6"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "LaTeXStrings", "Latexify", "Markdown", "PlutoLinks", "PlutoUI", "Random"]
git-tree-sha1 = "89f57f710cc121a7f32473791af3d6beefc59051"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.14"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "71a22244e352aa8c5f0f2adde4150f62368a3f2e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.58"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "37b7bb7aabf9a085e0044307e1717436117f2b3b"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.5.3+1"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "9b23c31e76e333e6fb4c1595ae6afa74966a729e"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.9.4"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Revise]]
deps = ["CodeTracking", "Distributed", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "Pkg", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "12aa2d7593df490c407a3bbd8b86b8b515017f3e"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.5.14"

[[deps.Roots]]
deps = ["Accessors", "ChainRulesCore", "CommonSolve", "Printf"]
git-tree-sha1 = "1ab580704784260ee5f45bffac810b152922747b"
uuid = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"
version = "2.1.5"

    [deps.Roots.extensions]
    RootsForwardDiffExt = "ForwardDiff"
    RootsIntervalRootFindingExt = "IntervalRootFinding"
    RootsSymPyExt = "SymPy"
    RootsSymPyPythonCallExt = "SymPyPythonCall"

    [deps.Roots.weakdeps]
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    IntervalRootFinding = "d2bf35a9-74e0-55ec-b149-d360ff49b807"
    SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
    SymPyPythonCall = "bc8888f7-b21e-4b7c-a06a-5d9c9496438c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "e2cfc4012a19088254b3950b85c3c1d8882d864d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.3.1"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.SplitApplyCombine]]
deps = ["Dictionaries", "Indexing"]
git-tree-sha1 = "c06d695d51cfb2187e6848e98d6252df9101c588"
uuid = "03a91e81-4c3e-53e1-a0a4-9c0c8f19dd66"
version = "1.2.3"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "bf074c045d3d5ffd956fa0a461da38a44685d6b2"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.3"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "36b3d696ce6366023a0ea192b4cd442268995a0d"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.2"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "1d77abd07f617c4868c33d4f5b9e1dbb2643c9cf"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.2"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
git-tree-sha1 = "a09c933bebed12501890d8e92946bbab6a1690f1"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.5"
weakdeps = ["Random", "Test"]

    [deps.TranscodingStreams.extensions]
    TestExt = ["Test", "Random"]

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "3c793be6df9dd77a0cf49d80984ef9ff996948fa"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.19.0"
weakdeps = ["ConstructionBase", "InverseFunctions"]

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "7558e29847e99bc3f04d6569e82d0f5c54460703"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+1"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "93f43ab61b16ddfb2fd3bb13b3ce241cafb0e6c9"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.31.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "07e470dabc5a6a4254ffebc29a1b3fc01464e105"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.12.5+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "31c421e5516a6248dfb22c194519e37effbf1f30"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.6.1+0"

[[deps.Xorg_libICE_jll]]
deps = ["Libdl", "Pkg"]
git-tree-sha1 = "e5becd4411063bdcac16be8b66fc2f9f6f1e8fe5"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.0.10+1"

[[deps.Xorg_libSM_jll]]
deps = ["Libdl", "Pkg", "Xorg_libICE_jll"]
git-tree-sha1 = "4a9d9e4c180e1e8119b5ffc224a7b59d3a7f7e18"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.3+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4bfde5d5b652e22b9c790ad00af08b6d042b97d"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.15.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "04341cb870f29dcd5e39055f895c39d016e18ccd"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.4+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "gperf_jll"]
git-tree-sha1 = "431b678a28ebb559d224c0b6b6d01afce87c51ba"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.9+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a68c9655fbe6dfcab3d972808f1aafec151ce3f8"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.43.0+0"

[[deps.gperf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3516a5630f741c9eecb3720b1ec9d8edc3ecc033"
uuid = "1a1c6b14-54f6-533d-8383-74cd7377aa70"
version = "3.1.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "141fe65dc3efabb0b1d5ba74e91f6ad26f84cc22"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "ad50e5b90f222cfe78aa3d5183a20a12de1322ce"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.18.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d7015d2e18a5fd9a4f47de711837e980519781a4"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.43+1"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "814e154bdb7be91d78b6802843f76b6ece642f11"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.6+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
"""

# ╔═╡ Cell order:
# ╟─9ade0bbc-0b04-4e6d-92cf-54062b638cfe
# ╟─437d3bf9-cf44-40a8-97bc-8aee4b62d069
# ╟─e8ba4b4e-2d21-4bfe-bf32-02969f9b2970
# ╠═cb9fdca3-db42-4501-a2fe-c3ff099b2d83
# ╟─a4750e66-b448-479e-a5dd-b9aec0f3a857
# ╟─c2a0a8bc-c1e6-4a48-91dc-590ca79383ff
# ╟─798f53e9-d871-42d1-a81c-d35adc7ece21
# ╟─7b717c8f-1fb8-4892-a250-c77e5e088445
# ╟─1215bc85-4760-473b-93d0-5d6a8952e27e
# ╟─1273bd41-9986-4b9f-9e06-b3bed7ab65f0
# ╟─6d5acd0c-dbcf-4d0a-a94c-76ac59006fc8
# ╟─fe35af83-4910-48e4-b9de-5b8a1f85fb72
# ╟─3fde6651-a704-4757-b282-3a7cfcd36f6e
# ╟─0ff7e560-37ca-4016-bc01-741322402679
# ╟─3e76dfec-e83c-46df-8838-b299a7aaa5e3
# ╟─ad74e82b-b2f4-4b8d-99ea-2fe295bb018d
# ╟─ce2c280e-6a55-4766-a0f9-941b448c41c9
# ╟─f880fd7c-d93d-4f76-9454-9fd59bcacff6
# ╟─915f987d-9bb5-4e0b-9cf0-f52e3937695a
# ╟─2486eb34-a858-4ea9-99e1-f17627589461
# ╠═a6fd628c-86db-4d3f-836b-ff376cac7f1d
# ╟─1663348b-ed67-4851-9365-9641e6379fcd
# ╟─96dc5bd2-c84e-4c6d-872d-e33c1e89758a
# ╟─a223cbff-88b0-4a28-af53-c139e7b9108a
# ╟─9d9a89ed-76f3-4e76-a3cc-0d33c747fbb5
# ╟─729c86ab-cf81-48bf-82be-b89cf28eaee6
# ╟─fbfc0e6c-775e-4025-ad06-e3f6e291ec52
# ╟─a7a68629-bf6f-435e-9a97-de9a02a31160
# ╟─cce481eb-13a8-4e49-b20e-23ec4395072d
# ╟─ac9ea1cd-1026-4d39-ac17-3881db54ea75
# ╟─0e899f67-adec-4837-9993-c9fe22f788d1
# ╟─12a615bb-97b8-4fde-bd66-ac7083970e0e
# ╟─27f0ae17-b61c-49c5-b4fc-6de5d2ddda94
# ╟─babfbc1f-7beb-44d1-b3c8-75309e8b817c
# ╟─8b92df7f-d97b-43fa-8ac3-fed8ee974f5f
# ╟─7b4fa73c-1075-4271-8d2f-1668d98904ab
# ╟─e6f501d6-14f8-4f04-8711-1cbccce3a60c
# ╠═8556c8f4-89e4-4544-ad73-4da8b43a7051
# ╟─e9c0d423-793d-4997-a0fd-5c67b41fffb2
# ╟─91db142a-109f-414a-8d2c-9d3cd92bae40
# ╟─f9dad52e-d6a2-46c4-a5b3-91a50c9425c1
# ╟─ff61d6e1-5681-4d15-8164-62baee4613ba
# ╟─b90a1c10-8e57-4b2a-b48a-ccb78010a4f5
# ╟─3019d77e-a41e-4fa5-a0bf-b91d3d72e96f
# ╠═2a5d2458-9958-4c9b-a183-d7029b6360c9
# ╠═25758574-5da4-4fbe-946d-d55f6210b7e2
# ╠═ae68a0e2-46ce-4186-97b3-4b03b5f2d8ce
# ╠═0360447c-c6c7-4ba6-8e5f-a20d5797995b
# ╠═1072afe6-bad7-4de3-9ad2-6dcef2b924bb
# ╠═ebf8b842-99ce-40e8-9bf4-931471879bf9
# ╠═9a2e8210-c140-4689-bb16-2aab3c3b2aaa
# ╠═fb45f5a8-15c4-4695-b36b-f21aab1e3d80
# ╟─474e5d19-b537-42d2-9e92-2a26996cee2d
# ╠═35b9a451-5fac-46e2-97bb-ebc19d4b3418
# ╠═2aef1bd5-7a81-417b-a090-77644fc5f640
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
