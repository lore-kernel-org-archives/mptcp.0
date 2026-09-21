Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2454D0CDF;
	Mon, 21 Sep 2026 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015956; cv=none; b=Ao15MXtAWPOSgZ/WunUsxqQyAn8l3YCWoXKia/7NT1txZ+lDTudU31qELG+/JnSCPulY98vFQXpOC/rJUHEvH0SgS3BQh0qbbh5BsdqKZgP++2SnEz7UX2VUFJQ8NUzgYl3QBeK/W31rfP1BMqciTB7Ml7RzL9oeQowUYjX1iVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015956; c=relaxed/simple;
	bh=DqNNLGNR3ctF8t2tpsjBQ0im7SGgiH8XvhRHJU6bQws=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=luQv/SVPdWAQYNlsuODWijMmNbkm3lYZCCerhezs83TXwLktoWZ4LwFDYGFVG4KBrkeuZa09bU+z0eOHSpEL9NlwaUlovauvhN0B5qDofVp7zWO/5RrhbXFtJV8K7p7mLSFU31FANGoKYaokeSHhX/503BLAVvBgAzdi428UgXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANtfCLV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANtfCLV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8877D1F00893;
	Mon, 21 Sep 2026 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015954;
	bh=yZunkGbCJx9XTDGw0iPLe5oHZ7LJFHE0Pl5dNj/PA1E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ANtfCLV287BppVzeS+OwPW/vv16U3hh2fWMjzBRppHIw4nzTG1XE0dulKHVcyjGCI
	 yErup1t0mMoAibzGKWYu7qY+foVMciICUjHeCQLvZCyb8iZyF+HAX4plJiXKuvPMUu
	 M88qT9XeosRaOFi3Ztqifeez7uzZ6mrEdAyaaF8URMF9waNmWVEJnXJ0bACpMs/WRv
	 kGpQ2xwk6Q9OmtzzlksjZDyBjly6DyjXj6Zxi99LN50FCbI33DFX+Y+SBmPfo5pDev
	 FI9BYrQXgj+E6CbVNoFQgOv0ZOtcfYLljHz8i8nw+G05ru2QZdF4nQINQ6mwfSMxBh
	 BuGpY8grcB+rQ==
Subject:
 Re: [PATCH net-next 3/4] mptcp: propagate RECVERR sockopts to subflows
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 devnexen@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Date: Mon, 21 Sep 2026 18:39:13 +0000
Message-ID: <179001595305.2160803.9169166654380498423@kernel.org>
In-Reply-To:
 <20260918-net-next-mptcp-msg_errqueue-v1-3-dd77e1738248@kernel.org>
References:
 <20260918-net-next-mptcp-msg_errqueue-v1-3-dd77e1738248@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new in-code comment in mptcp_setsockopt_all_sf()
  (net/mptcp/sockopt.c:417-420) and the commit changelog both justify…
- [Low] Short-buffer getsockopt ABI mismatch for the two newly supported
  IPv6 options: mptcp_getsockopt_v6() (net/mptcp/sockopt.c:1579 and…

Pre-existing issues:
- [Low] Inconsistent SOL_IPV6 getsockopt surface inside
  mptcp_getsockopt_v6() (net/mptcp/sockopt.c): the two newly added cases…

--

mptcp: propagate RECVERR sockopts to subflows

This adds IP_RECVERR/IP_RECVERR_RFC4884 and IPV6_RECVERR/
IPV6_RECVERR_RFC4884 handling to the MPTCP setsockopt and getsockopt
paths, pushing the value to all existing subflows and extending
MPTCP_INET_FLAGS_MASK so new subflows inherit the bits through
sync_socket_options().

A few questions below about the new comment, the changelog wording and the
getsockopt surface.

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 2ba56832587e..922f6ae5c80c 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c

[ ... ]

> @@ -398,6 +403,86 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>  	return -EOPNOTSUPP;
>  }
>  
> +static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
> +				   int optname, sockptr_t optval,
> +				   unsigned int optlen)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	int ret = 0;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		int err;
> +
> +		/* SOL_IPV6 options on a v4 subflow (v4 MP_JOIN, or userspace PM
> +		 * grafting a v4 subflow onto an AF_INET6 msk) would otherwise
> +		 * abort the loop with -EAFNOSUPPORT from ipv6_setsockopt().
> +		 */
> +		if (level == SOL_IPV6 && ssk->sk_family != AF_INET6)
> +			continue;
> +
> +		err = tcp_setsockopt(ssk, level, optname, optval, optlen);
> +		if (err < 0 && ret == 0)
> +			ret = err;
> +	}
> +
> +	if (!ret)
> +		sockopt_seq_inc(msk);
> +
> +	return ret;
> +}

[Severity: Medium]
Does the comment above the new skip describe what the loop actually does?

The loop records only the first error and keeps going:

	err = tcp_setsockopt(ssk, level, optname, optval, optlen);
	if (err < 0 && ret == 0)
		ret = err;

There is no break or return, so the remaining subflows are still visited.
Without the guard the visible effects would be the errno returned to
userspace plus the skipped sockopt_seq_inc(msk), not an aborted loop.

Is -EAFNOSUPPORT from ipv6_setsockopt() the right errno to name here?  For
a v4 subflow, tcp_setsockopt() with level != SOL_TCP dispatches through
icsk_af_ops->setsockopt, and net/mptcp/subflow.c sets

	subflow_specific = ipv4_specific;

so the call lands in ip_setsockopt(), which starts with:

	if (level != SOL_IP)
		return -ENOPROTOOPT;

ipv6_setsockopt() is never entered in that case, and grepping
net/ipv6/ipv6_sockglue.c for EAFNOSUPPORT gives no match; do_ipv6_setsockopt()
does not check sk_family either.  Could the comment say -ENOPROTOOPT from
ip_setsockopt() and describe the suppressed sockopt_seq_inc() instead of a
loop abort?  The guard itself looks correct and needed.

The changelog repeats the same reasoning:

    mptcp_setsockopt_all_sf() skips IPv4 subflows when called with
    SOL_IPV6: ipv6_setsockopt() on a sock with sk_family != AF_INET6
    returns an error, which would abort the loop and leave the remaining
    subflows desynchronised.

Could that be reworded for the same reasons?

The changelog also says:

    mptcp_setsockopt_recverr() snapshots optval into a local int, applies
    it to the parent socket via ip_setsockopt() / ipv6_setsockopt(), bumps
    msk->setsockopt_seq, and forwards to every subflow via
    mptcp_setsockopt_all_sf().

Does that match the order in the new helper?  mptcp_setsockopt_recverr()
passes the caller's sockptr and optlen straight to ip_setsockopt() /
ipv6_setsockopt() first, then reads the resulting bit into val, and
setsockopt_seq is bumped inside mptcp_setsockopt_all_sf() after a
successful forward, not before it.

[ ... ]

> @@ -1498,6 +1576,16 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
>  	case IPV6_FREEBIND:
>  		return mptcp_put_int_option(msk, optval, optlen,
>  					    inet_test_bit(FREEBIND, sk));
> +	case IPV6_RECVERR:
> +		if (sk->sk_family != AF_INET6)
> +			return -ENOPROTOOPT;
> +		return mptcp_put_int_option(msk, optval, optlen,
> +					    inet6_test_bit(RECVERR6, sk));
> +	case IPV6_RECVERR_RFC4884:
> +		if (sk->sk_family != AF_INET6)
> +			return -ENOPROTOOPT;
> +		return mptcp_put_int_option(msk, optval, optlen,
> +					    inet6_test_bit(RECVERR6_RFC4884, sk));

[Severity: Low]
This is a pre-existing inconsistency rather than something the patch
introduces, but the two new cases in mptcp_getsockopt_v6() now behave
differently from their neighbours in the same switch.

IPV6_V6ONLY, IPV6_TRANSPARENT and IPV6_FREEBIND answer a SOL_IPV6
getsockopt on an AF_INET msk by returning the IPv4 inet_flags bit, with no
family gate, while the new IPV6_RECVERR and IPV6_RECVERR_RFC4884 cases
return -ENOPROTOOPT there.

Plain TCP on an AF_INET socket rejects every SOL_IPV6 getsockopt through
ip_getsockopt()'s level != SOL_IP check, so the new cases look like the
stricter and more correct side.  Would it make sense to align the older
cases with the new gate, or is the divergence intentional for now?

[Severity: Low]
Does routing these two options through mptcp_put_int_option() change the
short-buffer behaviour compared to plain TCP?

mptcp_put_int_option() collapses any requested length of 1 to 3 bytes for a
0/1 value down to one byte:

	if (len < sizeof(int) && len > 0 && val >= 0 && val <= 255) {
		unsigned char ucval = (unsigned char)val;

		len = 1;

do_ipv6_getsockopt() instead keeps the requested length:

	len = min_t(unsigned int, sizeof(int), len);
	if (copy_to_sockptr(optlen, &len, sizeof(int)))
		return -EFAULT;
	if (copy_to_sockptr(optval, &val, len))
		return -EFAULT;

So getsockopt(SOL_IPV6, IPV6_RECVERR, buf, &len) with len of 2 or 3 reports
optlen 1 on an MPTCP socket and 2 or 3 on a TCP socket, and with len 1 the
returned byte comes from an unsigned char conversion rather than the first
byte of the native int, which differs on big-endian.

This matches what mptcp already does for IPV6_FREEBIND and
IPV6_TRANSPARENT, so the helper behaviour is not new here, only its use for
these two options.  Is the difference acceptable, or should these follow the
IPv6 stack's length handling?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-net-next-mptcp-msg_errqueue-v1-0-dd77e1738248%40kernel.org
