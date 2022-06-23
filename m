Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E751366
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 00:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655945187; x=1687481187;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uLRaQWCFN6vWC8PLqcvOi7Mc4Fc0ViUys2GKLcHeuWs=;
  b=Hnwu4hDHn9Rok1UKr/HrNLy/o00HPs7pAP3PEp8E3mTfapdDfEDSQ5fg
   9I1MyT/4l2q7FL7I2D1jjWjutNxkiFV223zeLUxi++bk72rVBeq+BjOod
   K8dHzx5H/1duiNIVxtVld5uGoieyjgyYIuzXhP7ohVSy0DDXHk95dAxwX
   Qd8xocS4lwrhMVJDt4+tHuV/3MYMml5+pUJ2JzXyKk8mLZjNqteDiam3h
   N8WXwpH1PCyQzlkGXEKEhp9UuzWOh8Gn0w1xyGTG+WLRLJnU1nZvNfhi6
   Cezxsc2wSTtF+Cr5/zjw4l69nlbehbE9mfnYRcOkN8COIJC5wDDYiDDMy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="261019242"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="261019242"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 17:46:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="677825307"
Received: from desireen-mobl.amr.corp.intel.com ([10.209.126.32])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 17:46:27 -0700
Date: Wed, 22 Jun 2022 17:46:26 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 2/5] mptcp: redundant subflows push
 pending
In-Reply-To: <f793d9828fcb5f698f577b75597ab8a378035e68.1655804700.git.geliang.tang@suse.com>
Message-ID: <c5223010-4547-9bc7-2e7a-3ecd83763bd1@linux.intel.com>
References: <cover.1655804700.git.geliang.tang@suse.com> <f793d9828fcb5f698f577b75597ab8a378035e68.1655804700.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 21 Jun 2022, Geliang Tang wrote:

> This patch adds the redundant subflows support for __mptcp_push_pending().
> Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send()
> in it.
>
> Check the subflow scheduled flags to test which subflow or subflows are
> picked by the scheduler, use them to send data.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 96 +++++++++++++++++++++++++-------------------
> 1 file changed, 55 insertions(+), 41 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 043ac3f222ed..4f5e7f7fa6aa 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1551,58 +1551,72 @@ void mptcp_check_and_set_pending(struct sock *sk)
>
> void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> {
> -	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct mptcp_sendmsg_info info = {
> -				.flags = flags,
> -	};
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_data_frag *dfrag;
> 	int len, copied = 0;
> +	int err = 0;
>
> -	while ((dfrag = mptcp_send_head(sk))) {
> -		info.sent = dfrag->already_sent;
> -		info.limit = dfrag->data_len;
> -		len = dfrag->data_len - dfrag->already_sent;
> -		while (len > 0) {
> -			int ret = 0;
> -
> -			prev_ssk = ssk;
> -			ssk = mptcp_subflow_get_send(msk);
> -
> -			/* First check. If the ssk has changed since
> -			 * the last round, release prev_ssk
> -			 */
> -			if (ssk != prev_ssk && prev_ssk)
> -				mptcp_push_release(prev_ssk, &info);
> -			if (!ssk)
> -				goto out;
> +	mptcp_sched_get_send(msk, &err);
> +	if (err)
> +		goto out;
>
> -			/* Need to lock the new subflow only if different
> -			 * from the previous one, otherwise we are still
> -			 * helding the relevant lock
> -			 */
> -			if (ssk != prev_ssk)
> -				lock_sock(ssk);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (READ_ONCE(subflow->scheduled)) {
> +			struct sock *prev_ssk = NULL, *ssk = NULL;
> +			struct mptcp_sendmsg_info info = {
> +				.flags = flags,
> +			};
> +
> +			while ((dfrag = mptcp_send_head(sk))) {

Hi Geliang -

Thanks for updating for v7. The changes you've made are definitely in the 
direction I was asking for, following the model of:

scheduler()
for_each_subflow():
    while(dfrag=...):
      send as much data on one subflow with one lock/unlock

I think there are some more modifications to make in order to send the 
same data on each subflow.

> +				info.sent = dfrag->already_sent;
> +				info.limit = dfrag->data_len;
> +				len = dfrag->data_len - dfrag->already_sent;
> +				while (len > 0) {
> +					int ret = 0;
> +
> +					prev_ssk = ssk;
> +					ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +					/* First check. If the ssk has changed since
> +					 * the last round, release prev_ssk
> +					 */
> +					if (ssk != prev_ssk && prev_ssk)
> +						mptcp_push_release(prev_ssk, &info);
> +					if (!ssk)
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
> +					len -= ret;
> +
> +					mptcp_update_post_push(msk, dfrag, ret);
> +				}
> +				WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));

When msk->first_pending is updated here, it changes the value returned by 
mptcp_send_head() in the "while ((dfrag = mptcp_send_head(sk)))" loop for 
the next subflow.

So, when there are redundant subflows scheduled, the next subflow will 
send new data instead of redundant data. This is because of the 
modifications made to msk->first_pending and the changes made to 
dfrag->already_sent in mptcp_update_post_push().

I think the fix is to keep the loop structure the same, but modify the 
"while ((dfrag = mptcp_send_head(sk)))" loop:

* Every subflow starts sending from the same position in the same 
first dfrag

* Track the max sent data across all the subflows (similar to the 'max' 
tracking done in v6)

* Update dfrag->already_sent (for all sent dfrags) and msk->first_pending 
after all subflows have been attempted. This is currently done by 
mptcp_update_post_push() after each dfrag but I think can be delayed until 
all subflows have sent. It looks like the update to msk->snd_nxt can also 
be delayed until after all subflows have sent.

* Now that I've looked more closely at how mptcp_update_post_push() 
handles msk->snd_burst, I think msk->snd_burst should be set to 0 in 
mptcp_sched_data_init().


This could send different length mappings on each subflow, I need to 
double check the RFC to see if that's allowed.


> +			}
>
> -			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
> -			if (ret <= 0) {
> +			/* at this point we held the socket lock for the last subflow we used */
> +			if (ssk) {
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
>
> -	/* at this point we held the socket lock for the last subflow we used */
> -	if (ssk)
> -		mptcp_push_release(ssk, &info);
> -
> out:
> 	/* ensure the rtx timer is running */
> 	if (!mptcp_timer_pending(sk))
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
