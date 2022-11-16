Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3787C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 00:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668559595; x=1700095595;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TrawdByVlpRxO6LFVnoSCXdENeNApt9n3xqMPWZUSsI=;
  b=k9CqVeRxXnIhpYgiPZZfSAYNUcm8ZTBjebWxtAcUUm26rmepN+417pkd
   Y810uamzD6uAmg9UDb0G/5igRsvbkJtmNAssCKVyaS5kZ2MwyfJfIJjH7
   EvXkpSt2z8gigw3giIB7CW4qBP/AndDf4+pAJ3TqURX1nlkLdzn8YZSni
   bzwpGZptPPOsPnzrhwkogyv9S1t8bMMLASzU2qsB8j2gVxWnLo016/9NF
   xaLhFi/JpchGLKbd5z3paFzu+8uSw9doU8I8EIwVgZ0wCT9RAhnUa0gCT
   T7QNDrheLnoUs1BIaKqIeF2QwOeX8Nqe1tP6Q/xjkjv0mLZ/T8meGucsO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="311116737"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="311116737"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:46:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="968211010"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="968211010"
Received: from trichard-mobl1.amr.corp.intel.com ([10.209.2.82])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:46:34 -0800
Date: Tue, 15 Nov 2022 16:46:33 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: refactor push_pending logic"
 v19
In-Reply-To: <20221112003133.27153-1-geliang.tang@suse.com>
Message-ID: <f2536a94-6bed-03ec-7f33-69efdbe3043a@linux.intel.com>
References: <20221112003133.27153-1-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 12 Nov 2022, Geliang Tang wrote:

> In the "msk->snd_burst <= 0" block, copied will never be 0, so err will
> never be EAGAIN, drop it.
>
> The orignal code only checks EAGAIN in __mptcp_push_pending, so drop this
> check in __mptcp_subflow_push_pending.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Looks good to squash, thanks.

- Mat

> ---
> net/mptcp/protocol.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a60961d0676d..2e60165c0eb2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1548,7 +1548,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> 		if (msk->snd_burst <= 0 ||
> 		    !sk_stream_memory_free(ssk) ||
> 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
> -			err = copied ? : -EAGAIN;
> +			err = copied;
> 			goto out;
> 		}
> 		mptcp_set_timeout(sk);
> @@ -1638,11 +1638,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
>
> 		ret = __subflow_push_pending(sk, ssk, &info);
> 		first = false;
> -		if (ret <= 0) {
> -			if (ret == -EAGAIN)
> -				continue;
> +		if (ret <= 0)
> 			break;
> -		}
> 		copied += ret;
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
