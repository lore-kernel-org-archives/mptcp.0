Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDDC7E
	for <mptcp@lists.linux.dev>; Sat, 26 Mar 2022 00:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648254128; x=1679790128;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HXDa7dWau+ngCMCpK3mLtq2DwIk52SRpDoFYgxdkuak=;
  b=bUTvxIC4WnBU7AmQVZvBudg+e5Rf8mLne4EZL2kIoBI9txAcuzQ686tS
   XtGfBnVd3ANhUpxTHDh5NqlQP0D8ApfgIsZuNCq+z5xnp5dXHa1bWZXYq
   JImmDig4yYdgn1NSTD0wl6TOigHrA6/LVZfEo4jdBMVH6nVae3PrbXP3M
   vM6TCjUK1v+OgYxGkEZX19J/EGEmYTO8bqKUalStmj9zjqu+d30B9Gd1g
   LNMqHRjuIYgeOGh4Qpj93lIySp1N01bXbxtfatywwwIveM7vHDRfKMKb9
   weB6QKyhiXPyK+IETaa7aU450GMH+SRQNuVJg/9VwydTOp31IUpQTTuZ+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="258930956"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="258930956"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:22:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="545278742"
Received: from ivbeskor-mobl1.amr.corp.intel.com ([10.209.23.71])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:22:07 -0700
Date: Fri, 25 Mar 2022 17:22:07 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 6/8] mptcp: add bpf_mptcp_sched_ops
In-Reply-To: <531f998e3069db7f5a21ba9e3a888ad5f1024253.1648223504.git.geliang.tang@suse.com>
Message-ID: <21ef9551-b664-c69e-4448-17cc54ad89e@linux.intel.com>
References: <cover.1648223504.git.geliang.tang@suse.com> <531f998e3069db7f5a21ba9e3a888ad5f1024253.1648223504.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 26 Mar 2022, Geliang Tang wrote:

> This patch implemented a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
> Register and unregister the mptcp scheduler in .reg and .unreg.
>

I think there is some reference counting code missing. The TCP BPF CA code 
uses bpf_try_module_get() and bpf_module_put() to manage that. I think 
this ties in with my reference counting comment on patch 4 too.

- Mat


> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> kernel/bpf/bpf_struct_ops_types.h |   4 ++
> net/mptcp/bpf.c                   | 103 ++++++++++++++++++++++++++++++
> 2 files changed, 107 insertions(+)
>
> diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_types.h
> index 5678a9ddf817..5a6b0c0d8d3d 100644
> --- a/kernel/bpf/bpf_struct_ops_types.h
> +++ b/kernel/bpf/bpf_struct_ops_types.h
> @@ -8,5 +8,9 @@ BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
> #ifdef CONFIG_INET
> #include <net/tcp.h>
> BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
> +#ifdef CONFIG_MPTCP
> +#include <net/mptcp.h>
> +BPF_STRUCT_OPS_TYPE(mptcp_sched_ops)
> +#endif
> #endif
> #endif
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 535602ba2582..be809438c5d2 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -10,8 +10,111 @@
> #define pr_fmt(fmt) "MPTCP: " fmt
>
> #include <linux/bpf.h>
> +#include <linux/bpf_verifier.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> #include "protocol.h"
>
> +extern struct bpf_struct_ops bpf_mptcp_sched_ops;
> +extern struct btf *btf_vmlinux;
> +
> +static u32 optional_ops[] = {
> +	offsetof(struct mptcp_sched_ops, init),
> +	offsetof(struct mptcp_sched_ops, release),
> +	offsetof(struct mptcp_sched_ops, get_subflow),
> +};
> +
> +static const struct bpf_func_proto *
> +bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
> +			       const struct bpf_prog *prog)
> +{
> +	return bpf_base_func_proto(func_id);
> +}
> +
> +static const struct bpf_verifier_ops bpf_mptcp_sched_verifier_ops = {
> +	.get_func_proto		= bpf_mptcp_sched_get_func_proto,
> +	.is_valid_access	= btf_ctx_access,
> +	.btf_struct_access	= btf_struct_access,
> +};
> +
> +static int bpf_mptcp_sched_reg(void *kdata)
> +{
> +	return mptcp_register_scheduler(current->nsproxy->net_ns, kdata);
> +}
> +
> +static void bpf_mptcp_sched_unreg(void *kdata)
> +{
> +	mptcp_unregister_scheduler(current->nsproxy->net_ns, kdata);
> +}
> +
> +static int bpf_mptcp_sched_check_member(const struct btf_type *t,
> +					const struct btf_member *member)
> +{
> +	return 0;
> +}
> +
> +static bool is_optional(u32 member_offset)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(optional_ops); i++) {
> +		if (member_offset == optional_ops[i])
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int bpf_mptcp_sched_init_member(const struct btf_type *t,
> +				       const struct btf_member *member,
> +				       void *kdata, const void *udata)
> +{
> +	const struct mptcp_sched_ops *usched;
> +	struct mptcp_sched_ops *sched;
> +	int prog_fd;
> +	u32 moff;
> +
> +	usched = (const struct mptcp_sched_ops *)udata;
> +	sched = (struct mptcp_sched_ops *)kdata;
> +
> +	moff = __btf_member_bit_offset(t, member) / 8;
> +	switch (moff) {
> +	case offsetof(struct mptcp_sched_ops, name):
> +		if (bpf_obj_name_cpy(sched->name, usched->name,
> +				     sizeof(sched->name)) <= 0)
> +			return -EINVAL;
> +		if (mptcp_sched_find(current->nsproxy->net_ns,
> +				     usched->name))
> +			return -EEXIST;
> +		return 1;
> +	}
> +
> +	if (!btf_type_resolve_func_ptr(btf_vmlinux, member->type, NULL))
> +		return 0;
> +
> +	/* Ensure bpf_prog is provided for compulsory func ptr */
> +	prog_fd = (int)(*(unsigned long *)(udata + moff));
> +	if (!prog_fd && !is_optional(moff))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int bpf_mptcp_sched_init(struct btf *btf)
> +{
> +	return 0;
> +}
> +
> +struct bpf_struct_ops bpf_mptcp_sched_ops = {
> +	.verifier_ops	= &bpf_mptcp_sched_verifier_ops,
> +	.reg		= bpf_mptcp_sched_reg,
> +	.unreg		= bpf_mptcp_sched_unreg,
> +	.check_member	= bpf_mptcp_sched_check_member,
> +	.init_member	= bpf_mptcp_sched_init_member,
> +	.init		= bpf_mptcp_sched_init,
> +	.name		= "mptcp_sched_ops",
> +};
> +
> struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> {
> 	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
