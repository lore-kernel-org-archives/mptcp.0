Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF00D7B
	for <mptcp@lists.linux.dev>; Sat, 30 Apr 2022 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651278624; x=1682814624;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CesGmm1ab4y3Z9/Toj4PDcuPH6TlIyCqSZvkwscR2i4=;
  b=LyKw8MRCBZV5agYbKdB+fm0Zvpbk6PFb7nYu/K3remQ1Pq9jO9Z+9ptq
   0gicz118ZdMD42VGEAj1mPaVU9m4nnC0rFoxsRPonRp0OCJzgE5SfT5Ns
   sr9sqIjdNYCXaaubyQGTjP7p3oAOTReDSu19NRmc6ozCUDkJ4kOIeyB1p
   /nOfus8c9YSNi75Lz2UOen8TcfSflUiEaOAXrqUXdsiaXB1uNbSd1Kb5p
   WB4Uy3y3762lHVD2FI/17Rxu7MbgB7kDiR0eQ/u17c6N4AYUtWmaKXUU2
   CEM3wRr8HfI7WFcAJO/Ylco/WyRfBDMNWZrUhJuOJr0wacwA7bgAHhHNO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266970137"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="266970137"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 17:30:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="685728661"
Received: from mdbellow-mobl.amr.corp.intel.com ([10.209.122.4])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 17:30:23 -0700
Date: Fri, 29 Apr 2022 17:30:23 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v9 1/3] mptcp: add subflows array in
 mptcp_sched_data
In-Reply-To: <c1e8b41ce01678189c1b5d51719df3c75ba881dd.1651243739.git.geliang.tang@suse.com>
Message-ID: <27dd2036-b1e0-95bb-19c5-6b8519a44f81@linux.intel.com>
References: <cover.1651243739.git.geliang.tang@suse.com> <c1e8b41ce01678189c1b5d51719df3c75ba881dd.1651243739.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 29 Apr 2022, Geliang Tang wrote:

> This patch adds a subflow pointers array in struct mptcp_sched_data. Set
> the array before invoking get_subflow(), then get it in get_subflow() in
> the BPF contexts.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/net/mptcp.h                             |  3 +++
> net/mptcp/protocol.h                            | 16 ++++++++++++++++
> tools/testing/selftests/bpf/bpf_mptcp_helpers.h |  3 +++
> 3 files changed, 22 insertions(+)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index bea7608d72d3..1a48e31f3ac7 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -96,10 +96,13 @@ struct mptcp_out_options {
> };
>
> #define MPTCP_SCHED_NAME_MAX	16
> +#define MPTCP_SUBFLOWS_MAX	8
>
> struct mptcp_sched_data {
> 	struct sock	*sock;
> 	bool		call_again;
> +	u8		subflows;
> +	struct mptcp_subflow_context *array[MPTCP_SUBFLOWS_MAX];
> };
>
> struct mptcp_sched_ops {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0da2a91ad197..95a65582f1e8 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -993,7 +993,9 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
>
> static inline struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> {
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sched_data data;
> +	int i = 0;
>
> 	sock_owned_by_me((struct sock *)msk);
>
> @@ -1007,14 +1009,22 @@ static inline struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> 	if (!msk->sched)
> 		return mptcp_subflow_get_send(msk);
>
> +	mptcp_for_each_subflow(msk, subflow)
> +		data.array[i++] = subflow;
> +	data.subflows = i;

As I mentioned in a previous patch, a helper function here would be good.

> 	msk->sched->get_subflow(msk, false, &data);
> +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++)
> +		data.array[i++] = NULL;
> +	data.subflows = 0;

Why zero out this data on the stack if BPF does not have write access to 
it?

- Mat

>
> 	return data.sock;
> }
>
> static inline struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
> {
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sched_data data;
> +	int i = 0;
>
> 	sock_owned_by_me((const struct sock *)msk);
>
> @@ -1025,7 +1035,13 @@ static inline struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
> 	if (!msk->sched)
> 		return mptcp_subflow_get_retrans(msk);
>
> +	mptcp_for_each_subflow(msk, subflow)
> +		data.array[i++] = subflow;
> +	data.subflows = i;
> 	msk->sched->get_subflow(msk, true, &data);
> +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++)
> +		data.array[i++] = NULL;
> +	data.subflows = 0;
>
> 	return data.sock;
> }
> diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> index ee07caf978b3..1fe3d0a97429 100644
> --- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> @@ -7,10 +7,13 @@
> #include "bpf_tcp_helpers.h"
>
> #define MPTCP_SCHED_NAME_MAX	16
> +#define MPTCP_SUBFLOWS_MAX	8
>
> struct mptcp_sched_data {
> 	struct sock	*sock;
> 	bool		call_again;
> +	__u8		subflows;
> +	struct mptcp_subflow_context *array[MPTCP_SUBFLOWS_MAX];
> };
>
> struct mptcp_sched_ops {
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
