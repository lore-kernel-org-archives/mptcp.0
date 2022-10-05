Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF8F364
	for <mptcp@lists.linux.dev>; Wed,  5 Oct 2022 00:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664928982; x=1696464982;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=x57agph7jrIudbn4W45Hs7to36iA0thrRYayxZ4js6E=;
  b=IxfdtenVaP2e8AzYov1Z3rSsuQvq49VuAOnGJ64fKXh6GjgE21ZXogYw
   tBXf/4ET4kB6WbMUkL/HAYurcqLStBlpUsWm/b59NlY2xqf3Sgk7wKVB/
   PwexM8OejnP7Q5cr/Hi96VhS94+fTDpTZvioSe6NMJSwhlZX6LdJjpGD2
   6SRcweqlMHdxkrvrnLek505jDicxpzE9W7y4nvSYkVsmP+r/D6r9NDJUn
   XJfhpPITBUb2VGDX/hAbxACPT/XpqJCr1HKkINN2RYQw/BOshkfciM3Nk
   HDeYPib6drMSSviI0VENec9+/D+6dguq6RtqSODFNO13fzSccPCoUlT21
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="282768904"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="282768904"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 17:16:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728467099"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728467099"
Received: from jessicat-mobl.amr.corp.intel.com ([10.209.12.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 17:16:21 -0700
Date: Tue, 4 Oct 2022 17:16:21 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 02/11] mptcp: add new argument ssk_first
In-Reply-To: <03e299e3fa96817a92e0f0f79f7bce938f732d96.1664720538.git.geliang.tang@suse.com>
Message-ID: <49eef695-e843-f3ab-90fa-6ba21f654147@linux.intel.com>
References: <cover.1664720538.git.geliang.tang@suse.com> <03e299e3fa96817a92e0f0f79f7bce938f732d96.1664720538.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sun, 2 Oct 2022, Geliang Tang wrote:

> The function mptcp_subflow_process_delegated() uses the input ssk first,
> while __mptcp_check_push() invokes the packet scheduler first.
>
> So this patch adds a new argument named ssk_first for the function
> __mptcp_subflow_push_pending() to deal with these two cases separately.
>
> With this change, the code that invokes the packet scheduler in the
> fuction __mptcp_check_push() can be removed, and replaced by invoking
> __mptcp_subflow_push_pending() directly.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 22 ++++++++--------------
> 1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index cc8e67543e76..bbc43212a20f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1593,16 +1593,17 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 		__mptcp_check_send_data_fin(sk);
> }
>
> -static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> +static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
> +					 bool ssk_first)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> 	struct mptcp_data_frag *dfrag;
> +	bool first = ssk_first;

Hi Geliang -

Thanks for the v4.

If you add 'first' as the new argument instead of ssk_first, then you can 
remove this line and use 'first' everywhere.


- Mat


> 	struct sock *xmit_ssk;
> 	int len, copied = 0;
> -	bool first = true;
>
> 	info.flags = 0;
> 	while ((dfrag = mptcp_send_head(sk))) {
> @@ -1612,8 +1613,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> 		while (len > 0) {
> 			int ret = 0;
>
> -			/* the caller already invoked the packet scheduler,
> -			 * check for a different subflow usage only after
> +			/* check for a different subflow usage only after
> 			 * spooling the first chunk of data
> 			 */
> 			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
> @@ -3195,16 +3195,10 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
> 	if (!mptcp_send_head(sk))
> 		return;
>
> -	if (!sock_owned_by_user(sk)) {
> -		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
> -
> -		if (xmit_ssk == ssk)
> -			__mptcp_subflow_push_pending(sk, ssk);
> -		else if (xmit_ssk)
> -			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
> -	} else {
> +	if (!sock_owned_by_user(sk))
> +		__mptcp_subflow_push_pending(sk, ssk, false);
> +	else
> 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
> -	}
> }
>
> #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
> @@ -3295,7 +3289,7 @@ void mptcp_subflow_process_delegated(struct sock *ssk)
> 	if (test_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status)) {
> 		mptcp_data_lock(sk);
> 		if (!sock_owned_by_user(sk))
> -			__mptcp_subflow_push_pending(sk, ssk);
> +			__mptcp_subflow_push_pending(sk, ssk, true);
> 		else
> 			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
> 		mptcp_data_unlock(sk);
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
