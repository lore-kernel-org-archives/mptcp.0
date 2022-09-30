Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCFA1363
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 00:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664498825; x=1696034825;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iuv66+TW1gWq/5j0MRucPNF3B09CggU9yukw5NZwQMs=;
  b=I/h0uMu2RlZt+AGuVAnqVV4vQ1mO6CSxXHccj0y+gYy/qYndAv0kPg9A
   TKSxSV9RjmZe9hswoUj+sJ+zIek4RFYT7Fq8pkfGza0qx/toLotvWlWck
   pm5DlWdpaPGhK/eqz1YUBbr2SwAyxwSFpzXKxz7dc6xpU2t3PWEXQJcHf
   QgjTTRV6H/Vr9BXTBBP/yglCqcRw0j9sTMjUeTntuYQrYGeZU1j83e6OG
   HWKQqDCYOsbxHxmSBv6xOiYI8YyKbP4r8eNCujZ2ZAolkWuKjrJwIH5+c
   buYKMbHiexCN0Yo7jSgS4KwLFjDcIUORrIAtAyojBcPRp8viT7Al+Q5G3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285204598"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="285204598"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 17:46:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="797779205"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="797779205"
Received: from kisungle-mobl.amr.corp.intel.com ([10.209.49.82])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 17:46:57 -0700
Date: Thu, 29 Sep 2022 17:46:56 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 2/4] mptcp: add do_push_pending helper
In-Reply-To: <3c7f5eb863b0b3b065fe28dfa116e7e1955b40d1.1664463491.git.geliang.tang@suse.com>
Message-ID: <147df9d2-45a2-9020-95e5-4ebe12a7f469@linux.intel.com>
References: <cover.1664463491.git.geliang.tang@suse.com> <3c7f5eb863b0b3b065fe28dfa116e7e1955b40d1.1664463491.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 29 Sep 2022, Geliang Tang wrote:

> This patch moves the duplicate code from __mptcp_push_pending() and
> __mptcp_subflow_push_pending() into a new helper function, named
> __do_push_pending(). And simplify __mptcp_push_pending() by invoking
> this helper.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 62 ++++++++++++++++++++++++--------------------
> 1 file changed, 34 insertions(+), 28 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 37a252a3f05b..fe92a301b8f7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1483,12 +1483,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> 	return ssk;
> }
>
> -static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
> -{
> -	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
> -	release_sock(ssk);
> -}
> -
> static void mptcp_update_post_push(struct mptcp_sock *msk,
> 				   struct mptcp_data_frag *dfrag,
> 				   u32 sent)
> @@ -1520,40 +1514,29 @@ void mptcp_check_and_set_pending(struct sock *sk)
> 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
> }
>
> -void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> +static int __do_push_pending(struct sock *sk, struct sock *ssk,
> +			     struct mptcp_sendmsg_info *info)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct mptcp_sendmsg_info info = {
> -				.flags = flags,
> -	};
> -	bool do_check_data_fin = false;
> 	struct mptcp_data_frag *dfrag;
> -	struct sock *ssk;
> -	int len;
> -
> -	ssk = mptcp_sched_get_send(msk);
> -	if (!ssk)
> -		goto out;
> -
> -	lock_sock(ssk);
> +	int len, copied = 0;
>
> 	while ((dfrag = mptcp_send_head(sk))) {
> -		info.sent = dfrag->already_sent;
> -		info.limit = dfrag->data_len;
> +		info->sent = dfrag->already_sent;
> +		info->limit = dfrag->data_len;
> 		len = dfrag->data_len - dfrag->already_sent;
> 		while (len > 0) {
> 			int ret = 0;
>
> -			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> +			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
> 			if (ret <= 0) {
> 				if (ret == -EAGAIN)
> 					continue;
> -				mptcp_push_release(ssk, &info);
> 				goto out;
> 			}
>
> -			do_check_data_fin = true;
> -			info.sent += ret;
> +			info->sent += ret;
> +			copied += ret;
> 			len -= ret;
>
> 			mptcp_update_post_push(msk, dfrag, ret);
> @@ -1569,10 +1552,33 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 		}
> 	}
>
> -	if (do_check_data_fin) {
> -		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> -			 info.size_goal);
> +out:
> +	if (copied) {
> +		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
> +			 info->size_goal);
> 	}
> +
> +	return copied;
> +}
> +
> +void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_sendmsg_info info = {
> +				.flags = flags,
> +	};
> +	bool do_check_data_fin = false;
> +	struct sock *ssk;
> +
> +	ssk = mptcp_sched_get_send(msk);
> +	if (!ssk)
> +		goto out;
> +
> +	if (!mptcp_send_head(sk))
> +		goto out;
> +
> +	lock_sock(ssk);
> +	do_check_data_fin = __do_push_pending(sk, ssk, &info);
> 	release_sock(ssk);
>
> out:

I think this is getting close to what I was talking about, but does not 
have the loop that will call the scheduler again. I tried this code and 
got slightly better performance in simult_flows.sh:

void __mptcp_push_pending(struct sock *sk, unsigned int flags)
{
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
 	struct sock *ssk;

 	while (mptcp_send_head(sk) && (ssk = mptcp_sched_get_send(msk))) {
 		lock_sock(ssk);
 		do_check_data_fin = __do_push_pending(sk, ssk, &info);
 		release_sock(ssk);
 	}

 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
 	if (do_check_data_fin)
 		__mptcp_check_send_data_fin(sk);
}



--
Mat Martineau
Intel
