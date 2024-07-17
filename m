Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01506628
	for <mptcp@lists.linux.dev>; Wed, 17 Jul 2024 04:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721191197; cv=none; b=XOz98pI6tYJ/ej9wn77zhAxU3/RrRVAFkwIsweThhk0HJZ7s5SPgdE/T4g9g0pehC6N0TvWdW+0QBlSRlgzsyw25f8KauyNkWAQAEveP9kKmvpMs6zgeI+cjtcS9Nlfwfj/7gFyFOUrKEz33hD7FTQlV675mN6yAc8qLbYnUCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721191197; c=relaxed/simple;
	bh=DJ6+DeW7nvAzlawTSuQodO8rOL9E9jiI3GNMIPcjHcM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VOk+/RugKEUAquAW8WT7Fm0WezLG8zw3u+Lw4+TohllhQ7YSpg/i56h6znRVtMdg7CajXv9YJ/7wPF6gVkRNY6tBZF1xpEtLpcZxr9k1JuK2CUqrb6nCj5Yrr2XWEp7abg7rEu85IAgVdfIWOocrXHIf7crpHT/RdhJrXQYV9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP9wEeVg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP9wEeVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0FAC32782;
	Wed, 17 Jul 2024 04:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721191196;
	bh=DJ6+DeW7nvAzlawTSuQodO8rOL9E9jiI3GNMIPcjHcM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=kP9wEeVg0DCWaqZMciYUgeeglRWq9ZpD8UOR12vZY0tWyEonzzIjXkz4rqbxvnPh3
	 A7Sdnn/pe4z/jcbEC0iyAymkHmvls/5KQzKy2ELJZmFoofTSP84OCM8O3oiE8piUmL
	 4TChYQJJWoaNqCtLeeQCxVZkHoZ/+6Qk+KGAkmNp2+puA3A08eSR57AnorlD2D0g6Y
	 EoXsP1U+DAyK5hzv9B3tVs0clAyH7Jt4yA3X2dv56Em36gmWO/kfFKO0auQt2xZKd+
	 fyt7fvxbQff8tCKnnpvZUljbpf5a/JhS8AHVVNq0cmwwEf/S+c2YTtMXLvYq26Nha1
	 pTwG6nl0Nq/Iw==
Message-ID: <59cdfb0ae86ea0f2e45c2fecbe0a0ceb7848a1f6.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 7/9] selftests: mptcp: join: check backup
 support in signal endp
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 17 Jul 2024 12:39:52 +0800
In-Reply-To: <20240716-mptcp-backup-mpj-v2-7-4d50247405fb@kernel.org>
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
	 <20240716-mptcp-backup-mpj-v2-7-4d50247405fb@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBGWKTg4BEAC/Subk93zbjSYPahLCGMgjylhY/s/R2ebALGJFp13MPZ9qWlbVC8O+X
 lU/4reZtYKQ715MWe5CwJGPyTACILENuXY0FyVyjp/jl2u6XYnpuhw1ugHMLNJ5vbuwkc1I29nNe8
 wwjyafN5RQV0AXhKdvofSIryqm0GIHIH/+4bTSh5aB6mvsrjUusB5MnNYU4oDv2L8MBJStqPAQRLl
 P9BWcKKA7T9SrlgAr0VsFLIOkKOQPVTCnYxn7gfKogH52nkPAFqNofVB6AVWBpr0RTY7OnXRBMInM
 HcjVG4I/NFn8Cc7oaGaWHqX/yHAufJKUsldieQVFd7C/SI8jCUXdkZxR0Tkp0EUzkRc/TS1VwWHav
 0x3oLSy/LGHfRaIC/MqdGVqgCnm6wapUt7f/JHloyIyKJBGBuHCLMpN6n/kNkSCzyZKV7h6Vw1OL5
 18p0U3Optyakoh95KiJsKzcd3At/eftQGlNn5WDflHV1+oMdW2sRgfVDPrYeEcYI5IkTc3LRO6ucp
 VCm9/+poZSHSXMI/oJ6iXMJE8k3/aQz+EEjvc2z0p9aASJPzx0XTTC4lciTvGj62z62rGUlmEIvU2
 3wWH37K2EBNoq+4Y0AZsSvMzM+CcTo25hgPaju1/A8ErZsLhP7IyFT17ARj/Et0G46JRsbdlVJ/Pv
 X+XIOc2mpqx/QARAQABtCVHZWxpYW5nIFRhbmcgPGdlbGlhbmcudGFuZ0BsaW51eC5kZXY+iQJUBB
 MBCgA+FiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBY
 CAwECHgECF4AACgkQfnvtNTGKqCmS+A/9Fec0xGLcrHlpCooiCnNH0RsXOVPsXRp2xQiaOV4vMsvh
 G5AHaQLb3v0cUr5JpfzMzNpEkaBQ/Y8Oj5hFOORhTyCZD8tY1aROs8WvbxqvbGXHnyVwqy7AdWelP
 +0lC0DZW0kPQLeel8XvLnm9Wm3syZgRGxiM/J7PqVcjujUb6SlwfcE3b2opvsHW9AkBNK7v8wGIcm
 BA3pS1O0/anP/xD5s5L7LIMADVB9MqQdeLdFU+FFdafmKSmcP9A2qKHAvPBUuQo3xoBOZR3DMqXIP
 kNCBfQGkAx5tm1XYli1u3r5tp5QCRbY5LSkntMNJJh0eWLU8I+zF6NWhqNhHYRD3zc1tiXlG5E0ob
 pX02Dy25SE2zB3abCRdAK30nCI4lMyMCcyaeFqvf6uhiugLiuEPRRRdJDWICOLw6KOFmxWmue1F71
 k08nj5PQMWQUX3X2K6jiOuoodYwnie/9NsH3DBHIVzVPWASFd6JkZ21i9Ng4ie+iQAveRTCeCCF6V
 RORJR0R8d7mI9+1eqhNeKzs21gQPVf/KBEIpwPFDjOdTwS/AEQQyhB+5ALeYpNgfKl2p30C20VRfJ
 GBaTc4ReUXh9xbUx5OliV69iq9nIVIyculTUsbrZX81Gz6UlbuSzWc4JclWtXf8/QcOK31wputde7
 Fl1BTSR4eWJcbE5Iz2yzgQu0IUdlbGlhbmcgVGFuZyA8Z2VsaWFuZ0BrZXJuZWwub3JnPokCVAQTA
 QoAPhYhBGYinflYXRnXKLAXGn577TUxiqgpBQJlqclXAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAg
 MBAh4BAheAAAoJEH577TUxiqgpaGkP/3+VDnbu3HhZvQJYw9a5Ob/+z7WfX4lCMjUvVz6AAiM2atD
 yyUoDIv0fkDDUKvqoU9BLU93oiPjVzaR48a1/LZ+RBE2mzPhZF201267XLMFBylb4dyQZxqbAsEhV
 c9VdjXd4pHYiRTSAUqKqyamh/geIIpJz/cCcDLvX4sM/Zjwt/iQdvCJ2eBzunMfouzryFwLGcOXzx
 OwZRMOBgVuXrjGVB52kYu1+K90DtclewEgvzWmS9d057CJztJZMXzvHfFAQMgJC7DX4paYt49pNvh
 cqLKMGNLPsX06OR4G+4ai0JTTzIlwVJXuo+uZRFQyuOaSmlSjEsiQ/WsGdhILldV35RiFKe/ojQNd
 4B4zREBe3xT+Sf5keyAmO/TG14tIOCoGJarkGImGgYltTTTM6rIk/wwo9FWshgKAmQyEEiSzHTSnX
 cGbalD3Do89YRmdG+5eP7HQfsG+VWdn8IH6qgIvSt8GOw6RfSP7omMXvXji1VrbWG4LOFYcsKTN+d
 GDhl8LmU0y44HejkCzYj/b28MvNTiRVfucrmZMGgI8L5A4ZwQ3Inv7jY13GZSvTb7PQIbqMcb1P3S
 qWJFodSwBg9oSw21b+T3aYG3z3MRCDXDlZAJONELx32rPMdBva8k+8L+K8gc7uNVH4jkMPkP9jPnV
 Px+2P2cKc7LXXedb/qQ3MuQINBGWKTg4BEADJxiOtR4SC7EHrUDVkp/pJCQC2wxNVEiJOas/q7H62
 BTSjXnXDc8yamb+HDO+Sncg9SrSRaXIh+bw9G3rvOiC2aQKB6EyIWKMcuDlD7GbkLJGRoPCA5nSfH
 Szht2PdNvbDizODhtBy8BOQA6Vb21XOb1k/hfD8Wy6OnvkA4Er61cf66BzXeTEFrvAIW+eUeoYTBA
 eOOc2m4Y0J28lXhoQftpNGV5DxH9HSQilQZxEyWkNj8oomVJ6Db7gSHre0odlt5ZdB7eCJik12aPI
 dK5W97adXrUDAclipsyYmZoC1oRkfUrHZ3aYVgabfC+EfoHnC3KhvekmEfxAPHydGcp80iqQJPjqn
 eDJBOrk6Y51HDMNKg4HJfPV0kujgbF3Oie2MVTuJawiidafsAjP4r7oZTkP0N+jqRmf/wkPe4xkGQ
 Ru+L2GTknKtzLAOMAPSh38JqlReQ59G4JpCqLPr00sA9YN+XP+9vOHT9s4iOu2RKy2v4eVOAfEFLX
 q2JejUQfXZtzSrS/31ThMbfUmZsRi8CY3HRBAENX224Wcn6IsXj3K6lfYxImRKWGa/4KviLias917
 DT/pjLw/hE8CYubEDpm6cYpHdeAEmsrt/9dMe6flzcNQZlCBgl9zuErP8Cwq8YNO4jN78vRlLLZ5s
 qgDTWtGWygi/SUj8AUQHyF677QARAQABiQI7BBgBCgAmFiEEZiKd+VhdGdcosBcafnvtNTGKqCkFA
 mWKTg4CGwwFCRLMAwAACgkQfnvtNTGKqCkpsw/2MuS0PVhl2iXs+MleEhnN1KjeSYaw+nLbRwd2Sd
 XoVXBquPP9Bgb92T2XilcWObNwfVtD2eDz8eKf3e9aaWIzZRQ3E5BxiQSHXl6bDDNaWJB6I8dd5TW
 +QnBPLzvqxgLIoYn+2FQ0AtL0wpMOdcFg3Av8MEmMJk6s/AHkL8HselA3+4h8mgoK7yMSh601WGrQ
 AFkrWabtynWxHrq4xGfyIPpq56e5ZFPEPd4Ou8wsagn+XEdjDof/QSSjJiIaenCdDiUYrx1jltLmS
 lN4gRxnlCBp6JYr/7GlJ9Gf26wk25pb9RD6xgMemYQHFgkUsqDulxoBit8g9e0Jlo0gwxvWWSKBJ8
 3f22kKiMdtWIieq94KN8kqErjSXcpI8Etu8EZsuF7LArAPch/5yjltOR5NgbcZ1UBPIPzyPgcAmZl
 AQgpy5c2UBMmPzxco/A/JVp4pKX8elTc0pS8W7ne8mrFtG7JL0VQfdwNNn2R45VRf3Ag+0pLSLS7W
 OVQcB8UjwxqDC2t3tJymKmFUfIq8N1DsNrHkBxjs9m3r82qt64u5rBUH3GIO0MGxaI033P+Pq3BXy
 i1Ur7p0ufsjEj7QCbEAnCPBTSfFEQIBW4YLVPk76tBXdh9HsCwwsrGC2XBmi8ymA05tMAFVq7a2W+
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-07-16 at 22:53 +0200, Matthieu Baerts (NGI0) wrote:
> Before the previous commit, 'signal' endpoints with the 'backup' flag
> were ignored when sending the MP_JOIN.
> 
> The MPTCP Join selftest has then been modified to validate this case:
> the "single address, backup" test, is now validating the MP_JOIN with
> a
> backup flag as it is what we expect it to do with such name. The
> previous version has been kept, but renamed to "single address,
> switch
> to backup" to avoid confusions.
> 
> The "single address with port, backup" test is also now validating
> the
> MPJ with a backup flag, which makes more sense than checking the
> switch
> to backup with an MP_PRIO.
> 
> The "mpc backup both sides" test is now validating that the backup
> flag
> is also set in MP_JOIN from and to the addresses used in the initial
> subflow, using the special ID 0.
> 
> The 'Fixes' tag here below is the same as the one from the previous
> commit: this patch here is not fixing anything wrong in the
> selftests,
> but it validates the previous fix for an issue introduced by this
> commit
> ID.
> 
> Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - v2:
>    - Also validating MPJ to/from ID0 with backup
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 34
> ++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 175127a9c00c..ffcf558b4610 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2639,6 +2639,19 @@ backup_tests()
>  
>  	# single address, backup
>  	if reset "single address, backup" &&
> +	   continue_if mptcp_lib_kallsyms_has
> "subflow_rebuild_header$"; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
> +		pm_nl_set_limits $ns2 1 1
> +		sflags=nobackup speed=slow \
> +			run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr 1 1 1
> +		chk_add_nr 1 1
> +		chk_prio_nr 1 0 0 1
> +	fi
> +
> +	# single address, switch to backup
> +	if reset "single address, switch to backup" &&
>  	   continue_if mptcp_lib_kallsyms_has
> "subflow_rebuild_header$"; then
>  		pm_nl_set_limits $ns1 0 1
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> @@ -2654,13 +2667,13 @@ backup_tests()

'''
>  	if reset "single address with port, backup" &&
>  	   continue_if mptcp_lib_kallsyms_has
> "subflow_rebuild_header$"; then
>  		pm_nl_set_limits $ns1 0 1
> -		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port
> 10100
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
> port 10100
>  		pm_nl_set_limits $ns2 1 1
> -		sflags=backup speed=slow \
> +		sflags=nobackup speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1
> -		chk_prio_nr 1 1 0 0
> +		chk_prio_nr 1 0 0 1
>  	fi
'''

How about keep this block unchanged. "nobackup" is already tested in
the above newly added test "single address, backup"? They are almost
the same now.

WDYT?

Thanks,
-Geliang

>  
>  	if reset "mpc backup" &&
> @@ -2674,12 +2687,21 @@ backup_tests()
>  
>  	if reset "mpc backup both sides" &&
>  	   continue_if mptcp_lib_kallsyms_doesnt_have "T
> mptcp_subflow_send_ack$"; then
> -		pm_nl_add_endpoint $ns1 10.0.1.1 flags
> subflow,backup
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 1 2
> +		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal,backup
>  		pm_nl_add_endpoint $ns2 10.0.1.2 flags
> subflow,backup
> +
> +		# 10.0.2.2 (non-backup) -> 10.0.1.1 (backup)
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> +		# 10.0.1.2 (backup) -> 10.0.2.1 (non-backup)
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		ip -net "$ns2" route add 10.0.2.1 via 10.0.1.1 dev
> ns2eth1 # force this path
> +
>  		speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
> -		chk_join_nr 0 0 0
> -		chk_prio_nr 1 1 0 0
> +		chk_join_nr 2 2 2
> +		chk_prio_nr 1 1 1 1
>  	fi
>  
>  	if reset "mpc switch to backup" &&
> 

