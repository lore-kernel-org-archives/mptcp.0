Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C891D5CEA
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182162; cv=none; b=KS8YkbEnvCjcGU1gu0BNNZFEszOUXwPWotVg+f7o3qu52cvMckxXgfX149PPbGRYqoH7T3a8P8Az1kQbmS/D56hGQSEpsPxhQKD3KaN7dyWFEZbSGU2xVMr4OLMTqYycNimKB4AqD50WiyShxt7orsHaYIGRSS9+xiNipTu6ZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182162; c=relaxed/simple;
	bh=jPJVUYBZalovfrMqoNKJRwmSyTsMZF9zKQxhGQAh0uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CUVAEhhrabwo3AwpZduHfM1+lHfBctD2lMp2MYSGMkPkn7yvXcym0rcVas7fBqQFd8xs7Zd2z8BbVk+7kWhvpyCqp+jyBndc9nfnOiB0Uf98hBBZqSZR4eGXm2z+HCtLJJteEaZxReWZXX3EmUcdPhV8Qui3lYoqJcKUm+LSpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrkqUoRu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrkqUoRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BAAC4CEED;
	Thu, 14 Aug 2025 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755182161;
	bh=jPJVUYBZalovfrMqoNKJRwmSyTsMZF9zKQxhGQAh0uk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rrkqUoRu1zs07VR5IrRfGBRE+KahOr6AAR1zl+E5xKFXf/ySGPO/I/kB9MFKs4S4c
	 HCnKl1lGxqDQUYCrhrdqYdC8yR+fiy5gFOer64XGHOdVC8pFWVR1JYsmTdxatmZdX3
	 3FwSb89bgGFviSRHrQ3QmZUvIRgw9r36mBfyHj0ViUWOSd5Nzbwn5vE24iCDJNiqHF
	 r+130uehXCymrGEdd5V11BCtG+lEwbvGRHMHRvl3Z0oV4IH1nSGNP0HZA9EZANEgMo
	 6X0tbZReIlSz1Iwj6BID/bIdAfCZKOWVwVDJCH1Ml39nqxk5XtiZw2OMcisu2sqs3Y
	 FHXkQB0EsxJ2Q==
Message-ID: <03fba60e-2c01-4570-9809-43d83a89f88a@kernel.org>
Date: Thu, 14 Aug 2025 16:35:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 1/2] selftests: net: mptcp: add checks for
 fallback counters
Content-Language: en-GB, fr-BE
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1755139312.git.yangang@kylinos.cn>
 <cda4fc3f4b901c1919adfc0ce4258be0b80e7ea9.1755139312.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cda4fc3f4b901c1919adfc0ce4258be0b80e7ea9.1755139312.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 14/08/2025 05:16, Gang Yan wrote:
> Recently, some mib counters about fallback has been added, this patch
> provides a helper to check the expected behavior of these mib counters
> during the test execution.

Thank you for the patch.

But alone, it doesn't make sense, and it is harder to review without
knowing how the helper is going to be used. Better to squash the two
patches together.

I think having patches dedicated to the introduction of new helpers only
make sense when such helpers will be used on another subsystem
(different maintainers) or when moving existing code to a new helper to
be re-used elsewhere. But here, I think it causes more troubles.

> 
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/571
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index b8af65373b3a..2c1f0704bc17 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -74,6 +74,15 @@ unset join_create_err
>  unset join_bind_err
>  unset join_connect_err
>  
> +unset infinite_map_tx_fb
> +unset dss_corruption_fb
> +unset simult_conn_fb
> +unset mpc_passive_fb
> +unset mpc_active_fb
> +unset mpc_data_fb
> +unset MD5_Sig_fb

No need to use capital letters here.

> +unset dss_fb

It might make more sense to use the "fb_" prefix, instead of the suffix,
similar to what has been done with "join_" above.

> +
>  # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
>  #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
>  CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
> @@ -1399,6 +1408,95 @@ chk_join_tx_nr()
>  	print_results "join Tx" ${rc}
>  }
>  
> +chk_fallback_nr()
> +{
> +	local infinite_map_tx=${infinite_map_tx_fb:-0}
> +	local dss_corruption=${dss_corruption_fb:-0}
> +	local simult_conn=${simult_conn_fb:-0}
> +	local mpc_passive=${mpc_passive_fb:-0}
> +	local mpc_active=${mpc_active_fb:-0}
> +	local mpc_data=${mpc_data_fb:-0}
> +	local MD5_Sig=${MD5_Sig_fb:-0}
> +	local dss=${dss_fb:-0}

No need to respect the reverse Xmas tree declaration for the variables
here in bash. I think it is better here (and above with the unset) to
follow the same order as below, when they are used, so it is easy to
check if they are all used correctly.

> +	local rc=${KSFT_PASS}
> +	local ns=$1
> +	local count
> +
> +	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCapableFallbackACK")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "$mpc_passive" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "mpc passive fallback "

All your "print_check" here and below have an extra whitespace before
the last double quote: why? I don't think it is needed.

> +		fail_test "got $count mpc passive fallback[s] expected $mpc_passive"

Because this helper is used twice, we need to know which direction had
an issue: can you pass that info (connector/listener or ns2/ns1) as
argument to this helper, and adding it to "print_check" and "fail_test"?
Same below.
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCapableFallbackSYNACK")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "$mpc_active" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "mpc active fallback "
> +		fail_test "got $count mpc active fallback[s] expected $mpc_active"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtDSSCorruptionFallback")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "$dss_corruption" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "dss corruption fallback "
> +		fail_test "got $count dss corruption fallback[s] expected $dss_corruption"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtInfiniteMapTx")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "$infinite_map_tx" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "infinite map tx fallback "
> +		fail_test "got $count infinite map tx fallback[s] expected $infinite_map_tx"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCapableDataFallback")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "$mpc_data" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "mpc data fallback "
> +		fail_test "got $count mpc data fallback[s] expected $mpc_data"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMD5SigFallback")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "$MD5_Sig" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "MD5 Sig fallback "
> +		fail_test "got $count MD5 Sig fallback[s] expected $MD5_Sig"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtDssFallback")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "$dss" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "dss fallback "
> +		fail_test "got $count dss fallback[s] expected $dss"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtSimultConnectFallback")
> +	if [ -z "$count" ]; then
> +		rc=${KSFT_SKIP}
> +	elif [ "$count" != "$simult_conn" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "simult conn fallback "
> +		fail_test "got $count simult conn fallback[s] expected $simult_conn"
> +	fi
> +
> +	print_results "check fallback nr" ${rc}

Just "fallback"?

EDIT: see the next patch: you should have a different message per netns.

> +}
> +
>  chk_join_nr()
>  {
>  	local syn_nr=$1

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

