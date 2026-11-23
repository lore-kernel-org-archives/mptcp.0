Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415552;
	b=prtvvspCkYj0r2DAOrtu7og1/Mnxv5z1bAjv0doSpOXq81lQmjMM0beE0BKc2U5KbWeA
	 79CBbPPM3ZOxTcxr9LnAmV4ZEmE00Vx8fTdGC/TR1nQgrjQvv+jEBXA5dcXujVOyMLR9g
	 RF2kdeV1Dt1TjpLgXYVXyzX6yqkGxnDMzDE0nMBhH3HXtpslV6z4PB4QqQ7+6Bsi04gTD
	 UknKCnYg7mdYPfTf9E7K0j0QxFC9OY7p1v2Vr3AzUVKqtixyjQrjw9hP747NG5wMTojsk
	 GN4cISypMsnfCdrlQhmTTJN1JoQhWhX55vJ+x2L1Hld5IZ+PojEpee/uQPS6MCq8+6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415552;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=195uvu5i9+qlmet4is4DWZuS/fgKm31kv3GM7Sur+6g=;
	b=LDlgqYXWYWsp9dVrRFBpeU7eRmEhL9ig8lmx81ZfCi1RrftvFU89lMN8ejUpgr7zTQTs
	 vPiIALu9kCneaNIO0PF5ic0kiq6LJxNGnY2pdUV2U81l95hrJwNWkw454pELTOB2gNEJP
	 DeDStn3IqepkGyMb/uqF7h5ujH83vqiB968PIIdZTb6SiKbO6OJQxhFw/VBWa+1sdIC4p
	 eDpS/tT0jQEZEHiylRTyAdneD++XHHNHV2lTi8ISGVNlsK91TQVx6nl4H3WEIlXIp2Hjq
	 w9FhpTXdHZl6AnURwDkrb6fq+Kai71xEHi9bfI2PRcEZPOKL87lsbcOpINJVtE3u2GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUCNCj54;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1589606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUCNCj54
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FEC1F000C0;
	Mon, 23 Nov 2026 06:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415552;
	bh=195uvu5i9+qlmet4is4DWZuS/fgKm31kv3GM7Sur+6g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LUCNCj54vQ3fRKcB4RIWmycLvxihA9zI0u9/XvX0W1lPcOchSH4/WWm0wVqBb0y5D
	 OoOIQUJlCqOyoDqfSHYJBdYDn6QFaEJT8HhBwrfA2cDrDrL72EBUJWY3Yfmo5oSHrZ
	 djPer+OHd2FTddWoO9Kb6OPNGk1L9VHqx88p73xGVF6uDBVpHYv2zV2vAs1fzh1ldz
	 E9AZ7JlIIfe/HAPg10okiarvOeWw3bC7tzsCqDHEB5bjz5CPv1b8EWeTnbQZ1cT9SX
	 Sw4M8XqwNuXDG4O+jdxPg6wST1zTHY/luep2ExE6qZk9oL1AKALT9oig2TweeDcXDz
	 Jd2B6cBuSFcnQ==
Subject: Re: [PATCH mptcp-net v2 27/62] mptcp: report sf aborts during
 deferred connect
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:32 +0000
Message-ID: <179541555209.3133.8166839441596353366@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-27-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-27-00327fd1de1f@kernel.org>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] mptcp_sendmsg_fastopen() (net/mptcp/protocol.c:1979-1986) adds an
  early `return 0` for 'DEFER_CONNECT set on the msk but cleared on…
- [Low] The new comment in mptcp_sendmsg_fastopen()
  (net/mptcp/protocol.c:1976) says 'subflow aborted by tcp_abort(): its…

--

mptcp: report sf aborts during deferred connect

This patch adds a check to mptcp_sendmsg_fastopen(), taken after the
first subflow lock is held. If DEFER_CONNECT is still set on the msk but
has been cleared on the first subflow, the subflow error is passed to
the msk right away, and the function returns early. mptcp_sendmsg() then
reports the error via sk_stream_wait_connect() instead of returning
-EISCONN.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a9ce2b6317d35..f80fac0c22c06 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -1974,6 +1972,19 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  	ssk = msk->first;
>  
>  	lock_sock(ssk);
> +
> +	/* subflow aborted by tcp_abort(): its error report may be deferred.
> +	 * With MSG_FASTOPEN, the socket is disconnected below, as with TCP.
> +	 */

[Severity: Low]
This isn't a bug, but the comment seems narrower than the condition it
guards. The commit message says the same thing:

  "if DEFER_CONNECT is set on the msk, but no longer on the subflow, the
  subflow has been aborted."

The check below matches any path that clears DEFER_CONNECT on
msk->first. tcp_disconnect() also clears the bit, and it sets sk_err on
a SYN_SENT socket:

net/ipv4/tcp.c:tcp_disconnect() {
    ...
	inet_clear_bit(DEFER_CONNECT, sk);
    ...
}

MPTCP calls it on a SYN_SENT first subflow from mptcp_subflow_shutdown().
PM subflow removal can reach that, for example through
mptcp_pm_nl_subflow_destroy_doit() or mptcp_pm_rm_addr_or_subflow(). The
msk bit stays set:

mptcp_subflow_shutdown() {
    ...
	case TCP_SYN_SENT:
		WARN_ON_ONCE(tcp_disconnect(ssk, O_NONBLOCK));
    ...
}

__mptcp_close_ssk() keeps msk->first for the first subflow, so the new
check can still be reached after that.

tcp_abort() also clears the bit before its "Avoid closing the same
socket twice" check. On a subflow that is already closed, the bit is
cleared and tcp_abort() returns -ENOENT without aborting anything.

The tcp_disconnect() case still gets the right msk error, through
__mptcp_close_ssk()->mptcp_close_last_err().

Could the comment and the commit message say that the check covers any
clearing of DEFER_CONNECT on the first subflow, not only tcp_abort()?

> +	if (unlikely(!(msg->msg_flags & MSG_FASTOPEN) &&
> +		     inet_test_bit(DEFER_CONNECT, sk) &&
> +		     !inet_test_bit(DEFER_CONNECT, ssk))) {
> +		inet_clear_bit(DEFER_CONNECT, sk);
> +		__mptcp_subflow_error_report(sk, ssk);
> +		release_sock(ssk);
> +		return 0;
> +	}

[Severity: Low]
This early return also handles the case with no race. That is when
tcp_abort() hits the first subflow while the msk is not owned. The msk
is then already in TCP_CLOSE with sk_err set to ECONNABORTED, but its
DEFER_CONNECT bit is still set.

The commit message describes this case as:

  "Without the race, the msk is already in TCP_CLOSE with the error set:
  the same check also avoids going through tcp_sendmsg_fastopen() and
  __inet_stream_connect() in this case, except with MSG_FASTOPEN."

Does this case also change what userspace sees?

Before this patch, tcp_sendmsg_fastopen() skipped tcp_connect(). It then
called __inet_stream_connect() on the msk socket, which went from
SS_CONNECTING to the TCP_CLOSE check and then to:

net/ipv4/af_inet.c:__inet_stream_connect() {
    ...
sock_error:
	err = sock_error(sk) ? : -ECONNABORTED;
	sock->state = SS_UNCONNECTED;
    ...
}

After that, the fallback at the end of mptcp_sendmsg_fastopen()
disconnected the msk:

	if (!mptcp_disconnect(sk, 0)) {
		sk->sk_disconnects++;
		sk->sk_socket->state = SS_UNCONNECTED;
	}

So write() returned -ECONNABORTED, and connect() could be called again
right away.

After this patch, write() still returns -ECONNABORTED, but it now comes
from sk_stream_wait_connect(), which consumes sk_err. Nothing
disconnects the socket, so sock->state stays SS_CONNECTING.

The next connect() or sendto(MSG_FASTOPEN) goes through
__inet_stream_connect() again. It reaches sock_error a second time,
returns -ECONNABORTED again because sk_err is now 0, and only then
disconnects.

This matches plain TCP after tcp_abort(), which seems to be the intent.
The patch has a Fixes: tag and will probably go to stable. Could the
commit message mention this user-visible change on the non-race path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
