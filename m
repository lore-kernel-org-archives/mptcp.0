Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CFD4317B
	for <mptcp@lists.linux.dev>; Thu,  8 Aug 2024 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087728; cv=none; b=gYv9wwosaQMbelgnFfDzBFA3dQE6JnbPqD+AdM9mF4/un3DDxxb8y7DxVn4C+4KxOEPsNfT/Yw0GpSNFsugGVfRHXwseySPW82JoARwIWO1PLv1AEFNuaYGeFiJ00ApQBEfjZ20njlYCiR4mrDwr3GNxKPCIJHK9d71R/h3NDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087728; c=relaxed/simple;
	bh=m0U9/ZXJrj8yHzKMnTTf9cHylgJVR6U43pmgSgeyPIg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JyxBS579xs1AJQUfECFKevoEKfvpiGdGAeeW1OE2qKmf70e8ymlI23ZbAxinifzZPNndWf8nKWfmXFR/x1Q1CFdiOGamKyssfv6GQXcHtF6CPsudmIvdU7C2az2kDXbuwDOpHr5JN8autaa346GhurGu5mdYcLz0GQU/7IbIOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbYitD4f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbYitD4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827FAC4AF0B;
	Thu,  8 Aug 2024 03:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723087728;
	bh=m0U9/ZXJrj8yHzKMnTTf9cHylgJVR6U43pmgSgeyPIg=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=QbYitD4fzIJs/uYZcG0OsGhtAEkQYTrWm6nrb+bpb0UVc0f26/W8w/PHbOfV/Tm1e
	 LFCd853CeWp1GErKTjT4a7N+OqCP3EnQy6ErlpLpotebO18MmfrW9CRrVtHv1RQZaF
	 LozPeAtWW3Gp7rzKjXKkoSyhq5fFdCxhPolmqiyCuOZXmEUn/+VLJc3yn5D89k10BT
	 TAwUnlqRNdLaeIsgX4iYTgp4FLHwC0N+iXG2a888GDf8sPsVqD1ce8jPZHQseQiWTq
	 3KRKFvJ9a2IbHkgxKTm958bOjeOJmKuPK//TvM7cZMZI22NqqLKVu/t7/3NxE9djEb
	 PMoW0ESTbgB0g==
Message-ID: <23fc6138bd31d81783683cf041fbf75e8280a204.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 3/8] selftests: mptcp: join: reduce
 join_nr params
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Thu, 08 Aug 2024 11:28:44 +0800
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-3-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
	 <20240806-mptcp-join-tx-mib-v3-3-c3b54d2099e9@kernel.org>
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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-08-06 at 13:18 +0200, Matthieu Baerts (NGI0) wrote:
> chk_join_nr() currently takes 9 positional parameters, 6 of them are
> optional. It makes it hard to read:
> 
>   chk_join_nr 1 1 1 1 0 1 1 0 4
> 
> Naming these vars helps to make it easier to read:
> 
>   join_csum_ns1=1 join_csum_ns2=0 \
>     join_fail_nr=1 join_rst_nr=1 join_infi_nr=0 \
>     join_corrupted_pkts=4 \
>     chk_join_nr 1 1 1
> 
> It will then be easier to add new optional parameters.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 31
> ++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index a1f80dac59a7..0401ba1aaf1b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -61,6 +61,12 @@ unset sflags
>  unset fastclose
>  unset fullmesh
>  unset speed
> +unset join_csum_ns1
> +unset join_csum_ns2
> +unset join_fail_nr
> +unset join_rst_nr
> +unset join_infi_nr
> +unset join_corrupted_pkts
>  
>  # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
>  #				  (ip6 && (ip6[74] & 0xf0) ==
> 0x30)'"
> @@ -1314,12 +1320,12 @@ chk_join_nr()
>  	local syn_nr=$1
>  	local syn_ack_nr=$2
>  	local ack_nr=$3
> -	local csum_ns1=${4:-0}
> -	local csum_ns2=${5:-0}
> -	local fail_nr=${6:-0}
> -	local rst_nr=${7:-0}
> -	local infi_nr=${8:-0}
> -	local corrupted_pkts=${9:-0}
> +	local csum_ns1=${join_csum_ns1:-0}
> +	local csum_ns2=${join_csum_ns2:-0}
> +	local fail_nr=${join_fail_nr:-0}
> +	local rst_nr=${join_rst_nr:-0}
> +	local infi_nr=${join_infi_nr:-0}
> +	local corrupted_pkts=${join_corrupted_pkts:-0}
>  	local count
>  	local with_cookie
>  
> @@ -3138,7 +3144,8 @@ fastclose_tests()
>  		MPTCP_LIB_SUBTEST_FLAKY=1
>  		test_linkfail=1024 fastclose=server \
>  			run_tests $ns1 $ns2 10.0.1.1
> -		chk_join_nr 0 0 0 0 0 0 1
> +		join_rst_nr=1 \
> +			chk_join_nr 0 0 0
>  		chk_fclose_nr 1 1 invert
>  		chk_rst_nr 1 1
>  	fi
> @@ -3157,7 +3164,10 @@ fail_tests()
>  		MPTCP_LIB_SUBTEST_FLAKY=1
>  		test_linkfail=128 \
>  			run_tests $ns1 $ns2 10.0.1.1
> -		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
> +		join_csum_ns1=+1 join_csum_ns2=+0 \
> +			join_fail_nr=1 join_rst_nr=0 join_infi_nr=1
> \

Can we drop this "join_rst_nr=0"?

> +			join_corrupted_pkts="$(pedit_action_pkts)" \
> +			chk_join_nr 0 0 0
>  		chk_fail_nr 1 -1 invert
>  	fi
>  
> @@ -3170,7 +3180,10 @@ fail_tests()
>  		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags
> subflow
>  		test_linkfail=1024 \
>  			run_tests $ns1 $ns2 10.0.1.1
> -		chk_join_nr 1 1 1 1 0 1 1 0 "$(pedit_action_pkts)"
> +		join_csum_ns1=1 join_csum_ns2=0 \
> +			join_fail_nr=1 join_rst_nr=1 join_infi_nr=0
> \

And this "join_infi_nr=0".

> +			join_corrupted_pkts="$(pedit_action_pkts)" \
> +			chk_join_nr 1 1 1
>  	fi
>  }
>  
> 

