Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B81860
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 21:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656709315; x=1688245315;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=v3G+2dHaZidu11TD1YI7wDqd+WLF5CU+0LJ4duITO3k=;
  b=bvbjt1uksGCRHuTw8npmsCkuQXM8HHI2sz5J3+8dIeYne0xJmU0iEvvK
   sEOqppcz4q/VlQZB9FbIJXe96Tpq3egOV+wydCKlvRfTuzr02a8BIu20Y
   tR8cVUhX0eeShCxV+uZ4mhWAX6kOfsqoAjC9IaQybxOqFy+EE1Dt9z0de
   jJSUBQ7XNjFuIToKyf5aswa3I5uq7F9j/gDdI77qRFqDH3gbDbmUcL8kS
   KIN6whEiM0N2zMX7olEQeB8DTZ42A8EZAehLwlWF+QJ3jP03YrmxZBGwQ
   B/iXYnQrYKJSuda/O7xa3+UhW8131K61OH8IYh6GrYAhSOzT5wwPt6JPf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="346726933"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="346726933"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 14:01:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="659561599"
Received: from shubhaml-mobl.amr.corp.intel.com ([10.255.229.171])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 14:01:53 -0700
Date: Fri, 1 Jul 2022 14:01:53 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v10 2/5] mptcp: redundant subflows push
 pending
In-Reply-To: <ef3d52ff98c97b3c3e5b1efd84a1d4bf3448df5d.1656578856.git.geliang.tang@suse.com>
Message-ID: <c33d2f78-7ff-7878-71f4-98c8ad7e588c@linux.intel.com>
References: <cover.1656578856.git.geliang.tang@suse.com> <ef3d52ff98c97b3c3e5b1efd84a1d4bf3448df5d.1656578856.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 30 Jun 2022, Geliang Tang wrote:

> This patch adds the redundant subflows support for __mptcp_push_pending().
> Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send()
> in it.
>
> Check the subflow scheduled flags to test which subflow or subflows are
> picked by the scheduler, use them to send data.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 96 ++++++++++++++++++++++++++------------------
> net/mptcp/protocol.h | 10 +++++
> 2 files changed, 66 insertions(+), 40 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6e44786e01fd..f97e6c318c0b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1516,57 +1516,73 @@ void mptcp_check_and_set_pending(struct sock *sk)
>
> void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> {
> -	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct mptcp_sendmsg_info info = {
> -				.flags = flags,
> -	};
> -	struct mptcp_data_frag *dfrag;
> +	struct mptcp_subflow_context *subflow;
> 	int len, copied = 0;
>
> -	while ((dfrag = mptcp_send_head(sk))) {
> -		info.sent = dfrag->already_sent;
> -		info.limit = dfrag->data_len;
> -		len = dfrag->data_len - dfrag->already_sent;
> -		while (len > 0) {
> -			int ret = 0;
> +	if (!mptcp_sched_get_send(msk))
> +		goto out;
>
> -			prev_ssk = ssk;
> -			ssk = mptcp_subflow_get_send(msk);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (READ_ONCE(subflow->scheduled)) {
> +			struct sock *prev_ssk = NULL, *ssk = NULL;
> +			struct mptcp_sendmsg_info info = {
> +				.flags = flags,
> +			};
> +			struct mptcp_data_frag *dfrag;
>
> -			/* First check. If the ssk has changed since
> -			 * the last round, release prev_ssk
> -			 */
> -			if (ssk != prev_ssk && prev_ssk)
> -				mptcp_push_release(prev_ssk, &info);
> -			if (!ssk)
> +			dfrag = mptcp_send_head(sk);
> +			if (!dfrag)
> 				goto out;
>
> -			/* Need to lock the new subflow only if different
> -			 * from the previous one, otherwise we are still
> -			 * helding the relevant lock
> -			 */
> -			if (ssk != prev_ssk)
> -				lock_sock(ssk);
> -
> -			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> -			if (ret <= 0) {
> +			do {
> +				info.sent = dfrag->already_sent;
> +				info.limit = dfrag->data_len;
> +				len = dfrag->data_len - dfrag->already_sent;
> +				while (len > 0) {
> +					int ret = 0;
> +
> +					prev_ssk = ssk;
> +					ssk = mptcp_subflow_tcp_sock(subflow);

prev_ssk isn't needed any more. The old code could return different ssks 
from each scheduler call, but now the ssk is the same for each iteration 
of the mptcp_for_each_subflow() loop. The locking can be simplified to 
lock the ssk before the do-while loop, and to always call 
mptcp_push_release() after the do-while loop is done.

> +
> +					/* First check. If the ssk has changed since
> +					 * the last round, release prev_ssk
> +					 */
> +					if (ssk != prev_ssk && prev_ssk)
> +						mptcp_push_release(prev_ssk, &info);
> +					if (!ssk)

This check is no longer needed, mptcp_subflow_tcp_sock() won't be 
returning NULL.

> +						goto out;
> +
> +					/* Need to lock the new subflow only if different
> +					 * from the previous one, otherwise we are still
> +					 * helding the relevant lock
> +					 */
> +					if (ssk != prev_ssk)
> +						lock_sock(ssk);
> +
> +					ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> +					if (ret <= 0) {
> +						mptcp_push_release(ssk, &info);
> +						goto out;
> +					}
> +
> +					info.sent += ret;
> +					copied += ret;

Since 'copied' is only used below to determine if 
__mptcp_check_send_data_fin() should be called, I think it would be 
clearer to use a bool variable do something like this:

if (ret > 0)
 	do_check_data_fin = true;

instead. 'copied' can be removed.

> +					len -= ret;
> +
> +					mptcp_update_post_push(msk, dfrag, ret);

This modifies dfrag->already_sent and msk->snd_nxt, which will interfere 
with sending data on the next subflow. All the dfrag modifications need to 
be made _after_ the mptcp_for_each_subflow() loop is done (right before 
the "out:" label).

Store a pointer to the last dfrag that was used, and how many bytes were 
sent from it (last_dfrag and last_sent?).

> +				}
> +			} while ((dfrag = mptcp_next_frag(sk, dfrag)));
> +
> +			/* at this point we held the socket lock for the last subflow we used */
> +			if (ssk) {

Like I mentioned above, this conditional is no longer needed.

> 				mptcp_push_release(ssk, &info);
> -				goto out;
> +				msk->last_snd = ssk;
> +				mptcp_subflow_set_scheduled(subflow, false);
> 			}
> -
> -			info.sent += ret;
> -			copied += ret;
> -			len -= ret;
> -
> -			mptcp_update_post_push(msk, dfrag, ret);
> 		}
> -		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> 	}
> -
> -	/* at this point we held the socket lock for the last subflow we used */
> -	if (ssk)
> -		mptcp_push_release(ssk, &info);

Here (before updating msk->first_pending) is the place to update the dfrag 
list. Walk the list from mptcp_send_head() to last_dfrag. All of the 
dfrags before last_dfrag need to assign dfrag->already_sent = 
dfrag->data_len (because they were fully sent). For last_dfrag, call 
mptcp_update_post_push().

Also double-check that msk->snd_burst is updated correctly.

> +	WRITE_ONCE(msk->first_pending, NULL);

This shouldn't be NULL - needs to be mptcp_send_next() like the old code, 
which should work if the dfrag list is updated.

>
> out:
> 	/* ensure the rtx timer is running */
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index af414cd8b7cd..09a9797d2dfb 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -355,6 +355,16 @@ static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
> 						     list_next_entry(cur, list);
> }
>
> +static inline struct mptcp_data_frag *mptcp_next_frag(struct sock *sk,
> +						      struct mptcp_data_frag *cur)
> +{
> +	if (!cur)
> +		return NULL;
> +
> +	return list_is_last(&cur->list, &mptcp_sk(sk)->rtx_queue) ? NULL :
> +						     list_next_entry(cur, list);
> +}
> +
> static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
