Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272843FC2
	for <mptcp@lists.linux.dev>; Mon, 30 Aug 2021 23:57:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69F6E60E98;
	Mon, 30 Aug 2021 23:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1630367826;
	bh=i8kLKOhMKzI8tWgGkpH1gw+IEQdRjLKrS3VLggTNIrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ivhdxNHjLA/3BkE1gQtM5WG0DbqGHRHG7rHCeY2igCCUjdGfjEh0YzzPvtBg6HVVO
	 UMBE+0Rb/HBtHCUAXs4AD6mKtIf8Me5yZQNun3nUP6E1PxqGiVytWj5Sm1KN7i6UjG
	 Mjq+QGaAE9bs2CJnwo+E6tdMGgjcagXW5pr7FgBREZRkw5ZrTqMGSrjWOEI61rNEnS
	 mRXsL1fe3E/UJCvImHxkwzfZy9TQpX8NbSk1o7PngSq12N0zV6dlJn93ouiBtys8Zv
	 GgtPYlSJc498puwpwllhN+/dJz/IusqvMUVIk9tMpjYT982DeRdv0miqziIVs8Dixl
	 r+4mbHYBZbxQw==
Date: Mon, 30 Aug 2021 16:57:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 davem@davemloft.net, matthieu.baerts@tessares.net, mptcp@lists.linux.dev,
 Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net 1/2] mptcp: fix possible divide by zero
Message-ID: <20210830165705.1f0dbafc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210828001731.67757-2-mathew.j.martineau@linux.intel.com>
References: <20210828001731.67757-1-mathew.j.martineau@linux.intel.com>
	<20210828001731.67757-2-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Aug 2021 17:17:30 -0700 Mat Martineau wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Florian noted that if mptcp_alloc_tx_skb() allocation fails
> in __mptcp_push_pending(), we can end-up invoking
> mptcp_push_release()/tcp_push() with a zero mss, causing
> a divide by 0 error.
> 
> This change addresses the issue refactoring the skb allocation
> code checking if skb collapsing will happen for sure and doing
> the skb allocation only after such check. Skb allocation will
> now happen only after the call to tcp_send_mss() which
> correctly initializes mss_now.
> 
> As side bonuses we now fill the skb tx cache only when needed,
> and this also clean-up a bit the output path.
> 
> Reported-by: Florian Westphal <fw@strlen.de>
> Fixes: 724cfd2ee8aa ("mptcp: allocate TX skbs in msk context")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  net/mptcp/protocol.c | 78 +++++++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 41 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a88924947815..0d5c1ec28508 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -994,6 +994,15 @@ static void mptcp_wmem_uncharge(struct sock *sk, int size)
>  	msk->wmem_reserved += size;
>  }
>  
> +static void __mptcp_mem_reclaim_partial(struct sock *sk)
> +{
> +#ifdef CONFIG_LOCKDEP
> +	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock.slock));
> +#endif

lockdep_assert_held_once() ? No ifdef should be needed?

> +	__mptcp_update_wmem(sk);
> +	sk_mem_reclaim_partial(sk);
> +}
> +
>  static void mptcp_mem_reclaim_partial(struct sock *sk)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);

> @@ -1512,7 +1516,9 @@ static void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>  static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct mptcp_sendmsg_info info;
> +	struct mptcp_sendmsg_info info = {
> +				 .data_lock_held = true,

indentation looks off

> +	};
