Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A32370
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 01:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665710080; x=1697246080;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fiHarhEU+a5VvfQ0Nxh7/TxriIdgWvz2EzxJfS/0DY4=;
  b=dB8V2ei1BxDSeIm7qsb9JVd/JIVs7aF5TcfmgxNdMj2nX8IEGxVH1crY
   /ce8ukqlHY53hsvSAeEhOhbyK7qRC02K4yM2o9G235rPuxigzljtlGGkI
   j3I9y2IQdruMTGTaeeIbFEM+BXAKNbXbK/G/mRDeFHy1QSKBTAM62EQSi
   4kFY1GErhFx6Btw68y6qpmYxtYS0gll/FJS0GjzJvHAm5v2/YUX5GTsho
   docwXAdgShSTDuBtskbd0eRcb7bFBKB2b1ZZpXRQkHhnJJ6p7QpVZ9L1H
   WLHv7WHg3/M773Mpr/5APq1eLNkr0B6Rbnvsmp9+sKDzNKchNYleKnH+o
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="391556423"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="391556423"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 18:14:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="716562952"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="716562952"
Received: from pateldee-mobl5.amr.corp.intel.com ([10.209.118.62])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 18:14:31 -0700
Date: Thu, 13 Oct 2022 18:14:30 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 10/12] mptcp: multi subflows
 subflow_push_pending
In-Reply-To: <5ed126ff5fef486cb205b81f7f78fb9e7df4e040.1665549148.git.geliang.tang@suse.com>
Message-ID: <fcae64af-2da6-4880-2d40-c32f76c8885f@linux.intel.com>
References: <cover.1665549148.git.geliang.tang@suse.com> <5ed126ff5fef486cb205b81f7f78fb9e7df4e040.1665549148.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 12 Oct 2022, Geliang Tang wrote:

> This patch adds the multiple subflows support for
> __mptcp_subflow_push_pending(). Use mptcp_sched_get_send() wrapper
> instead of mptcp_subflow_get_send() in it.
>
> Check the subflow scheduled flags to test which subflow or subflows are
> picked by the scheduler, use them to send data.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Hi Geliang -

We talked about redundant transmits from __mptcp_subflow_push_pending() in 
the meeting today: 
https://annuel2.framapad.org/p/mptcp_upstreaming_20221013#L110

It was hard to capture the whole discussion in the notes, but the main 
point is that handling the multi-sublow __mptcp_subflow_push_pending() is 
a lot more complicated than the __mptcp_push_pending() case.


__mptcp_subflow_push_pending() is running in one of two contexts, where 
the ssk lock is already held and sock_owned_by_user(msk) has been checked:

1. From mptcp_incoming_options(). This allows transmission of unsent data 
from mptcp_send_head when acks are received on a subflow - if the 
scheduler selects the subflow that is already locked, then additional data 
can be quickly sent without any delegated actions, release callbacks, or 
worker threads. If the scheduler selects a different subflow, a "delegated 
action" is used to schedule a callback for that subflow using the NAPI 
poll API.

2. From mptcp_napi_poll() (the "delegated action"), as scheduled by the 
case above.


There are some constraints to observe here:

In both case 1 and case 2, it should only delegate to one other subflow. 
If there are more than two redundant subflows scheduled, there would need 
to be a way to chain delegated calls. (I'll explain more about this with 
the code below).

It's also important to understand that the subflow and msk data locks are 
released between case 1 above and a delegated action that runs later. 
__mptcp_push_pending() could run and invoke the scheduler again, which 
would overwrite the subflow->scheduled bits that were set by 
__mptcp_subflow_push_pending(). This means __mptcp_push_pending() needs to 
be aware of multiple-subflow sends that are in progress, and finish those 
pushes before calling the scheduler again.


To make all this work, we think more data needs to be stored in each 
subflow by the scheduler. Each scheduled subflow needs to know:

  * Is it scheduled? (subflow->scheduled)
  * Where to start sending
  * How much data to try to send on that subflow

As the code is now, __mptcp_subflow_push_pending() will send sequential 
data instead of redundant data if multiple subflows are scheduled.


Like I said above, this is getting quite a bit more complicated for the 
multiple subflow case. What do you think about posting a v8 patch set that 
has only the single subflow refactoring and any necessary squash-to 
patches? Then we could add those commits to the export branch, and start 
working on a dedicated multi-subflow series?



> ---
> net/mptcp/protocol.c | 50 +++++++++++++++++++++++++++++++++-----------
> 1 file changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 36525d7ea8e7..4c9c2c6dfbe5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1599,11 +1599,11 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
> 					 bool first)
> {
> +	struct mptcp_subflow_context *subflow, *last = NULL;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> -	struct sock *xmit_ssk;
> 	int ret = 0;
>
> 	info.flags = 0;
> @@ -1612,20 +1612,46 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
> 		/* check for a different subflow usage only after
> 		 * spooling the first chunk of data
> 		 */
> -		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
> -		if (!xmit_ssk)
> -			goto out;
> -		if (xmit_ssk != ssk) {
> -			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
> -					       MPTCP_DELEGATE_SEND);
> +		if (first) {
> +			ret = __subflow_push_pending(sk, ssk, &info);
> +			if (ret <= 0) {
> +				if (ret == -EAGAIN)
> +					goto again;
> +				break;
> +			}
> +			first = false;
> +			continue;
> +		}
> +
> +		if (mptcp_sched_get_send(msk))
> 			goto out;
> +
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled))
> +				last = subflow;
> 		}
>
> -		ret = __subflow_push_pending(sk, ssk, &info);
> -		if (ret <= 0) {
> -			if (ret == -EAGAIN)
> -				goto again;
> -			break;
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled)) {
> +				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +				if (xmit_ssk != ssk) {
> +					mptcp_subflow_delegate(subflow,
> +							       MPTCP_DELEGATE_SEND);
> +					mptcp_subflow_set_scheduled(subflow, false);
> +					if (last && subflow != last)
> +						continue;
> +					goto out;

mptcp_subflow_delegate() should be called only one time to pick the next 
subflow to attempt. mptcp_napi_poll() will try to send on that subflow, 
and then call mptcp_subflow_delegate() to schedule the next subflow. This 
chain will continue until all the redundant subflows have transmitted 
their data.

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
