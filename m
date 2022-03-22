Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288F621
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 00:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647908543; x=1679444543;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=G9mM6iveN3ifAeKGZRYTvkJg0IOAofkwhraxZc88WsM=;
  b=KCGYrZHf+W2sP1H2sYtLEYJVuupbHearqv2dTQMq9tcJ3Fzpc2mnn4uP
   EBja4dCF8GgY4wkpkhSNTusEhNCIfO9DeXdULhzSa8erSLFuXECEYaFDJ
   ZsNnW44ouhvfdApTZDT9bWvHmLqRdfNpPWFJHKKjnb4k8+0gtVxN166YM
   XduTnSNZF4zQoZ3VhdVeUoHg+ahRRF9VtWVlts0a9bJQHrf22UnkzeSE9
   20qabUxadKC2GVXfswWO2uICC5yB5+bqPNJ7gB/NK0rEhMhjpdtt15a0l
   3YISNrbwEiSkAeU2GbKlDSiqQX1t+Tn1hmLVxY12dG0bXKdTiOD6xGreS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="256502425"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="256502425"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:22:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="560112338"
Received: from danieljm-mobl.amr.corp.intel.com ([10.252.129.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:22:22 -0700
Date: Mon, 21 Mar 2022 17:22:21 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/3] mptcp: optimize release_cb for the common
 case
In-Reply-To: <6fc1ea29ae85074d626ad1cef3fea34055de37f1.1647601548.git.pabeni@redhat.com>
Message-ID: <5090893b-932c-6086-93ee-dfc357dbe859@linux.intel.com>
References: <6fc1ea29ae85074d626ad1cef3fea34055de37f1.1647601548.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 18 Mar 2022, Paolo Abeni wrote:

> The mptcp release callback checks several flags in atomic
> context, but only MPTCP_CLEAN_UNA can be up frequently.
>
> Reorganize the code to avoid multiple conditionals in the
> most common scenarios.
>
> Additional clarify a related comment.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)
>

This one LGTM:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index fbb14dfe62b3..bdba1ddee2a7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3118,15 +3118,17 @@ static void mptcp_release_cb(struct sock *sk)
> 		spin_lock_bh(&sk->sk_lock.slock);
> 	}
>
> -	/* be sure to set the current sk state before tacking actions
> -	 * depending on sk_state
> -	 */
> -	if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags))
> -		__mptcp_set_connected(sk);
> 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
> 		__mptcp_clean_una_wakeup(sk);
> -	if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
> -		__mptcp_error_report(sk);
> +	if (unlikely(&msk->cb_flags)) {
> +		/* be sure to set the current sk state before tacking actions
> +		 * depending on sk_state, that is processing MPTCP_ERROR_REPORT
> +		 */
> +		if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags))
> +			__mptcp_set_connected(sk);
> +		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
> +			__mptcp_error_report(sk);
> +	}
>
> 	__mptcp_update_rmem(sk);
> }
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
