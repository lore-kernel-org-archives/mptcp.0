Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147197B
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 00:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650932264; x=1682468264;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bfNaIyCGxYj9/CR17FpIXoeq2UbSRoSJEaJ584UCzMw=;
  b=ElfTFztUtDDtyluZVQCVDL22aR2QmgYqo6r6rCUVNl434J7ag3giQzfP
   p+lHkZuy01sm7lwoszhyNf2ZHXaIvqKEIjzU4nBH9qG6HS3R+N71mz+mZ
   o4PdefgdO1iuDnhwl30PHlquhh+E2j4eRun7hJaX3QB3cHtcmbleRpQ1t
   8QYRK6MNVmMmwO+ZTHJhIRrqdKATYLqm9fE5B5rY5PJYjbfqs5B0RDk/2
   c5PHBBK6VF1feYAf2l88hbpBtsNCD8uhqh490X+rEiMse8SyLMHllKVKN
   RjbuPd/rB5DxFDKLrrn62PZcxZVrIHtYJ+bXpAYbnXs9EtHPs1o5Hz6at
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325888281"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="325888281"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 17:17:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="704798087"
Received: from rderber-mobl.amr.corp.intel.com ([10.212.151.176])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 17:17:43 -0700
Date: Mon, 25 Apr 2022 17:17:43 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 6/8] mptcp: add bpf_mptcp_sched_ops
In-Reply-To: <fb91639f50d18e06a1af69f48cfdd0f8b614cf77.1650613135.git.geliang.tang@suse.com>
Message-ID: <f0edb8e2-682-1152-8017-c7cfc4ce426@linux.intel.com>
References: <cover.1650613134.git.geliang.tang@suse.com> <fb91639f50d18e06a1af69f48cfdd0f8b614cf77.1650613135.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 22 Apr 2022, Geliang Tang wrote:

> This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
> Register and unregister the bpf scheduler in .reg and .unreg.
>
> This MPTCP BPF scheduler implementation is similar to BPF TCP CC. And
> net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> kernel/bpf/bpf_struct_ops_types.h |   4 +
> net/mptcp/bpf.c                   | 148 ++++++++++++++++++++++++++++++
> 2 files changed, 152 insertions(+)
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
> index 535602ba2582..6c01f6b959a3 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -10,8 +10,156 @@
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
> +static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
> +					     const struct btf *btf,
> +					     const struct btf_type *t, int off,
> +					     int size, enum bpf_access_type atype,
> +					     u32 *next_btf_id,
> +					     enum bpf_type_flag *flag)
> +{
> +	const struct btf_type *state;
> +	u32 type_id;
> +	size_t end;
> +
> +	if (atype == BPF_READ)
> +		return btf_struct_access(log, btf, t, off, size, atype,
> +					 next_btf_id, flag);
> +
> +	type_id = btf_find_by_name_kind(btf, "mptcp_sched_data", BTF_KIND_STRUCT);

This lookup should be done once and stored in a static var, in 
bpf_mptcp_sched_init() - similar to how tcp_sock_type is handled in 
bpf_tcp_ca.c. Static mptcp_sock_type can also be marked as __read_mostly.

> +	if (type_id < 0)
> +		return -EINVAL;
> +
> +	state = btf_type_by_id(btf, type_id);
> +	if (t != state) {
> +		bpf_log(log, "only access to mptcp_sched_data is supported\n");
> +		return -EACCES;
> +	}

't' is directly compared to tcp_sock_type in bpf_tcp_ca.c, will that 
simpler approach work here?

- Mat

> +
> +	switch (off) {
> +	case offsetof(struct mptcp_sched_data, sock):
> +		end = offsetofend(struct mptcp_sched_data, sock);
> +		break;
> +	case offsetof(struct mptcp_sched_data, call_again):
> +		end = offsetofend(struct mptcp_sched_data, call_again);
> +		break;
> +	default:
> +		bpf_log(log, "no write support to mptcp_sched_data at off %d\n", off);
> +		return -EACCES;
> +	}
> +
> +	if (off + size > end) {
> +		bpf_log(log, "access beyond mptcp_sched_data at off %u size %u ended at %zu",
> +			off, size, end);
> +		return -EACCES;
> +	}
> +
> +	return NOT_INIT;
> +}
> +
> +static const struct bpf_verifier_ops bpf_mptcp_sched_verifier_ops = {
> +	.get_func_proto		= bpf_mptcp_sched_get_func_proto,
> +	.is_valid_access	= bpf_tracing_btf_ctx_access,
> +	.btf_struct_access	= bpf_mptcp_sched_btf_struct_access,
> +};
> +
> +static int bpf_mptcp_sched_reg(void *kdata)
> +{
> +	return mptcp_register_scheduler(kdata);
> +}
> +
> +static void bpf_mptcp_sched_unreg(void *kdata)
> +{
> +	mptcp_unregister_scheduler(kdata);
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
> +		if (mptcp_sched_find(usched->name))
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
