Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17815AC
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 00:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665449707; x=1696985707;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=O/vUjaZa6P/YkPiq8E5i+2L09Uh8q7YClsTXR7Xov6U=;
  b=DbuVrFDfx4y8xjpXAjA/ZMb6gaYxpKJmyB6q1MplBTDphUizTg9w9l6n
   +E/lCDN1ZoZslfxljEp+J/sKcqPpfWWgofUr8rgRHb1MvdMbs8b25SiYV
   XmUomeMgNfdaMUkIx8jgidzB63XwzyN9yQqpgaB8rDGSZhR5bsTu5cdJe
   80jVFmY++hEjtOyiEvDzSSUdpV8UlXCUm8Co9vi6ZJDNtVJHfUKLiMBPC
   FXkyls2WE3cLqKht7bCYxpOH8v7OiwzgexYfz3gHWFK+6vj23JtOXAexx
   YL2zhEtI8Nj6yiW65ESTh2JcfDdB2nnmUv2FQVgM8Y8N5vMeb5UgxgNxO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="330845745"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="330845745"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 17:55:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="626167512"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="626167512"
Received: from pnle-mobl.amr.corp.intel.com ([10.212.235.19])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 17:55:05 -0700
Date: Mon, 10 Oct 2022 17:55:05 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/2] Squash to "mptcp: multi subflows
 subflow_push_pending" v5
In-Reply-To: <20221009083604.14151-2-geliang.tang@suse.com>
Message-ID: <3d897fe0-15e5-2d94-15c0-d9cc3b0f22c8@linux.intel.com>
References: <20221009083604.14151-1-geliang.tang@suse.com> <20221009083604.14151-2-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sun, 9 Oct 2022, Geliang Tang wrote:

> Update the first chunk of data pushing.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 18 +++++++-----------
> 1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ff2c1bbf4484..acc220bfb34e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1614,17 +1614,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
> 		/* check for a different subflow usage only after
> 		 * spooling the first chunk of data
> 		 */
> -		if (first) {
> -			ret = __subflow_push_pending(sk, ssk, &info);
> -			if (ret <= 0) {
> -				if (ret == -EAGAIN)
> -					goto again;
> -				break;
> -			}
> -			first = false;
> -			msk->last_snd = ssk;
> -			continue;
> -		}
> +		if (first)
> +			goto push;

Is the only goal here to reduce duplicate code? It looks like the 
functionality is equivalent, but I'd rather not use 'goto' to jump into 
the middle of a loop.

The 'Squash to "mptcp: simplify push_pending"' looks fine to include in 
v6.

- Mat

>
> 		if (mptcp_sched_get_send(msk))
> 			goto out;
> @@ -1643,6 +1634,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
> 					continue;
> 				}
>
> +push:
> 				ret = __subflow_push_pending(sk, ssk, &info);
> 				if (ret <= 0) {
> 					if (ret == -EAGAIN)
> @@ -1650,6 +1642,10 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
> 					goto out;
> 				}
> 				msk->last_snd = ssk;
> +				if (first) {
> +					first = false;
> +					goto again;
> +				}
> 				mptcp_subflow_set_scheduled(subflow, false);
> 			}
> 		}
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
