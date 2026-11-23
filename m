Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415551;
	b=SasY2rkTWUI6888jS+eZJTkSADAXsD1Sm3dwn8VjxdMAf1c4LXYALKOecpLaLAPfemK3
	 IFRXxKX7gHHPHFeYMlTqLUo6PfnRNhYl33FeSiD0Jsrv+UpFE8NZJDLJB3lNkzlRsJi8+
	 RrUvyJzr+6Vfo0b8vwHws2ZYJQGf5Hn/ggORFoCUlD7vDH1eBl8ZnTZHbt17rzU+wiq1K
	 ujZAGFMbR45I545U8huufgF8rmhxeMQqkmuAsNpnqh9GfeZxSJW8u82z308mM06NOdxCN
	 8GYE3ElsD7G5IOEOqjmy3WuNd4WWSrDG6sYMNecD1N+bvQHrKecekuJnlO6AUYwFe5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415551;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CQWW0t7l1f53J04oCvzAbGjbfKaVwZ5h+T7Jd4R2u68=;
	b=nFGFZxS2JFYPHXV8rDooTXgtOtwGR1vqr+2J4LNAIsZqpHJISk2JD6MzmbtJy97ohuPW
	 ELz5/A419DR7syQ41Wvw4u8936GzftdpjXYxOxGnLvDBmVo2wJYzvYvAABWhjdXAAbGh2
	 cUaE+fRSjydnP+gTNXXrGSCaQ9jKwTu/PMs8k97GMbBfFh5R3TA3vwfZ2PfBbakQ88MOJ
	 F7U/E6LQJdpTzsrIq4IPF8kWL4gdwfazfc4sJwZ83YrBpVrL5HnIENIOW4Dq1T0dCcjgg
	 ntmDYT8FE/kU+87lToNZ5XH+m/Vz3/xexegHg2mPi9w1OK9Bfe61t8qtEUGBJlq2CNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKy80TnJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F06606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKy80TnJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FB11F000D2;
	Mon, 23 Nov 2026 06:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415551;
	bh=CQWW0t7l1f53J04oCvzAbGjbfKaVwZ5h+T7Jd4R2u68=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kKy80TnJJyEAwjNCf7IY3oIJC5RAQjROI9iMglZxKODTngCMTH1qx4DxzjZIy7Qi6
	 7tnwiOMahSB670M3Jddl2dwYVzQO11RZQWmNgtX1XIkBp4Z/HtDXsBsgP0C39sXGdr
	 ynhEyZ54YyK7GZGwY3SL0wh1PBm1I4AZe6jQINQO7xGsd8UDYjkoB6DJis52Zn3w0m
	 RLCRyAeTvImwnfvj3at4cuY46W3c6qQfrG4bRuxehc0NNdTKwsXuKuGXZA6ArXnn+o
	 T+ylIlxqZiMeHH1UveJ3z40FTwa7WWcQcsOdKfuSJiWpC0O6RFWhoBwWk5BCa62fTU
	 GzxWWDfd481nw==
Subject:
 Re: [PATCH mptcp-net v2 23/62] mptcp: no sf left: process pending DATA_FIN
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:30 +0000
Message-ID: <179541555052.3133.2432257885712070240@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-23-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-23-00327fd1de1f@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mptcp: tcp_disconnect() clears SOCK_DONE before
  mptcp_check_rcv_close()

--

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2818,9 +2830,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  			mptcp_schedule_work(sk);
>  		} else if (sk->sk_state != TCP_ESTABLISHED ||
>  			   msk->in_accept_queue) {
> -			/* After the close, an MP_FASTCLOSE would be ignored */
> -			mptcp_check_fastclose(msk);
> -
> +			mptcp_check_rcv_close(sk);
>  			mptcp_set_state(sk, TCP_CLOSE);
>  			WRITE_ONCE(sk->sk_shutdown,
>  				   sk->sk_shutdown | SEND_SHUTDOWN);
>

[Severity: Medium]
On a fallback connection, I think this is called too late for
mptcp_check_data_fin() to propagate SOCK_DONE to the MPTCP socket.

To reach this branch, msk->first is the only subflow and is already in
TCP_CLOSE, and the msk is not SOCK_DEAD, so dispose_it is false. That
means __mptcp_subflow_disconnect() has already been called on
msk->first before jumping to out:. With the subflow in TCP_CLOSE, it
calls tcp_disconnect(ssk, 0), which unconditionally clears SOCK_DONE
on the subflow.

mptcp_check_rcv_close() then spools the backlog and calls
mptcp_check_data_fin(). On fallback, that function only sets SOCK_DONE
on sk if msk->first still has SOCK_DONE, which tcp_disconnect() just
reset. This is the exact case the patch is fixing: the last data and
the FIN were received while the worker owned the msk, so the data is
still in msk->backlog_list. In that case rcv_data_fin is consumed, but
SOCK_DONE is never set on sk.

That matters for mptcp_recvmsg() and mptcp_splice_read(). Suppose
sk_err gets set afterwards, e.g. by a RST following the peer's FIN, or
by the error set on close from FIN_WAIT1/CLOSING later in this series.
Without SOCK_DONE on sk, the reader would get -ECONNRESET or -EPIPE
after draining the data instead of 0 (EOF).

Should SOCK_DONE on msk->first be sampled before the subflow is
disconnected? Or should mptcp_check_rcv_close() be called earlier in
__mptcp_close_ssk(), before __mptcp_subflow_disconnect()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
