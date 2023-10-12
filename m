Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159528E16
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTseid9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3DBC433C7;
	Thu, 12 Oct 2023 19:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697140248;
	bh=BZCm1Ap3hr/rKNkIXWdLameChGuuzbfZXaHJmy2WxVY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=fTseid9x//HywSxEQf9AO4j3wS03bKlo/5PQdmkAsSVUMaU4QNZ3566B86ye9JW6R
	 NMHZa82uIz56WbJFlLO8h0VG9cv9hmhw89mBo9rqt1OKOXg/7WwLsdElfxHPrN/PfN
	 xsMkTLDJXRSfpbj8aZquy5NZ4kZwqK77+Mg4aHDNctym86Q5asbnulCW49i5EAd18n
	 ZfwWE7v2BANTtl27H70HHfMLdbTct0CjYPHRDRDG3pCWYrVED3VJHOB+jpg5kJETNm
	 fkWR/CR0wdC2/1N0Bts3ioxKbXk+wXMM7hqsf+hAXLDlvL+mG2Xsm3w0sh2HzHrqyM
	 brwoQzQnvpgFw==
Date: Thu, 12 Oct 2023 12:50:41 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-net] mptcp: more conservative check for zero
 probes.
In-Reply-To: <0ee2a306b00ef868b993e2426d9d51e14882bd72.1697125647.git.pabeni@redhat.com>
Message-ID: <a3b72824-6ccf-01dd-3f2a-c18ddd920291@kernel.org>
References: <0ee2a306b00ef868b993e2426d9d51e14882bd72.1697125647.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 12 Oct 2023, Paolo Abeni wrote:

> Christoph reported that the MPTCP protocol can find the subflow-level
> write queue unexpectedly not empty while crafting a zero-window probe,
> hitting a warning:
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 188 at net/mptcp/protocol.c:1312 mptcp_sendmsg_frag+0xc06/0xe70
> Modules linked in:
> CPU: 0 PID: 188 Comm: kworker/0:2 Not tainted 6.6.0-rc2-g1176aa719d7a #47
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
> Workqueue: events mptcp_worker
> RIP: 0010:mptcp_sendmsg_frag+0xc06/0xe70 net/mptcp/protocol.c:1312
> RAX: 47d0530de347ff6a RBX: 47d0530de347ff6b RCX: ffff8881015d3c00
> RDX: ffff8881015d3c00 RSI: 47d0530de347ff6b RDI: 47d0530de347ff6b
> RBP: 47d0530de347ff6b R08: ffffffff8243c6a8 R09: ffffffff82042d9c
> R10: 0000000000000002 R11: ffffffff82056850 R12: ffff88812a13d580
> R13: 0000000000000001 R14: ffff88812b375e50 R15: ffff88812bbf3200
> FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000695118 CR3: 0000000115dfc001 CR4: 0000000000170ef0
> Call Trace:
> <TASK>
> __subflow_push_pending+0xa4/0x420 net/mptcp/protocol.c:1545
> __mptcp_push_pending+0x128/0x3b0 net/mptcp/protocol.c:1614
> mptcp_release_cb+0x218/0x5b0 net/mptcp/protocol.c:3391
> release_sock+0xf6/0x100 net/core/sock.c:3521
> mptcp_worker+0x6e8/0x8f0 net/mptcp/protocol.c:2746
> process_scheduled_works+0x341/0x690 kernel/workqueue.c:2630
> worker_thread+0x3a7/0x610 kernel/workqueue.c:2784
> kthread+0x143/0x180 kernel/kthread.c:388
> ret_from_fork+0x4d/0x60 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304
> </TASK>
>
> The root cause of the issue is that expectations are wrong: e.g. due
> to MPTCP-level re-injection we can hit the critical condition.
>
> Explicitly avoid the zero-window probe when the subflow write queue
> is not empty and drop the related warning.
>
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/444
> Fixes: f70cad1085d1 ("mptcp: stop relying on tcp_tx_skb_cache")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - drop additional, obsoleted warn_on() (Mat)

Thanks Paolo, v2 looks good.

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/mptcp/protocol.c | 8 +-------
> 1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 30e0c29ae0a4..48aa4045cb0d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1297,7 +1297,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 	if (copy == 0) {
> 		u64 snd_una = READ_ONCE(msk->snd_una);
>
> -		if (snd_una != msk->snd_nxt) {
> +		if (snd_una != msk->snd_nxt || tcp_write_queue_tail(ssk)) {
> 			tcp_remove_empty_skb(ssk);
> 			return 0;
> 		}
> @@ -1305,11 +1305,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 		zero_window_probe = true;
> 		data_seq = snd_una - 1;
> 		copy = 1;
> -
> -		/* all mptcp-level data is acked, no skbs should be present into the
> -		 * ssk write queue
> -		 */
> -		WARN_ON_ONCE(reuse_skb);
> 	}
>
> 	copy = min_t(size_t, copy, info->limit - info->sent);
> @@ -1338,7 +1333,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 	if (reuse_skb) {
> 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_PSH;
> 		mpext->data_len += copy;
> -		WARN_ON_ONCE(zero_window_probe);
> 		goto out;
> 	}
>
> -- 
> 2.41.0
>
>
>
