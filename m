Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F11FCC
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 00:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650588957; x=1682124957;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4SVRJdyFWrK3t0Z0rh1xj0R5SMH1sRvLOc2/cZhoulo=;
  b=NMMrcOsBZyj3uRMuZrF6OEIxM/lQjrHXjIoeAY2tFhOOnZIuYsrHvxNh
   hNiq3J/aYD4FY2Si5MMLwgF0WLSjcyPfXvfY6g6KMrghE7PXcgheV+24w
   9JVe1PGdWde9Zv+zxC3vXA3PxvGhRkLIqeVR2cjKE7NoRKv3t+kuPiQFP
   ZSoS7YwwZGKOuTg6dgmHxabOdDIvn8vuveWiGnriqqcXOFTy8Fuq0o1+5
   4hdTbjbOyPmXgm869jC4v13WdrVGH5nB35WFCRDRtBzKbVXVV8NlJN+PG
   6CnJbcfjOvufkHXBzBdlSq6Vp6ZZmaTIGp2gPmZSLsRVQHHELngII5/L1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289645774"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="289645774"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 17:55:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="658771939"
Received: from dolaleye-mobl.amr.corp.intel.com ([10.209.117.155])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 17:55:57 -0700
Date: Thu, 21 Apr 2022 17:55:57 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v13 7/9] mptcp: add call_me_again flag
In-Reply-To: <11f597e62ca79b4c5c1d6256b5eb5233c1bdfba1.1650521788.git.geliang.tang@suse.com>
Message-ID: <6c212541-6d3a-99b6-a15c-ab8dbd3f74ff@linux.intel.com>
References: <cover.1650521788.git.geliang.tang@suse.com> <11f597e62ca79b4c5c1d6256b5eb5233c1bdfba1.1650521788.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 21 Apr 2022, Geliang Tang wrote:

> For supporting a "redundant" packet scheduler in the future, this patch
> adds a flag of struct mptcp_sock named call_me_again to indicate that
> get_subflow() function needs to be called again.
>
> Export it in bpf_mptcp_helpers.h, and add BPF write access to it.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/bpf.c                                 | 16 ++++++++++++++++
> net/mptcp/protocol.h                            |  1 +
> net/mptcp/sched.c                               |  1 +
> tools/testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
> 4 files changed, 19 insertions(+)
>
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index e849fc3fb6c5..1611dbe63eb2 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -40,6 +40,7 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
> {
> 	const struct btf_type *state;
> 	u32 type_id;
> +	size_t end;
>
> 	if (atype == BPF_READ)
> 		return btf_struct_access(log, btf, t, off, size, atype,
> @@ -55,6 +56,21 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
> 		return -EACCES;
> 	}
>
> +	switch (off) {
> +	case offsetofend(struct mptcp_sock, sched):
> +		end = offsetofend(struct mptcp_sock, sched) + sizeof(u8);
> +		break;
> +	default:
> +		bpf_log(log, "no write support to mptcp_sock at off %d\n", off);
> +		return -EACCES;
> +	}
> +
> +	if (off + size > end) {
> +		bpf_log(log, "access beyond mptcp_sock at off %u size %u ended at %zu",
> +			off, size, end);
> +		return -EACCES;
> +	}
> +
> 	return NOT_INIT;
> }
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f31bc3271bcc..13c6ad5fbade 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -299,6 +299,7 @@ struct mptcp_sock {
> 	struct sock	*first;
> 	struct mptcp_pm_data	pm;
> 	struct mptcp_sched_ops	*sched;
> +	u8		call_me_again:1;

This should be part of the get_subflow function call in mptcp_sched_ops, 
not part of the socket state. We need some BPF-compatible way to return 
both a subflow pointer and a boolean from the call to the scheduler.

Seems like it should work to add a new struct like this:

struct mptcp_sched_data {
 	struct sock *sock;
 	bool call_again;
};

void (*get_subflow)(struct mptcp_sock *msk, bool reinject, struct mptcp_sched_data *data);


and then modify bpf_mptcp_sched_btf_struct_access() to allow writing 
values? What do you think?


The other part we need to figure out is how to update the transmit code to 
send the same data across multiple subflows with this call_again flag is 
used. I'm not yet sure what to recommend for that yet.

- Mat

> 	struct {
> 		u32	space;	/* bytes copied in last measurement window */
> 		u32	copied; /* bytes copied in this measurement window */
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 8025dc51fbe9..05ab45505f88 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -83,6 +83,7 @@ int mptcp_init_sched(struct mptcp_sock *msk,
> 	msk->sched = sched_init;
> 	if (msk->sched->init)
> 		msk->sched->init(msk);
> +	msk->call_me_again = 0;
>
> 	pr_debug("sched=%s", msk->sched->name);
>
> diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> index 81a9c5d91aae..dacee63455f5 100644
> --- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> @@ -24,6 +24,7 @@ struct mptcp_sock {
> 	__u32		token;
> 	struct sock	*first;
> 	struct mptcp_sched_ops *sched;
> +	__u8		call_me_again:1;
> 	char		ca_name[TCP_CA_NAME_MAX];
> } __attribute__((preserve_access_index));
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
