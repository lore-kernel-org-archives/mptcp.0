Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC385C87
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 23:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666222397; x=1697758397;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6tT/+OWK1ezfcugc4N5G6xwZ4irV92P9t3WkIsW26OA=;
  b=Ue7bjfKKUWWklY8E1wAl/NhqGjzpvdfyEhZAuZEiG8Ola5I/QCDesA57
   sf3r0F+sfkaIUY1mzT75qMml+JhqnNhuusutcSS1riU//UnBvmJh2s8+M
   HS9470KZBD/ZJsCDzQs/oYTSmlxSQnVx/Inpl4/sLS+97doTDEsQxqInJ
   S3P9KNrEOzkrwz04XKz2kC3l6gn3vT/r9FdlBKjUjMZw2sD8YPJjas1yK
   Kd65CI5+J7bo8c0ctr0rq3bKhUPmnhWt2ilWErO1XCB7FrKs/9Qv+ujT8
   WBF3S2BGO7Vb7yCee9FlUDjpoDfphAmWqHnmFl/QvL7RhuXZIdkcsPDvw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="370769235"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="370769235"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 16:33:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="629489644"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="629489644"
Received: from mk6ht25xq5mac.sea.intel.com ([10.241.111.152])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 16:33:16 -0700
Date: Wed, 19 Oct 2022 16:33:16 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 2/7] mptcp: use get_send wrapper
In-Reply-To: <c4caba14a3378673867216e1abd04a0aa46d43d4.1666185947.git.geliang.tang@suse.com>
Message-ID: <6537135b-1bbe-6cb9-5773-0f2181f04d18@linux.intel.com>
References: <cover.1666185947.git.geliang.tang@suse.com> <c4caba14a3378673867216e1abd04a0aa46d43d4.1666185947.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 19 Oct 2022, Geliang Tang wrote:

> This patch adds the multiple subflows support for __mptcp_push_pending()
> and __mptcp_subflow_push_pending(). Use mptcp_sched_get_send() wrapper
> instead of mptcp_subflow_get_send() in them.
>
> Check the subflow scheduled flags to test which subflow or subflows are
> picked by the scheduler, use them to send data.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Geliang -

Could you split the multi-subflow changes for __mptcp_push_pending() and 
__mptcp_subflow_push_pending() in to separate commits?

__mptcp_subflow_push_pending() is going to involve some larger changes. 
I'll work on some specific code suggestions/examples to clarify what I was 
trying to suggest after the meeting last week.

Thanks,

Mat


> ---
> net/mptcp/protocol.c | 98 +++++++++++++++++++++++++++-----------------
> 1 file changed, 61 insertions(+), 37 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 67450378cb97..05238a0313f6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1566,36 +1566,41 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> {
> 	struct sock *prev_ssk = NULL, *ssk = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {
> 		.flags = flags,
> 	};
> 	int ret = 0;
>
> -	while (mptcp_send_head(sk)) {
> -		prev_ssk = ssk;
> -		ssk = mptcp_subflow_get_send(msk);
> -
> -		/* First check. If the ssk has changed since
> -		 * the last round, release prev_ssk
> -		 */
> -		if (ssk != prev_ssk && prev_ssk)
> -			mptcp_push_release(prev_ssk, &info);
> -		if (!ssk)
> -			goto out;
> +again:
> +	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled)) {
> +				prev_ssk = ssk;
> +				ssk = mptcp_subflow_tcp_sock(subflow);
>
> -		/* Need to lock the new subflow only if different
> -		 * from the previous one, otherwise we are still
> -		 * helding the relevant lock
> -		 */
> -		if (ssk != prev_ssk)
> -			lock_sock(ssk);
> +				/* First check. If the ssk has changed since
> +				 * the last round, release prev_ssk
> +				 */
> +				if (ssk != prev_ssk && prev_ssk)
> +					mptcp_push_release(prev_ssk, &info);
>
> -		ret = __subflow_push_pending(sk, ssk, &info);
> -		if (ret <= 0) {
> -			if (ret == -EAGAIN)
> -				continue;
> -			mptcp_push_release(ssk, &info);
> -			goto out;
> +				/* Need to lock the new subflow only if different
> +				 * from the previous one, otherwise we are still
> +				 * helding the relevant lock
> +				 */
> +				if (ssk != prev_ssk)
> +					lock_sock(ssk);
> +
> +				ret = __subflow_push_pending(sk, ssk, &info);
> +				if (ret <= 0) {
> +					if (ret == -EAGAIN)
> +						goto again;
> +					mptcp_push_release(ssk, &info);
> +					goto out;
> +				}
> +				mptcp_subflow_set_scheduled(subflow, false);
> +			}
> 		}
> 	}
>
> @@ -1614,32 +1619,51 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> -	struct sock *xmit_ssk;
> 	int ret = 0;
>
> 	info.flags = 0;
> +again:
> 	while (mptcp_send_head(sk)) {
> 		/* check for a different subflow usage only after
> 		 * spooling the first chunk of data
> 		 */
> -		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
> -		if (!xmit_ssk)
> -			goto out;
> -		if (xmit_ssk != ssk) {
> -			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
> -					       MPTCP_DELEGATE_SEND);
> -			goto out;
> +		if (first) {
> +			ret = __subflow_push_pending(sk, ssk, &info);
> +			first = false;
> +			if (ret <= 0) {
> +				if (ret == -EAGAIN)
> +					goto again;
> +				break;
> +			}
> +			continue;
> 		}
>
> -		ret = __subflow_push_pending(sk, ssk, &info);
> -		first = false;
> -		if (ret <= 0) {
> -			if (ret == -EAGAIN)
> -				continue;
> -			break;
> +		if (mptcp_sched_get_send(msk))
> +			goto out;
> +
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled)) {
> +				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +				if (xmit_ssk != ssk) {
> +					mptcp_subflow_delegate(subflow,
> +							       MPTCP_DELEGATE_SEND);
> +					mptcp_subflow_set_scheduled(subflow, false);
> +					goto out;
> +				}
> +
> +				ret = __subflow_push_pending(sk, ssk, &info);
> +				if (ret <= 0) {
> +					if (ret == -EAGAIN)
> +						goto again;
> +					goto out;
> +				}
> +				mptcp_subflow_set_scheduled(subflow, false);
> +			}
> 		}
> 	}
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
