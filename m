Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E4617C7F
	for <mptcp@lists.linux.dev>; Fri, 12 Apr 2024 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955920; cv=none; b=QimjNFY3RSxH+zpooMvfUMvD6yvCx1rdPNsCZAyHNpdyHeLSdcKkZ90ZO/KeZRdrkp+lWzkkAKSpwpzMtIJ2uPBrAvKdMgI8I/2hIlanAaYndf68+qiGSuY2P59vi0CSrAC8XCN7dL66rTBxvoukmMAWuL8udyu7xuh4DiALKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955920; c=relaxed/simple;
	bh=S60m+YX2ixh1oyasOJkEx1CugC5OwOGAlW0zqmKweVE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DGkVIx/YDgiWkbGtLzPKnLPemdqWg+v4IPUPAIYxWQ6EDD2Wd8lVzl7eV7UBckcrdNhTPwZ6hfagNQUKY31vIhFLpv/CkzWHe+HLULvthWX2u7PrFwUad5U0i/qNEFUa6B8sijm4LD5ubuTbnH0/Futnf/D/Wx9nSfdJAcmA8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp0rCg8J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp0rCg8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37906C113CC;
	Fri, 12 Apr 2024 21:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712955920;
	bh=S60m+YX2ixh1oyasOJkEx1CugC5OwOGAlW0zqmKweVE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=cp0rCg8JGft0z212D5i0681usrHQjcySD/54lgAPoS4JPFyRDF1/mixymKNaEHMly
	 eZdgRfTYPr0lpDVdRdl0KoN128Wa1NCUlZbA3rtIkrM47SgTEHFWYh88SDkxOc4ZdL
	 ZdFuyjQHIAcrwSoQ/OU1leWoEluA1B8YawLfeNhvUUuk/Ia2QD718RjC6fBcQXInSW
	 D4CQI1kaY2TYf/91oj7lCanTddok/a009Q4XmRv4VuKxwSrgsizUIZva/Y76M6jSbR
	 mrZ803XcCCaOoqxevbjD3A8RcUFPQyjF28PpRgd8bJFOXMjqYmwJy7e+3YpEurolPR
	 ad8mIrN4P/DqQ==
Date: Fri, 12 Apr 2024 14:05:19 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
Subject: Re: [PATCH mptcp-net] mptcp: ensure snd_una is properly initialized
 on connect
In-Reply-To: <2b6d11d0210f683cc0de8bb47a923d568cfa8f47.1712942966.git.pabeni@redhat.com>
Message-ID: <7aa81bc3-7ec1-6e93-bc81-e60911ef5eed@kernel.org>
References: <2b6d11d0210f683cc0de8bb47a923d568cfa8f47.1712942966.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 12 Apr 2024, Paolo Abeni wrote:

> Christoph reported a splat hinting at a corrupted snd_una:
>
> WARNING: CPU: 1 PID: 38 at net/mptcp/protocol.c:1005 __mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
> Modules linked in:
> CPU: 1 PID: 38 Comm: kworker/1:1 Not tainted 6.9.0-rc1-gbbeac67456c9 #59
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
> Workqueue: events mptcp_worker
> RIP: 0010:__mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
> Code: be 06 01 00 00 bf 06 01 00 00 e8 a8 12 e7 fe e9 00 fe ff ff e8
> 	8e 1a e7 fe 0f b7 ab 3e 02 00 00 e9 d3 fd ff ff e8 7d 1a e7 fe
> 	<0f> 0b 4c 8b bb e0 05 00 00 e9 74 fc ff ff e8 6a 1a e7 fe 0f 0b e9
> RSP: 0018:ffffc9000013fd48 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff8881029bd280 RCX: ffffffff82382fe4
> RDX: ffff8881003cbd00 RSI: ffffffff823833c3 RDI: 0000000000000001
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: fefefefefefefeff R12: ffff888138ba8000
> R13: 0000000000000106 R14: ffff8881029bd908 R15: ffff888126560000
> FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f604a5dae38 CR3: 0000000101dac002 CR4: 0000000000170ef0
> Call Trace:
> <TASK>
> __mptcp_clean_una_wakeup net/mptcp/protocol.c:1055 [inline]
> mptcp_clean_una_wakeup net/mptcp/protocol.c:1062 [inline]
> __mptcp_retrans+0x7f/0x7e0 net/mptcp/protocol.c:2615
> mptcp_worker+0x434/0x740 net/mptcp/protocol.c:2767
> process_one_work+0x1e0/0x560 kernel/workqueue.c:3254
> process_scheduled_works kernel/workqueue.c:3335 [inline]
> worker_thread+0x3c7/0x640 kernel/workqueue.c:3416
> kthread+0x121/0x170 kernel/kthread.c:388
> ret_from_fork+0x44/0x50 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> </TASK>
>
> When fallback to TCP happens early on client socket, and the mptcp
> worker (dumbly) tries mptcp-level re-injection, the snd_una is
> not yet initialized, and the worker tries to use it to clean-up
> the send buffer.
>
> Address the issue always initializing snd_una for active sockets
> at connect time.
>
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> @Christoph: could you please test this vs the above issue reproducer?
> The repro doesn't work for me.
> ---
> net/mptcp/protocol.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3e1b15d76442..68247075069b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1002,8 +1002,12 @@ static void __mptcp_clean_una(struct sock *sk)
>
> 		if (unlikely(dfrag == msk->first_pending)) {
> 			/* in recovery mode can see ack after the current snd head */
> -			if (WARN_ON_ONCE(!msk->recovery))
> +			if (WARN_ON_ONCE(!msk->recovery)) {
> +				pr_err("snd_una %llx dfrag end seq %llx frag len %d bytes sent %lld acked %lld",
> +					msk->snd_una, dfrag->data_seq + dfrag->data_len, dfrag->data_len,
> +					msk->bytes_sent, msk->bytes_acked);
> 				break;
> +			}
>
> 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> 		}
> @@ -3730,6 +3734,13 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
> 		mptcp_subflow_early_fallback(msk, subflow);
> 	}
> +
> +	/* after the connect, the worker (and re-injections) can trigger
> +	 * at any time, and that will need snd_una properly initialized
> +	 */
> +	mptcp_data_lock(sk);
> +	WRITE_ONCE(msk->snd_una, subflow->idsn);
> +	mptcp_data_unlock(sk);

Hi Paolo -

msk->write_seq, msk->snd_nxt, and msk->snd_una are initialized as a group 
in mptcp_sk_clone_init() (on the accept() side).

Does it make sense to also initialize them together on the connect() side? 
Looks like msk->write_seq and msk->snd_nxt are initialized together in 
__mptcp_sync_state() and I think setting msk->snd_una would fit better 
there. The attempt to re-inject means that a transmit happened, so 
msk->write_seq and msk->snd_nxt must have been initialized in 
__mptcp_sync_state().

- Mat

