Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713BD3D69
	for <mptcp@lists.linux.dev>; Wed,  6 Apr 2022 23:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649289222; x=1680825222;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FpvguBoXWgOmFl9R0HKXMFJTZM/tLMdeycMxySkTD2s=;
  b=jO+ZL1Y0PvW6aexMR58VueFHFtUoBYkNYJgf4Z32TaHLK3YO3nt3h1oh
   FvNgFSWFpa1p4uRY4tCAJZ6/B7jYug8REU/8/srdC2cJuC+4dNwcn4pPr
   6xgv2mQu9DDVBYPsqzCXNqGAiuAeHUK+1oP4f+wsNQJHRxWkvhAS4SYSj
   wuxRUVR3M9W27qCtl43/FXJFgGvtEMB51SmpbYCpk1nMRC9uZFQYk3Xql
   8m0Vn1gYAAVKmEuCU82ln45UzIhkylB33ID3W2PUcXKRrMgDms1WEYwKz
   K87WKnCUhe0RRdU437fjx2AGQih3nPR4j4OPX1SZb37rTPQ7VJBlUrXi4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="324351854"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="324351854"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 16:53:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="652588894"
Received: from tdoan-mobl2.amr.corp.intel.com ([10.209.9.245])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 16:53:41 -0700
Date: Wed, 6 Apr 2022 16:53:41 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v9 6/8] mptcp: add bpf_mptcp_sched_ops
In-Reply-To: <20220405113727.GA4058@localhost>
Message-ID: <6752b06-a27-6887-9284-bfe6fc8f3d82@linux.intel.com>
References: <cover.1649037838.git.geliang.tang@suse.com> <31b426d5e4d7ccb318ee96f122bc1ac0421d5162.1649037838.git.geliang.tang@suse.com> <6d9a111-77a4-e693-df67-a18e873e7c21@linux.intel.com> <20220405113727.GA4058@localhost>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 5 Apr 2022, Geliang Tang wrote:

> Hi Mat,
>
> On Mon, Apr 04, 2022 at 05:29:43PM -0700, Mat Martineau wrote:
>> On Mon, 4 Apr 2022, Geliang Tang wrote:
>>
>>> This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
>>> Register and unregister the bpf scheduler in .reg and .unreg.
>>>
>>> This implementation is similar to BPF TCP CC. And some code in this patch
>>> is from bpf_tcp_ca.c
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>> kernel/bpf/bpf_struct_ops_types.h |   4 ++
>>> net/mptcp/bpf.c                   | 102 ++++++++++++++++++++++++++++++
>>> 2 files changed, 106 insertions(+)
>>>
>>> diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_types.h
>>> index 5678a9ddf817..5a6b0c0d8d3d 100644
>>> --- a/kernel/bpf/bpf_struct_ops_types.h
>>> +++ b/kernel/bpf/bpf_struct_ops_types.h
>>> @@ -8,5 +8,9 @@ BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
>>> #ifdef CONFIG_INET
>>> #include <net/tcp.h>
>>> BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
>>> +#ifdef CONFIG_MPTCP
>>> +#include <net/mptcp.h>
>>> +BPF_STRUCT_OPS_TYPE(mptcp_sched_ops)
>>> +#endif
>>> #endif
>>> #endif
>>> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
>>> index 535602ba2582..647cb174d917 100644
>>> --- a/net/mptcp/bpf.c
>>> +++ b/net/mptcp/bpf.c
>>> @@ -10,8 +10,110 @@
>>> #define pr_fmt(fmt) "MPTCP: " fmt
>>>
>>> #include <linux/bpf.h>
>>> +#include <linux/bpf_verifier.h>
>>> +#include <linux/btf.h>
>>> +#include <linux/btf_ids.h>
>>> #include "protocol.h"
>>>
>>> +extern struct bpf_struct_ops bpf_mptcp_sched_ops;
>>> +extern struct btf *btf_vmlinux;
>>> +
>>> +static u32 optional_ops[] = {
>>> +	offsetof(struct mptcp_sched_ops, init),
>>> +	offsetof(struct mptcp_sched_ops, release),
>>> +	offsetof(struct mptcp_sched_ops, get_subflow),
>>> +};
>>> +
>>> +static const struct bpf_func_proto *
>>> +bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
>>> +			       const struct bpf_prog *prog)
>>> +{
>>> +	return bpf_base_func_proto(func_id);
>>> +}
>>> +
>>> +static const struct bpf_verifier_ops bpf_mptcp_sched_verifier_ops = {
>>> +	.get_func_proto		= bpf_mptcp_sched_get_func_proto,
>>> +	.is_valid_access	= btf_ctx_access,
>>
>> Hi Geliang -
>>
>> I'm mostly comparing this code to bpf_tcp_ca.c to try to get a frame of
>> reference for how BPF works.
>>
>> Using 'btf_ctx_access' here seems like a less strict check than what the CA
>> code uses. bpf_tracing_btf_ctx_access() has more constraints like only
>> allowing READs. What's the reasoning behind the difference? I want to be
>> sure access is not more open than it needs to be.
>
> I agree, bpf_tracing_btf_ctx_access() is much better. I sent a squash-to
> patch to fix this. I want to keep the accesses more generic, not do specific,
> additional checks unless we need them in the future. So I uesd btf_ctx_access
> and btf_struct_access.
>

Ok, thanks for the squash-to patch.

>>
>>> +	.btf_struct_access	= btf_struct_access,

While I realize it's simpler to refer to the existing function, I think 
it's safer to add the BPF_READ check similar to what the BPF CA code does.

- Mat

>>
>> Similar question here - bpf_tcp_ca.c has more strict checking.
>>
>> - Mat
>>
>>> +};
>>> +
>>> +static int bpf_mptcp_sched_reg(void *kdata)
>>> +{
>>> +	return mptcp_register_scheduler(kdata);
>>> +}
>>> +
>>> +static void bpf_mptcp_sched_unreg(void *kdata)
>>> +{
>>> +	mptcp_unregister_scheduler(kdata);
>>> +}
>>> +
>>> +static int bpf_mptcp_sched_check_member(const struct btf_type *t,
>>> +					const struct btf_member *member)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>> +static bool is_optional(u32 member_offset)
>>> +{
>>> +	unsigned int i;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(optional_ops); i++) {
>>> +		if (member_offset == optional_ops[i])
>>> +			return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +static int bpf_mptcp_sched_init_member(const struct btf_type *t,
>>> +				       const struct btf_member *member,
>>> +				       void *kdata, const void *udata)
>>> +{
>>> +	const struct mptcp_sched_ops *usched;
>>> +	struct mptcp_sched_ops *sched;
>>> +	int prog_fd;
>>> +	u32 moff;
>>> +
>>> +	usched = (const struct mptcp_sched_ops *)udata;
>>> +	sched = (struct mptcp_sched_ops *)kdata;
>>> +
>>> +	moff = __btf_member_bit_offset(t, member) / 8;
>>> +	switch (moff) {
>>> +	case offsetof(struct mptcp_sched_ops, name):
>>> +		if (bpf_obj_name_cpy(sched->name, usched->name,
>>> +				     sizeof(sched->name)) <= 0)
>>> +			return -EINVAL;
>>> +		if (mptcp_sched_find(usched->name))
>>> +			return -EEXIST;
>>> +		return 1;
>>> +	}
>>> +
>>> +	if (!btf_type_resolve_func_ptr(btf_vmlinux, member->type, NULL))
>>> +		return 0;
>>> +
>>> +	/* Ensure bpf_prog is provided for compulsory func ptr */
>>> +	prog_fd = (int)(*(unsigned long *)(udata + moff));
>>> +	if (!prog_fd && !is_optional(moff))
>>> +		return -EINVAL;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int bpf_mptcp_sched_init(struct btf *btf)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>> +struct bpf_struct_ops bpf_mptcp_sched_ops = {
>>> +	.verifier_ops	= &bpf_mptcp_sched_verifier_ops,
>>> +	.reg		= bpf_mptcp_sched_reg,
>>> +	.unreg		= bpf_mptcp_sched_unreg,
>>> +	.check_member	= bpf_mptcp_sched_check_member,
>>> +	.init_member	= bpf_mptcp_sched_init_member,
>>> +	.init		= bpf_mptcp_sched_init,
>>> +	.name		= "mptcp_sched_ops",
>>> +};
>>> +
>>> struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
>>> {
>>> 	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
>>> --
>>> 2.34.1
>>>
>>>
>>>
>>
>> --
>> Mat Martineau
>> Intel
>>
>
>

--
Mat Martineau
Intel
