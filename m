Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEDC22C6C2
	for <mptcp@lists.linux.dev>; Sat,  7 Dec 2024 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733535942; cv=none; b=gpg8DjPedRSMIzKqly0t+xDFL9Bi+pmBsk6lLBs4ikq+KXigd2shKrm8gEGgIpmogQF5aS1UYLIzbB4qt8uUcnog8cPBLtoMCoS2Q4LmI5lRlf3MOpEhcfNZ459LTVSia2zZHbjtl6nrTs9OZsqHAdgJHxRLGOO3DZ5tqv7JOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733535942; c=relaxed/simple;
	bh=3B9wYauNsdy+dtcMCJ5A12M6lF7rh/eWp7M1cNCnY/M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P8U3BRDXIMqfP0q/OhI5C9mT4gJCIw2ZXwVLVjFArDLXC7FVfGYch4GsFr7eIJ1+9jVWfc/jqAtnjt5zYLBn7I+HJApo+Sc42+nIMnh3fj3+sjVbTT6IQmNUSlg4p14hOag7LGylnpx4ELKhOYm1JsYaNMArAlMXcf/XQSpIDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufNRUXaf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufNRUXaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C22C4CED1;
	Sat,  7 Dec 2024 01:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733535941;
	bh=3B9wYauNsdy+dtcMCJ5A12M6lF7rh/eWp7M1cNCnY/M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ufNRUXafqEFBNDL/Vw+HgivSK+GQtsTlhN80kSf4e6z+C2MmvNcjuDixLii0hobGB
	 1hHiWoEN92uSWA/xThjTRDgz3JCO5EmtFT9vagKsB3n/RPKA0btfXa85fODuv/uWms
	 5ElV39Di748YelRB1KTotaLfIsHL9RPuC1g6gZuTFe+6806QghRiNfISuuxT449TbQ
	 sQEUmyUKMqwduPqe2ElKL9dfCxq3WUB3b/oS7xP48QfnTJHrUKNgffstxB3mbqDKzb
	 HdKGsnDoSLwThrUSOqX0M4noXGwwu1mgjhibhqVaiFxfTMFsbdt1C6TQJW1ZqHe4pt
	 SRkZEKVt9CHNQ==
Date: Fri, 6 Dec 2024 17:45:40 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 6/7] mptcp: cleanup mem accounting.
In-Reply-To: <152364cf85476115c84f435d76a8f04da9e2d089.1733486870.git.pabeni@redhat.com>
Message-ID: <7eb7bd25-b6b2-9561-bec3-7b51020a21fb@kernel.org>
References: <cover.1733486870.git.pabeni@redhat.com> <152364cf85476115c84f435d76a8f04da9e2d089.1733486870.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 6 Dec 2024, Paolo Abeni wrote:

> After the previous patch, updating sk_forward_memory is cheap and
> we can drop a lot of complexity from the MPTCP memory acconting,
> removing the custom fwd mem allocations for rmem.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - keep 'snd_una' and recovery-related fields under the msk
>   data lock
> - dropped unneeded code in __mptcp_move_skbs()
> ---
> net/mptcp/fastopen.c |   2 +-
> net/mptcp/protocol.c | 115 +++----------------------------------------
> net/mptcp/protocol.h |   4 +-
> 3 files changed, 10 insertions(+), 111 deletions(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index ad940cc1f26f..a0d46b69746d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -278,7 +278,6 @@ struct mptcp_sock {
> 	u64		rcv_data_fin_seq;
> 	u64		bytes_retrans;
> 	u64		bytes_consumed;
> -	int		rmem_fwd_alloc;
> 	int		snd_burst;
> 	int		old_wspace;
> 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
> @@ -293,7 +292,6 @@ struct mptcp_sock {
> 	u32		last_ack_recv;
> 	unsigned long	timer_ival;
> 	u32		token;
> -	int		rmem_released;
> 	unsigned long	flags;
> 	unsigned long	cb_flags;
> 	bool		recovery;		/* closing subflow write queue reinjected */
> @@ -384,7 +382,7 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
>  */
> static inline int __mptcp_rmem(const struct sock *sk)
> {
> -	return atomic_read(&sk->sk_rmem_alloc) - READ_ONCE(mptcp_sk(sk)->rmem_released);
> +	return atomic_read(&sk->sk_rmem_alloc);
> }

Hi Paolo -

Minor change: this helper is now exactly the same as sk_rmem_alloc_get(), 
so use that existing helper instead.

Thats actually the only suggestion I have for v2! Good to delete code and 
improve performance. I also think the release_cb approach on rx is a good 
idea because it could be further leveraged to help with redundant 
schedulers (our main problem there was trying to trigger sends on other 
subflows when we couldn't acquire the msk lock).

- Mat

>
> static inline int mptcp_win_from_space(const struct sock *sk, int space)
> -- 
> 2.45.2
>
>
>
