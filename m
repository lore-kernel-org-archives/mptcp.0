Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102232B128
	for <mptcp@lists.linux.dev>; Sun, 31 May 2026 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780207918; cv=none; b=KPbNNvFkFb4SdHOU5dILXB5mapws2lgbpVZJeJmeF24WGEf8TZ7VYNZlcZKYS7mFZslb9tW+BgGbNTrhjmewiKs8qOXqcMvWLME8oRJ/Azax0AFG8kjPsexKkWIO/EHn/nq7rd/nD1iG4WfxlI1Of5CG9R/4ypHzo1scDxcqLkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780207918; c=relaxed/simple;
	bh=XnluPBN8C0XTUxdgBNCISiuzTKg/ibDPQoKP9NgP1/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYhsP9dDM8q+9XUEXNnnVYlvRV4ucIqabmwuXAHIikBN4EfObHtm6FRLDL8s7sgZeHbQ2FiyrnKgSJEG63EtK66TBDEZYDZ1fEUptOjZkkViT4N3freh1kZR1H4+MPdovnD5qL1LSu3hLNAn1Xla53tnGAlaTmLId3GTb0YPJRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoOZ92WX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoOZ92WX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA561F00893;
	Sun, 31 May 2026 06:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780207917;
	bh=qKtL05u0bW5bFWGYsugGLIuTRujOXrnjGXFevkaCTjU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KoOZ92WXWg+548Ah4cfPDp47f+prmr2bTheQcx5PaRoRkhYbxvJj18DisjeZirg5u
	 FkREcCBZE61MfEz0NGdWSkHQ4d40HM1aP+m+kgsq49hhJH+46rkzH6jsnTEsPPboBW
	 Q7la9iaW1Ji/X5C2ciwpjLfHN6Xgk6KSnG6tdKQ67D6cCBh/w/FRWPNmVz/JGe40vd
	 cTUNWPLoKfU9LcFlUG9TMc0SWxE9vf7OaM0tKSzh2BXWZjlhjel3DNet0keHstfzG2
	 n7VzlFyOcmxFGZudDaNzV2QLgmirAQZFB7yA7UesXdt8bjWyPfKG8oghD0aAbzO23Q
	 k5XrX+0EgZ7qg==
Message-ID: <dc26df7b-5a00-4c55-bf5f-a402e079b7ef@kernel.org>
Date: Sun, 31 May 2026 16:11:51 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v3] mptcp: fix stale skb->sk reference on subflow
 close
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com, janak@mpiric.us, kalpanjani009@gmail.com,
 shardulsb08@gmail.com
References: <20260519092243.1242351-1-kalpan.jani@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260519092243.1242351-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kalpan,

On 19/05/2026 19:22, Kalpan Jani wrote:
> The backlog list is updated by mptcp_data_ready() under
> mptcp_data_lock(), but the cleanup of references to a closing subflow
> in mptcp_close_ssk() was done after release_sock(ssk) without holding
> that lock.

Is it possible the commit message needs to be updated?

AI assisted review is reporting this:

The commit message states the cleanup "was done after release_sock(ssk)"
Is this description of the old code accurate?

Looking at the pre-patch code, the backlog traversal in mptcp_close_ssk
ran before __mptcp_close_ssk() was called. __mptcp_close_ssk() is where
lock_sock_nested(ssk) happens. The traversal was never preceded by
lock_sock(ssk) nor followed by release_sock(ssk) - it simply ran with
neither ssk lock nor mptcp_data_lock held.

The phrase "after release_sock(ssk)" does not match the actual old code
structure. The correct statement would be: "was done without holding the
ssk lock or mptcp_data_lock, before __mptcp_close_ssk() acquired the ssk
lock."

> Once release_sock(ssk) returns, the RX path can acquire the ssk lock,
> call mptcp_data_ready(), and enqueue a new skb under mptcp_data_lock()
> before the close path reaches its list_for_each traversal. That skb is
> missed by cleanup, leaving skb->sk pointing to the freed ssk.

AI assisted review is reporting this:

The race scenario is real, but is the ordering description accurate?

In the old code, the list_for_each traversal happened before
lock_sock(ssk) (inside mptcp_close_ssk(), before calling
__mptcp_close_ssk()). There was no prior release_sock(ssk) to trigger
the race.

The actual race is: the traversal runs without mptcp_data_lock, so
concurrent softirq processing on another CPU can call subflow_data_ready
-> mptcp_data_ready -> __mptcp_add_backlog (under mptcp_data_lock) while
the traversal is in progress. The traversal can miss newly-added entries
or worse, encounter list corruption. The bug is real, but the mechanism
description is inaccurate.

> Fix this by moving the backlog cleanup into __mptcp_close_ssk(), after
> subflow->closing is set to 1 and while the ssk lock is still held,
> serialized under mptcp_data_lock(). The cleanup runs only on the push
> path (MPTCP_CF_PUSH), where backlog references accumulate; on other
> teardown paths the caller already handles cleanup.
> 
> With both locks held simultaneously, any concurrent mptcp_data_ready()
> either completes its enqueue before the purge runs and gets caught, or
> observes closing=1 while the ssk lock is still held and bails without
> enqueuing. After mptcp_data_unlock(), no new skbs can be enqueued.
> The cleanup is exhaustive.
> 
> Remove the unprotected traversal from mptcp_close_ssk() entirely.
> 
> Tested with the MPTCP kernel selftests on the patched kernel:
> - tools/testing/selftests/net/mptcp/mptcp_join.sh: all tests pass
> - tools/testing/selftests/net/mptcp/mptcp_connect.sh: 68/68 pass

Do not forget about the Fixes tag.

> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/621
> Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
> ---
> v3: follow Paolo's suggestion exactly — use mptcp_cleanup_ssk_backlog() helper under MPTCP_CF_PUSH condition only; remove inline loop duplication and second call from !dispose_it path.
> v2: moved cleanup into __mptcp_close_ssk() but duplicated logic and added redundant second call; incorrect approach.
> v1: incorrect race analysis around subflow->closing flag.
> 
>  net/mptcp/protocol.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 718e910ff..149f816fe 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2527,6 +2527,22 @@ static void __mptcp_subflow_disconnect(struct sock *ssk,
>  	}
>  }
>  
> +static void mptcp_cleanup_ssk_backlog(struct sock *sk, struct sock *ssk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sk_buff *skb;
> +
> +	mptcp_data_lock(sk);
> +	list_for_each_entry(skb, &msk->backlog_list, list) {
> +		if (skb->sk != ssk)
> +			continue;
> +
> +		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
> +		skb->sk = NULL;
> +	}
> +	mptcp_data_unlock(sk);
> +}
> +
>  /* subflow sockets can be either outgoing (connect) or incoming
>   * (accept).
>   *
> @@ -2550,6 +2566,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
>  	subflow->closing = 1;
>  
> +	if (flags & MPTCP_CF_PUSH)
> +		mptcp_cleanup_ssk_backlog(sk, ssk);
> +
>  	/* Borrow the fwd allocated page left-over; fwd memory for the subflow
>  	 * could be negative at this point, but will be reach zero soon - when
>  	 * the data allocated using such fragment will be freed.
> @@ -2641,9 +2660,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  		     struct mptcp_subflow_context *subflow)
>  {
> -	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct sk_buff *skb;
> -
>  	/* The first subflow can already be closed or disconnected */
>  	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
>  		return;
> @@ -2653,17 +2669,6 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	if (sk->sk_state == TCP_ESTABLISHED)
>  		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
>  
> -	/* Remove any reference from the backlog to this ssk; backlog skbs consume
> -	 * space in the msk receive queue, no need to touch sk->sk_rmem_alloc
> -	 */
> -	list_for_each_entry(skb, &msk->backlog_list, list) {
> -		if (skb->sk != ssk)
> -			continue;
> -
> -		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
> -		skb->sk = NULL;
> -	}
> -
>  	/* subflow aborted before reaching the fully_established status
>  	 * attempt the creation of the next subflow
>  	 */

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

