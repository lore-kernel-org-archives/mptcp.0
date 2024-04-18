Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1517165C
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459594; cv=none; b=GyfENBP9Z2wTd++t0EWuiC70H5QUm7brY+ioJg5eDIqh+947wJuPIGcsncB/eN+7HtxMmqct1VQLnBlhQzaS3fW+wg2MZajpApjN8koSel3LfTmfJrVEPub6+l7X4JVK5qs7p0kfx6BMjyTPDITLfQAcwLY/fgD7W5xF/NkSgMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459594; c=relaxed/simple;
	bh=j2ZabjX3c2RFenhlVEnD2dCuRzlpblujcV1/+j07LgU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f1uhXcTbDO8HoaYf0vACfKYYc+C0m+YylHzVGj34j7w9njlbVuoBnU3CqfBXS+7XTEq5VarkQGzX0ort6BPsfTqsWrN6ZwSRY0XYLYMosAxRHEJJ4ol/xDaoSDnQfn26oDLQVl37Bs6VA82f1j/ToTF0DbkvPysjbaU1owaLrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4XPQLqG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4XPQLqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022AFC113CC;
	Thu, 18 Apr 2024 16:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713459594;
	bh=j2ZabjX3c2RFenhlVEnD2dCuRzlpblujcV1/+j07LgU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=j4XPQLqGIR16G+Jl0ijPrXvZrwkSXlbyYJF/sAlvUq0PS3J/oz7XmHXNRS4lEG8++
	 gUepQFxaW7tN7yl/ucT1bN69sDESOA04ndQg60MdufGSjv0wziDk/rLvWXEfrw0mlY
	 1ppDhlv3WB2YPZOttGV/CyZTkZBjVr5WNgUOWKocIXBoC8Mb64WXoMWLUZ3yj4PzOy
	 2saMXi6kqYCPnPM+/mx06SHyYTP9MyuJ4FAo7GfR4VwLswqTgar36oBzyMjEJ9db3H
	 sPZz57bZAI8+txySQWQOqD5qDwhfgOuItkmvdlA4jI6WknrPh9DG0eO8tbjTDqDqnD
	 OS5uNLY8PYnEw==
Date: Thu, 18 Apr 2024 09:59:53 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: ensure snd_nxt is properly initialized
 on connect
In-Reply-To: <3b0ca23eaa8906f967a841f55bafed48d0f895cb.1713367699.git.pabeni@redhat.com>
Message-ID: <422a4453-7344-e5dd-342f-577baa9743b0@kernel.org>
References: <3b0ca23eaa8906f967a841f55bafed48d0f895cb.1713367699.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 18 Apr 2024, Paolo Abeni wrote:

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
> When fallback to TCP happens early on a client socket, snd_nxt
> is not yet initialized and any incoming ack will copy such value
> into snd_una. If the mptcp worker (dumbly) tries mptcp-level
> re-injection after such ack, that would unconditionally trigger a send
> buffer cleanup using 'bad' snd_una values.
>
> We could easily disable re-injection for fallback sockets, but such
> dumb behavior already helped catching a few subtle issues and a very
> low to zero impact in practice.
>
> Instead address the issue always initializing snd_nxt (and write_seq,
> for consistency) at connect time.
>
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Tested-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
> Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
> - init snd_nxt/write_seq instead
>
> v1 -> v2:
> - moved the initialization at established time (Mat)
> - dropped debug code wrongly landed in v1
> - added fixes tag
> ---
> net/mptcp/protocol.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3e1b15d76442..4205cef2d45f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1002,8 +1002,13 @@ static void __mptcp_clean_una(struct sock *sk)
>
> 		if (unlikely(dfrag == msk->first_pending)) {
> 			/* in recovery mode can see ack after the current snd head */
> -			if (WARN_ON_ONCE(!msk->recovery))
> +			if (WARN_ON_ONCE(!msk->recovery)) {
> +				pr_err("sk state %d:%d snd_una %llx write_seq %llx dfrag end seq %llx frag len %d bytes sent %lld acked %lld",
> +				       sk->sk_state, msk->first ? msk->first->sk_state: -1, msk->write_seq,
> +				       msk->snd_una, dfrag->data_seq + dfrag->data_len, dfrag->data_len,
> +				       msk->bytes_sent, msk->bytes_acked);
> 				break;
> +			}

Hi Paolo -

You dropped this debug code in v2, do you want it included?

Otherwise, LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> 		}
> @@ -3730,6 +3735,9 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
> 		mptcp_subflow_early_fallback(msk, subflow);
> 	}
> +
> +	WRITE_ONCE(msk->write_seq, subflow->idsn);
> +	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
> 	if (likely(!__mptcp_check_fallback(msk)))
> 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
>
> -- 
> 2.43.2
>
>
>
