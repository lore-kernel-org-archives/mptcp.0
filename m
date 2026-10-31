Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440973;
	b=PoP/Y95Zic3zmZKwf+dUrhBKRRR1AVjhvDi1AkJvY6tFiO8Rw8A623gupMft/u0yDztb
	 w7HhGb8IsMHZIYoPegmqUbzv1h+J22UV3pl+jGomSNj5VtdXRwnjWat5ggrC3Fsc4sLeL
	 qBcT2f5Kp/UC3oN7DFVm4RtTlKj+cORzh6qDJqppuokRL2LPhEXzk97UPHBw0XZgU3ryM
	 aUh4K606ZgHxw53u5TFxlTbKxuOZPYcuD9/51yETEu0mcU9v/rxxE32DITaaGAKA8++Mx
	 dzmMkhH8EnQvX1F4P17Vx0tkySPVCsodl5gixvHQnDZMxvMXDl1Yj4ZfThO3GXs2tdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440973;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6rV84S6eanCegLb0TzfzwLYY0wkXOw6dPHzz+4yboXQ=;
	b=mJO1AIRdFZQXSVOCoIDYVzOUKqwpztCexqrLxWiFvgvIXsayMAJ936nCKPRQTVu6PM+/
	 kVec/nysMX5vmsaUKE9V98dOw0TpYmxw7NRPVka9J6DqBIkez4twicnKOkvYbmXZKeHYr
	 Bq8veGTMbjAcNMXzGpufunbZxjmUzAyQ2elrR3bDwaiB+vYBky1DSHoD2PxwHdJS0pt3o
	 Ugf5W2D0nO4OJV5lbZUHT3Zd7/RXVfCoDvxGvpfSDOpzFOhHQ2ZgBTpoCAT/dSbt3Txnl
	 uzyWRCMxZIFnJODRYvszauOTRVRaI+a1njXh+UCT04G6VxsrFkG2zqLeEaxqPhWwuuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlXA3vMG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D134606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlXA3vMG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886521F000C1;
	Sat, 31 Oct 2026 10:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440972;
	bh=6rV84S6eanCegLb0TzfzwLYY0wkXOw6dPHzz+4yboXQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KlXA3vMGx2Wo+50XgObLV1yADg9VKBZD//UTlLAto5nR2Yyis2YtvLVmVf5K9Tm1Q
	 vyhdN5HTpJMd9ywQizQh4XlBcR/qXyh+A2b/DVCcVayIIkGK8w0z7BkvzBWgCQKGE5
	 sKvEDMydDoE42L491rEztS+mXjE8fZlN9Iyn6dJlzdfCN/yEdfYJebtFDaKZgY+xTL
	 U3BXD4vpDhPfbmDVQ6bFCXLKSGEnH7Ed5fI+8TtULAhuFq6Q9KrsaQpDazvNQO2E5u
	 DfVdGOxy7D1VNekt3OWTnubDhxgNpA0P7lSu0ma2I10n5Po7ymoKGKHsH+jL9e9c8d
	 bKm04ZZqroNcQ==
Subject:
 Re: [PATCH mptcp-next v3 2/3] mptcp: options: track invalid suboptions
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 10:02:52 +0000
Message-ID: <179344097210.3128.4507803185066572219@kernel.org>
In-Reply-To: <20261029-mptcp-mib-inval-opt-v3-2-428f42a35674@kernel.org>
References: <20261029-mptcp-mib-inval-opt-v3-2-428f42a35674@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "receiving unsupported versions or
  extensions can happen, so this part shouldn't be considered as…
- [Medium] With CONFIG_MPTCP_IPV6 disabled, mptcp_parse_option()
  (net/mptcp/options.c:276-297) counts valid RFC 8684 IPv6 ADD_ADDR…
- [Low] In this commit, MPTCP_MIB_OPTINVALID is incremented once per
  parse pass inside mptcp_parse_option() (options.c:430), and the…

--

mptcp: options: track invalid suboptions

This commit adds a new MPTCP MIB counter, OptInvalid. mptcp_parse_option()
increments it when a suboption is combined with other suboptions in an
unexpected way, or has an invalid size. A struct sock pointer is now passed
through mptcp_get_options() so that the counter can be updated in the right
netns, and unsupported versions, extensions and unknown subtypes are left
uncounted.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cbc105199073e..10a150e2ad69e 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c

[ ... ]

> @@ -71,7 +71,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  		if (opsize != expected_opsize &&
>  		    (expected_opsize != TCPOLEN_MPTCP_MPC_ACK_DATA ||
>  		     opsize != TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM))
> -			break;
> +			goto invalid;
>  
>  		/* try to be gentle vs future versions on the initial syn */
>  		version = *ptr++ & MPTCP_VERSION_MASK;

[Severity: Medium]

The commit message says:

  Note that receiving unsupported versions or extensions can happen, so
  this part shouldn't be considered as invalid.

Does this size check still count an MPTCPv0 (RFC 6824) SYN as invalid?

On a SYN without ACK, expected_opsize is TCPOLEN_MPTCP_MPC_SYN, which is 4.
A v0 MP_CAPABLE on a SYN carries the sender key and is 12 bytes. It fails
this check and jumps to the invalid label before its version is read.

So it never reaches the version handling just below, which was kept as a
plain break:

	version = *ptr++ & MPTCP_VERSION_MASK;
	if (opsize != TCPOLEN_MPTCP_MPC_SYN) {
		if (version != MPTCP_SUPPORTED_VERSION)
			break;
	} else if (version < MPTCP_SUPPORTED_VERSION) {
		break;
	}

Every SYN to an MPTCP listener goes through
subflow_check_req()->mptcp_get_options(). That means each connection
attempt from a v0-only client increments MPTCP_MIB_OPTINVALID. The
connection still falls back to TCP as before, so only the counter is
affected.

The code path and the counting are unchanged at the end of the series,
after "mptcp: options: reset parsing in case of invalidity".

Could the version be checked before the strict size check on SYNs, or
could this case be left uncounted?

[ ... ]

> @@ -281,7 +283,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  				mp_opt->addr.family = AF_INET6;
>  #endif
>  			else
> -				break;
> +				goto invalid;
>  		} else {
>  			if (opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE ||
>  			    opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT)
> @@ -292,7 +294,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  				mp_opt->addr.family = AF_INET6;
>  #endif
>  			else
> -				break;
> +				goto invalid;
>  		}

[Severity: Medium]

When CONFIG_MPTCP_IPV6 is disabled, does a valid IPv6 ADD_ADDR now get
counted as invalid?

MPTCP_IPV6 depends on IPV6=y. On IPV6=n or IPV6=m builds, the branches that
match TCPOLEN_MPTCP_ADD_ADDR6 (28) and TCPOLEN_MPTCP_ADD_ADDR6_PORT (30) are
compiled out, so those lengths reach the first goto invalid. The echoed
lengths TCPOLEN_MPTCP_ADD_ADDR6_BASE (20) and
TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT (22) reach the second one.

RFC 8684 lets a dual-stack peer announce an IPv6 address on an IPv4
connection. That makes this legal input that is only unsupported locally,
like the unsupported versions and the default case ("Not invalid: maybe used
for experimentations"), which are not counted. Before this patch, the option
was simply ignored.

Later in the series, "mptcp: options: reset parsing in case of invalidity"
means this case would also discard suboptions already parsed from the same
packet, for example a DSS ack placed before the ADD_ADDR.

[ ... ]

> @@ -418,11 +420,17 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  		break;
>  
>  	default:
> +		/* Not invalid: maybe used for experimentations */
>  		break;
>  	}
> +
> +	return;
> +
> +invalid:
> +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OPTINVALID);
>  }

[Severity: Low]

In this commit, can the same invalid option be counted more than once for
a single skb?

The counter goes up once per parse pass. On the passive side, the third ACK
is parsed first in:

  subflow_syn_recv_sock()->mptcp_get_options()

and then again on the child in:

  tcp_child_process()->tcp_rcv_state_process()->tcp_data_queue()
    ->mptcp_incoming_options()->mptcp_get_options()

With syncookies, mptcp_subflow_init_cookie_req() parses it a third time.

If MPC_ACK or MPJ_ACK is still set after the invalid option, the child
stays MPTCP and MPTCP_MIB_OPTINVALID goes up two or three times. One
example is an MPC_ACK followed by a second MP_CAPABLE.

This looks resolved later in the series by "mptcp: options: reset parsing
in case of invalidity". That commit clears the parsed status at the first
invalid option, so the subflow falls back or is reset and the later passes
never run on that skb. The over-count is limited to this intermediate
commit.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-mptcp-mib-inval-opt-v3-0-428f42a35674%40kernel.org
