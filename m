Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C01840
	for <mptcp@lists.linux.dev>; Sat, 30 Apr 2022 00:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651278156; x=1682814156;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=n5ss326xpl9KfIpHxkn5aNMNCu4Aq/AoZ3x10bMGz7o=;
  b=NvOibO2Gt1nAbz/YD6GF6qKSA7Dzsng2vpYBowI92mobFykWmMPenLd6
   ymHIaDV+RVt3I3wDfJOgPg0R0ZRU98/I6I8zylbsfPjL7fKF5PLJHC81/
   vMVw2n6zCfqYjIPjaACePQ+ilpgJkQ3YT6L0renw4hi8uR9/oCHHbqC4u
   ewM3PgdgcXjwrS5WQuoMsDhh48xbkc7CKG/tzo/USZvHNNOkioWw8uB37
   oIqWt0BwmFd1d1JcoHdtE7eQ6ADJk5FYP2JCTIl59rv5/L44KxyU+kef7
   oq6Y6kt2r2NRC8dmFZlapN6iL80dxb2Ts+e4s35Nb+DG3gQPwqfwLZjRc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="264391153"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="264391153"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 17:22:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="685717457"
Received: from mdbellow-mobl.amr.corp.intel.com ([10.209.122.4])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 17:22:33 -0700
Date: Fri, 29 Apr 2022 17:22:33 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v17 6/8] mptcp: add last_snd write access
In-Reply-To: <60a9490aa49e64c1db357ad2096d321d7c54713a.1651123078.git.geliang.tang@suse.com>
Message-ID: <b954e32b-f0e3-4725-b755-66e5831adcee@linux.intel.com>
References: <cover.1651123078.git.geliang.tang@suse.com> <60a9490aa49e64c1db357ad2096d321d7c54713a.1651123078.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 28 Apr 2022, Geliang Tang wrote:

> This patch exports the member last_snd of struct mptcp_sock in
> bpf_mptcp_helpers.h, and adds BPF write access to it.
>

I still think we should stay away from giving the BPF functions write 
access to the msk unless it's really necessary.

In this case, both of the example schedulers write identical values to 
msk->last_snd and data->sock. Will they ever be different? Seems better to 
keep it simple for the BPF code and have the get_subflow wrappers handle 
assigning to msk->last_snd if a BPF function was called, and let the 
built-in scheduler assign last_snd itself.

- Mat

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/bpf.c                                 | 15 ++++++++++++---
> tools/testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
> 2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index a085c72fe695..300493f9a2b6 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -18,8 +18,8 @@
> #ifdef CONFIG_BPF_JIT
> extern struct bpf_struct_ops bpf_mptcp_sched_ops;
> extern struct btf *btf_vmlinux;
> -static const struct btf_type *mptcp_sched_type __read_mostly;
> -static u32 mptcp_sched_id;
> +static const struct btf_type *mptcp_sock_type, *mptcp_sched_type __read_mostly;
> +static u32 mptcp_sock_id, mptcp_sched_id;
>
> static u32 optional_ops[] = {
> 	offsetof(struct mptcp_sched_ops, init),
> @@ -47,12 +47,15 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
> 		return btf_struct_access(log, btf, t, off, size, atype,
> 					 next_btf_id, flag);
>
> -	if (t != mptcp_sched_type) {
> +	if (t != mptcp_sock_type && t != mptcp_sched_type) {
> 		bpf_log(log, "only access to mptcp_sched is supported\n");
> 		return -EACCES;
> 	}
>
> 	switch (off) {
> +	case offsetof(struct mptcp_sock, last_snd):
> +		end = offsetofend(struct mptcp_sock, last_snd);
> +		break;
> 	case offsetof(struct mptcp_sched_data, sock):
> 		end = offsetofend(struct mptcp_sched_data, sock);
> 		break;
> @@ -145,6 +148,12 @@ static int bpf_mptcp_sched_init(struct btf *btf)
> {
> 	s32 type_id;
>
> +	type_id = btf_find_by_name_kind(btf, "mptcp_sock", BTF_KIND_STRUCT);
> +	if (type_id < 0)
> +		return -EINVAL;
> +	mptcp_sock_id = type_id;
> +	mptcp_sock_type = btf_type_by_id(btf, mptcp_sock_id);
> +
> 	type_id = btf_find_by_name_kind(btf, "mptcp_sched_data",
> 					BTF_KIND_STRUCT);
> 	if (type_id < 0)
> diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> index a0b83fbe8133..79a16636400b 100644
> --- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> @@ -27,6 +27,7 @@ struct mptcp_sched_ops {
> struct mptcp_sock {
> 	struct inet_connection_sock	sk;
>
> +	struct sock	*last_snd;
> 	__u32		token;
> 	struct sock	*first;
> 	struct mptcp_sched_ops *sched;
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
