Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDDD46B6
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 21:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664226897; x=1695762897;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fuEEMQWbGzpjAYd/p0S0Kc0ta8ge1e4r8zD7xy0WDiY=;
  b=A8g+L338Lho3EvdMSgrYN7k1QaL32JY3X03Y5aFZ3D0zwiok2n56WD3r
   DZEvOMjFsSZk83W50NQx10rYoQ4tNq5h+d5SNubbM75HkSVuzXFRVt9k1
   bzTE4i0mVO+rVRHVY0VhLi209jfcWJBQji+iygrPw9uNNo8+ZNXF4A6NW
   hKfAojzMLUhhqOSShNX1poRgrzsBCL108ZLk3LOTbfxG2NEIcT97rCUqS
   qW87d6CPD9FLXf+nblW09K+ZptEy5tDkFu5yp7oDaZeoc2c0w1ofnuO5e
   z/TcwQXVUtsZ8McEHXxu6Hc5ZnCKfisf1NDcAYlCJk9Z17tkmhuZv+q3B
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="299864141"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="299864141"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 14:14:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="746772807"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="746772807"
Received: from msakmal-mobl.amr.corp.intel.com ([10.209.99.219])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 14:14:56 -0700
Date: Mon, 26 Sep 2022 14:14:56 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: update misleading comments.
In-Reply-To: <870262a8c7ca7eb682da90684f2ff193a818924b.1664205929.git.pabeni@redhat.com>
Message-ID: <4d18a02d-5f12-cfdc-034f-10cb5e2696d8@linux.intel.com>
References: <870262a8c7ca7eb682da90684f2ff193a818924b.1664205929.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 26 Sep 2022, Paolo Abeni wrote:

> The MPTCP data path is quite complex and hard to understend even
> without some foggy comments referring to modified code and/or
> completely misleading from the beginning.
>
> Update a few of them to more accurately describing the current
> status.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thanks for updating the comments, Paolo. New comments look good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> net/mptcp/protocol.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c99eb4ce948e..8feb684408f7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -662,9 +662,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>
> 		skb = skb_peek(&ssk->sk_receive_queue);
> 		if (!skb) {
> -			/* if no data is found, a racing workqueue/recvmsg
> -			 * already processed the new data, stop here or we
> -			 * can enter an infinite loop
> +			/* With racing move_skbs_to_msk() and __mptcp_move_skbs(),
> +			 * a different CPU can have already processed the pending
> +			 * data, stop here or we can enter an infinite loop
> 			 */
> 			if (!moved)
> 				done = true;
> @@ -672,9 +672,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> 		}
>
> 		if (__mptcp_check_fallback(msk)) {
> -			/* if we are running under the workqueue, TCP could have
> -			 * collapsed skbs between dummy map creation and now
> -			 * be sure to adjust the size
> +			/* Under fallback skbs have no MPTCP extension and TCP could
> +			 * collapse them between the dummy map creation and the
> +			 * current dequeue. Be sure to adjust the map size.
> 			 */
> 			map_remaining = skb->len;
> 			subflow->map_data_len = skb->len;
> @@ -3767,7 +3767,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
> 	if (sk->sk_shutdown & RCV_SHUTDOWN)
> 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
>
> -	/* This barrier is coupled with smp_wmb() in tcp_reset() */
> +	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
> 	smp_rmb();
> 	if (sk->sk_err)
> 		mask |= EPOLLERR;
> -- 
> 2.37.3
>
>
>

--
Mat Martineau
Intel
