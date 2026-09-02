Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371643802F;
	Wed,  2 Sep 2026 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343248; cv=none; b=MZS+5aKhICYMcwpSDGYAaRcuD7k0a/u9B5n5Kt7RwxqRjpuxC9/xTkw172kH5Xn4Hg53MjOaIY1LhQaay7ajRVnaRhyONpufxIDaCmO940tDftx1WHUXJpTWJZGoSH9Gua2O1GdgFhCDAzQAgxAVFlgcv0GB1WpmRy9jGfYUm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343248; c=relaxed/simple;
	bh=ykt6Va/lDPFmMmRlQUH+M8p5vUrvXvZGFi4cstllRi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLdNkZQmqOhngqRnbCWi4KeYJInWxifFjNTzBQje6IeDNitX0TcM9tGGrVGAE7q7iTYVKKVGSi9tnZ7eH10TdJbqhHH3MgXMFOWSxAtER1SBhm3hW699Aoi1z+VVGmsN2EN/ucUZG5Hd5L3gLsfvRhYVb8H2P971lkGhq0YIP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJMGadu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJMGadu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EAB1F000E9;
	Wed,  2 Sep 2026 10:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788343247;
	bh=2P2aeznVVcqZJgDMLTLIEl8DGWFRzzAkFW/jOBRMURs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LJMGadu1hEL5HvDD6wOQCw6Aq3NwrauijnrnFwBcALWtAlkq/xD3Z03WbwKuZhH0n
	 1gQ3e6xxCnQLohjTut7EVtG8QadShHUBuZYUIF3dKbHzcl9oVNscQ8vukdSf8aA619
	 y2ORhso4UqrpP9ie6gKahD+hDORtOoARCu2/dZMqvt9ZAktJVRcRYgKg6gmMmBRDlq
	 NIDiMvNvXQDrcsZa0JJjsLGvoftep51og4WOR1xp2WMP4foSIKFgPbCS1rlfC1lp4s
	 QNKSQlvvFgeGrVXHFzUyd7Ca25DWiSNsV2pTEXRsD+5f53eXFltmdkqSOhVd96W8tI
	 gg4bO/gLi4guA==
Message-ID: <513e6559-a06a-45d8-a8b7-72b3a1a77e71@kernel.org>
Date: Wed, 2 Sep 2026 12:00:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Content-Language: fr
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>, MPTCP Linux <mptcp@lists.linux.dev>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-2-559caa16f410@kylinos.cn>
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
In-Reply-To: <20260902-mptcp_nft-v1-2-559caa16f410@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hangbin,

On 02/09/2026 08:52, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> Replace the per-address-family iptables rules with a single inet table
> (mjoin_table) that handles both IPv4 and IPv6. The BPF bytecode for
> matching MPTCP add-addr and remove-addr suboptions is replaced with
> native nft matching via "tcp option mptcp subtype". Rule handles are

Good idea!

> captured via "nft -e --handle" so that rules can be selectively removed
> during tests.
> 
> The config file adds CONFIG_NFT_NUMGEN (replaces iptables statistic nth),
> CONFIG_NFT_REJECT and CONFIG_NFT_REJECT_IPV4 for reject‑related rules.
> 
> The iptables/ip6tables check inside mptcp_lib.sh is kept in case any
> one still need them.

Please remove them, not to be tempted to use them.

> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/config        |   3 +
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 136 +++++++++---------------
>  2 files changed, 51 insertions(+), 88 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> index 59051ee2a986..0d0a744c4ca8 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -30,6 +30,9 @@ CONFIG_NET_SCH_NETEM=m
>  CONFIG_NF_TABLES=m
>  CONFIG_NF_TABLES_INET=y
>  CONFIG_NFT_COMPAT=m
> +CONFIG_NFT_NUMGEN=y
> +CONFIG_NFT_REJECT=m
> +CONFIG_NFT_REJECT_IPV4=m

Even if we currently don't need the v6 version, I wonder if we shouldn't
add it here. Up to you, when we will need it, we can also add it here, fine.

I wonder if we shouldn't remove the ones linked to IPTables. I was
thinking that maybe we could keep them for debug purposes, but same as
the reject v6, we can add them when required instead of guessing which
ones would be useful, "just in case". So yes, do you mind removing the
ones that are no longer needed, please?

>  CONFIG_NFT_SOCKET=m
>  CONFIG_NFT_TPROXY=m
>  CONFIG_SYN_COOKIES=y
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 18ce7136a2b0..05cbaddb8261 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -26,8 +26,6 @@ capout=""
>  cappid=""
>  ns1=""
>  ns2=""
> -iptables="iptables"
> -ip6tables="ip6tables"
>  timeout_poll=30
>  timeout_test=$((timeout_poll * 2 + 1))
>  capture=false
> @@ -50,6 +48,7 @@ declare -A failed_tests
>  MPTCP_LIB_TEST_FORMAT="%03u %s\n"
>  TEST_NAME=""
>  nr_blank=6
> +nft_handle=""
>  
>  # These var are used only in some tests, make sure they are not already set
>  unset FAILING_LINKS
> @@ -99,42 +98,6 @@ unset add_addr_tx_nr
>  unset add_addr_echo_tx_nr
>  unset add_addr_drop_tx_nr
>  
> -# generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
> -#				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
> -CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
> -			       48 0 0 0,
> -			       84 0 0 240,
> -			       21 0 3 64,
> -			       48 0 0 54,
> -			       84 0 0 240,
> -			       21 6 7 48,
> -			       48 0 0 0,
> -			       84 0 0 240,
> -			       21 0 4 96,
> -			       48 0 0 74,
> -			       84 0 0 240,
> -			       21 0 1 48,
> -			       6 0 0 65535,
> -			       6 0 0 0"
> -
> -# IPv4: TCP hdr of 48B, a first suboption of 12B (DACK8), the RM_ADDR suboption
> -# generated using "nfbpf_compile '(ip[32] & 0xf0) == 0xc0 && ip[53] == 0x0c &&
> -#				  (ip[66] & 0xf0) == 0x40'"
> -CBPF_MPTCP_SUBOPTION_RM_ADDR="13,
> -			      48 0 0 0,
> -			      84 0 0 240,
> -			      21 0 9 64,
> -			      48 0 0 32,
> -			      84 0 0 240,
> -			      21 0 6 192,
> -			      48 0 0 53,
> -			      21 0 4 12,
> -			      48 0 0 66,
> -			      84 0 0 240,
> -			      21 0 1 64,
> -			      6 0 0 65535,
> -			      6 0 0 0"

Good to get rid of that. Also not to have get_maintainer.pl cc'ing the
BPF ML just for that :)

>  init_partial()
>  {
>  	capout=$(mktemp)
> @@ -147,6 +110,14 @@ init_partial()
>  		if $checksum; then
>  			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
>  		fi
> +
> +		ip netns exec "$netns" nft add table inet mjoin_table
> +		ip netns exec "$netns" nft add chain inet mjoin_table input \
> +			'{ type filter hook input priority filter; policy accept; }'
> +		ip netns exec "$netns" nft add chain inet mjoin_table output \
> +			'{ type filter hook output priority filter; policy accept; }'
> +		ip netns exec "$netns" nft add chain inet mjoin_table mangle \
> +			'{ type filter hook output priority mangle; policy accept; }'

I hope having this done by default for all subtests will not have a big
impact at the end when using a debug kernel. Do you mind checking the
impact, please? Just not to add a few seconds for each of the 130+
subtest if it is only needed in some of them.

If it is, we could move that to a new helper and call it when 'nft' is
required, it shouldn't be in many places I guess. This new helper could
also be used to add new rules, or this could be a "reset_" helper, I
didn't check what would be best.

>  	done
>  
>  	check_invert=0
> @@ -196,7 +167,7 @@ init() {
>  
>  	mptcp_lib_check_mptcp
>  	mptcp_lib_check_kallsyms
> -	mptcp_lib_check_tools ip tc ss "${iptables}" "${ip6tables}"
> +	mptcp_lib_check_tools ip tc ss nft
>  
>  	sin=$(mktemp)
>  	sout=$(mktemp)
> @@ -381,23 +352,18 @@ reset_with_cookies()
>  reset_with_add_addr_timeout()
>  {
>  	local ip="${2:-4}"
> -	local tables
>  
>  	reset "${1}" || return 1
>  
> -	tables="${iptables}"
> -	if [ $ip -eq 6 ]; then
> -		tables="${ip6tables}"
> -	fi
> -
>  	# set a maximum, to avoid too long timeout with exponential backoff
>  	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
>  
> -	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
> -			-m tcp --tcp-option 30 \
> -			-m bpf --bytecode \
> -			"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
> -			-j DROP; then
> +
> +	nft_handle=$(ip netns exec "$ns2" nft -e --handle add rule \
> +		inet mjoin_table output meta nfproto ipv${ip} \
> +		tcp option mptcp subtype add-addr \

That's clearer, nice!

I just hope devs and CIs will use a recent enough version for nft (>=
1.1.2 from Apr. 25) to support mptcp subtypes. (Fine to use them, no
need to have a fallback mechanism.)

> +		drop | head -n1 | awk '{print $NF}')

Why do you need "head -n1 | awk '{print $NF}'"? Can we not look at the
ret code like we did with IPTables?

Same below with the RM_ADDR subtype, but for the reject ones, you do
check the ret code.

EDIT: mmh, I see you are using "nft_handle" below, but not the one set
here, right?. That's not very clear when it is set in the function and
used later. Plus this field is not reset before/after each subtest. Is
this really needed? I guess you used it for others because it is easier
remove rules, right?

If you don't need this one (or any set in helpers), don't set it/them,
and don't use a global variable. Or reset it in init_partial, but prefer
using local variable with a limited scope.

Also, maybe clearer to use 'nft -j' with 'jq' to get that (if possible)?


One last note: for new features linked to MPTCP that might take multiple
versions to get ready, it might be better to send these patches only to
the MPTCP ML (no need to add anybody else in cc). Then we will apply
them in our tree and send them to netdev when we consider them as
"ready" (and hope for Clashiko not to get back to them days/weeks later,
but that should be a temporally issue :) ).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

