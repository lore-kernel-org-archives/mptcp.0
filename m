Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70B6371
	for <mptcp@lists.linux.dev>; Sat, 17 Jun 2023 00:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBC2C433C0;
	Sat, 17 Jun 2023 00:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686963285;
	bh=FN/9polJ3J4EH3eDiT7xh8CBEEPNlHo0u2RLwUjUuAI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IQgFHFUbC38tcTp3ZTGYYIJ2BnbVnfkgIbqVkyXi0lniEbUIJX4p9pJoxnJbE++RD
	 g1zpMciEKcXtWe7yW4djlX8YW2Q4M4Y8gIWdlmcwcgnz1+MpNrKgF36a+8VZByWvjA
	 zitGMuS+e7uyoPNBJEALXrAHlk2wbh1Cl04soWXk3WdLzOlA8xys+wClhyiv+6SW38
	 t8t5UJ6JEfp8wUxOhxStF/2XFlVW1wQVovysLXrWJMy/4nD4e881zZ+8ude2YJnxcn
	 Ivb6EbuF4dyuDSLPeA5xLSRdhZiorf3D+spwuPr7o7DnK78gQqSdUfTvP7kzBEbwzL
	 cp2rRBC80FAgA==
Date: Fri, 16 Jun 2023 17:54:44 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, pabeni@redhat.com
Subject: Re: [PATCH mptcp-next v9 05/23] Squash to "mptcp: add scheduler
 wrappers"
In-Reply-To: <256cf1d3f00f5577d10f885272f1725b3302bd62.1686709116.git.geliang.tang@suse.com>
Message-ID: <5f6d3011-63de-c7a2-3ae7-9a70b51edd73@kernel.org>
References: <cover.1686709116.git.geliang.tang@suse.com> <256cf1d3f00f5577d10f885272f1725b3302bd62.1686709116.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 14 Jun 2023, Geliang Tang wrote:

> Add sched_data into mptcp_sock too.
> Use msk->sched_data instead of the local variable data.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.h |  1 +
> net/mptcp/sched.c    | 14 ++++++--------
> 2 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4e42f52596d4..bda91399be49 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -314,6 +314,7 @@ struct mptcp_sock {
> 				   */
> 	struct sock	*first;
> 	struct mptcp_pm_data	pm;
> +	struct mptcp_sched_data sched_data;

Hi Geliang -

If mptcp_sched_data is part of the mptcp_sock then 
mptcp_sock->sched_data->contexts[] is stale once mptcp_sched_get_send() or 
mptcp_sched_get_retrans() return. It's also "wasted memory" while the 
scheduler is not running.

Are you moving the struct here mainly to be able to add persistent 
scheduler data (last_snd and snd_burst) in the next two patches?

I'm concerned that this design is setting up the BPF scheduler to require 
custom additions to mptcp_sched_data for many new scheduler types. Is 
there a way to leave mptcp_sched_data unchanged, but add a new member to 
mptcp_sock just for bpf scheduler state?

Is it possible to create a BPF map and store scheduler-specific key-value 
pairs in it that are accessble by the various BPF scheduler functions?

The basic idea is:

  * struct bpf_map pointer is passed in to each BPF scheduler function
  * If a BPF scheduler is configured for a MPTCP socket, allocate an empty 
map. Store a struct bpf_map* in msk_sock (instead of moving sched_data).
  * Scheduler sets up the map keys and initial values when configured
  * The BPF get_send() functions access and update those values using bpf 
helpers (https://man7.org/linux/man-pages/man7/bpf-helpers.7.html)
  * When scheduler is reconfigured or socket is closed, free the map

This way sched_data remains temporary, and there's a new place to store 
persistent scheduler-specific values.

What do you think?

- Mat


> 	struct mptcp_sched_ops	*sched;
> 	struct {
> 		u32	space;	/* bytes copied in last measurement window */
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index a15d7632abec..ca4bd53cf5d9 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -125,7 +125,6 @@ mptcp_subflow_ctx_by_pos(const struct mptcp_sock *msk, unsigned int pos)
> int mptcp_sched_get_send(struct mptcp_sock *msk)
> {
> 	struct mptcp_subflow_context *subflow;
> -	struct mptcp_sched_data data;
>
> 	msk_owned_by_me(msk);
>
> @@ -155,15 +154,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
> 		return 0;
> 	}
>
> -	data.reinject = false;
> -	msk->sched->data_init(msk, &data);
> -	return msk->sched->get_subflow(msk, &data);
> +	msk->sched_data.reinject = false;
> +	msk->sched->data_init(msk, &msk->sched_data);
> +	return msk->sched->get_subflow(msk, &msk->sched_data);
> }
>
> int mptcp_sched_get_retrans(struct mptcp_sock *msk)
> {
> 	struct mptcp_subflow_context *subflow;
> -	struct mptcp_sched_data data;
>
> 	msk_owned_by_me(msk);
>
> @@ -186,7 +184,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
> 		return 0;
> 	}
>
> -	data.reinject = true;
> -	msk->sched->data_init(msk, &data);
> -	return msk->sched->get_subflow(msk, &data);
> +	msk->sched_data.reinject = true;
> +	msk->sched->data_init(msk, &msk->sched_data);
> +	return msk->sched->get_subflow(msk, &msk->sched_data);
> }
> -- 
> 2.35.3
>
>
>
