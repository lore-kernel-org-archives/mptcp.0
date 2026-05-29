Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840819D065
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780020175; cv=none; b=Afm1Cmcg5cY1cOVtIoMNIB3jpVdgy/bCgOytVugtdSZDAdkTU9JD0C0cD1tMLuBbeIMS4Rn+mFRblzEw6p4azvOqLSZHCzOe/n5c8pKuGl4jFY8lqosSaCUvCcV3ngMcxkB+UIG8QXJFmXIex7KDLU+U4xLEQTkZd7IuolHDjeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780020175; c=relaxed/simple;
	bh=sqbddRu9f15ReeaiLPHsPOc9XP9zDA9qJioUGFVSLH0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AF6uiN2AMyKsGj+vr7ZXC84kKuf9X5KoAIBTGlz17y/oeEui9PBDP1zLfRIMD0ke5qR0BYtMovu3kwZGpdN9jZ3jowMm/YvIjRQodXC6DhLBbbll1aKfvnr5Grbyuuo99WqmS8crMgZLSJbzOvB6jhg2UR+2WJjuaLIzN7Cewdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKYJMFfh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKYJMFfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63701F000E9;
	Fri, 29 May 2026 02:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780020174;
	bh=eN3p5ZwriJ30UuTVJSch9+y1wnWJpydPlYDipdwkNSg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=oKYJMFfhiw9GXDYdpI1yMAJrmszcu+/JabZIuyBxjtI+nzZI0HtpOdE1HzQJSFbEs
	 RVTExGTkR3gYR3zZO/zFwXgfW1YSHCC7TX7jmLelizzloU6S8WFAyLXQ3FDh7X5ZZw
	 7zOe2mizAhHLVFk2Lmf/3tEngVB1Mzagkqbk9h1CUT0sPPogMsG78NmaYBoLQOXV1U
	 qqt23y3zARhk+rwhDBPTbPPziSuhntoHMMwDFIXzwUtHct/3JPfLx1JL4gTAuKCDpr
	 JtGlv68iWHKPOvOr7rDL1IGoKH5/ihX38oR6i80JvNQ4Ax5r8iqP4EsfZia/WyNR8A
	 JaAGbwj5P1gWA==
Date: Thu, 28 May 2026 19:02:53 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v3 03/16] mptcp: pm: avoid computing rm_addr
 size twice
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-3-bffa658a7678@kernel.org>
Message-ID: <0a8338e5-d688-ea0a-9d9e-622b8bc3f99c@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org> <20260520-mptcp-add-addr6-port-ts-v3-3-bffa658a7678@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 20 May 2026, Matthieu Baerts (NGI0) wrote:

> mptcp_rm_addr_len helper was called twice: in mptcp_pm_rm_addr_signal,
> then just after in mptcp_established_options_rm_addr. Both to check the
> remaining space.
>
> The second call is not needed: if there is not enough space,
> mptcp_pm_rm_addr_signal will return false, and the caller,
> mptcp_established_options_rm_addr, will do the same without re-checking
> the size again. Instead, mptcp_pm_rm_addr_signal can directly set the
> size.
>
> While at it, move mptcp_rm_addr_len to pm.c, as it is now only used
> there, once.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/options.c  | 11 ++---------
> net/mptcp/pm.c       | 11 ++++++++++-
> net/mptcp/protocol.h | 10 +---------
> 3 files changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 966f6a867287..231010aaf163 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -723,19 +723,12 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> 	struct mptcp_rm_list rm_list;
> -	int i, len;
> +	int i;
>
> 	if (!mptcp_pm_should_rm_signal(msk) ||
> -	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
> +	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list, size)))
> 		return false;
>
> -	len = mptcp_rm_addr_len(&rm_list);
> -	if (len < 0)
> -		return false;
> -	if (remaining < len)
> -		return false;
> -
> -	*size = len;
> 	opts->suboptions |= OPTION_MPTCP_RM_ADDR;
> 	opts->rm_list = rm_list;
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 4fc7d648b672..e78a248414fb 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -960,8 +960,16 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
> 	return ret;
> }
>
> +static int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
> +{
> +	if (rm_list->nr == 0 || rm_list->nr > MPTCP_RM_IDS_MAX)
> +		return -EINVAL;
> +
> +	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
> +}
> +
> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> -			     struct mptcp_rm_list *rm_list)
> +			     struct mptcp_rm_list *rm_list, unsigned int *size)

The signed/unsigned comment from patch 2 affects the type of 'size' here 
too.

- Mat


> {
> 	int ret = false, len;
> 	u8 rm_addr;
> @@ -981,6 +989,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> 	if (remaining < len)
> 		goto out_unlock;
>
> +	*size = len;
> 	*rm_list = msk->pm.rm_list_tx;
> 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
> 	ret = true;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 661600f8b573..6f3c73ad4284 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1224,20 +1224,12 @@ static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
> 	return len;
> }
>
> -static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
> -{
> -	if (rm_list->nr == 0 || rm_list->nr > MPTCP_RM_IDS_MAX)
> -		return -EINVAL;
> -
> -	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
> -}
> -
> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
> 			      unsigned int opt_size, unsigned int remaining,
> 			      struct mptcp_addr_info *addr, bool *echo,
> 			      bool *drop_other_suboptions);
> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> -			     struct mptcp_rm_list *rm_list);
> +			     struct mptcp_rm_list *rm_list, unsigned int *len);
> int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
> bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
> int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
>
> -- 
> 2.53.0
>
>
>
