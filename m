Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588CF624
	for <mptcp@lists.linux.dev>; Tue, 26 Jul 2022 01:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658798076; x=1690334076;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Lq3n6uAyCI/bYOj/MADimJQGNChnFzdNuwLdkiaEYEo=;
  b=DqYYAr3ulapX8PsmJlxC59v4ZBC4LClYUbVXlUiayrMnm25pTbivgDGT
   ES4AhyG1BynQaT+sQIzGjRBR5zub0eH/WZ+cSDMyElBJwsQbaBwI1TEyn
   OiGsnXRPKuBmn9FuC6gnUCw+e6Sttel9/9M8CBzAyOn5zZAITi7yObcSN
   C3ihNGYwDZjVxxg56fdgyt7CyFLjgFahcweYb/3ND55DdnIWo5mIRhVdu
   qwfEQBfVyb3EUxYn6yE5GhbCyN+cV0aCBNrtVa1CmSuzP0okXXG0induL
   ek22RNbxD3qZqov3Ezo3ec/dxszB68gVaUU8EYcJciLEccbK4w+8MoRmP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="285378886"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="285378886"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 18:14:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="845693799"
Received: from jacobsd-mobl1.amr.corp.intel.com ([10.209.100.69])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 18:14:35 -0700
Date: Mon, 25 Jul 2022 18:14:35 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Dipanjan Das <mail.dipanjan.das@gmail.com>
Subject: Re: [PATCH mptcp-net] mptcp: do not queue data on closed subflows
In-Reply-To: <937464128633daa18ebc093215ac04487f001b3f.1658769042.git.pabeni@redhat.com>
Message-ID: <595ba8d4-5ba2-666-b336-e48977d8864e@linux.intel.com>
References: <937464128633daa18ebc093215ac04487f001b3f.1658769042.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 25 Jul 2022, Paolo Abeni wrote:

> Dipanjan reported a syzbot splat at close time:
>
> WARNING: CPU: 1 PID: 10818 at net/ipv4/af_inet.c:153
> inet_sock_destruct+0x6d0/0x8e0 net/ipv4/af_inet.c:153
> Modules linked in: uio_ivshmem(OE) uio(E)
> CPU: 1 PID: 10818 Comm: kworker/1:16 Tainted: G           OE
> 5.19.0-rc6-g2eae0556bb9d #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Workqueue: events mptcp_worker
> RIP: 0010:inet_sock_destruct+0x6d0/0x8e0 net/ipv4/af_inet.c:153
> Code: 21 02 00 00 41 8b 9c 24 28 02 00 00 e9 07 ff ff ff e8 34 4d 91
> f9 89 ee 4c 89 e7 e8 4a 47 60 ff e9 a6 fc ff ff e8 20 4d 91 f9 <0f> 0b
> e9 84 fe ff ff e8 14 4d 91 f9 0f 0b e9 d4 fd ff ff e8 08 4d
> RSP: 0018:ffffc9001b35fa78 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00000000002879d0 RCX: ffff8881326f3b00
> RDX: 0000000000000000 RSI: ffff8881326f3b00 RDI: 0000000000000002
> RBP: ffff888179662674 R08: ffffffff87e983a0 R09: 0000000000000000
> R10: 0000000000000005 R11: 00000000000004ea R12: ffff888179662400
> R13: ffff888179662428 R14: 0000000000000001 R15: ffff88817e38e258
> FS:  0000000000000000(0000) GS:ffff8881f5f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020007bc0 CR3: 0000000179592000 CR4: 0000000000150ee0
> Call Trace:
> <TASK>
> __sk_destruct+0x4f/0x8e0 net/core/sock.c:2067
> sk_destruct+0xbd/0xe0 net/core/sock.c:2112
> __sk_free+0xef/0x3d0 net/core/sock.c:2123
> sk_free+0x78/0xa0 net/core/sock.c:2134
> sock_put include/net/sock.h:1927 [inline]
> __mptcp_close_ssk+0x50f/0x780 net/mptcp/protocol.c:2351
> __mptcp_destroy_sock+0x332/0x760 net/mptcp/protocol.c:2828
> mptcp_worker+0x5d2/0xc90 net/mptcp/protocol.c:2586
> process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
> worker_thread+0x623/0x1070 kernel/workqueue.c:2436
> kthread+0x2e9/0x3a0 kernel/kthread.c:376
> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> </TASK>
>
> The root cause of the problem is that an mptcp-level (re)transmit can
> race with mptcp_close() and the packet scheduler checks the subflow
> state before acquiring the socket lock: we can try to (re)transmit on
> an already closed ssk.
>
> Fix the issue checking again the subflow socket status under the
> subflow socket lock protection. Additionally add the missing check
> for the fallback-to-tcp case.
>
> Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
> Fixes: d5f49190def6 ("mptcp: allow picking different xmit subflows")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thanks Paolo.

Patchew didn't tag this for some reason, so I manually pushed a tag to 
trigger the CI builds:

https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2736071165
https://cirrus-ci.com/build/5132666281394176


The tests I ran worked ok, but the c reproducer didn't trigger the crash 
in my syzkaller vm with v5.19-rc6.

One question below.

> ---
> net/mptcp/protocol.c |  8 +++++++-
> net/mptcp/protocol.h | 11 +++++++----
> 2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index cc21fafd9726..7c7670942e76 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1275,6 +1275,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 			 info->limit > dfrag->data_len))
> 		return 0;
>
> +	if (unlikely(!__tcp_can_send(ssk)))
> +		return -EAGAIN;
> +
> 	/* compute send limit */
> 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
> 	copy = info->size_goal;
> @@ -1448,7 +1451,8 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 	if (__mptcp_check_fallback(msk)) {
> 		if (!msk->first)
> 			return NULL;
> -		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
> +		return __tcp_can_send(msk->first) &&
> +		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
> 	}
>
> 	/* re-use last subflow, if the burst allow that */
> @@ -1599,6 +1603,8 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>
> 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> 			if (ret <= 0) {
> +				if (ret == -EAGAIN)
> +					continue;

There are two other mptcp_sendmsg_frag() callers: 
__mptcp_subflow_push_pending() and __mptcp_retrans(). The code for those 
has not changed to check for -EAGAIN like the line of code above, and it 
looks like such changes are not needed. Does my reasoning for these two 
other cases match yours:

__mptcp_subflow_push_pending() has the subflow lock held when it calls 
mptcp_subflow_get_send(), so it shouldn't run in to the problem you 
described in the commit message.

__mptcp_retrans() acquires the subflow lock after the call to 
mptcp_subflow_get_retrans(). But there's no check for -EAGAIN like the two 
lines added above so __mptcp_retrans() will give up. This looks valid to 
me since the retransmit is either not needed (if the connection is 
closing) or will get retried again when triggered by the retransmit timer.


The CI builds haven't finished yet, but so far it looks like the tests are 
passing.

Thanks,

- Mat

> 				mptcp_push_release(ssk, &info);
> 				goto out;
> 			}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 480c5320b86e..93d783039fce 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -625,16 +625,19 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> 			 struct sockaddr_storage *addr,
> 			 unsigned short family);
>
> -static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> +static inline bool __tcp_can_send(const struct sock *ssk)
> {
> -	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +	/* only send if our side has not closed yet */
> +	return ((1 << inet_sk_state_load(ssk)) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
> +}
>
> +static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> +{
> 	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
> 	if (subflow->request_join && !subflow->fully_established)
> 		return false;
>
> -	/* only send if our side has not closed yet */
> -	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
> +	return __tcp_can_send(mptcp_subflow_tcp_sock(subflow));
> }
>
> void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow);
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
