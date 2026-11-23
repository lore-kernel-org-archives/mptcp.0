Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415545;
	b=LedZMufQncuYatnXwBECLwMHrCnDGyZaqDhaeiZU6cmrL3od2su/7XM7Vl/g51R1ZAcu
	 0Lfn1k42+XH+r33wWfD//rUiw7Gsj0G/6CBzbHZI80Buw10DfXA9Dc4WeQR8LuR6KdssU
	 h8OtqPl8a4ynhJqKrojHaZbuIPnDg2WiSQYwv7itvydSeU06t0szui4Lan54VIrPXvPLt
	 BxosnG+OoryJ440kn2uQZ0sNB9TmqiiOdAMnZw8PuH5O+zsDjOnRKOdyNUlCsYtx1i9ja
	 J/LoBV1dQqv7AVIKx+yQIJ8zD2lbmADMULJvTdXgPsVM49iZRgx6zMZNTD+1chFFxEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415545;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7SdpdrVw0hnqfMOmm9JAm+YX+2kiuJFyIFWDxo34RGg=;
	b=e3TYqgGwa/WK12V5cjmZxzNdU5nGQivFvkmnxP5aWbTa90Q3iTDkBoJX5RXWK4xAteKS
	 ivY96msSxsGR+0Z005JGNr1o47L+Vo/VQ4N386jB6uFKuTy3lxhff1NLXJGT/mjzQ8jO4
	 cD3fYsqUEMC2TNvdYdsxYgumezUS6nVOivGSjZ/elskpEPBNznUyF6DVEhz0PMRBDCZZH
	 n2jejqjwdFS/sV97wamp60JFVMYygNEbEiV6sddhdR/5KDpM7dUN5jh927adabm59qEfx
	 Qc6GtQ8xF88tzPDYO6gXxavpSnYKgQOpLgoZSxHVV4aS5IlO5EESjsBvaqmMw2jx7VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PB+6YlSH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5895606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PB+6YlSH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4701F000E1;
	Mon, 23 Nov 2026 06:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415544;
	bh=7SdpdrVw0hnqfMOmm9JAm+YX+2kiuJFyIFWDxo34RGg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PB+6YlSHoXtytOrcnpF02q65ZyMAgHXxP683uYdyrM6ENRFgeGKtI0JfAeYEcZKFT
	 EE2XdFgRm4p6lH0spx4TVb1KPh0G9AAlQD3d9Txvo1T/gT9YWOml0Wz+XZXcqDirr7
	 SYY2zI7wgwh9VrzIffOUjz7Atnwgwd23D/LfjRrTktPllGUQB5C77WO6SL8U2pDCBb
	 BdNqFLxldlEZzCIFEF102yLbMkfWuY3knxEZs5Ro0eggFH0Sn/G6mfgOi75IHDeuQB
	 8AyEKa7TV0B9ptjucNrgUvE7wRpDL40rp8s0rhylIWGB0clKB6LN6XBdrZ1BIPA7zg
	 KGa9N7y+aDS0A==
Subject: Re: [PATCH mptcp-net v2 14/62] mptcp: count orphans as TCP does
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:23 +0000
Message-ID: <179541554369.3133.1466917387695199781@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-14-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-14-00327fd1de1f@kernel.org>
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

- [Low] When MPTCP resets an orphan because of memory pressure or too
  many orphans, the counter and the reset reason disagree.

--

mptcp: count orphans as TCP does

MPTCP sockets orphaned by close() are now counted in tcp_orphan_count.
Like TCP orphans, they are reset when tcp_check_oom() reports too many
orphans or too much TCP memory, both at close() and when the close timeout
expires while the orphan is kept to send its data. These resets are
counted in TCPAbortOnMemory.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ff71f19540771..9e297fa08bfed 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2897,6 +2897,16 @@ static bool mptcp_subflow_probe_timed_out(struct sock *ssk)
>  	return ret;
>  }
>
> +/* As TCP orphans: limited in number and memory */
> +static bool mptcp_orphan_oom(struct sock *sk)
> +{
> +	if (!tcp_check_oom(sk, 0))
> +		return false;
> +
> +	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONMEMORY);
> +	return true;
> +}
> +

[ ... ]

> @@ -3636,8 +3649,15 @@ bool __mptcp_close(struct sock *sk, long timeout)
>  	/* all the subflows are closed, only timeout can change the msk
>  	 * state, let's not keep resources busy for no reasons
>  	 */
> -	if (subflows_alive == 0)
> +	if (subflows_alive == 0) {
>  		mptcp_set_state(sk, TCP_CLOSE);
> +	} else if (sk->sk_state != TCP_CLOSE) {
> +		/* as TCP orphans: counted, and limited */
> +		tcp_orphan_count_inc();
> +		set_bit(MPTCP_ORPHAN_COUNTED, &msk->flags);
> +		if (mptcp_orphan_oom(sk))
> +			mptcp_do_fastclose(sk);

[Severity: Low]
Should this reset carry the abort on memory reason instead of the abort
on close one?

mptcp_orphan_oom() counts the event in LINUX_MIB_TCPABORTONMEMORY. The
reset is then sent by mptcp_do_fastclose(), which hard-codes the reason
for every subflow:

net/mptcp/protocol.c:mptcp_do_fastclose() {
    ...
	tcp_send_active_reset(ssk, SK_RST_REASON_TCP_ABORT_ON_CLOSE);
    ...
}

include/net/rstreason.h maps SK_RST_REASON_TCP_ABORT_ON_CLOSE to
LINUX_MIB_TCPABORTONCLOSE, and SK_RST_REASON_TCP_ABORT_ON_MEMORY to
LINUX_MIB_TCPABORTONMEMORY. The TCP orphan path in __tcp_close(), which
the commit message says this follows, keeps the two together:

	tcp_send_active_reset(sk, SK_RST_REASON_TCP_ABORT_ON_MEMORY);
	__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONMEMORY);

With this patch, a single MPTCP memory abort shows up as
TcpExtTCPAbortOnMemory in nstat, but as TCP_ABORT_ON_CLOSE in the
tcp_send_reset tracepoint.

The worker path has the same mismatch. There, mptcp_orphan_keep() returns
false after mptcp_orphan_oom() fires, and the close timeout path then calls
mptcp_do_fastclose().

The code is the same at the end of the series. Could the reset reason be
passed into mptcp_do_fastclose(), so that these OOM paths can use
SK_RST_REASON_TCP_ABORT_ON_MEMORY?

> +	}
>
>  	sock_hold(sk);
>  	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
