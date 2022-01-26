Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187442CA9
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 23:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643241510; x=1674777510;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=glBhiVd1INaQPV6aoL89JDf5+u8be7p87eH1y38QxSU=;
  b=aZXOTHhjHU4KbMODyVk38VpDYhNRFM8EKnWj5cImZfXvJwULdIp6sF4a
   VdCPK6rlZ/WNZK0aYmnudKIEx+s/yTZ1qbW8KZ1wLccHypnqKWla/32hh
   y/SqVC8FrigJqS7liNTVZS/CjAcQoGmBl+ZdCYLerg3XR70SBfW8JDKxc
   Gft0sVYosVsDQgOG9pLnF8Z4nA15xV9m5U4OfuvboehmQQdv9LqkIcQlP
   0jLO1+UWANJNXXlFHSh0khESgqWrO96z+9XC7bUqgpnVvFP1mFwlSWB0V
   UZAL8/S8J1EqdBZGqfMjejjUBh0qpfIVXidq34qRFEYhx6opM01T4seoM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245530165"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="245530165"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 15:58:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="767304084"
Received: from dhurwitz-mobl.amr.corp.intel.com ([10.209.79.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 15:58:29 -0800
Date: Wed, 26 Jan 2022 15:58:28 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/3] Squash to "mptcp: infinite mapping
 sending"
In-Reply-To: <a89164069e575fbb57a426877cc6d55e72a6834e.1643110285.git.geliang.tang@suse.com>
Message-ID: <59de1e76-b815-e09b-d364-ffc78ab4cf2@linux.intel.com>
References: <cover.1643110285.git.geliang.tang@suse.com> <a89164069e575fbb57a426877cc6d55e72a6834e.1643110285.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 25 Jan 2022, Geliang Tang wrote:

> Add a flag infinite_sent in struct mptcp_subflow_context, to make sure
> only one infinite map is sent.

Could you explain more about the extra infinite mappings you mention in 
the cover letter? Maybe share a pcap?

>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/options.c  | 2 +-
> net/mptcp/pm.c       | 4 +++-
> net/mptcp/protocol.h | 9 +++++++--
> 3 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 0d0d2eb8c8ca..03c82985dba1 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -826,7 +826,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>
> 	opts->suboptions = 0;
>
> -	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
> +	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(subflow, skb)))
> 		return false;
>
> 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 1f8878cc29e3..88f0fec1bee5 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -275,8 +275,10 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>
> 	pr_debug("fail_seq=%llu", fail_seq);
>
> -	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallback))
> +	if (!mptcp_has_another_subflow(sk) && READ_ONCE(msk->allow_infinite_fallback)) {
> 		subflow->send_infinite_map = 1;
> +		subflow->infinite_sent = 0;
> +	}
> }
>
> /* path manager helpers */
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index c47d69a42fcb..6bcf6cbded45 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -450,6 +450,7 @@ struct mptcp_subflow_context {
> 		send_mp_fail : 1,
> 		send_fastclose : 1,
> 		send_infinite_map : 1,
> +		infinite_sent : 1,
> 		rx_eof : 1,
> 		can_ack : 1,        /* only after processing the remote a key */
> 		disposable : 1,	    /* ctx can be free at ulp release time */
> @@ -893,13 +894,17 @@ static inline void mptcp_do_fallback(struct sock *sk)
>
> #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
>
> -static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
> +static inline bool mptcp_check_infinite_map(struct mptcp_subflow_context *subflow,
> +					    struct sk_buff *skb)
> {
> 	struct mptcp_ext *mpext;
>
> 	mpext = skb ? mptcp_get_ext(skb) : NULL;
> -	if (mpext && mpext->infinite_map)
> +	if (mpext && mpext->infinite_map &&
> +	    !subflow->infinite_sent) {
> +		subflow->infinite_sent = 1;

We don't want to have side effects in this function.

Even though the check for NULL skb means that infinite_sent is not 
modified when tcp_established_options() is called from tcp_current_mss(), 
this doesn't seem right. If this flag is needed (I'm not sure of that 
yet), wouldn't mptcp_update_infinite_map() be a better place for it?

> 		return true;
> +	}
>
> 	return false;
> }
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
