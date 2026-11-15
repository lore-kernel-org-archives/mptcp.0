Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739986;
	b=wyxN/HuJhAdRD1h2pB7lW9dLFtyZzNDDpyBSPgz+7ujEeatCbYgfOsxV9C3WIWtJ26qk
	 C/DW/g6sZ9j8XpvvZvZExIa0jmW0a2Z6kTvu72iK+7MPPCLTeXCyUoKPj9kgsv3yQMdWy
	 OVqH2aVbVFfh868XMux4au0qXWEAkfVlGKCC9ihOqYvbcmluy5ZtSzim67WdQRdgzlxpD
	 vqDdrOfSRVNbHkCuR65FTKWy+LwtDoU6LMsHRUFjShtfRAqw791DiHk+DvBnOW3FtuJLh
	 Fx6svvwGcXCpY0XiyHzLne2pW9t1gc+dk86H1uEFygHohJgNSHoD9t+quYSRWixravw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739986;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Q+f96FDTyFOhNCgx3ovmOG6bsbjSAjjNrm7nuyoIl2o=;
	b=ttsxbrtH8OuiYUGSc97Tt8hi8kJrsUW5AQnw34yca3l4FuF9/+IHVsuvzijzxAO8MDwg
	 iVqPdv7voPae4c/Ulv83o50QqCGCzpcGNYDaM06j/9q/U42l4A5Eovint7QVm6wPVBZeg
	 XaPdNfZaflW309f8Tns9BTnEB4nt0AywSyCdJvcOO/qHCf++Gh3waJuT4XQv9xqTJzVlf
	 pSIxYpPh8Ba/7wvzAU/0ad6Qfg/z914FBN1ozOyDpf8T0qXoVPmFJ+4VC8/lGNCxhubSk
	 6X0WpOZHxhSnvQv5Ihm3WZ3LQ/e8KeQW7ujTzf4Z+9V5NG8SlZHdMpbNQnrAcmTtbUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TKy/axda";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B1A606A31D
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKy/axda
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C239C1F000C5;
	Sun, 15 Nov 2026 10:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794739986;
	bh=Q+f96FDTyFOhNCgx3ovmOG6bsbjSAjjNrm7nuyoIl2o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TKy/axda9xh0RIU/SEU5Zdu4qNVs5nY1WuhMmD5EqEyo43XwVp5NHFHwjxuKjdXmN
	 HVcXj2TTTxQq0TUsSrfErnGJDaFEjgmJdbQUrZHKPVRpYMTMXexmmjQQE4Wo9HV98i
	 04QXoYDLzQYt3KbxqXGUHe7QSNr8mKv2M9ydiqZ/2lYZv454HECB9bmjBQUZESelVF
	 3C/xvHhM+59q32/umLv8VpAgQolUCgg041WKgzNUMZKK+A4KA1yJtzC4xHxrX631t4
	 F+Kw4LJuiW5SRGmbZ347V0wxWVUW6u78EQkfYHxTKRJE7ALQGIP6NyNXP6EfqDd/Z3
	 UccBzXl6sRO7A==
Subject:
 Re: [PATCH mptcp-net 01/34] tcp: drain the queues of a listen() that fails
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc:
 mptcp@lists.linux.dev, mason@kernel.org, pabeni@redhat.com, kuba@kernel.org
Date: Sun, 15 Nov 2026 10:53:05 +0000
Message-ID: <179473998528.488855.7816958320444264036@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-1-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-1-9205b77e9a2f@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new error-path drain in inet_csk_listen_start() can still
  miss an RST-queue entry, so the TFO leak this commit says it closes…

--

tcp: drain the queues of a listen() that fails

This patch changes the error path of inet_csk_listen_start() to call
inet_csk_listen_stop() after it sets TCP_CLOSE again. Children and TFO
RST-queue entries that reqs from an earlier listen() add during the
temporary TCP_LISTEN window are then freed. MPTCP subflows are skipped
here and left to mptcp_listen(), which a following patch handles.

> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 5807067083c90..3d9cc189c8075 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c

[ ... ]

> @@ -1371,6 +1371,10 @@ int inet_csk_listen_start(struct sock *sk)
>  	}
>  
>  	inet_sk_set_state(sk, TCP_CLOSE);
> +
> +	/* MPTCP subflows are drained by mptcp_listen() */
> +	if (!sk_is_mptcp(sk))
> +		inet_csk_listen_stop(sk);

[Severity: High]
Can this new drain still miss an entry on the TFO RST queue?

inet_csk_listen_stop() checks whether to drain the RST queue without
taking fastopenq.lock:

net/ipv4/inet_connection_sock.c:inet_csk_listen_stop() {
    ...
	if (queue->fastopenq.rskq_rst_head) {
		/* Free all the reqs queued in rskq_rst_head. */
		spin_lock_bh(&queue->fastopenq.lock);
    ...
}

The writer is reqsk_fastopen_remove(). tcp_check_req() calls it when an
accepted TFO child in SYN_RECV receives a valid RST. It runs in the
child's context and holds only fastopenq->lock:

net/ipv4/tcp_fastopen.c:reqsk_fastopen_remove() {
    ...
	spin_lock_bh(&fastopenq->lock);
    ...
	if (!reset || lsk->sk_state != TCP_LISTEN) {
    ...
	if (fastopenq->rskq_rst_head == NULL)
		fastopenq->rskq_rst_head = req;
	else
		fastopenq->rskq_rst_tail->dl_next = req;
    ...
	spin_unlock_bh(&fastopenq->lock);
}

Is this interleaving possible?

CPU0 (failing listen())            CPU1 (child receives RST)
inet_sk_state_store(TCP_LISTEN)
                                   tcp_check_req()
                                     reqsk_fastopen_remove(sk, req, true)
                                       spin_lock_bh(&fastopenq->lock)
                                       sees lsk->sk_state == TCP_LISTEN
get_port() fails
inet_sk_set_state(TCP_CLOSE)
inet_csk_listen_stop()
  accept queue loop (rskq_lock only)
  reads rskq_rst_head == NULL,
  skips the drain
                                       fastopenq->rskq_rst_head = req
                                       spin_unlock_bh(&fastopenq->lock)

After that, nothing frees the req. close() drains the queues only in
TCP_LISTEN. The next listen() calls reqsk_queue_alloc(), which sets
rskq_rst_head and rskq_rst_tail to NULL.

The req holds a reference on req->rsk_listener. The listener socket and
its netns would then stay pinned, which is the same leak the commit
message describes.

The accept queue does not appear to have this problem, because
inet_csk_reqsk_queue_add() and reqsk_queue_remove() both run under
rskq_lock. The MPTCP error path added by "mptcp: drain the queues of a
listen() that fails" calls the same inet_csk_listen_stop(), so it seems
to have the same race.

Could inet_csk_listen_stop() drop the lockless pre-check and instead read
and clear rskq_rst_head under spin_lock_bh(&queue->fastopenq.lock)?

TCP_CLOSE is stored before that lock is taken. A reqsk_fastopen_remove()
that took the lock first would have its insertion seen and freed by the
drain. One that takes the lock later would see TCP_CLOSE and call
reqsk_put() itself.

>  	return err;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f%40kernel.org
