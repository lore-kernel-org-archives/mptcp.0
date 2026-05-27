Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439AF35838B
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863067; cv=none; b=tBlt/joJ33HchTvvakNYzx0kto/rxhbSKpL0mg09+YWMZnZTlgzmUwALav1IOzciqYndq7LHcAMGsgH7WfKhr7FYrjBBwS51VYUxaaXEQcid0YSig7wJZ9cb2JW3ybWmlFPlDLRbWL2tyHk09sA1Ft86Ag+nWFTnw1bVYX1AMIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863067; c=relaxed/simple;
	bh=aznASPGp2kTqqUlqZPiv0ezGhdWJWgLi1QrK0s5DnhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=To5wvvLfN2xFrt4ZR8E0/dwJKqXl8XHLUek0dgXlxdaiRFHo0DuwL+zALYjayWmz7TQw+2mg4cfa8uSj1Cbpex/R/zsseCoZf424DdHPuSWbdHDzBo6/3MiLHGuE0Kfk2Gkf5KlSf2Y8ZwcJJdBLEN8GL3VpWkrBt5gOZypcG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWdC9Jif; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWdC9Jif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592D61F000E9;
	Wed, 27 May 2026 06:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779863063;
	bh=GW8adILk1zn74ty2oEFYlfdbUd6w3qx+mzLQAEggkpc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BWdC9Jif5Zv2MyJ1eD9yOW0wJJehkHmWBlc1iTZWrxmo11eLoynicEKwi7Iijn6az
	 Ik3pWFTwJd5sR9x7WN42NwEpD9u1NSnu9fOiyKZTKAvaSHjVatR5SXuW4BeqsnnDZq
	 NFjolSyOV5/yBNgOrQ76Ia7xGkMJvEIFPII6xsoC4Q3qTp+/zL8CUrxb2UuzLI7wfB
	 KQgBRyKa/bWByXF/1Wtz3kfSQulrgUllcFulUucICJiuvl055XvhDTm4HXeIT9JicE
	 MblqEva3SiSxtXKpQBm9cIrzL0FT4gsvq1CBNCdgUru/mHTmwzOXCj+nD7d2T4XuXp
	 BvmOqYeySRuBA==
Message-ID: <b69a2221-bd18-4435-a477-1ba830cc4f19@kernel.org>
Date: Wed, 27 May 2026 16:24:17 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 2/2] selftests: mptcp: extend chk_rst_nr to validate
 per-event RST counters
Content-Language: fr
To: Shardul Bankar <shardulsb08@gmail.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com,
 janak@mpiric.us, kalpan.jani@mpiricsoftware.com,
 Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <20260512103331.1934343-1-shardul.b@mpiricsoftware.com>
 <20260512103331.1934343-3-shardul.b@mpiricsoftware.com>
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
In-Reply-To: <20260512103331.1934343-3-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shardul,

On 12/05/2026 20:33, Shardul Bankar wrote:
> Extend chk_rst_nr() with named env-var expectations for each
> per-event MPTCP_RST_EMPTCP counter, matching the pattern used by
> chk_join_nr().  Each counter defaults to 0 and is checked silently
> on success; mismatches print a check line and fail the test.
> Counters absent from the running kernel are skipped silently so
> older kernels do not false-fail.
> 
> Add a test at the end of signal_address_tests that triggers
> MPJoinSynAckNoMPJoin: ns1 signals an address that is already bound
> on the client (ns2), where a TCP-only mptcp_connect listener is
> started.  The client's MP_JOIN routes locally to the TCP listener,
> which responds with a plain SYN/ACK without the MP_JOIN option, and
> the new counter increments on the client side.
> 
> Other per-event counters (MD5SigReset, MPJoinAckNoMPJoin,
> MPJoinAckNoCtx, DssReset, MPJoinNotEstablished) are not currently
> reachable from mptcp_join.sh; the env-var hooks are in place for
> future tests to set expectations explicitly.
> 
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
> v3:
>   - Drop the third-netns approach for triggering
>     MPJoinSynAckNoMPJoin.  Use ns1 signalling an address that is
>     already bound on ns2 (10.0.2.2) with a TCP-only mptcp_connect
>     listener on ns2; the client's MP_JOIN routes locally to that
>     listener and the SYN/ACK arrives without MP_JOIN.
>   - Move the test into signal_address_tests; drop the standalone
>     rst_emptcp_tests group and its sorted-list entry.
>   - Drop speed=slow (not needed: only one ADD_ADDR, no in-flight
>     actions).
>   - The local-and-assign that tripped shellcheck SC2155 is gone
>     with the old test.
> v2: https://lore.kernel.org/all/20260509183335.969018-1-shardul.b@mpiricsoftware.com/
> 
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 5d4d0f127f795..c6ef7f785a558 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -76,6 +76,13 @@ unset join_create_err
>  unset join_bind_err
>  unset join_connect_err
>  
> +unset rst_md5sig_reset
> +unset rst_synack_no_mpjoin
> +unset rst_ack_no_mpjoin
> +unset rst_ack_no_ctx
> +unset rst_dss_reset
> +unset rst_not_established

See below: I think you can use the 'join_' prefix and attach them above,
except for md5sig and dss that could also simply be called rst_dss and
rst_md5sig.

> +
>  unset fb_ns1
>  unset fb_ns2
>  unset fb_infinite_map_tx
> @@ -1349,6 +1356,12 @@ chk_rst_nr()
>  	local rst_tx=$1
>  	local rst_rx=$2
>  	local ns_invert=${3:-""}
> +	local md5sig_reset=${rst_md5sig_reset:-0}
> +	local synack_no_mpjoin=${rst_synack_no_mpjoin:-0}
> +	local ack_no_mpjoin=${rst_ack_no_mpjoin:-0}
> +	local ack_no_ctx=${rst_ack_no_ctx:-0}
> +	local dss_reset=${rst_dss_reset:-0}
> +	local not_established=${rst_not_established:-0}
>  	local count
>  	local ns_tx=$ns1
>  	local ns_rx=$ns2
> @@ -1385,6 +1398,43 @@ chk_rst_nr()
>  	else
>  		print_ok
>  	fi
> +
> +	# Per-event MPTCP_RST_EMPTCP counters; default 0, gated on availability.
> +	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMD5SigReset")
> +	if [ -n "$count" ] && [ "$count" != "$md5sig_reset" ]; then
> +		print_check "MD5SigReset ${tx}"
> +		fail_test "got $count MD5SigReset expected $md5sig_reset"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinSynAckNoMPJoin")

Here, the netns should be fixed: only the client should get it, and
using "chk_rst_nr ... invert" will not check at the right netns.

In fact, I think this counter and other MPJoin counters here below
should probably be added to the chk_join_nr() helper, no? Leaving here
only the MD5Sig and DSS related one. WDYT?

> +	if [ -n "$count" ] && [ "$count" != "$synack_no_mpjoin" ]; then
> +		print_check "MPJoinSynAckNoMPJoin ${rx}"
> +		fail_test "got $count MPJoinSynAckNoMPJoin expected $synack_no_mpjoin"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinAckNoMPJoin")
> +	if [ -n "$count" ] && [ "$count" != "$ack_no_mpjoin" ]; then
> +		print_check "MPJoinAckNoMPJoin ${tx}"
> +		fail_test "got $count MPJoinAckNoMPJoin expected $ack_no_mpjoin"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPJoinAckNoCtx")
> +	if [ -n "$count" ] && [ "$count" != "$ack_no_ctx" ]; then
> +		print_check "MPJoinAckNoCtx ${tx}"
> +		fail_test "got $count MPJoinAckNoCtx expected $ack_no_ctx"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtDssReset")
> +	if [ -n "$count" ] && [ "$count" != "$dss_reset" ]; then
> +		print_check "DssReset ${rx}"
> +		fail_test "got $count DssReset expected $dss_reset"
> +	fi
> +
> +	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPJoinNotEstablished")
> +	if [ -n "$count" ] && [ "$count" != "$not_established" ]; then
> +		print_check "MPJoinNotEstablished ${rx}"
> +		fail_test "got $count MPJoinNotEstablished expected $not_established"
> +	fi
>  }
>  
>  chk_infi_nr()
> @@ -2378,6 +2428,28 @@ signal_address_tests()
>  			chk_add_nr 4 4
>  		fi
>  	fi
> +
> +	# signalled address belongs to the client, where a TCP-only
> +	# listener is bound at it: the client's MP_JOIN routes locally
> +	# to the listener and receives a SYN/ACK without MP_JOIN.
> +	# MPJoinSynAckNoMPJoin increments on the client side.
> +	if reset "signal address, TCP-only listener on client"; then
> +		local extra_bind
> +
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns1 10.0.2.2 flags signal
> +
> +		ip netns exec ${ns2} ./mptcp_connect -l -t -1 -p "$(get_port)" \
> +			-s TCP 10.0.2.2 &
> +		extra_bind=$!

It would be better to call mptcp_lib_wait_local_port_listen(), just to
be sure it is listening. (Even if 'run_tests' will also call it on the
other netns)

On the other end, I see we didn't call it in similar other cases.

> +		run_tests $ns1 $ns2 10.0.1.1

See above: so here, call chk_join_nr() after, like in most tests, but
here check with join_synack_no_mpjoin=1.

> +		rst_synack_no_mpjoin=1 \
> +			chk_rst_nr 0 0
> +
> +		kill ${extra_bind} 2>/dev/null
> +	fi
>  }
>  
>  laminar_endp_tests()

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

