Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6D7E
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 00:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650933770; x=1682469770;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/Ofo8Jug6qXg4kXWwAp2Bla06FYWjp7+WywzNt2JcIQ=;
  b=P7sTPI9UbFFavASCNHaZzj9qQDfF/KWlB7UgHy4sz4f0fO0xCeN1SSqq
   FicDjfWN+F38EYBONKSBoBPE6hQR9cikdllFREaa0QuM6kRdfjn1lbS2V
   0UYtWSYHVBW2JHkJrsc01C14MAn6BKa+cPT8/9vWByBXgpzMDHyKt4c1C
   48HLYSqVnD6lbClWpHxkTvQk61hKmb8rGhozVfofT/xXGOsk5k/KK6tJr
   FTCxyHbQIwkCU1J8VLKuIfdP6l1f+rRl96paWZLfIBYE0AeZsF89YntFM
   RTtmeD/57keXLkb7ULYdwbpwTxMW/S72C5uJL+nfbslH2wTjzqBbNsTlC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247333786"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="247333786"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 17:42:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="512888567"
Received: from rderber-mobl.amr.corp.intel.com ([10.212.151.176])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 17:42:50 -0700
Date: Mon, 25 Apr 2022 17:42:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 1/3] mptcp: add bpf get_subflows helper
In-Reply-To: <95f8ee4b211b3cfd0d372080ca81fac1eb50e415.1650613515.git.geliang.tang@suse.com>
Message-ID: <4917583c-43-bb8f-14cc-3757672bfd25@linux.intel.com>
References: <cover.1650613515.git.geliang.tang@suse.com> <95f8ee4b211b3cfd0d372080ca81fac1eb50e415.1650613515.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 22 Apr 2022, Geliang Tang wrote:

> This patch implements a new helper bpf_mptcp_get_subflows() to get all the
> subflows of the given mptcp_sock, it returns the number of suflows. Add
> a new member subflows in struct mptcp_sock as a pointers array of all the
> subflows.
>
> Register this helper in bpf_mptcp_sched_kfunc_init() to make sure it can
> be accessed from the BPF context.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/bpf.c      | 47 ++++++++++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.h |  7 +++++++
> 2 files changed, 54 insertions(+)
>
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 6c01f6b959a3..3367541b353c 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -160,6 +160,23 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
> 	.name		= "mptcp_sched_ops",
> };
>
> +BTF_SET_START(bpf_mptcp_sched_kfunc_ids)
> +BTF_ID(func, bpf_mptcp_get_subflows_array)
> +BTF_ID(func, bpf_mptcp_put_subflows_array)
> +BTF_SET_END(bpf_mptcp_sched_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
> +	.owner		= THIS_MODULE,
> +	.check_set	= &bpf_mptcp_sched_kfunc_ids,
> +};
> +
> +static int __init bpf_mptcp_sched_kfunc_init(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +					 &bpf_mptcp_sched_kfunc_set);
> +}
> +late_initcall(bpf_mptcp_sched_kfunc_init);
> +
> struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> {
> 	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
> @@ -168,3 +185,33 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> 	return NULL;
> }
> EXPORT_SYMBOL(bpf_mptcp_sock_from_subflow);
> +
> +struct mptcp_subflows_array *bpf_mptcp_get_subflows_array(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_subflows_array *array;
> +
> +	array = kzalloc(sizeof(*array), GFP_KERNEL);
> +	if (!array)
> +		return array;
> +
> +	mptcp_for_each_subflow(msk, subflow)
> +		array->subflows[array->nr++] = subflow;
> +
> +	return array;
> +}
> +EXPORT_SYMBOL(bpf_mptcp_get_subflows_array);
> +
> +void bpf_mptcp_put_subflows_array(struct mptcp_subflows_array *array)
> +{
> +	int i;
> +
> +	if (!array)
> +		return;
> +
> +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++)
> +		array->subflows[i] = NULL;
> +	array->nr = 0;
> +	kfree(array);

We can't trust the caller to always call this function, since we don't 
want to allow userspace to leak this array memory either accidentally or 
intentionally.

Can BPF code call a helper with a pointer to a struct on the BPF stack?

> +}
> +EXPORT_SYMBOL(bpf_mptcp_put_subflows_array);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 006914cb78de..c42fb54298ef 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -500,6 +500,13 @@ struct mptcp_subflow_context {
> 	struct	rcu_head rcu;
> };
>
> +#define MPTCP_SUBFLOWS_MAX	8

I noticed that this value is separately defined here and in the next 
commit (tools/testing/selftests/bpf/bpf_mptcp_helpers.h). That seems 
fragile to me, there's no way for bpf_mptcp_sched_btf_struct_access() to 
enforce access limits correctly.

Do you have some other ideas for how to share this data between kernel and 
BPF contexts? Maybe mptcp_sched_data could be expanded to pass the subflow 
list/array in to the scheduler function.

> +
> +struct mptcp_subflows_array {
> +	u8 nr;
> +	struct mptcp_subflow_context *subflows[MPTCP_SUBFLOWS_MAX];
> +};
> +
> static inline struct mptcp_subflow_context *
> mptcp_subflow_ctx(const struct sock *sk)
> {
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
