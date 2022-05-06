Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A906B7F
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 15:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651849527; x=1683385527;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zfAyfwHZeptJFKZr8lnpb8bBK3Fe9hLGhoWwjd2hBKQ=;
  b=VezEfHwZMrVA6tu8wbp1IZYCloQSN+nv6DxJBsmDNR3QKlv4qN/HYSBw
   wdh5oO03Fa8mqYtF/sP+0dg6gUxUcfab7gRgWKLJLkY0ob///cv/uFNOw
   r+TuPqOB0ofOo501TlARgRd4yFZrrm9ZpAch3P3tp5aI76Xhp1CmwZsXN
   upqXjMOY3mCXj6DBFQaM5CBsFfUZKdY7Zb/S9PUFbU/LTs8zBs0pNLiyG
   aGeDFOmLpBWR3hQ4fiyWwZMul/GtNVwGn+zxXP5aXn7ezGvC3unGJhcKS
   O1q/COJckXd2zjiBHgGc8yoTZaTMjjoyGJrThcU7R5GsIfCCQAqr07au0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="354923221"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="354923221"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:05:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="537924326"
Received: from jrbond-mobl1.amr.corp.intel.com ([10.212.218.216])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:05:00 -0700
Date: Fri, 6 May 2022 08:04:52 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH net v3] net/sched: act_pedit: really ensure the skb is
 writable
In-Reply-To: <7ec2ff1bd88c6d87e452afa58f1f6b6c756a2fb0.1651828857.git.pabeni@redhat.com>
Message-ID: <9220dc2b-1082-db78-4c3e-9d4f801279c9@linux.intel.com>
References: <7ec2ff1bd88c6d87e452afa58f1f6b6c756a2fb0.1651828857.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 6 May 2022, Paolo Abeni wrote:

> Currently pedit tries to ensure that the accessed skb offset
> is writeble via skb_unclone(). The action potentially allows
> touching any skb bytes, so it may end-up modifying shared data.
>
> The above causes some sporadic MPTCP self-test failures.
>
> Address the issue keeping track of a rough over-estimate highest skb
> offset accessed by the action and ensure such offset is really
> writable.
>
> Note that this may cause performance regressions in some scenario,
> but hopefully pedit is not critical path.
>
> v1 -> v2:
> - cleanup hint update (Jakub)
> - avoid raices while accessing the hint (Jakub)
> - re-organize the comments for clarity
>
> Fixes: db2c24175d14 ("act_pedit: access skb->data safely")
> Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Tested-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
> - release lock on error (Mat)

LGTM. My Acked-by tag is re-affirmed :)

- Mat

>
> note: part of the changelog is here, because -net will see only v2
> (hopefully)
> ---
> include/net/tc_act/tc_pedit.h |  1 +
> net/sched/act_pedit.c         | 26 ++++++++++++++++++++++----
> 2 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
> index 748cf87a4d7e..3e02709a1df6 100644
> --- a/include/net/tc_act/tc_pedit.h
> +++ b/include/net/tc_act/tc_pedit.h
> @@ -14,6 +14,7 @@ struct tcf_pedit {
> 	struct tc_action	common;
> 	unsigned char		tcfp_nkeys;
> 	unsigned char		tcfp_flags;
> +	u32			tcfp_off_max_hint;
> 	struct tc_pedit_key	*tcfp_keys;
> 	struct tcf_pedit_key_ex	*tcfp_keys_ex;
> };
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index e01ef7f109f4..d1221daa0952 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -149,7 +149,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
> 	struct nlattr *pattr;
> 	struct tcf_pedit *p;
> 	int ret = 0, err;
> -	int ksize;
> +	int i, ksize;
> 	u32 index;
>
> 	if (!nla) {
> @@ -228,6 +228,18 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
> 		p->tcfp_nkeys = parm->nkeys;
> 	}
> 	memcpy(p->tcfp_keys, parm->keys, ksize);
> +	p->tcfp_off_max_hint = 0;
> +	for (i = 0; i < p->tcfp_nkeys; ++i) {
> +		u32 cur = p->tcfp_keys[i].off;
> +
> +		/* The AT option can read a single byte, we can bound the actual
> +		 * value with uchar max.
> +		 */
> +		cur += (0xff & p->tcfp_keys[i].offmask) >> p->tcfp_keys[i].shift;
> +
> +		/* Each key touches 4 bytes starting from the computed offset */
> +		p->tcfp_off_max_hint = max(p->tcfp_off_max_hint, cur + 4);
> +	}
>
> 	p->tcfp_flags = parm->flags;
> 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> @@ -308,13 +320,18 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
> 			 struct tcf_result *res)
> {
> 	struct tcf_pedit *p = to_pedit(a);
> +	u32 max_offset;
> 	int i;
>
> -	if (skb_unclone(skb, GFP_ATOMIC))
> -		return p->tcf_action;
> -
> 	spin_lock(&p->tcf_lock);
>
> +	max_offset = (skb_transport_header_was_set(skb) ?
> +		      skb_transport_offset(skb) :
> +		      skb_network_offset(skb)) +
> +		     p->tcfp_off_max_hint;
> +	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> +		goto unlock;
> +
> 	tcf_lastuse_update(&p->tcf_tm);
>
> 	if (p->tcfp_nkeys > 0) {
> @@ -403,6 +420,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
> 	p->tcf_qstats.overlimits++;
> done:
> 	bstats_update(&p->tcf_bstats, skb);
> +unlock:
> 	spin_unlock(&p->tcf_lock);
> 	return p->tcf_action;
> }
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
