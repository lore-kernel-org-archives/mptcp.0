Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B8160
	for <mptcp@lists.linux.dev>; Thu, 12 May 2022 00:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652314531; x=1683850531;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rAhJjPzj/+aC6Ye2ItBAqd5169E4q0TFGujqTIEVNKc=;
  b=DZCeQIvTjuA+DmHKe6+xVJxxZu/RT3F7uoIlaKjTADjW5/ClWEYyNIEC
   90S+YtGjYnGgLogVtUXdlYiTyB0nbO0Lby8TTUAem6gzQZ5RoDiUZ7WJN
   gQtjmeZ+HRY0aC9wpJ4b6PI/yabondTbuWm85VRDeskOFWUefrzluHdD6
   oGkRowUOM0VHGs5Pc2F7J60pL1IXJgSek8ys5se6sgdfap1XlJ29/GjDx
   V4fImtqIQK8pz9kjOF8Z2G1ZWqy09raZ2CHyPB6463j8rBO98uxwvM58U
   kx3dAqQWRp+k/h1SEUkme+i2IP4g8Hf5JCAid3GPqQuYbwR/fg2Hj+FhO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="267432422"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="267432422"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:15:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="572302582"
Received: from rdstein-mobl.amr.corp.intel.com ([10.212.177.197])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:15:30 -0700
Date: Wed, 11 May 2022 17:15:29 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: stop using the mptcp_has_another_subflow()
 helper
In-Reply-To: <5e05ab9275671ea3018eaa02028197817715de65.1652275377.git.pabeni@redhat.com>
Message-ID: <19d1ced2-b6f7-9e69-b152-6d52c21e0ac@linux.intel.com>
References: <5e05ab9275671ea3018eaa02028197817715de65.1652275377.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 11 May 2022, Paolo Abeni wrote:

> The mentioned helper requires the msk socket lock, and the
> current callers don't own it nor can't acquire it, so the
> access is racy.
>
> All the current callers are really checking for infinite mapping
> fallback, and the latter condition is explicitly tracked by
> the relevant msk variable: we can safely remove the caller usage
> - and the caller itself.
>
> The issue is present since MP_FAIL implementation, but the
> fix only applies since the infinite fallback support, ence the
> somewhat unexpected fixes tag.
>
> Fixes: 0530020a7c8f ("mptcp: track and update contiguous data status")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Looks good to me. I wasn't able to reproduce the CI failure.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>



> ---
> net/mptcp/pm.c       |  2 +-
> net/mptcp/protocol.h | 13 -------------
> net/mptcp/subflow.c  |  3 +--
> 3 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 59fdab2d0c27..8ba51120f35b 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -303,7 +303,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>
> 	pr_debug("fail_seq=%llu", fail_seq);
>
> -	if (mptcp_has_another_subflow(sk) || !READ_ONCE(msk->allow_infinite_fallback))
> +	if (!READ_ONCE(msk->allow_infinite_fallback))
> 		return;
>
> 	if (!READ_ONCE(subflow->mp_fail_response_expect)) {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f98c27300e60..dbb914def5cc 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -661,19 +661,6 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
> 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
> }
>
> -static inline bool mptcp_has_another_subflow(struct sock *ssk)
> -{
> -	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk), *tmp;
> -	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> -
> -	mptcp_for_each_subflow(msk, tmp) {
> -		if (tmp != subflow)
> -			return true;
> -	}
> -
> -	return false;
> -}
> -
> void __init mptcp_proto_init(void);
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> int __init mptcp_proto_v6_init(void);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index b38a02db924b..550c8fbec54d 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1218,8 +1218,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 	if (!__mptcp_check_fallback(msk)) {
> 		/* RFC 8684 section 3.7. */
> 		if (subflow->send_mp_fail) {
> -			if (mptcp_has_another_subflow(ssk) ||
> -			    !READ_ONCE(msk->allow_infinite_fallback)) {
> +			if (!READ_ONCE(msk->allow_infinite_fallback)) {
> 				ssk->sk_err = EBADMSG;
> 				tcp_set_state(ssk, TCP_CLOSE);
> 				subflow->reset_transient = 0;
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
