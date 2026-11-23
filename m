Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415547;
	b=eitx4PIH7lYoaPeCHvM+blwRZ3ZDP68aZkBo8f/33gEttObr/rrYdovh6GWlPgHYM9zX
	 e+cDmqnOPdVGaAiHSkEshgEOMNBqVWgIuuS3lCnkSF0ZU9ih7hBoSBDZMFLgz7zRMpw0l
	 R5BGjVPb9FOF2adsE7vETLxooUxyjAgrXjxbDa1J15OUSwbIqNO/xtRD/YtOKgMiXvgKU
	 ZdfHN7Ui5Nuf8+usVYRC1xkEobcRhXdyrjCnKlAyAv66yS4AWKZpLyG1w+j2rGtPevBHk
	 JIGeS8jsAjanatCA+N3hXkpxcHG4aYHVsISYMXMBFVHWfXJnfq0PHZXDicc5ekxK5Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415547;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yT80Ec0IMJUSS9UJ7aYXhiWS4wn2zbri4q+AbusoSy8=;
	b=5cf381O/vf+8vrKdX2PeGYw6sXmiKpavIVBB0oY1y//TXtioBMQdvmnTuHON115aulb6
	 luqlE+FMZ9hqnA6fVPBoGFtNKdKTBtZLEtZFzZ8oGIWuLZdgX9FutjEmOz7JN2MzCgeHv
	 HWeqACdxpwSJT5Ijpycy0aMLqI6gOnNnkkdzjsf4GuTM6j72OCoU6zAFAFGECex5hhx64
	 byuHQvsiNuvc0fDzL4mS7dqaaOdpMpVoY2bd8ebuCrl6KZA+E04Zqt1y5ElYyZr8JzQUJ
	 cOGnRsNiVL3kWvJWjrzpxk75qKIB5XThuymAVplvpBj42vG2YnG1Wbwu4Mls3Rv3y7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F0gL9xQg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166F606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F0gL9xQg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891FD1F000E0;
	Mon, 23 Nov 2026 06:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415546;
	bh=yT80Ec0IMJUSS9UJ7aYXhiWS4wn2zbri4q+AbusoSy8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F0gL9xQg6XcAmY0krYOCpeOFVMGzGeUinN31nJq77oq7WOrdSeyFeyh1L9ajA0j9S
	 W5HCNScmdpmTaGKpCWKFYSKVwBhpl5Z5clAcegALlnLmsCShT+gMjQlJJ9zsIo9YgA
	 zPGJPl37GsbUzl3G4wCTXilTzV6nIQIsT+4BOAHbt99sedQGt3EqvkeKzsChWfxbTz
	 ZrBLE35LMbCrK4N3MFKuX1p/XN1t9M6cBYB4SW62vTSUlQN/bemwi9h3BAxlN24QWH
	 qi2qUJ4up2eUJLNRg69BKk3xyMwop0a5EW/s0T9fpHWrivuk0VtIU2S8G6FYfB3CFO
	 4ePhVIQuD1WTA==
Subject:
 Re: [PATCH mptcp-net v2 16/62] mptcp: let TCP send orphan data after fallback
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:26 +0000
Message-ID: <179541554613.3133.4510633710831218984@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-16-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-16-00327fd1de1f@kernel.org>
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

- [Medium] This is a TOCTOU race in the new graceful hand-over, and the
  patch introduces it.

--

mptcp: let TCP send orphan data after fallback

This patch changes the close timeout path for an orphaned MPTCP socket
that fell back to TCP. If all its data and the FIN were already handed to
the subflow, the msk is now closed without a reset, so TCP can finish
sending the remaining data. A reset is still expected when data received
after close() was not read.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/647

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 91639ae0c8a02..541bf23d1bda1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2940,6 +2940,18 @@ static bool mptcp_orphan_keep(struct sock *sk)
>  	return false;
>  }
>  
> +/* On fallback, TCP can send what an orphan gave to the subflow. As in
> + * __mptcp_close(), unread data requires a reset, also in the backlog.
> + */
> +static bool mptcp_orphan_handover(const struct sock *sk)
> +{
> +	const struct mptcp_sock *msk = mptcp_sk(sk);
> +
> +	return sock_flag(sk, SOCK_DEAD) && __mptcp_check_fallback(msk) &&
> +	       msk->snd_nxt == msk->write_seq && !mptcp_data_avail(msk) &&
> +	       !READ_ONCE(msk->backlog_len);
> +}
> +

[ ... ]

> @@ -3287,6 +3299,10 @@ static void mptcp_worker(struct work_struct *work)
>  		__mptcp_push_pending(sk, 0);
>  	}
>  
> +	/* TCP will close the subflow, as with its own orphans */
> +	if (mptcp_close_tout_expired(sk) && mptcp_orphan_handover(sk))
> +		mptcp_set_state(sk, TCP_CLOSE);
> +

[Severity: Medium]

Can unread peer data still be dropped here without a reset being sent?

mptcp_orphan_handover() checks for unread data with only the msk socket
lock held. It does not hold the data lock or any subflow lock, and the
check is not repeated later. Holding the msk socket lock does not stop
subflow RX in softirq.

Once the check passes, mptcp_worker() sets TCP_CLOSE and skips
mptcp_do_fastclose(), going straight to __mptcp_destroy_sock(). The
subflows keep feeding the msk until __mptcp_close_ssk() sets
subflow->closing under the ssk lock. That only happens in
mptcp_destroy_common(), after __mptcp_clear_xmit() and
mptcp_backlog_purge().

A segment that arrives on the fallback subflow in that window would take
this path:

subflow_data_ready()
  mptcp_data_ready()            /* closing still 0, msk owned by worker */
    __mptcp_move_skbs_from_subflow(msk, ssk, false)
      mptcp_init_skb()          /* __skb_unlink() from ssk, copied_seq advanced */
      __mptcp_add_backlog()

__mptcp_add_backlog() then frees it:

	if (unlikely(sk->sk_state == TCP_CLOSE)) {
		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
		return;
	}

If the skb was queued just before the state change, mptcp_backlog_purge()
in mptcp_destroy_common() frees it instead.

Later, mptcp_destroy_common() calls __mptcp_close_ssk(), which calls
__tcp_close(ssk, 0). __tcp_close() only sets data_was_unread for skbs
still in the ssk receive queue past copied_seq. Here the skb has already
been unlinked and copied_seq advanced. So no RST is sent, and the subflow
closes gracefully.

After a fallback, the TCP ACK is the end-to-end acknowledgement. Would
the peer then see its data acked and a clean FIN, even though the data
was thrown away?

That seems to contradict this part of the commit message:

    Unless data received after close() has not been read: as in
    __mptcp_close(), a reset is then needed.

Before this patch, an expired timeout always went through
mptcp_do_fastclose() and then tcp_disconnect() on the subflow, so an RST
was always sent in this case.

The window runs from the unlocked check until lock_sock_nested(ssk) in
__mptcp_close_ssk().

Would it help to stop RX on each subflow (setting subflow->closing under
its ssk lock) before checking for unread data? Other options would be to
recheck under the data lock, or to record a drop in __mptcp_add_backlog()
for a dead msk and send a reset in that case.

>  	if (mptcp_close_tout_expired(sk)) {
>  		struct mptcp_subflow_context *subflow, *tmp;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
