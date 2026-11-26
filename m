Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735786;
	b=yXlGApvgIdsyD0VX7Uze/XRInvfDafptTeQXQ7L82DyOn1V5Z2342hhCDYOYduYRTBb3
	 cUI2MUYwczgv8H6KV/qE84hK9KcQWF4nTWVWyFTTNlcCLX39oSOUK76xxXUWSDrUirQk0
	 wun2plXx+B1YZhKa7b0fGwPDwRHSyerheNQyRkYDWC8bDN3BymxUGOlvRGhxHHE4gfKdF
	 coG2NCZYS+yiTHMfMnbIW1pG2R0y5e4APQInRkSB5Z90Y0sIa+iShJi2rAxSPB2PsZxI7
	 xI3y1AngR7zAoWkk2eHCjhWAmJQxB2JzT3D82iCfY5TjtDIcVhswJ/tPxbENF8Ctx7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735786;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hTtaK9fwVJ4KMIeK5gDyZrOB2hk/FBwHnc9+dQ59hwA=;
	b=MaLtATR+OS5a/I0zqtgXG9Ex1ol9FQ7tYMmg+h6VQtpJ0TCzJZ0jbc/jqyg/NLVie3d4
	 ai7JTrmtG983LXPoJrr0UjIfcZ95yYqCu4AnHv7D7VGRZIFCJ39s68/JOiDA8Z6RIe5/T
	 at0fKPU52FXw/wLdrsD+Ln086dMDVDs4bBAlDuJuMVLA57TBVqwU0r58ZgPPJOkyAXnEH
	 LWH2rReLDIY4T+H05XKzDkB9KG/tFPWYQFcAXMzSMHHMPuMr4LeoheN9yX38sZuY/set9
	 R38gBYuLaickm71mkM+pdR8Cea3nccFcJMWsbCHTVZ0Vyj1A/nVoAvk1o7T/hlCbxXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLD9sHLb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93477606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLD9sHLb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7701F0089A;
	Thu, 26 Nov 2026 23:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735786;
	bh=hTtaK9fwVJ4KMIeK5gDyZrOB2hk/FBwHnc9+dQ59hwA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DLD9sHLbFLSh89sbIRgqPUIfkZ46rEpbdwtJK6Hgh2pwVRQAfSbdJWv1hh9Zc49Tx
	 Y+lydWNmtf5dtv/tAQ3db+ptdBcGc6ZzbNoNQAjTy11rN9+J9pv5z7/D8gS4He9Hdf
	 96iOyUHWpBzLgzSr6bJHDQkene/dZCMUDF7dUkQIYyXlr44419UF2WQ+Xtti2jijrC
	 IY8fZ62h2hId+kfuypka0IhNY6/TkT0uv44ssVigMJm/CyMBW/hYPSo6z1pBfFFqJK
	 gCAjWP9X/R524YMXs3aw4FmFwDN6wB94R8e9CbsVYZTM+cOtrT3mAHweOXb7FQ02nn
	 Hq858xLOqbNDg==
Subject: Re: [PATCH mptcp-net v3 06/50] mptcp: reset the subflow on abort
 after fallback
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:45 +0000
Message-ID: <179573578572.3133.9946844363721576755@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-6-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-6-416c0920c73f@kernel.org>
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

- [Low] The commit message says that, after a fallback to TCP, closing
  with SO_LINGER and a zero timeout "did not reset the connection as TCP…
- [Low] With the fallback early return gone, mptcp_do_fastclose()
  (net/mptcp/protocol.c:3272-3289) sends a plain TCP RST with…

--

mptcp: reset the subflow on abort after fallback

This patch removes the fallback early return in mptcp_do_fastclose(). As
a result, a plain TCP reset is now sent on each subflow when an MPTCP
socket that fell back to TCP is aborted. It also moves the switch of
fastclosed subflows to TCP_CLOSE earlier in __mptcp_close_ssk(), so that
inet_child_forget() does not send a second reset to children of a closed
listener that were never accepted.

> After a fallback to TCP, closing an MPTCP socket with unread data, or
> with SO_LINGER and a zero timeout, did not reset the connection as TCP
> does: the data still in the MPTCP send queue was dropped, and the
> subflow was closed with a FIN.

[Severity: Low]
Is the SO_LINGER part of this description accurate? It looks like the
zero linger case already sent a TCP reset before this patch.

SO_LINGER is copied to every subflow. mptcp_setsockopt_sol_socket_linger()
does it for existing subflows, and sync_socket_options() does it for
subflows created later:

net/mptcp/sockopt.c:sync_socket_options() {
    ...
	if (sock_flag(sk, SOCK_LINGER)) {
		ssk->sk_lingertime = sk->sk_lingertime;
		sock_set_flag(ssk, SOCK_LINGER);
    ...
}

Before this patch, the SO_LINGER(0) close of a fallen-back socket went
through:

__mptcp_close()
  mptcp_do_fastclose()   <- returned early after fallback
  __mptcp_destroy_sock()
    mptcp_destroy()
      mptcp_destroy_common()
        __mptcp_close_ssk()
          __tcp_close(ssk, 0)

send_fastclose was never set, so the subflow was not moved to TCP_CLOSE.
__tcp_close() then reached the zero linger branch:

net/ipv4/tcp.c:__tcp_close() {
    ...
	} else if (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime) {
		/* Check zero linger _after_ checking for unread data. */
		sk->sk_prot->disconnect(sk, 0);
    ...
}

tcp_disconnect() sends a reset for every state in tcp_need_reset().

Only the unread data case seems to have sent a FIN. That is the case the
Packetdrill test covers: the unread data was in the msk receive queue, so
__tcp_close() on the subflow saw neither unread data nor zero linger.

Could the commit message be limited to the unread data case?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f28262f072820..bbb28f778d81d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -3268,10 +3269,7 @@ static void mptcp_do_fastclose(struct sock *sk)
>  	mptcp_backlog_purge(sk);
>  	msk->fastclosing = 1;
>  
> -	/* Explicitly send the fastclose reset as need */
> -	if (__mptcp_check_fallback(msk))
> -		return;
> -
> +	/* Explicitly send the fastclose reset, a plain one after a fallback */
>  	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
>  		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>  

[Severity: Low]
With the early return gone, the loop now filters fallen-back subflows
only by LISTEN and CLOSE:

net/mptcp/protocol.c:mptcp_do_fastclose() {
    ...
		/* Some subflow socket states don't allow/need a reset.*/
		if ((1 << ssk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
			goto unlock;
    ...
		tcp_send_active_reset(ssk, SK_RST_REASON_TCP_ABORT_ON_CLOSE);
    ...
}

Plain TCP uses a narrower rule in tcp_disconnect():

net/ipv4/tcp.c:tcp_disconnect() {
    ...
	} else if (tcp_need_reset(old_state)) {
		tcp_send_active_reset(sk, SK_RST_REASON_TCP_STATE);
		WRITE_ONCE(sk->sk_err, ECONNRESET);
	} else if (tp->snd_nxt != tp->write_seq &&
		   (1 << old_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
    ...
}

tcp_need_reset() covers only ESTABLISHED, CLOSE_WAIT, FIN_WAIT1,
FIN_WAIT2 and SYN_RECV.

Before this patch, these fallen-back subflows were torn down by
tcp_disconnect(). On SO_LINGER(0) close, that happened through the zero
linger branch of __tcp_close(). On disconnect() and on the orphan close
timeout, it happened through __mptcp_subflow_disconnect().

Can a fallen-back subflow in CLOSING or LAST_ACK now get a reset that
plain TCP would not send? That would be the case when all its data and
its FIN were already sent (snd_nxt == write_seq), on close() with
SO_LINGER{1,0}, connect(AF_UNSPEC), the orphan close timeout in
mptcp_worker(), or mptcp_orphan_oom().

For close() with unread data, TCP also resets in these states, so that
path matches.

SYN_SENT subflows are handled later in this series by "mptcp: no
fastclose reset from SYN_SENT subflows". Only the CLOSING and LAST_ACK
difference remains at the end of the series.

The commit message says the reset is now sent as without a fallback.
Only the v2 note below the "---" line mentions this difference, and
git am drops that note. Should the permanent commit message, or a
comment in mptcp_do_fastclose(), mention it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
