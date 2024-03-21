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
	import Pkg
	Pkg.add([
		Pkg.PackageSpec("StaticArrays"),
		Pkg.PackageSpec("Plots"),
		Pkg.PackageSpec("PlutoUI"),
		Pkg.PackageSpec("Parameters"),
		Pkg.PackageSpec("PlutoTeachingTools"),
		Pkg.PackageSpec("LaTeXStrings"),
		Pkg.PackageSpec("LinearAlgebra")
		])
	# 
	using StaticArrays
	using Plots
	using LaTeXStrings
	using PlutoUI
	using Parameters
	using LinearAlgebra
	using PlutoTeachingTools
end

# ╔═╡ 9ade0bbc-0b04-4e6d-92cf-54062b638cfe
md"""
# Practical K-Matrix Applications

This educational material introduces the K-matrix formalism, focusing on its practical application in describing scattering amplitude observables. The K-matrix approach provides a robust framework for analyzing scattering processes, essential for understanding resonance phenomena in hadron physics. One of the main challenges in employing this formalism lies in the initial estimation of the bare parameters, which requires a thorough comprehension of the underlying principles and mechanics of the model. The provided examples are designed to facilitate this understanding by illustrating the connection between the K-matrix parameters and observable quantities.


**Exapmle 1 (3x3 one pole):** The connection between the K-matrix and the multichannel Breit-Wigner model, demonstrating the generation of resonance widths.

**Example 2 (2x2 two poles):** The analysis of a 2x2 problem highlighting the dynamics of weakly coupled resonances.

**Example 3 (1x1 two poles):** The examination of a single-channel production amplitude involving two interfering resonances.

These examples provide insights into estimating parameters, understanding resonance behavior, and interpreting observable phenomena within the K-matrix framework.
"""

# ╔═╡ cb9fdca3-db42-4501-a2fe-c3ff099b2d83
TableOfContents()

# ╔═╡ c2a0a8bc-c1e6-4a48-91dc-590ca79383ff
md"""
## Example 1: Multichannel Breit-Wigner Model and Resonance Widths

The first example delves into the relationship between the K-matrix and the multichannel Breit-Wigner (BW) model. It demonstrates how resonance widths are generated within this framework, offering insight into the dynamic nature of resonances. This example is pivotal for appreciating how the K-matrix formalism can be used to describe complex resonance structures in multichannel scattering processes.
"""

# ╔═╡ 798f53e9-d871-42d1-a81c-d35adc7ece21
md"""
### Setup

$T = \begin{pmatrix}
T_{1\to1} & T_{1\to2} & T_{1\to3}\\
T_{2\to1} & T_{2\to2} & T_{2\to3}\\
T_{3\to1} & T_{3\to2} & T_{3\to3}\\
\end{pmatrix}$

where the index 1,2, and 3 label a channel of two particles, A+B, C+D, E+F, respectively.


The K mattrix

$K = \frac{1}{m_0^2-s}
\begin{pmatrix}
g_1^2 & g_1 g_2 & g_1 g_3\\
g_2 g_1 & g_2^2 & g_2 g_3\\
g_3 g_1 & g_3 g_2 & g_3^2\\
\end{pmatrix}$

Use in the expression
$T = [1 -i  K \rho]^{-1} K$, 
where 1 is identity matrix of three dims.,

with $\rho$ being a diagonal matrix of phase space factors, $\rho=\text{Diag}(\rho_1,\rho_2,\rho_3)$.

Do the calculations and find simple answer

$T = \frac{g_i g_j}{m_0^2-s-ig_1^2 \rho_1-ig_2^2 \rho_2-ig_3^2 \rho_3}$

Let's compare to the BW parametrization

$\text{BW} = \frac{m_0\Gamma_0}{m_0^2-s-im_0 \Gamma_0}$

"""

# ╔═╡ 3fde6651-a704-4757-b282-3a7cfcd36f6e
md"""
Let's setup couplings for three channels, that we can adjust:
- g₁ = $(@bind g1_T1 Slider(range(0,2,51), default=1.2, show_value=true)) GeV for the first channel,
- g₂ = $(@bind g2_T1 Slider(range(0,2,51), default=0.5, show_value=true)) GeV for the second channel, and 
- g₃ = $(@bind g3_T1 Slider(range(0,2,51), default=1.6, show_value=true)) GeV for the third channel.
"""

# ╔═╡ fe35af83-4910-48e4-b9de-5b8a1f85fb72
md"""
what we plot is a cross section calculated as 

$\frac{\mathrm{d}\sigma}{\mathrm{d}m} = \frac{1}{J_i} |T_{ij}|^2 \frac{\mathrm{d}\Phi_j}{\mathrm{d}m}$

with
- the flux $J_i$ set to 1, and
- the $\mathrm{d}\Phi_j / \mathrm{d}m = 2m\rho_j$, and
- the $\rho_j$ is zero below the threshold of the j channel.
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

# ╔═╡ 915f987d-9bb5-4e0b-9cf0-f52e3937695a
md"""
## Example 2: The 2x2 Problem with Weakly Coupled Resonances

In the second example, we explore the 2x2 problem, focusing on scenarios with weakly coupled resonances. This case study sheds light on the interactions between resonances in a two-dimensional parameter space, emphasizing the effects of weak coupling. It is an essential exploration for understanding how resonance coupling influences scattering amplitudes and observable resonance characteristics.
"""

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


we start with

$K \approx
\begin{pmatrix}
\frac{g_1^2}{m_{(1)}^2-s} & 0\\
0 & \frac{h_2^2}{m_{(2)}^2-s}
\end{pmatrix}$

since $g_2$ and $h_1$ are small

In that case, the T is simply ...


"""

# ╔═╡ 729c86ab-cf81-48bf-82be-b89cf28eaee6
md"""
Non-diagonal couplings make the system coupled. The channels start talking to each other.
- g₂ = $(@bind g2_T2 Slider(range(-1,2,61), default=0.1, show_value=true)) GeV for the first channel,
- h₁ = $(@bind h1_T2 Slider(range(-1,2,61), default=0.1, show_value=true)) GeV for the second channel, and 
"""

# ╔═╡ a7a68629-bf6f-435e-9a97-de9a02a31160
md"""
Let's find the first expansion term to reflect on how a weakly coupled resonances show up in the second channel.

$T_{22} = \frac{h_2^2}{m_{(2)}^2 - s - ih_2^2\rho_2} + \epsilon X$
"""

# ╔═╡ 0e899f67-adec-4837-9993-c9fe22f788d1
md"""
## Example 3: Single-Channel Production Amplitude with Interfering Resonances

The third example examines a single-channel problem featuring two prominent resonances. The focus is on the production amplitude and the investigation of interference effects between resonances. This scenario is critical for comprehending how overlapping resonances interact within the K-matrix formalism, affecting the overall scattering amplitude and observable patterns in the data.
"""

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

# ╔═╡ 91db142a-109f-414a-8d2c-9d3cd92bae40
md"""
### Production amplitude

$A = [1-iK\rho]^{-1}
\begin{pmatrix}
\frac{\alpha_1 g}{m_{(1)}^2-s}\\
\frac{\alpha_2 h}{m_{(2)}^2-s}
\end{pmatrix}$
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
    xlim=(:auto, :auto), ylim=(:auto, :auto), lab="", xlab="Mass of system [GeV]")

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
	MG = [(M=5.3, gs=[g1_T1, g2_T1, g3_T1])]
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
	Markdown.parse("The sum: $(round(sum(Γv_T1), digits=2)) GeV = $(join(string.(Γv_T1), " + ")*" GeV"), that corresponds to $(join(string.(round.(100*Γv_T1./sum(Γv_T1), digits=1)) .*"%", ", ")), respectively")
end

# ╔═╡ a6fd628c-86db-4d3f-836b-ff376cac7f1d
T2 = let
	# two channels
	channels = SVector(
			TwoBodyChannel(1.1, 1.1),
	        TwoBodyChannel(1.3, 1.3))
	# two bare pole
	MG = [
		(M=4.3, gs=[2.1, g2_T2]),
		(M=6.3, gs=[h1_T2, 2.5])]
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
		phsp = 1.0 # as before
		abs2(A) * phsp * e
	end
	plot!(2.6, 8, sp=2, lab="Tₖ[2,2]") do e
		A = amplitude(T2, e)[2,2]
		phsp = 1.0 # as before
		abs2(A) * phsp * e
	end
	vline!(sp=1, [T2.K.poles[1].M])
	vline!(sp=2, [T2.K.poles[2].M])
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

# ╔═╡ ff61d6e1-5681-4d15-8164-62baee4613ba
A_E3 = ProductionAmplitude(T3, SVector{2}(α1_E3, α2_E3*cis(ϕ2_E3)), SVector{1}(0));

# ╔═╡ 7b4fa73c-1075-4271-8d2f-1668d98904ab
let
	plot(title="Scattering cross section", yaxis=nothing)
	plot!(2.6, 8, lab="Tₖ") do e
		A = amplitude(T3, e)[1,1]
		phsp = 1
		abs2(A) * phsp * e
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
	vline!([m0])
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
	plot!(2.6, 8, sp=1, lab="Total production", yaxis=nothing) do e
		A = amplitude(A_E3, e)[1]
		phsp = 1 # to the corrected
		abs2(A) * e * phsp
	end
	map([1,2]) do ind
		plot!(2.6, 8, sp=1, fill=0, alpha=0.2, lab="from R$(ind)") do e
			A = productionpole(A_E3, e, ind)[1]
			phsp = 1 # to the corrected
			abs2(A) * phsp * e
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

# ╔═╡ Cell order:
# ╟─9ade0bbc-0b04-4e6d-92cf-54062b638cfe
# ╠═cb9fdca3-db42-4501-a2fe-c3ff099b2d83
# ╟─c2a0a8bc-c1e6-4a48-91dc-590ca79383ff
# ╟─798f53e9-d871-42d1-a81c-d35adc7ece21
# ╟─3fde6651-a704-4757-b282-3a7cfcd36f6e
# ╠═0ff7e560-37ca-4016-bc01-741322402679
# ╟─fe35af83-4910-48e4-b9de-5b8a1f85fb72
# ╠═3e76dfec-e83c-46df-8838-b299a7aaa5e3
# ╟─ad74e82b-b2f4-4b8d-99ea-2fe295bb018d
# ╟─ce2c280e-6a55-4766-a0f9-941b448c41c9
# ╟─915f987d-9bb5-4e0b-9cf0-f52e3937695a
# ╠═a6fd628c-86db-4d3f-836b-ff376cac7f1d
# ╟─1663348b-ed67-4851-9365-9641e6379fcd
# ╟─729c86ab-cf81-48bf-82be-b89cf28eaee6
# ╟─a7a68629-bf6f-435e-9a97-de9a02a31160
# ╠═fbfc0e6c-775e-4025-ad06-e3f6e291ec52
# ╟─0e899f67-adec-4837-9993-c9fe22f788d1
# ╟─27f0ae17-b61c-49c5-b4fc-6de5d2ddda94
# ╠═babfbc1f-7beb-44d1-b3c8-75309e8b817c
# ╟─8b92df7f-d97b-43fa-8ac3-fed8ee974f5f
# ╠═7b4fa73c-1075-4271-8d2f-1668d98904ab
# ╟─91db142a-109f-414a-8d2c-9d3cd92bae40
# ╟─f9dad52e-d6a2-46c4-a5b3-91a50c9425c1
# ╠═ff61d6e1-5681-4d15-8164-62baee4613ba
# ╠═b90a1c10-8e57-4b2a-b48a-ccb78010a4f5
# ╟─3019d77e-a41e-4fa5-a0bf-b91d3d72e96f
# ╠═2a5d2458-9958-4c9b-a183-d7029b6360c9
# ╠═25758574-5da4-4fbe-946d-d55f6210b7e2
# ╠═ae68a0e2-46ce-4186-97b3-4b03b5f2d8ce
# ╠═0360447c-c6c7-4ba6-8e5f-a20d5797995b
# ╠═1072afe6-bad7-4de3-9ad2-6dcef2b924bb
# ╠═ebf8b842-99ce-40e8-9bf4-931471879bf9
# ╠═9a2e8210-c140-4689-bb16-2aab3c3b2aaa
# ╠═fb45f5a8-15c4-4695-b36b-f21aab1e3d80
# ╠═474e5d19-b537-42d2-9e92-2a26996cee2d
# ╠═35b9a451-5fac-46e2-97bb-ebc19d4b3418
# ╠═2aef1bd5-7a81-417b-a090-77644fc5f640
