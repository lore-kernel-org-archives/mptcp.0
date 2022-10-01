Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DD41360
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 00:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664583366; x=1696119366;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=impTcFVH+O8SrB0qlSyuDiAxptJl5+KUQW+FvDiY/Co=;
  b=nPtUejxUniaDK8C3EjRfNDtVYUWu7+GcOBrGmnhq75hVMyelgQKovQ87
   2zy/9PVJrEPiiocFB0xa4n8CzXVlEOowNhGityeCR5ZN7z2PPyvytdGYQ
   wCOKKjUQToSn/roBzm5p79ZK9jEXKAzbYdxhWPmsV00WKL89bxxwP8zq7
   fMei2pgtqXefgh2zv55bKA1WCi34J22IwXJ1fWbS3GXtVb9DU9kmBxBn0
   O7SaOp8FxXBcoHxq1fkCJhjDZCBIYZPBxaB9ry7G2hP/dksqNN9rO6Qbq
   hjKpqtVCi/H7YvKHXow3kuYM5lPLSQreCxbkbPZyPTnRNyragaFu8dsWw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="282028847"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="282028847"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 17:16:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="867990208"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="867990208"
Received: from gkaragat-mobl.amr.corp.intel.com ([10.252.141.75])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 17:16:05 -0700
Date: Fri, 30 Sep 2022 17:16:04 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 4/5] mptcp: update
 __mptcp_subflow_push_pending
In-Reply-To: <37356025b64f3a1efc6e2726a51840c4fb80a177.1664547250.git.geliang.tang@suse.com>
Message-ID: <6e1884f7-54f4-4cae-67c0-53c66f2dfb79@linux.intel.com>
References: <cover.1664547250.git.geliang.tang@suse.com> <37356025b64f3a1efc6e2726a51840c4fb80a177.1664547250.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 30 Sep 2022, Geliang Tang wrote:

> Move the packet scheduler out of the dfrags loop, invoke it only once in
> __mptcp_subflow_push_pending().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Hi Geliang -

I think the __mptcp_push_pending() changes are looking good. Some changes 
are needed here for __mptcp_subflow_push_pending().

> ---
> net/mptcp/protocol.c | 44 ++++++++++++++++++++------------------------
> 1 file changed, 20 insertions(+), 24 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index dc5e03a616b3..8e67c149bbab 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1589,7 +1589,15 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> 	struct mptcp_data_frag *dfrag;
> 	struct sock *xmit_ssk;
> 	int len, copied = 0;
> -	bool first = true;
> +
> +	xmit_ssk = mptcp_sched_get_send(msk);
> +	if (!xmit_ssk)
> +		goto out;
> +	if (xmit_ssk != ssk) {
> +		mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
> +				       MPTCP_DELEGATE_SEND);
> +		goto out;
> +	}

There's no need to delegate before the first __do_push_pending(). In the 
existing code, the first send skips the scheduler call and tries to send 
on the selected ssk (the one that's the last arg to the function).

The existing code then calls the scheduler after each 
mptcp_sendmsg_frag(), and if the scheduler chooses a different xmit_ssk 
then mptcp_subflow_delegate() is called and it does the 'goto out'.

In other words, this function also needs a loop like 
__mptcp_push_pending() to call the scheduler multiple times.


- Mat

>
> 	info.flags = 0;
> 	while ((dfrag = mptcp_send_head(sk))) {
> @@ -1599,19 +1607,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> 		while (len > 0) {
> 			int ret = 0;
>
> -			/* the caller already invoked the packet scheduler,
> -			 * check for a different subflow usage only after
> -			 * spooling the first chunk of data
> -			 */
> -			xmit_ssk = first ? ssk : mptcp_sched_get_send(msk);
> -			if (!xmit_ssk)
> -				goto out;
> -			if (xmit_ssk != ssk) {
> -				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
> -						       MPTCP_DELEGATE_SEND);
> -				goto out;
> -			}
> -
> 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> 			if (ret <= 0)
> 				goto out;
> @@ -1619,11 +1614,18 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> 			info.sent += ret;
> 			copied += ret;
> 			len -= ret;
> -			first = false;
>
> 			mptcp_update_post_push(msk, dfrag, ret);
> 		}
> 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> +
> +		if (msk->snd_burst > 0 &&
> +		    sk_stream_memory_free(ssk) &&
> +		    mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
> +			mptcp_set_timeout(sk);
> +		} else {
> +			break;
> +		}
> 	}
>
> out:
> @@ -3182,16 +3184,10 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
> 	if (!mptcp_send_head(sk))
> 		return;
>
> -	if (!sock_owned_by_user(sk)) {
> -		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
> -
> -		if (xmit_ssk == ssk)
> -			__mptcp_subflow_push_pending(sk, ssk);
> -		else if (xmit_ssk)
> -			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
> -	} else {
> +	if (!sock_owned_by_user(sk))
> +		__mptcp_subflow_push_pending(sk, ssk);
> +	else
> 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
> -	}
> }
>
> #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
