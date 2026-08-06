Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F4623BD06;
	Thu,  6 Aug 2026 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020211; cv=none; b=mx8xTVvMj0hZF2AAH7/A8iiC3HrjdYykIn8UNNxyXyHpjYsP8skkX5OjMopJAVWKT7ID8VyRPU/wYw1uRY0PBN+9g7nC4y+NV1ESk7l6OAv63HVgxc8W8+6PhKzCppP3O1vhaeC0/QaUICOzXOHb+5lpIO7bVR9efg8Y2f4a4i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020211; c=relaxed/simple;
	bh=DK0cqkFmwiEXsaiPBauXtuB9eUxCxcSyKeeVLE4Nb0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+VfCcHHJfH6bvVVnPOOL87w+34Z7MdxkFUTwkPGE2bhA8nej8roC9kDuG3HnvMaRG4kOubWEvYGytyDEZHDVRQI9jxUU5kjkoct1xv+C6lJBKfI7HRIO5WApxnatfef8dE9BIhNMG3suBgAZokEUtCsSorRnDr8qfOjCd7OCGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7IKnd37; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7IKnd37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6201F000E9;
	Thu,  6 Aug 2026 12:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020209;
	bh=JoqeMau3HW0OzVxuPyJJqm+W627ZrvxUuvEC4cmRcEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V7IKnd37YedOHKea36qH8Zz2FT/QrvYvV5YaoV4bFM2O/19TRFR9qC6M4KG5DQAZt
	 BvRH9sqTZtoCn0TPzXMtrgP9+QZfq3IrFR84//y7RisTLOgiKlSQza0PwEw39g3BeL
	 9M0B1YQ78n8MzQpGZA8ycCEsJdvafKNRV5brPc+dyyn/hYRFzJSJHfSEKXN847vvrs
	 EAK8fNG7e9q15NjVysv7EnM2rs0P3IIciV4YjNFFJCRWRiGhvm3RiyhWEosutwCFES
	 vY/L5dY2C8NMZJ1nQIUa+C8EO3m1fKUXMBV1tRqfv87cXLKc+CxclnJEjIw4JVosQD
	 lsUAX1O2TL7XQ==
Message-ID: <202a6f62-6ffb-4f18-9168-66621b2963f3@kernel.org>
Date: Thu, 6 Aug 2026 14:43:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v3 0/2] mptcp: fix request migration ownership
Content-Language: fr
To: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com,
 kylebot@openai.com, david.lee@trailofbits.com, vega@nebusec.ai,
 caoruide123@gmail.com, sashiko-bot@kernel.org
References: <cover.1785995291.git.caoruide123@gmail.com>
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
In-Reply-To: <cover.1785995291.git.caoruide123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ren, Ruide,

Thank you for the v3! Here is a quick reaction, only about the
reproducers, not about the kernel code:

On 06/08/2026 13:14, Ren Wei wrote:

(...)

> Changes in v3:

(...)

> - Added a packetdrill MP_CAPABLE reproducer and decoded warning.

Nice, very appreciated, thank you!

I confirm they work well!
> // poc for MP_JOIN:
> 
> // Minimal reproducer for a stale subflow_req->msk after reqsk migration.
> --tolerance_usecs=200000
> --non_fatal=packet
> 
> `sysctl -q net.mptcp.enabled=1

Small details to help you next time to look at packetdrill reproducers
for MPTCP:

 - You can add new tests in gtests/net/mptcp/<dir>/<file>.pkt from the
   MPTCP packetdrill repository.
 - Then here above, you can add: `../common/defaults.sh`.
 - And execute your tests with run_all.py from the gtests/net dir, e.g.:
   ./packetdrill/run_all.py -lv4 mptcp/<dir>/<file>.pkt

These tests will then be executed from a dedicated netns, using many
sysctl settings: this helps to reproduce issues in a more controlled
environment.

> sysctl -q net.ipv4.tcp_migrate_req=1
> sysctl -q net.ipv4.tcp_synack_retries=1`

(detail) Here, tcp_synack_retries can be set to 0, then the sleep at the
end can be reduced.
> // Listener A and the owning MPTCP connection.
> +0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
> +0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> +0     setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) = 0
> +0     bind(3, ..., ...) = 0
> +0     listen(3, 8) = 0
> 
> +0.0   <  addr[caddr0] > addr[saddr0]  S   0:0(0)         win 65535  <mss 1460, sackOK, TS val 1000 ecr 0,    nop, wscale 8, mpcapable v1 flags[flag_h] nokey>

Also for next time, when validating the listener side, feel free to drop
the TCP Timestamps option if it is not required (like what you did with
the other test): that makes the .pkt file more readable.

(...)

> MP_CAPABLE packetdrill reproducer:
> 
> // Reproducer for MP_CAPABLE request token ownership during TCP req migration.
> //
> // The first listener owns the request created by the MP_CAPABLE SYN.  A second
> // SO_REUSEPORT listener is added only after that SYN, then the first listener is
> // closed.  The SYN+ACK retransmission timer migrates the request to the second
> // listener, and a later request timer destroys the migrated request.
> //
> // On a vulnerable kernel, inet_reqsk_clone() raw-copies token_node.  The clone
> // is not the token table owner, so destroying the migrated request triggers the
> // MPTCP token ownership bug.
> --tolerance_usecs=250000
> 
> +0     `sysctl -q net.mptcp.enabled=1`
> +0     `sysctl -q net.ipv4.tcp_migrate_req=1`
> +0     `sysctl -q net.ipv4.tcp_synack_retries=2`
> +0     `sysctl -q net.ipv4.tcp_timestamps=1`
> +0     `sysctl -q kernel.panic_on_warn=0`
> +0     `sysctl -q kernel.panic_on_oops=0`
> +0     `ip tcp_metrics flush all >/dev/null 2>&1 || true`
> +0     `tc qdisc replace dev tun0 root pfifo >/dev/null 2>&1 || true`

Same here for `../common/defaults.sh`. Then I guess you only need
tcp_migrate_req=1 and tcp_synack_retries=2 (set to 0 to reduce the last
wait), and "wscale" will always be 8 in the S(.) instead of depending on
the environment.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

