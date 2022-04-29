Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C81869
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 20:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651265762; x=1682801762;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=A8bFyREG+zJhvbarid0vK5FxHYzSPGrmBghjq5QrW10=;
  b=XgPd7Tbs3CR6DGDPWOvliPSojAwudLTMUeAO5cAnBoKAdpBgYrCQvtX5
   2TKwUnbY8ihRKkLK3148MNqUqecPyYmpXNGn2NBD3SY+T6c5mgG1ZIArZ
   znSyIxuNX7Rc3TNTB06KeKPqKA5E+BA4UI8Sf6v2H8PPHbv5JliJEeabe
   QMrrYp17GVr5g278zpBt7EjzAfX6bn5yWQSuz1h2L7oyL7rTetf0aaQNv
   wFXFrRQp7MWCviRW5p8Tt74lgcgz6PWHh1RjxoCNPHmc4yHDUkEhM5Nro
   X0scXIPXeeyPTBFQ2ze6cqkmH7gAIC7bUK+D7csiKLGZ4alLIIqPEk/D/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="291943654"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="291943654"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 13:56:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="732270210"
Received: from mdbellow-mobl.amr.corp.intel.com ([10.209.122.4])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 13:56:01 -0700
Date: Fri, 29 Apr 2022 13:56:01 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2] net/sched: act_pedit: really ensure the
 skb is writable
In-Reply-To: <26445210b10b18b39129c4ede9d7fde0e37fe21f.1651253087.git.pabeni@redhat.com>
Message-ID: <7c93496c-5153-5b83-48a9-6dd75da42542@linux.intel.com>
References: <26445210b10b18b39129c4ede9d7fde0e37fe21f.1651253087.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 29 Apr 2022, Paolo Abeni wrote:

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
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - fix build issue
> - account for the skb hdr offset, too
>
> this almost solves issues/265 here. I'm still getting some rare
> failure with MPTcpExtMPFailTx==0: sometimes the transfer completes
> before we are able to use the 2nd/failing link. The relevant fix
> is a purely seft-test one
>
> Note that a much simpler alternatives would be simply replacing
> skb_unshare() with skb_ensure_writable(skb, skb->len), but that
> really could causes more visible regressions

To make sure I'm understanding correctly: skb_ensure_writable(skb, 
skb->len) would copy the entire packet payload on every edited 
packet, but this patch will only copy the part that might be modified (and 
maybe a little extra). Seems like the full copy is worth avoiding, and 
that users shouldn't be depending on pedit modifying shared data.

I did run the associated test for a while (with the other patches for 
#265) and the changes look good from a MPTCP perspective:

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Do you plan to upstream this one yourself, or should I include it with the 
other mptcp-net patches?


Thanks,
Mat

> ---
> include/net/tc_act/tc_pedit.h |  1 +
> net/sched/act_pedit.c         | 23 +++++++++++++++++++++--
> 2 files changed, 22 insertions(+), 2 deletions(-)
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
> index e01ef7f109f4..301ad7f19da9 100644
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
> @@ -228,6 +228,20 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
> 		p->tcfp_nkeys = parm->nkeys;
> 	}
> 	memcpy(p->tcfp_keys, parm->keys, ksize);
> +	p->tcfp_off_max_hint = 0;
> +	for (i = 0; i < p->tcfp_nkeys; ++i) {
> +		u32 cur = p->tcfp_keys[i].off;
> +
> +		/* The AT option can read a single byte, we can bound the actual
> +		 * value with uchar max. Each key touches 4 bytes starting from
> +		 * the computed offset
> +		 */
> +		if (p->tcfp_keys[i].offmask) {
> +			cur += 255 >> p->tcfp_keys[i].shift;
> +			cur = max(p->tcfp_keys[i].at, cur);
> +		}
> +		p->tcfp_off_max_hint = max(p->tcfp_off_max_hint, cur + 4);
> +	}
>
> 	p->tcfp_flags = parm->flags;
> 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> @@ -308,9 +322,14 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
> 			 struct tcf_result *res)
> {
> 	struct tcf_pedit *p = to_pedit(a);
> +	u32 max_offset;
> 	int i;
>
> -	if (skb_unclone(skb, GFP_ATOMIC))
> +	max_offset = (skb_transport_header_was_set(skb) ?
> +		      skb_transport_offset(skb) :
> +		      skb_network_offset(skb)) +
> +		     p->tcfp_off_max_hint;
> +	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> 		return p->tcf_action;
>
> 	spin_lock(&p->tcf_lock);
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
