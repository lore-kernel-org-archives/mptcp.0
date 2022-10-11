Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD4333CC
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 22:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665527444; x=1697063444;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BvxmCcou0znRQ6dCgSwzul+IRmvgOn4rehFrWPwfAa0=;
  b=jMs2vr3icIgHHtQtCF28s0i6XCk+YPCV8A7USe/fKU9dhmTC9Hi93qn+
   xENeeT8HEAEFqfPYzZYyvWe+QUs1G69yFpfje8d+MbFG3C8zgRkN2TAXl
   RwOAlr8+z4+bkL8+t+RO7bK63UegpFeful1RzjK/JtXtgar+78rxg8c9Q
   VsHaPLuTF8q91sLPHT9uByWezxy9h9U+FkqIoAj4eaqf9xbDzQVFOIvIf
   8eBVA6IVncYn1Iv1Nn3fLpqcQrT/iKroOZZxHoAlOGRJtM3UqrHSRsqno
   QfT0Pi9c0wnglaW6DyETBbYfafl1M3lInXWdwMQA3MRBATzm72eqFbZQL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="303381240"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="303381240"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 15:30:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="657534881"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="657534881"
Received: from klee13-mobl1.amr.corp.intel.com ([10.212.187.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 15:30:43 -0700
Date: Tue, 11 Oct 2022 15:30:43 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 06/13] mptcp: multi subflows push_pending
In-Reply-To: <20221011120137.5475-7-geliang.tang@suse.com>
Message-ID: <d2926dc5-f72d-f104-d982-78215924d96e@linux.intel.com>
References: <20221011120137.5475-1-geliang.tang@suse.com> <20221011120137.5475-7-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 11 Oct 2022, Geliang Tang wrote:

> This patch adds the multiple subflows support for __mptcp_push_pending().
> Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send() in
> it.
>
> Check the subflow scheduled flags to test which subflow or subflows are
> picked by the scheduler, use them to send data.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 32 ++++++++++++++++++++------------
> 1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 817e539d1d12..86ac38d10bc4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1561,22 +1561,30 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct mptcp_sendmsg_info info = {
> -				.flags = flags,
> -	};
> -	struct sock *ssk;
> 	int ret = 0;
>
> again:
> -	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
> -		lock_sock(ssk);
> -		ret = __subflow_push_pending(sk, ssk, &info);
> -		release_sock(ssk);
> +	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
> +		struct mptcp_subflow_context *subflow;
> +		struct mptcp_sendmsg_info info = {
> +			.flags = flags,
> +		};
>
> -		if (ret <= 0) {
> -			if (ret == -EAGAIN)
> -				goto again;
> -			goto out;
> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (READ_ONCE(subflow->scheduled)) {
> +				struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +				lock_sock(ssk);
> +				ret = __subflow_push_pending(sk, ssk, &info);
> +				release_sock(ssk);

Geliang -

It seems like this doesn't allow for redundant transmits, since 
__subflow_push_pending() updates msk->first_pending. Did you find that 
redundant sends were working correctly (maybe I've misunderstood)?

- Mat

> +
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
