Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C825631
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 20:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651782635; x=1683318635;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3s0uEbRnI0IaVl5zqG62Yxb0TbcESa0WiRDjjxTMMi8=;
  b=ECeZ8wAfkXX0cY3x2TXiz0dG52KHvVm3dAcxGwi1KyNi7cQ7GgeP6YxZ
   /xhdiUgkIinSSufqVMhEBn0Kwu1kbUpHcql2CLu3cu2SHbiAcLAuhOAGV
   abXh1VLsqDbwV2OU57G7DEFNes25/U1t53IwzpDvtO4FJ3Wal7YKN7beq
   TZu3nN6WsSgVy8L9S3lRaAjw8MP/AB1Mfl+WNzzuuH+UPzba3q1pBVwW7
   cQPO9q0vEbZUOFeDuMTsgzBBUOWqD+6+aNdKXmi1YiOPa5u9nGWCy04Ui
   iCixS22z0NGLAhDuxeIDZdBn/m3E0wZaP1uKrlM/TWkMjtKVqam2cIqxX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268389445"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268389445"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 13:30:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="537521945"
Received: from barreola-mobl1.amr.corp.intel.com ([10.212.167.175])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 13:30:34 -0700
Date: Thu, 5 May 2022 13:30:13 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH net] net/sched: act_pedit: really ensure the skb is
 writable
In-Reply-To: <dfcfe03e01c364599e92715828b24713d955e7c8.1651764848.git.pabeni@redhat.com>
Message-ID: <f81c6f47-3fe-1e9f-c260-31c68d32547c@linux.intel.com>
References: <dfcfe03e01c364599e92715828b24713d955e7c8.1651764848.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 5 May 2022, Paolo Abeni wrote:

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
> include/net/tc_act/tc_pedit.h |  1 +
> net/sched/act_pedit.c         | 25 +++++++++++++++++++++----
> 2 files changed, 22 insertions(+), 4 deletions(-)
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
> index e01ef7f109f4..0fc07532e6f6 100644
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
> +		return p->tcf_action;

Now that this hunk of code happens after the spinlock is acquired, that 
lock needs to be released before returning.

> +
> 	tcf_lastuse_update(&p->tcf_tm);
>
> 	if (p->tcfp_nkeys > 0) {
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
