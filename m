Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC415168
	for <mptcp@lists.linux.dev>; Fri, 12 Nov 2021 01:03:18 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="219941269"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="219941269"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 17:03:18 -0800
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="452956999"
Received: from neelchat-mobl2.amr.corp.intel.com ([10.209.109.125])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 17:03:18 -0800
Date: Thu, 11 Nov 2021 17:03:17 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 3/4] mptcp: add SIOCINQ, OUTQ and OUTQNSD
 ioctls
In-Reply-To: <20211111151418.17276-4-fw@strlen.de>
Message-ID: <246033df-61f-5b44-d7fd-9cd95cf8dc6b@linux.intel.com>
References: <20211111151418.17276-1-fw@strlen.de> <20211111151418.17276-4-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 11 Nov 2021, Florian Westphal wrote:

> Allows to query in-sequence data ready for read(), total bytes in
> write queue and total bytes in write queue that have not yet been sent.
>
> v2: remove unneeded READ_ONCE() (Paolo Abeni)
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> net/mptcp/protocol.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 54 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 61047d04e849..1c4604283b00 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -22,6 +22,7 @@
> #endif
> #include <net/mptcp.h>
> #include <net/xfrm.h>
> +#include <asm/ioctls.h>
> #include "protocol.h"
> #include "mib.h"
>
> @@ -3260,6 +3261,58 @@ static int mptcp_forward_alloc_get(const struct sock *sk)
> 	return sk->sk_forward_alloc + mptcp_sk(sk)->rmem_fwd_alloc;
> }
>
> +static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
> +{
> +	const struct sock *sk = (void *)msk;
> +	u64 delta;
> +
> +	if (sk->sk_state == TCP_LISTEN)
> +		return -EINVAL;
> +
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> +		return 0;
> +
> +	delta = msk->write_seq - v;
> +	if (delta > INT_MAX)
> +		delta = INT_MAX;
> +
> +	return (int)delta;
> +}
> +
> +static int mptcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	int answ;
> +	bool slow;

Reverse-xmas issue here.

> +
> +	switch (cmd) {
> +	case SIOCINQ:
> +		if (sk->sk_state == TCP_LISTEN)
> +			return -EINVAL;
> +
> +		lock_sock(sk);
> +		if (skb_queue_empty(&msk->receive_queue))

I'm guessing that the idea here is that answering with a nonzero value is 
enough to get the userspace program to do another read, rather than always 
imposing overhead to dig through the subflow rx buffers and 
sk->sk_receive_queue? That does seem like a good way to go, at least with 
regard to calling __mptcp_move_skbs().

Would it be useful to check sk->sk_receive_queue and splice if non-empty 
(which is relatively cheap) to get a slightly more accurate inq number? 
To maybe answer this question for myself - the socket lock was just 
acquired so it's unlikely for skbs to have been added to sk_receive_queue, 
and the extra complexity may not be worth it.

- Mat


> +			__mptcp_move_skbs(msk);
> +		answ = mptcp_inq_hint(sk);
> +		release_sock(sk);
> +		break;
> +	case SIOCOUTQ:
> +		slow = lock_sock_fast(sk);
> +		answ = mptcp_ioctl_outq(msk, READ_ONCE(msk->snd_una));
> +		unlock_sock_fast(sk, slow);
> +		break;
> +	case SIOCOUTQNSD:
> +		slow = lock_sock_fast(sk);
> +		answ = mptcp_ioctl_outq(msk, msk->snd_nxt);
> +		unlock_sock_fast(sk, slow);
> +		break;
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +
> +	return put_user(answ, (int __user *)arg);
> +}
> +
> static struct proto mptcp_prot = {
> 	.name		= "MPTCP",
> 	.owner		= THIS_MODULE,
> @@ -3272,6 +3325,7 @@ static struct proto mptcp_prot = {
> 	.shutdown	= mptcp_shutdown,
> 	.destroy	= mptcp_destroy,
> 	.sendmsg	= mptcp_sendmsg,
> +	.ioctl		= mptcp_ioctl,
> 	.recvmsg	= mptcp_recvmsg,
> 	.release_cb	= mptcp_release_cb,
> 	.hash		= mptcp_hash,
> -- 
> 2.32.0
>
>
>

--
Mat Martineau
Intel
