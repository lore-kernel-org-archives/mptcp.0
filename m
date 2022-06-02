Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB75363
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 00:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654129393; x=1685665393;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e9Vgsqp6Sqh5Ov2Hv1DdwrLLoMvUafyqNttXPbJ7Klc=;
  b=IQsW8WpizlJXGFMF9hOZUboo2s/fjIoPq4deyezUXhjSCmnXlFgvsefn
   hMkOmHRDAllFsQe7IYEs5bvJ/4Eoud9BX47umfJNsmxfVw80UnVE+9VzD
   obgvofpM2U0sPjqUXf1Zy6im+R+S2nnZ73b8l4SpjIaJ4SBge3gfZk8cX
   pWD5w5nw3WgWSFIIyOtEwyjB+0ekolIn6NWo3gitEbxkRWq5Kw6FF2AaW
   gS2tN2I3FN4NRufCLVDNHfw+IM7BHZ+1e/yziWZ6ML9ZmngD3HbsVSJcQ
   APD87RcRhoS5U99zcOsp3QFVbP2de422hdk70FedTZGduVm1TgSCfG+BO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="338819891"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="338819891"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 17:23:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="606550864"
Received: from hli80-mobl.amr.corp.intel.com ([10.212.232.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 17:23:10 -0700
Date: Wed, 1 Jun 2022 17:23:10 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 05/11] mptcp: add subflow_set_scheduled
 helper
In-Reply-To: <b459c84aa68ea021299b89e2c4bcad208736ce48.1654092153.git.geliang.tang@suse.com>
Message-ID: <3468a375-3122-ad91-9955-78236a3be365@linux.intel.com>
References: <cover.1654092153.git.geliang.tang@suse.com> <b459c84aa68ea021299b89e2c4bcad208736ce48.1654092153.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 1 Jun 2022, Geliang Tang wrote:

> This patch adds a new helper mptcp_subflow_set_scheduled() to set the
> scheduled flag of struct mptcp_subflow_context using WRITE_ONCE().
> Register this helper in bpf_mptcp_sched_kfunc_init() to make sure it can
> be accessed from the BPF context.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/bpf.c                               | 16 ++++++++++++++++
> net/mptcp/protocol.h                          |  2 ++
> net/mptcp/sched.c                             |  7 +++++++
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 +++

Geliang -

This commit changes both bpf_tcp_helpers.h and MPTCP core code. There are 
different upstreaming requirements for bpf_tcp_helpers.h since the BPF 
maintainers own that file.

Could you split the changes to bpf_tcp_helpers.h in this commit, and in 
the others already in the export branch, in to a separate "MPTCP BPF 
helper" commit before "selftests/bpf: add bpf_first scheduler"? I think 
that will make it easier to upstream commits that don't need to go through 
the BPF maintainers.


> 4 files changed, 28 insertions(+)
>
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 0529e70d53b1..e86dff4272d5 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -161,6 +161,22 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
> 	.init		= bpf_mptcp_sched_init,
> 	.name		= "mptcp_sched_ops",
> };
> +
> +BTF_SET_START(bpf_mptcp_sched_kfunc_ids)
> +BTF_ID(func, mptcp_subflow_set_scheduled)
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
> #endif /* CONFIG_BPF_JIT */
>
> struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 48c5261b7b15..d406b5afbee4 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -629,6 +629,8 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
> int mptcp_init_sched(struct mptcp_sock *msk,
> 		     struct mptcp_sched_ops *sched);
> void mptcp_release_sched(struct mptcp_sock *msk);
> +void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
> +				 bool scheduled);
> struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
> struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
> struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 6815654fc6f4..8858e1fc8b74 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -88,6 +88,12 @@ void mptcp_release_sched(struct mptcp_sock *msk)
> 	bpf_module_put(sched, sched->owner);
> }
>
> +void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
> +				 bool scheduled)
> +{
> +	WRITE_ONCE(subflow->scheduled, scheduled);
> +}

As far as I can tell, it is safe to call a function like this from BPF 
code. I modified the bpf_first test to try to pass a bad subflow pointer 
in a few different ways, and the BPF verifier caught it.

I'm curious, have you found any documentation for how the verifier checks 
args for kfunc calls? I'd like to understand that better and will keep 
searching.

Thanks,

Mat

> +
> static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
> 				 struct mptcp_sched_data *data)
> {
> @@ -101,6 +107,7 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
> 			pr_warn_once("too many subflows");
> 			break;
> 		}
> +		mptcp_subflow_set_scheduled(subflow, false);
> 		data->contexts[i++] = subflow;
> 	}
>
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index 5f6a7fa2269b..5e301e830a0a 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -261,4 +261,7 @@ struct mptcp_sock {
> 	char		ca_name[TCP_CA_NAME_MAX];
> } __attribute__((preserve_access_index));
>
> +extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
> +					bool scheduled) __ksym;
> +
> #endif
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
