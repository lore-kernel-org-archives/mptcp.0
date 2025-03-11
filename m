Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03771F09B4
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734875; cv=none; b=dw6Sn7KvRVQ2uW3s43tr8kItu+WTKLLNp9pni+Kx4eZyYgz6OZebRmbwUFrW1Cl/px838Zo0ztbUI75MT/KCE6La2lltB0JM1KcHp6mAvC+XJKTa9Xs+RmZyppwYCkWVPOqXZZjkO/jl9g4+MiCcuikAdzyZKcv0cc3InqURvf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734875; c=relaxed/simple;
	bh=Y1+yAna01CKftq+/ZtULPdiZckuJUDPmPTaseh1tN64=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AAdOehgC6JqKGuol+mDt0qkKNXmgO8TO+EYw3P3GhlZ9U/LYTqvPqf6ZNldYJ2A6EvPD1yIvEaT00fEewsafwHqKNVJoScygXVlD3dkZyBM3ZltKj45Tt3qcFPsmZutK4O4dBA3AzqDdnD2jcsjdb6bo/RR9bP6a4Qt0xJmicQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwIwk6+e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwIwk6+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDD2C4CEE9;
	Tue, 11 Mar 2025 23:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741734875;
	bh=Y1+yAna01CKftq+/ZtULPdiZckuJUDPmPTaseh1tN64=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=uwIwk6+eyG2yTBqLXvpr99J1J9+YIgVSi6TNn8BKy0Eb2BcliP8CPg3sv7MTDF+jd
	 /zVAKEqOhNgV1j0SwBpyS4yq7QJWaM8Qjl/Ar0mczXKMjYpthSUdRSLAZuEibiMoqn
	 WfER8Bw+H3pDyBwhCETliZ2eSBE786dmFpsLT2a6YpsO7QmgdROfT+Dzdax/A2IxKJ
	 pv9OO1AnPbPfDYeb/nASVDQSC0OYrasDejMvlOifujIYSQrJGPnbu/OG1NHWMmjcBw
	 lL3LieyLvC3oI+X/IdWT8S0xN0yiBA4wTH0NTmEIftJrxQo889C3N52Ys/CV8YI933
	 ksuou5j8Hg4WQ==
Message-ID: <07a52b91-2c2d-4eee-8711-098bf5516f01@kernel.org>
Date: Wed, 12 Mar 2025 00:14:31 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH mptcp-next v1 3/6] mptcp: pm: add subflow_check_next()
 interface
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741685260.git.tanggeliang@kylinos.cn>
 <2e7dd2f26852e4d5b5cd0434e13069b9461a3f32.1741685260.git.tanggeliang@kylinos.cn>
Content-Language: en-GB
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2e7dd2f26852e4d5b5cd0434e13069b9461a3f32.1741685260.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 11/03/2025 10:32, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The helper mptcp_pm_is_userspace() is used to distinguish userspace PM
> operations from in-kernel PM in mptcp_pm_subflow_check_next(). It seems
> reasonable to add a mandatory .subflow_check_next interface for struct
> mptcp_pm_ops.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h      |  3 +++
>  net/mptcp/pm.c           | 31 +++----------------------------
>  net/mptcp/pm_kernel.c    | 20 ++++++++++++++++++++
>  net/mptcp/pm_userspace.c | 15 +++++++++++++++
>  4 files changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 6f9bc0ca4d37..5f2d94b2f97f 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -15,6 +15,7 @@
>  struct mptcp_info;
>  struct mptcp_sock;
>  struct mptcp_pm_addr_entry;
> +struct mptcp_subflow_context;
>  struct seq_file;
>  
>  /* MPTCP sk_buff extension data */
> @@ -125,6 +126,8 @@ struct mptcp_pm_ops {
>  
>  	bool (*allow_new_subflow)(struct mptcp_sock *msk);
>  	bool (*accept_new_subflow)(const struct mptcp_sock *msk);
> +	void (*subflow_check_next)(struct mptcp_sock *msk,

Maybe we should rename this: subflow_established?

'check_next' is not really explicit.

> +				   const struct mptcp_subflow_context *subflow);
>  
>  	char			name[MPTCP_PM_NAME_MAX];
>  	struct module		*owner;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 31a2c66a1af3..d8a5c2c06500 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -526,33 +526,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
>  void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
>  				 const struct mptcp_subflow_context *subflow)
>  {
> -	struct mptcp_pm_data *pm = &msk->pm;
> -	bool update_subflows;
> -
> -	update_subflows = subflow->request_join || subflow->mp_join;
> -	if (mptcp_pm_is_userspace(msk)) {
> -		if (update_subflows) {
> -			spin_lock_bh(&pm->lock);
> -			pm->subflows--;
> -			spin_unlock_bh(&pm->lock);
> -		}

I wonder if... this 'if' should not be done for all PMs here. I guess
mptcp_pm_close_subflow(msk) could then be called.

Then I suggest scheduling the worker if msk->pm.ops->subflow_established
is set, and ... I'm not sure how to deal with work_pending. Maybe a new
callback? Or maybe we can deal with that later, but the current name is
not good :)

Anyway: then msk->pm.ops->subflow_check_next(), when the msk lock is
held. I think all these ops should only be called when the msk lock is
held, no? I don't think a BPF PM should schedule the worker.

> -		return;
> -	}
> -
> -	if (!READ_ONCE(pm->work_pending) && !update_subflows)
> -		return;
> -
> -	spin_lock_bh(&pm->lock);
> -	if (update_subflows)
> -		__mptcp_pm_close_subflow(msk);
> -
> -	/* Even if this subflow is not really established, tell the PM to try
> -	 * to pick the next ones, if possible.
> -	 */
> -	if (mptcp_pm_nl_check_work_pending(msk))
> -		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
> -
> -	spin_unlock_bh(&pm->lock);
> +	msk->pm.ops->subflow_check_next(msk, subflow);
>  }
>  
>  void mptcp_pm_add_addr_received(const struct sock *ssk,
> @@ -1017,7 +991,8 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
>  int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
>  {
>  	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
> -	    !pm_ops->allow_new_subflow || !pm_ops->accept_new_subflow) {
> +	    !pm_ops->allow_new_subflow || !pm_ops->accept_new_subflow ||
> +	    !pm_ops->subflow_check_next) {

See above: this new callback would not be mandatory then.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


