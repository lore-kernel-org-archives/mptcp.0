Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6633C1
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 23:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651017516; x=1682553516;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yTZhxkBY+rsOapioJyiEZG/DurdqnC1jTTUKlclH9jY=;
  b=k+7KyvGlw0rPM9K6X45jwpAGpqFKWuglwHSQEraIzvdyffiRE5lE0cyT
   ABiOm8l33llhDCEO2lP5/ve2woAov1Ai/0Y6SbeP9mXA0kSeqZah32EM6
   xtI7rrMTfsUHIrut0/3hy5s8uiRZChi6meDgOowfAHpnjBBNiD4/piTP6
   AHeaeCkJqumnw1hmFPPW7+3yHPv8daNG44MobJ0m5nzoKsXxTPnSKxmXQ
   Fu3nePZJfxaIerorXpqhXkRuDh4faaduXqGu0V9t7ZF3HNTwiNZJZZoFB
   SowCX0eGsNSdxQNo+p56y1xBh7yhE3p318zwhigdO07FzQU/iAK85dlsU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265567834"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="265567834"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:58:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="705288862"
Received: from brpivitt-mobl1.amr.corp.intel.com ([10.252.136.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:58:35 -0700
Date: Tue, 26 Apr 2022 16:58:35 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v15 6/8] mptcp: add bpf_mptcp_sched_ops
In-Reply-To: <475b55fee1b3010c4f91682de154c408e65028e5.1650981078.git.geliang.tang@suse.com>
Message-ID: <1a85a8a3-7e4c-cc1e-b3a0-9a557a4010db@linux.intel.com>
References: <cover.1650981078.git.geliang.tang@suse.com> <475b55fee1b3010c4f91682de154c408e65028e5.1650981078.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 26 Apr 2022, Geliang Tang wrote:

> This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
> Register and unregister the bpf scheduler in .reg and .unreg.
>
> This MPTCP BPF scheduler implementation is similar to BPF TCP CC. And
> net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/net/mptcp.h               |   2 +-
> kernel/bpf/bpf_struct_ops_types.h |   4 +
> net/mptcp/Makefile                |   2 +
> net/mptcp/bpf.c                   | 149 ++++++++++++++++++++++++++++++
> 4 files changed, 156 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index dd4ee7a77567..4d777db0a3de 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -303,7 +303,7 @@ static inline int mptcpv6_init(void) { return 0; }
> static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
> #endif
>
> -#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
> +#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
> struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
> #else
> static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk) { return NULL; }
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
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index 8a7f68efa35f..702b86e8ecb0 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -11,4 +11,6 @@ mptcp_crypto_test-objs := crypto_test.o
> mptcp_token_test-objs := token_test.o
> obj-$(CONFIG_MPTCP_KUNIT_TEST) += mptcp_crypto_test.o mptcp_token_test.o
>
> +ifeq ($(CONFIG_BPF_JIT),y)

bpf.c is still needed because bpf_mptcp_sock_from_subflow() should be 
compiled with or without CONFIG_BPF_JIT.

Would be better to either split all the BPF scheduler code to a second 
file (bpf_sched.c?), or put a big #ifdef CONFIG_BPF_JIT block around the 
scheduler code inside bpf.c (similar to how CONFIG_BPF_SYSCALL is handled 
in tcp_bpf.c).

- Mat

> obj-$(CONFIG_BPF_SYSCALL) += bpf.o
> +endif
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 535602ba2582..dff1ab26a608 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -10,8 +10,157 @@
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
> +static const struct btf_type *mptcp_sched_type __read_mostly;
> +static u32 mptcp_sched_id;
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
> +	size_t end;
> +
> +	if (atype == BPF_READ)
> +		return btf_struct_access(log, btf, t, off, size, atype,
> +					 next_btf_id, flag);
> +
> +	if (t != mptcp_sched_type) {
> +		bpf_log(log, "only access to mptcp_sched_data is supported\n");
> +		return -EACCES;
> +	}
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
> +	mptcp_sched_id = btf_find_by_name_kind(btf, "mptcp_sched_data",
> +					       BTF_KIND_STRUCT);
> +	if (mptcp_sched_id < 0)
> +		return -EINVAL;
> +	mptcp_sched_type = btf_type_by_id(btf, mptcp_sched_id);
> +
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
