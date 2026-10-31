Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440974;
	b=vQL6dPfoQMIiQcQZHiuc3b3ws/AdcOWF6wmfffUICD3JUyX5ybiaW/7uowN3OQNfXzUr
	 X5KJSHQ8G0V6ziGqDWFRTJlEsnqkTmP6CF9oOz2fBujncSuIk3EWE1HwrO6MRn4DDl5me
	 QeEAhNmO2h/v5Q0GbaQUCgt8nz5rNdotu53TLdnHe2mSQDM8TxhLzGiaBlUE7IU+/82QP
	 5Gi/glnhItXLlPbGu2aFqXUVRlAkHtFfDfNQUhob2Lrj3XlbaKWovYHKHdkk7u3SctMwG
	 J0jawUQ2k0rbOVKe2oG13u1lTX+If3sbd/dsaYIArHy8WOTxlXqMqJvxDGLvNM4yZMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440974;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ul4Ckqq/uAtOSl6NhGdiUEx2AveNDa8KvSavUe0ANmw=;
	b=zEYbdNz3a18Dk5yxqPDkzCIuF14i6U2dcY1DDjzMGNYi60JMm9gZtD3jib7BsNWufOr2
	 5i65V5A4j0iRsVNKgwIutxMRM4ulKvNoTjYQxu+i5qCDzYvBRuZX35iDoySwOwHzPNgg8
	 ic2a+MYd6Qw4vwZuDXRF15qHnVyvdvgN8Lqs9OvcU8efd6Eqjt8/FnE6F6VQTyIfhSP0H
	 +n9s4Ja3V/PO2kFo8Rf2FMNTfgitDi5KYruCS5PDxhY0fJmlt+pIF4ZDchQxe2NkgHl9C
	 xqczXPRBLpRqCu3MidBqokvhTW5MEQtRoupyDkJUwMKNEqG//t8/gDXZa+1O8WdN3pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEBjzL00;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E7606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEBjzL00
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CB41F0093A;
	Sat, 31 Oct 2026 10:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440973;
	bh=ul4Ckqq/uAtOSl6NhGdiUEx2AveNDa8KvSavUe0ANmw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aEBjzL00sqEoTXKlSGZlBtu37K+gnyEIQ9+b7YOW2RAwLZ4Tlumpevj5Hc6MYiCJY
	 4vB42uJ2oi0KQ0o1wSU45GQRrtR6pojp4cj7YuOZ75XxJ9BL0F5R+fwR8eXvRQkK6b
	 YERT0aYU1CL53OSXzlcXvXnO1Vrx/kV5L1gOgxRT2Ou8o5jPKF4UjmoVcK48qZoL/B
	 Ul4E3AL6e5jXqA9MS2C0H/UDCJVLH27Up98Bv7kLy7t1nXFAWmsxft5VElbQmU/QUH
	 Kxr0LATEfBHMOLy+qgS98e8y6AkDVHCTUV0Btj+QoAANdkiuBYN50MsBq1FP2nf+Xq
	 rBC2qMfEQ/BTg==
Subject: Re: [PATCH mptcp-next v3 3/3] mptcp: options: reset parsing in case
 of invalidity
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sat, 31 Oct 2026 10:02:52 +0000
Message-ID: <179344097286.3128.8488107627745728800@kernel.org>
In-Reply-To: <20261029-mptcp-mib-inval-opt-v3-3-428f42a35674@kernel.org>
References: <20261029-mptcp-mib-inval-opt-v3-3-428f42a35674@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On kernels built without CONFIG_MPTCP_IPV6, a well-formed IPv6
  ADD_ADDR is now handled as a hostile option, and the valid suboptions…
- [Medium] mptcp_get_options() passes MPTCP options with opsize == 2
  (kind + length only, no subtype byte) to mptcp_parse_option(), and…

--

mptcp: options: reset parsing in case of invalidity

With this commit, mptcp_parse_option() returns false when it finds an
invalid suboption combination or size. mptcp_get_options() then clears
the whole status group and stops parsing. Any MPTCP option already
parsed from the same packet is dropped.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 10a150e2ad69e..b068f4f1861e3 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c

[ ... ]

> @@ -424,10 +418,11 @@ static void mptcp_parse_option(const struct sock *sk, const struct sk_buff *skb,
>  		break;
>  	}
>  
> -	return;
> +	return true;

[Severity: Medium]
Can a 2-byte MPTCP option get past the new reset here?

Before calling the parser, mptcp_get_options() only checks that
opsize >= 2. mptcp_parse_option() then reads the subtype without
checking for opsize >= 3:

    u8 subtype = *ptr >> 4;

When opsize == 2, that byte belongs to the next TCP option, or lies
after the TCP options. If it decodes to subtype 9-15, this case runs:

	default:
		/* Not invalid: maybe used for experimentations */
		break;

The function then returns true, so the status is not cleared.

Here is an example. A valid MP_PRIO is followed by "TCPOPT_MPTCP, 2",
which is followed by an option of kind 254 (TCPOPT_EXP, which decodes
as subtype 0xf). OPTION_MPTCP_PRIO is kept and applied, even though a
2-byte MPTCP option has an invalid size. The commit message says
invalid sizes should drop everything.

The DSS case also reads the flags byte before the expected_opsize
check:

		pr_debug("DSS\n");
		ptr++;

		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;

With opsize 2 or 3, this reads up to two bytes past the option.

The short option may be the last one in the header. In that case
those bytes are past th->doff * 4, which is the most tcp_v4_rcv()
guarantees to be linear. They may be tailroom or skb_shared_info
rather than packet data.

These out-of-option reads already existed before this patch. Only
the reset bypass is new.

Should opsize < 3 be treated as invalid before the subtype is read?
That would close the reset bypass and also avoid the out-of-option
reads.

>  
>  invalid:
>  	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OPTINVALID);
> +	return false;
>  }
>  
>  void mptcp_get_options(const struct sock *sk, const struct sk_buff *skb,
> @@ -464,9 +459,12 @@ void mptcp_get_options(const struct sock *sk, const struct sk_buff *skb,
>  				return;
>  			if (opsize > length)
>  				return;	/* don't parse partial options */
> -			if (opcode == TCPOPT_MPTCP)
> -				mptcp_parse_option(sk, skb, ptr, opsize,
> -						   mp_opt);
> +			if (opcode == TCPOPT_MPTCP &&
> +			    !mptcp_parse_option(sk, skb, ptr, opsize, mp_opt)) {
> +				/* invalid option, drop previously parsed opt */
> +				*(u32 *)&mp_opt->status = 0;
> +				return;
> +			}

[Severity: Medium]
On kernels built without CONFIG_MPTCP_IPV6, does this drop valid
suboptions?

In mptcp_parse_option(), the IPv6 ADD_ADDR sizes are only accepted
under IS_ENABLED(CONFIG_MPTCP_IPV6):

#if IS_ENABLED(CONFIG_MPTCP_IPV6)
			else if (opsize == TCPOLEN_MPTCP_ADD_ADDR6 ||
				 opsize == TCPOLEN_MPTCP_ADD_ADDR6_PORT)
				mp_opt->addr.family = AF_INET6;
#endif
			else
				goto invalid;

The echo path has the same pattern for the _BASE sizes.

MPTCP_IPV6 depends on IPV6=y. With CONFIG_IPV6=m or n, a well-formed
IPv6 ADD_ADDR now makes mptcp_parse_option() return false. The reset
above then clears every option parsed before it, and parsing stops,
so the options after it are skipped too. Before this patch, only the
unsupported ADD_ADDR was ignored.

A Linux peer can trigger this. In pm_kernel.c, select_signal_address()
announces signal endpoints of any family. A dual-stack peer can
therefore send an IPv6 ADD_ADDR on an IPv4 connection.

mptcp_established_options() can also put ADD_ADDR and MP_PRIO in the
same packet:

	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining,
					       has_ts, opts)) {
		...
	}

	if (mptcp_established_options_mp_prio(sk, &opt_size, remaining, opts)) {

mptcp_write_options() writes MP_PRIO after ADD_ADDR and clears
send_mp_prio:

		subflow->send_mp_prio = 0;

As a result, the MP_PRIO is never parsed and never resent. The subflow
backup state then stays out of sync between the two hosts.

The goto invalid for this case came with the previous patch in the
series. Dropping the other options along with it is new here.

The commit message says these packets come from "a buggy host, or an
attacker". The previous patch, "mptcp: options: track invalid
suboptions", says unsupported versions or extensions "shouldn't be
considered as invalid".

Should a kernel without IPv6 support treat an IPv6 ADD_ADDR as
unsupported here, rather than invalid?

>  			ptr += opsize - 2;
>  			length -= opsize;
>  		}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-mptcp-mib-inval-opt-v3-0-428f42a35674%40kernel.org
