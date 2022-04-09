Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4E36B
	for <mptcp@lists.linux.dev>; Sat,  9 Apr 2022 00:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649463163; x=1680999163;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WB7ZSmiKJ1u9ZxIiHmGIsLc0D0Bx0WwzTjYybGt3NPM=;
  b=mZ4/E8uhoTPXWPwl8kw9FMLOXY4wrBgy6wfEEqQh5DqNT4niaAMQ97uj
   8Sr3MaMMgSNlN5vqDHEBfYAK7XrVsZmGS1hELW23yM7O2SNsA5umsaBGn
   MBaXTmIw3MLtWv0bJaqO6fyhSIW29qlyCVPtADUG0l6uxZKwFq2dZvIUt
   2zONrpHFQN7UXPmHh65/am4dXaxuRcx+6FO4ai3qn9umqZDEpWYVMjvuD
   D+5BVp2/UeGy+0cZpv2gIlTSKJ9cK/jUcvWZReR8rWpvMQcBoegGoW6DJ
   jlKJMo6Oq+ptYMEw4EZltOQZK2kYLgzSXKCA/cVO4vZ5buS1aAKVGNKYJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="286726373"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="286726373"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 17:12:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="643117271"
Received: from kogunron-mobl.amr.corp.intel.com ([10.134.42.75])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 17:12:42 -0700
Date: Fri, 8 Apr 2022 17:12:42 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 2/4] mptcp: add bpf get_subflows helper
In-Reply-To: <016936c2bcc0fad9dbdb2d1372d027d99e78215a.1649432434.git.geliang.tang@suse.com>
Message-ID: <8522fc21-4eb0-3265-f218-bb9f27494863@linux.intel.com>
References: <cover.1649432434.git.geliang.tang@suse.com> <016936c2bcc0fad9dbdb2d1372d027d99e78215a.1649432434.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 8 Apr 2022, Geliang Tang wrote:

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
> net/mptcp/bpf.c      | 28 ++++++++++++++++++++++++++++
> net/mptcp/protocol.h |  3 +++
> 2 files changed, 31 insertions(+)
>
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index bd3c50b07ab2..7f8782dbfa6d 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -157,6 +157,22 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
> 	.name		= "mptcp_sched_ops",
> };
>
> +BTF_SET_START(bpf_mptcp_sched_kfunc_ids)
> +BTF_ID(func, bpf_mptcp_get_subflows)
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
> @@ -165,3 +181,15 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> 	return NULL;
> }
> EXPORT_SYMBOL(bpf_mptcp_sock_from_subflow);
> +
> +u8 bpf_mptcp_get_subflows(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	u8 nr = 0;
> +
> +	mptcp_for_each_subflow(msk, subflow)
> +		msk->subflows[nr++] = subflow;
> +
> +	return nr;
> +}
> +EXPORT_SYMBOL(bpf_mptcp_get_subflows);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a58c5c84e72b..7c5bb8fb9e77 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -238,6 +238,8 @@ struct mptcp_data_frag {
> 	struct page *page;
> };
>
> +#define MPTCP_SUBFLOWS_MAX	8
> +
> /* MPTCP connection sock */
> struct mptcp_sock {
> 	/* inet_connection_sock must be the first member */
> @@ -298,6 +300,7 @@ struct mptcp_sock {
>
> 	u32 setsockopt_seq;
> 	char		ca_name[TCP_CA_NAME_MAX];
> +	struct mptcp_subflow_context *subflows[MPTCP_SUBFLOWS_MAX];

This storage shouldn't be added to struct mptcp_sock, when the values are 
only locally useful in a BPF hook. Besides the extra memory usage, the 
pointers will get stale and possibly point to invalid locations after 
subflows are closed. Can't the helper write to some temporary storage 
instead?

> };
>
> #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
