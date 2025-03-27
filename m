Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04210212B0D
	for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074840; cv=none; b=HELXemXi+v3KVNomBpycrfuz+QvbLncAdNTHUVpcCWmjKbuMat1zSZ9KeLwgX00HAGVEo2lHmfdf0FYb9tZnF6gjpilvUlLTD0YwnXV1TKlJdym6JrTJqau986Aznb6eFYziCQECsSiaNVGykRo9MRMzg5Ek/mBYqWPS1c3E+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074840; c=relaxed/simple;
	bh=8ikFt6GaninrfW1d6R7bKfsc4Nh45HHgAj+B0Qt/9hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXPopPOTSTVONYh2FMP3wmmUtJSABBTYR5BOuBbuQwqr6eT0nz1pBzKxrkMjSQnivhbF8D/RY34Xjh0GlMZiuOG8OnVQGYGTq3MrZ4tLZFR1rs15TfgbzLQApCIZXbgEU6LeAcAMgadAMiNiCEo6lh9fZGcjy4uWTquXEGyMz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URNbZ4Gp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URNbZ4Gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D88C4CEDD;
	Thu, 27 Mar 2025 11:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743074839;
	bh=8ikFt6GaninrfW1d6R7bKfsc4Nh45HHgAj+B0Qt/9hc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=URNbZ4GpUqQb9/pYynHJfew/51LB2GU0zdH1Q4EWLfv1DXFEIgym8NGmm1szCOtQi
	 /sUA7xQTVgPFR/bTkEUAT1Yk8TqkdS3//2htrUqFfKACWBdCHfUqlJVsWisExY8m0L
	 LnTocK5ytajqxCuvDyP9FFSFXqFNl0MTIh6kT2I/cX/8EBsPeL9fE9JU2QGS6+FJ6I
	 P7AmW4qki/zVxiDiExK+MGSttmUh+p9/RL/f3T1QrflQmh2wjFuV+zsJz8GFpxLHzP
	 jMmhIl8DuA2q8no4h57wkiK0kGFtLsYVCSukTLrqYuVbckQxxjf6qKy0vEgAgKIr83
	 iwR/bcgElhe3w==
Message-ID: <85ba8108-46ab-4e9b-b8f3-157b449e3053@kernel.org>
Date: Thu, 27 Mar 2025 12:27:18 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 2/7] mptcp: pm: add accept_new_subflow()
 interface
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1743054942.git.tanggeliang@kylinos.cn>
 <bb1346672d021bedf325489364b6c2eea16928b9.1743054942.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <bb1346672d021bedf325489364b6c2eea16928b9.1743054942.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 27/03/2025 07:04, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The helper mptcp_pm_is_userspace() is used to distinguish userspace PM
> operations from in-kernel PM in mptcp_can_accept_new_subflow(). It seems
> reasonable to add a mandatory .accept_new_subflow interface for struct
> mptcp_pm_ops.
> 
> The boolean type 'allow' parameter is used to control whether to allow new
> subflow unconditionally.
> 
> A new helper mptcp_pm_accept_new_subflow() is added in pm.c to ensure that
> pm->ops is only used in pm.c.
> 
> This interface of the in-kernel PM is implemented as a wrapper of
> READ_ONCE(pm->accept_subflow), and this interface of the userspace PM is
> implemented as a wrapper of mptcp_userspace_pm_active().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h      |  1 +
>  net/mptcp/pm.c           |  8 +++++++-
>  net/mptcp/pm_kernel.c    | 15 +++++++++++++++
>  net/mptcp/pm_userspace.c |  7 +++++++
>  net/mptcp/protocol.h     |  1 +
>  net/mptcp/subflow.c      |  6 ++----
>  6 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 4cf59e83c1c5..549b8075cc86 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -123,6 +123,7 @@ struct mptcp_pm_ops {
>  			    struct mptcp_pm_addr_entry *skc);
>  	bool (*get_priority)(struct mptcp_sock *msk,
>  			     struct mptcp_addr_info *skc);
> +	bool (*accept_new_subflow)(struct mptcp_sock *msk, bool allow);
>  
>  	char			name[MPTCP_PM_NAME_MAX];
>  	struct module		*owner;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index be1e27ee393e..1c8395d3baa9 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -453,6 +453,11 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
>  	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
>  }
>  
> +bool mptcp_pm_accept_new_subflow(struct mptcp_sock *msk, bool allow)
> +{
> +	return msk->pm.ops->accept_new_subflow(msk, allow);
> +}
> +
>  bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
>  {
>  	struct mptcp_pm_data *pm = &msk->pm;
> @@ -1050,7 +1055,8 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
>  
>  int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
>  {
> -	if (!pm_ops->get_local_id || !pm_ops->get_priority) {
> +	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
> +	    !pm_ops->accept_new_subflow) {
>  		pr_err("%s does not implement required ops\n", pm_ops->name);
>  		return -EINVAL;
>  	}
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 7ec81d5195d4..ee3915d33e04 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1399,6 +1399,20 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
>  	.size = sizeof(struct pm_nl_pernet),
>  };
>  
> +static bool mptcp_pm_kernel_accept_new_subflow(struct mptcp_sock *msk,
> +					       bool allow)

"allow" is always true.

> +{
> +	struct mptcp_pm_data *pm = &msk->pm;
> +	bool ret = false;
> +
> +	if (READ_ONCE(pm->accept_subflow)) {
> +		if (allow)
> +			return true;
> +	}
> +
> +	return ret;

Mmh, what about:

  return READ_ONCE(msk->pm.accept_subflow) && allow;

EDIT: OK, I just noticed the next patch. I suggest squashing this patch
with the next one, or you remove 'allow' and simplify this code here,
but I think it is easier to squash.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

