Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1100E7C
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 01:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77593C433C7;
	Fri, 28 Jul 2023 01:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690507841;
	bh=0ydvTJVtNBDvV2u0D7rs29phTDoGUEhUv7lMCnVwRAI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=FQWaQhjYy7Dujn5zXXxLR5chQ5/RARcScPRXY5H2zblw8buQ6laN3eUA99d/B4df8
	 HOooWMpZw4fAvs+G3o0mA4tJR7DUzJD8li2bRQsC1lWlobwaMDnOAQ3SGtv8/JZ2cr
	 FR8kvrhz+oUNQPpc2ROavbTGd1FDg9zF84TyMamye3SWTSBat/qhE3T6GMp8cqwYDM
	 hk23aRmUg108t7Q61rOGzQJAJBZt5Wqb9RE+R1f9/AnknisDpofE96r/JUHl5XBZtl
	 LHVQtb42tWwlrhtsDRzxL2ZfYVfbQOMYH4P4cZ03bY8S50b0TSvrnh9EkEmBYzg+eN
	 8na5U3g1vCAGA==
Date: Thu, 27 Jul 2023 18:30:40 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 08/13] mptcp: add subflow_set_stale
 helper
In-Reply-To: <94b445b3225d4f91e2d05cab0338c4367ecbabb4.1689650435.git.geliang.tang@suse.com>
Message-ID: <f678a249-e191-05ca-012f-28811c520b51@kernel.org>
References: <cover.1689650435.git.geliang.tang@suse.com> <94b445b3225d4f91e2d05cab0338c4367ecbabb4.1689650435.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 18 Jul 2023, Geliang Tang wrote:

> Add mptcp_subflow_set_stale() helper.
>

I was trying to remember the use case for this. The closest thing I can 
find is this:

     => the scheduler should be able to interact with the "stale" logic
        we have in the upstream kernel: mark a subflow as stale / back
        active.

from 
https://lore.kernel.org/mptcp/dd4363e7-d057-97e8-0b5f-8570f39aa538@tessares.net/

I think that need is met by the change in patch 11 to export 
mptcp_pm_subflow_chk_stale - if a particular scheduler wants to track some 
stale-like metric, it can do so with its own sk_storage values. There's 
also the matter of coordinating the values of stale_count and 
stale_rcv_tstamp.

My suggestion is to drop patches 8, 9, and 10 unless there's a compelling 
reason to allow a BPF scheduler to control this bit. If there's a need for 
it please speak up!


- Mat



> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/bpf.c      | 1 +
> net/mptcp/protocol.h | 2 ++
> net/mptcp/sched.c    | 6 ++++++
> 3 files changed, 9 insertions(+)
>
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index f388baf08d49..e6f94d5e22fb 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -146,6 +146,7 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
>
> BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
> BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
> +BTF_ID_FLAGS(func, mptcp_subflow_set_stale)
> BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
> BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
> BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 1b4457c44fe8..78b3beeb7d7a 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -662,6 +662,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
> void mptcp_release_sched(struct mptcp_sock *msk);
> void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
> 				 bool scheduled);
> +void mptcp_subflow_set_stale(struct mptcp_subflow_context *subflow,
> +			     int stale);
> void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
> 				   struct mptcp_sched_data *data);
> struct mptcp_subflow_context *
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index a80cf0481edf..3f361e75e38c 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -127,6 +127,12 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
> 	WRITE_ONCE(subflow->scheduled, scheduled);
> }
>
> +void mptcp_subflow_set_stale(struct mptcp_subflow_context *subflow,
> +			     int stale)
> +{
> +	subflow->stale = stale;
> +}
> +
> void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
> 				   struct mptcp_sched_data *data)
> {
> -- 
> 2.35.3
>
>
>
