Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3D5482CA
	for <mptcp@lists.linux.dev>; Mon, 22 Apr 2024 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769528; cv=none; b=dvO0GrG72unBJBGE3R1YHypPgxUj/lYXyauA29T3v6N/WWA/Qw+1JvWnOC6kheMFHpN0LYIQHzwUjWnsOy3FQ40CneSa0mmMl62lJL/Vy/6FWffIpgPb3U3NrNeLmXbBuspTFgzIMkFF7pNGtlnFKvnHcPb3DQIFGgOuIhJE91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769528; c=relaxed/simple;
	bh=IhXoAQhZ+DCLFhsyQ8SKb5wf4o6cTGxfM+3xSdw+K7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=spYqe/sEUFe7TzBJhbOlv3dqMSdZhwV+0Wk7yHefQHByU+mD6eK+TMpHnmeVkqAO/A1yLmATrFWghgaLZnexTIzfFYn+OCCWXMsxmW/aI54VPuBDXUaHa4zkKKE9obDc8KAOTZVPniL0nvw3jUOtPOhp4pPHRlKET5t1wEtGXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgLrqPXe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgLrqPXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857B1C113CC;
	Mon, 22 Apr 2024 07:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713769528;
	bh=IhXoAQhZ+DCLFhsyQ8SKb5wf4o6cTGxfM+3xSdw+K7s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JgLrqPXepXw+OYF6ueO9idbpiDAE9ZL3X/m+MNotNkIPDdrTyC+HKUHiVE8CVFT0t
	 Fzn1vOyAUQXBLIodBxfGW1qJxt2qyDhsLZRrNeG9w9IfMNFsNpiI4lIaHYUhfv11uh
	 hLl+9f8UbxhO0818i1tezAn5HmD7HHZx5BMp4ywwPEE4gPUMWyjgFJd+rlIYg5alOB
	 hNw/NPVghNF+z9/E7VsZgbzmOrzNSe2PeYttX7pSt7oASbFTxByUVX+0siDWzsHDQ2
	 qSX0VCm2wWF7mxgBnr/tslDplzVOqEDQyENooiQvTGDkHZUoLTv9K3+/w3U1Swf59l
	 rLsflXot4ywMQ==
Message-ID: <febc0751efc11641e353216ff22fe94e6d623811.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v9 0/8] refactor mptcp bpf tests
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 22 Apr 2024 15:05:22 +0800
In-Reply-To: <72ba1395-fa5f-489a-872d-5dcb1727da5f@kernel.org>
References: <cover.1713321357.git.tanggeliang@kylinos.cn>
	 <10659d84-5d60-4a0f-84d9-859ad39a23f5@kernel.org>
	 <db02b2fd3c44e050aa9bc20537f108c3b9e07c9b.camel@kernel.org>
	 <72ba1395-fa5f-489a-872d-5dcb1727da5f@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBGWKTg4BEAC/Subk93zbjSYPahLCGMgjylhY/s/R2ebALGJFp13MPZ9qWlbVC8O+XlU/4reZtYKQ715MWe5CwJGPyTACILENuXY0FyVyjp/jl2u6XYnpuhw1ugHMLNJ5vbuwkc1I29nNe8wwjyafN5RQV0AXhKdvofSIryqm0GIHIH/+4bTSh5aB6mvsrjUusB5MnNYU4oDv2L8MBJStqPAQRLlP9BWcKKA7T9SrlgAr0VsFLIOkKOQPVTCnYxn7gfKogH52nkPAFqNofVB6AVWBpr0RTY7OnXRBMInMHcjVG4I/NFn8Cc7oaGaWHqX/yHAufJKUsldieQVFd7C/SI8jCUXdkZxR0Tkp0EUzkRc/TS1VwWHav0x3oLSy/LGHfRaIC/MqdGVqgCnm6wapUt7f/JHloyIyKJBGBuHCLMpN6n/kNkSCzyZKV7h6Vw1OL518p0U3Optyakoh95KiJsKzcd3At/eftQGlNn5WDflHV1+oMdW2sRgfVDPrYeEcYI5IkTc3LRO6ucpVCm9/+poZSHSXMI/oJ6iXMJE8k3/aQz+EEjvc2z0p9aASJPzx0XTTC4lciTvGj62z62rGUlmEIvU23wWH37K2EBNoq+4Y0AZsSvMzM+CcTo25hgPaju1/A8ErZsLhP7IyFT17ARj/Et0G46JRsbdlVJ/PvX+XIOc2mpqx/QARAQABtCVHZWxpYW5nIFRhbmcgPGdlbGlhbmcudGFuZ0BsaW51eC5kZXY+iQJUBBMBCgA+FiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQfnvtNTGKqCmS+A/9Fec0xGLcrHlpCooiCnNH0RsXOVPsXRp2xQiaOV4vMsvhG5AHaQLb3v0cUr5JpfzMzNpEkaBQ/Y8Oj5hFOORhTyCZD8tY1aROs8WvbxqvbGXHnyVwqy7Ad
	WelP+0lC0DZW0kPQLeel8XvLnm9Wm3syZgRGxiM/J7PqVcjujUb6SlwfcE3b2opvsHW9AkBNK7v8wGIcmBA3pS1O0/anP/xD5s5L7LIMADVB9MqQdeLdFU+FFdafmKSmcP9A2qKHAvPBUuQo3xoBOZR3DMqXIPkNCBfQGkAx5tm1XYli1u3r5tp5QCRbY5LSkntMNJJh0eWLU8I+zF6NWhqNhHYRD3zc1tiXlG5E0obpX02Dy25SE2zB3abCRdAK30nCI4lMyMCcyaeFqvf6uhiugLiuEPRRRdJDWICOLw6KOFmxWmue1F71k08nj5PQMWQUX3X2K6jiOuoodYwnie/9NsH3DBHIVzVPWASFd6JkZ21i9Ng4ie+iQAveRTCeCCF6VRORJR0R8d7mI9+1eqhNeKzs21gQPVf/KBEIpwPFDjOdTwS/AEQQyhB+5ALeYpNgfKl2p30C20VRfJGBaTc4ReUXh9xbUx5OliV69iq9nIVIyculTUsbrZX81Gz6UlbuSzWc4JclWtXf8/QcOK31wputde7Fl1BTSR4eWJcbE5Iz2yzgQu0IUdlbGlhbmcgVGFuZyA8Z2VsaWFuZ0BrZXJuZWwub3JnPokCVAQTAQoAPhYhBGYinflYXRnXKLAXGn577TUxiqgpBQJlqclXAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH577TUxiqgpaGkP/3+VDnbu3HhZvQJYw9a5Ob/+z7WfX4lCMjUvVz6AAiM2atDyyUoDIv0fkDDUKvqoU9BLU93oiPjVzaR48a1/LZ+RBE2mzPhZF201267XLMFBylb4dyQZxqbAsEhVc9VdjXd4pHYiRTSAUqKqyamh/geIIpJz/cCcDLvX4sM/Zjwt/iQdvCJ2eBzunMfouzryFwLGcOXzxOwZRMOBgVuXrjGVB52kYu1+K90DtclewEgvzWmS9d057CJztJZMXzvHfFAQMgJC7DX4pa
	Yt49pNvhcqLKMGNLPsX06OR4G+4ai0JTTzIlwVJXuo+uZRFQyuOaSmlSjEsiQ/WsGdhILldV35RiFKe/ojQNd4B4zREBe3xT+Sf5keyAmO/TG14tIOCoGJarkGImGgYltTTTM6rIk/wwo9FWshgKAmQyEEiSzHTSnXcGbalD3Do89YRmdG+5eP7HQfsG+VWdn8IH6qgIvSt8GOw6RfSP7omMXvXji1VrbWG4LOFYcsKTN+dGDhl8LmU0y44HejkCzYj/b28MvNTiRVfucrmZMGgI8L5A4ZwQ3Inv7jY13GZSvTb7PQIbqMcb1P3SqWJFodSwBg9oSw21b+T3aYG3z3MRCDXDlZAJONELx32rPMdBva8k+8L+K8gc7uNVH4jkMPkP9jPnVPx+2P2cKc7LXXedb/qQ3MuQINBGWKTg4BEADJxiOtR4SC7EHrUDVkp/pJCQC2wxNVEiJOas/q7H62BTSjXnXDc8yamb+HDO+Sncg9SrSRaXIh+bw9G3rvOiC2aQKB6EyIWKMcuDlD7GbkLJGRoPCA5nSfHSzht2PdNvbDizODhtBy8BOQA6Vb21XOb1k/hfD8Wy6OnvkA4Er61cf66BzXeTEFrvAIW+eUeoYTBAeOOc2m4Y0J28lXhoQftpNGV5DxH9HSQilQZxEyWkNj8oomVJ6Db7gSHre0odlt5ZdB7eCJik12aPIdK5W97adXrUDAclipsyYmZoC1oRkfUrHZ3aYVgabfC+EfoHnC3KhvekmEfxAPHydGcp80iqQJPjqneDJBOrk6Y51HDMNKg4HJfPV0kujgbF3Oie2MVTuJawiidafsAjP4r7oZTkP0N+jqRmf/wkPe4xkGQRu+L2GTknKtzLAOMAPSh38JqlReQ59G4JpCqLPr00sA9YN+XP+9vOHT9s4iOu2RKy2v4eVOAfEFLXq2JejUQfXZtzSrS/31ThMbfUmZsRi8CY3HRBAENX224Wcn6IsXj3K6lfYxImRKWGa
	/4KviLias917DT/pjLw/hE8CYubEDpm6cYpHdeAEmsrt/9dMe6flzcNQZlCBgl9zuErP8Cwq8YNO4jN78vRlLLZ5sqgDTWtGWygi/SUj8AUQHyF677QARAQABiQI7BBgBCgAmFiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwwFCRLMAwAACgkQfnvtNTGKqCkpsw/2MuS0PVhl2iXs+MleEhnN1KjeSYaw+nLbRwd2SdXoVXBquPP9Bgb92T2XilcWObNwfVtD2eDz8eKf3e9aaWIzZRQ3E5BxiQSHXl6bDDNaWJB6I8dd5TW+QnBPLzvqxgLIoYn+2FQ0AtL0wpMOdcFg3Av8MEmMJk6s/AHkL8HselA3+4h8mgoK7yMSh601WGrQAFkrWabtynWxHrq4xGfyIPpq56e5ZFPEPd4Ou8wsagn+XEdjDof/QSSjJiIaenCdDiUYrx1jltLmSlN4gRxnlCBp6JYr/7GlJ9Gf26wk25pb9RD6xgMemYQHFgkUsqDulxoBit8g9e0Jlo0gwxvWWSKBJ83f22kKiMdtWIieq94KN8kqErjSXcpI8Etu8EZsuF7LArAPch/5yjltOR5NgbcZ1UBPIPzyPgcAmZlAQgpy5c2UBMmPzxco/A/JVp4pKX8elTc0pS8W7ne8mrFtG7JL0VQfdwNNn2R45VRf3Ag+0pLSLS7WOVQcB8UjwxqDC2t3tJymKmFUfIq8N1DsNrHkBxjs9m3r82qt64u5rBUH3GIO0MGxaI033P+Pq3BXyi1Ur7p0ufsjEj7QCbEAnCPBTSfFEQIBW4YLVPk76tBXdh9HsCwwsrGC2XBmi8ymA05tMAFVq7a2W+TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matt,

On Sat, 2024-04-20 at 11:12 +0200, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 20/04/2024 02:18, Geliang Tang wrote:
> > Hi Matt,
> >=20
> > On Fri, 2024-04-19 at 11:58 +0200, Matthieu Baerts wrote:
> > > Hi Geliang, Mat,
> > >=20
> > > On 17/04/2024 04:38, Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > >=20
> > > > v9:
> > > > =C2=A0- extract a new helper test_bpf_sched() from
> > > > MPTCP_SCHED_TEST() to
> > > > make
> > > > =C2=A0=C2=A0 the macro simpler as Mat suggested. (thanks)
> > > > =C2=A0- squash MPTCP_SCHED_TEST() into "selftests/bpf: Add bpf_firs=
t
> > > > =C2=A0=C2=A0 scheduler & test", not "selftests/bpf: Add bpf schedul=
er
> > > > test"
> > > > to
> > > > =C2=A0=C2=A0 avoid a build error "test_bpf_sched is not used".
> > > Thank you for the v9, and the review!
> > >=20
> > > @Geliang: there were a lot of Git (TopGit) manipulations here,
> > > please
> > > check that the result is the expected one.
> >=20
> > Thank you for applying these patches. I know there must be many
> > conflicts inside. Thank you for updating my email address too. All
> > patches merged well and all tests passed.
>=20
> Thank you for having checked!
>=20
> > >=20
> > >=20
> > > New patch for t/upstream:
> > >=20
> > > - d0432b7d2bb0: selftests/bpf: Add RUN_MPTCP_TEST macro
> >=20
> > Please insert this commit "selftests/bpf: Add RUN_MPTCP_TEST macro"
> > before "mptcp: add sched_data helpers" so that it can be upstreamed
> > in advance with "setsockopt per subflow: BPF" series being
> > reviewed,
> > without waiting for BPF scheduler APIs to be updated. WDYT?
>=20
> I don't think we need to move it: there are no other patches
> modifying
> the BPF selftests before that one. So we should be safe regarding
> conflicts.

Yes, I agree.

>=20
> We can indeed send it with "setsockopt per subflow: BPF" series.
> These
> patches can be applied before "selftests/bpf: Add RUN_MPTCP_TEST
> macro",
> in the "patches for net-next" section when they will be marked as
> ready.

"setsockopt per subflow: BPF" series could be merged in this order:

1 selftests/bpf: Add mptcp subflow example
2 selftests/bpf: Add RUN_MPTCP_TEST macro
3 selftests/bpf: Add mptcp subflow subtest
4 selftests/bpf: Handle SIGINT when creating netns

Thanks,
-Geliang

>=20
> Cheers,
> Matt

