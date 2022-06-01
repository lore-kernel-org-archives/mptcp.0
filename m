Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415E7E
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 00:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654043944; x=1685579944;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I/FjY0rAnqKIJCKAVSwyvpwuDGOtThVdLsvm352JFZw=;
  b=if0Mm2ZG5wjwUPQ37nn6ee5sMIOoZ7PSJjmzJOx0bNgcDI5UQnGZ3dJ0
   53gAL0ixo9FJ+dzOHqwebU8tkt/fmB0FQTUvlplus1XmbUl4OPDzHWCke
   Sv33JBfO/ubG4tsB5mYabL7TGQm75BpERWQnPcyb2sWlDXOox7Ssqe4e0
   xsyuRCaXbjToM/LmgqcFM1n4LmonufW8ZOuGrji97Zxe3UIvv2XCyYnGD
   gDFNp2EQ4RNpjEXnLu2TL48yX+vcRkACjkOhxYF81QZg7M2KL6/hbHWbk
   J4BpG3LbA0Ub6+Oq6A9OpOZrC5OS5/iptEl+tEj18Kuk2OGn/NW28gzhc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275508812"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="275508812"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 17:39:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="904216366"
Received: from sbeaupre-mobl1.amr.corp.intel.com ([10.209.105.200])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 17:39:03 -0700
Date: Tue, 31 May 2022 17:38:56 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 01/10] Squash to "mptcp: add struct
 mptcp_sched_ops"
In-Reply-To: <fc0419737e68303ab2f9da821b740f5069d1da7e.1653987929.git.geliang.tang@suse.com>
Message-ID: <8e7fff78-1f64-2757-c6c-a7ce826cef5a@linux.intel.com>
References: <cover.1653987929.git.geliang.tang@suse.com> <fc0419737e68303ab2f9da821b740f5069d1da7e.1653987929.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 31 May 2022, Geliang Tang wrote:

> Use bitmap instead of sock in struct mptcp_sched_data.
>
> Please update the commit log:
>
> '''
> This patch defines struct mptcp_sched_ops, which has three struct members,
> name, owner and list, and three function pointers, init, release and
> get_subflow.
>
> Add the scheduler registering, unregistering and finding functions to add,
> delete and find a packet scheduler on the global list mptcp_sched_list.
>
> The BPF scheduler function get_subflow() has a struct mptcp_sched_data
> parameter, which contains a mptcp_subflow_context array. Add a new member
> scheduled for mptcp_subflow_context, which will be set in the MPTCP
> scheduler context when the scheduler picks this subflow to send data.
> '''
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/net/mptcp.h                           |  7 ++++---
> net/mptcp/protocol.h                          |  1 +
> tools/testing/selftests/bpf/bpf_tcp_helpers.h | 11 ++++++++---
> 3 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 6456ea26e4c7..7af7fd48acc7 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -97,14 +97,15 @@ struct mptcp_out_options {
> };
>
> #define MPTCP_SCHED_NAME_MAX	16
> +#define MPTCP_SUBFLOWS_MAX	8
>
> struct mptcp_sched_data {
> -	struct sock	*sock;
> -	bool		call_again;
> +	bool	reinject;
> +	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];

Ok - the BPF verifier is able to handle this array? That's good news.

> };
>
> struct mptcp_sched_ops {
> -	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
> +	void (*get_subflow)(const struct mptcp_sock *msk,
> 			    struct mptcp_sched_data *data);
>
> 	char			name[MPTCP_SCHED_NAME_MAX];
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8739794166d8..48c5261b7b15 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -469,6 +469,7 @@ struct mptcp_subflow_context {
> 		valid_csum_seen : 1;        /* at least one csum validated */
> 	enum mptcp_data_avail data_avail;
> 	bool	mp_fail_response_expect;
> +	bool	scheduled;
> 	u32	remote_nonce;
> 	u64	thmac;
> 	u32	local_nonce;
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index aca4e3c6ac48..a705054f38c5 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -231,10 +231,15 @@ extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
> extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
>
> #define MPTCP_SCHED_NAME_MAX	16
> +#define MPTCP_SUBFLOWS_MAX	8
> +
> +struct mptcp_subflow_context {
> +	bool	scheduled;
> +} __attribute__((preserve_access_index));

Ah, is this the array "magic"?

>
> struct mptcp_sched_data {
> -	struct sock	*sock;
> -	bool		call_again;
> +	bool	reinject;
> +	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
> };
>
> struct mptcp_sched_ops {
> @@ -243,7 +248,7 @@ struct mptcp_sched_ops {
> 	void (*init)(const struct mptcp_sock *msk);
> 	void (*release)(const struct mptcp_sock *msk);
>
> -	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
> +	void (*get_subflow)(const struct mptcp_sock *msk,
> 			    struct mptcp_sched_data *data);
> 	void *owner;
> };
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
