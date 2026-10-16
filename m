Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF743D301D
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137818; cv=none; b=JxScSr57ts3ZuS17OV7SLCtmyzH2kdqTr6JuqSwbUscZxejs0/skGmDU63VSwZ9YVl98CyKJCtkX5AhWmTjrtaH0br7B8rnh7TWcO+rPmTDFH6g4xI0gdvIRh56stmE7IYYCOnNAlYDuoSyUSVqzR4bam+endSLujXBQ6KOXiSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137818; c=relaxed/simple;
	bh=fVpeicE9c0fxk6LUKIBH3T/+emOq2zl5js5ylDzCwok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXiPMEvqa0ZIKo+6W5J/X7Xla4o3o8/xQONJl0n/WtqYzEU4N5vw9hBJz7wMn8wUOVslp/QaqHBbGPAoGjEi0svIEA3A1EskLvlr/uEFhsP2Hcj0nstpYUbDjpg62Gqd0u25iIwe9wNu+i/fwrk2zkryYev9iGDy99CqGvrb9Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDJ+G07I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDJ+G07I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51631F000C5;
	Fri, 16 Oct 2026 08:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792137813;
	bh=prLWnN7jGolaWhLiNmETbAELeScuz5F6+iowRQZ24PQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cDJ+G07InRQd51QhGlxzSCS+HU3B2z32ZDnhSaTEra1Ymn3b1LE7y+/Az+ZhYt2Nt
	 6HrBDZXheiRUzhpZx8b8MwdA/qQYHF8Ny7jK0jza7RN99yRqMMEVuJAaye/ukUsqil
	 rq96GfluwYUOWJUxOtOfW7dnViPV2uHgbgTOCSQmghaMzrYK+BQzbbk/MjZnq9J8a5
	 wUHLi3uvExyAkyc/g/O5Be1BrZ61O0PexUY88kgHf4MwL413sPYib4QBi1odyP+h0e
	 +pnyEaO+e8ChZ3ad7xowR5WKlDiOjqPgypSD5P+tdaljSn9gkus3Y6OLFxohvtGACm
	 j0mQm0db4nOtw==
Message-ID: <f9145188-a354-49e9-ad5f-889a2895e4fa@kernel.org>
Date: Fri, 16 Oct 2026 10:03:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: give MPTCP sockets a distinct
 lockdep class
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1792114102.git.tanggeliang@kylinos.cn>
 <8651f29fb4e11de14a7ea7d05d97a33b1e5390f3.1792114102.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8651f29fb4e11de14a7ea7d05d97a33b1e5390f3.1792114102.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the new version.

On 16/10/2026 03:35, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> MPTCP sockets and their subflows share the same k-sk_lock-AF_INET
> lockdep class. When both are kernel sockets, lockdep flags every path
> that holds the MPTCP socket lock and then locks a subflow (setsockopt,
> connect, bind, worker send-ack) as "possible recursive locking".
> 
> Extract the lock reclassification logic from PM listener socket creation
> into mptcp_reclassify_socket() helper to reclassify MPTCP socket locks
> to a distinct class (msk_lock-AF_INET for IPv4, msk_lock-AF_INET6 for
> IPv6). Call it from __mptcp_init_sock() to cover both active (connect)
> and passive (accept/clone) socket creation paths.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_kernel.c | 18 ++++++++++++------
>  net/mptcp/protocol.c  |  3 +++
>  net/mptcp/protocol.h  |  2 ++
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3..5e8792ad38ca 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -849,10 +849,20 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
>  static struct lock_class_key mptcp_slock_keys[2];
>  static struct lock_class_key mptcp_keys[2];
>  
> +void mptcp_reclassify_socket(struct sock *sk)
> +{
> +	bool is_ipv6 = sk->sk_family == AF_INET6;
> +
> +	sock_lock_init_class_and_name(sk,
> +				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
> +				      &mptcp_slock_keys[is_ipv6],
> +				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
> +				      &mptcp_keys[is_ipv6]);
> +}

Good idea to share this code here, but then I think it should be better
in net/mptcp/protocol.c than in the in-kernel PM.

>  static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>  					    struct mptcp_pm_addr_entry *entry)
>  {
> -	bool is_ipv6 = entry->addr.family == AF_INET6;
>  	int addrlen = sizeof(struct sockaddr_in);
>  	struct sockaddr_storage addr;
>  	struct sock *newsk, *ssk;
> @@ -874,11 +884,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>  	 * modifiers in several places, re-init the lock class for the msk
>  	 * socket to an mptcp specific one.
>  	 */
> -	sock_lock_init_class_and_name(newsk,
> -				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
> -				      &mptcp_slock_keys[is_ipv6],
> -				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
> -				      &mptcp_keys[is_ipv6]);
> +	mptcp_reclassify_socket(newsk);
>  
>  	lock_sock(newsk);
>  	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 60cbd91be632..68f339311993 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3245,6 +3245,9 @@ static void __mptcp_init_sock(struct sock *sk)
>  	/* re-use the csk retrans timer for MPTCP-level retrans */
>  	timer_setup(&sk->mptcp_retransmit_timer, mptcp_retransmit_timer, 0);
>  	timer_setup(&msk->sk.mptcp_tout_timer, mptcp_tout_timer, 0);
> +
> +	if (sk->sk_socket)

If you need this check here, that means the reclassification is not
always done, thus this new helper is certainly called from the wrong place.

> +		mptcp_reclassify_socket(sk);
>  }
>  
>  static void mptcp_ca_reset(struct sock *sk)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index ed2f363bb915..325499e65236 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1265,6 +1265,8 @@ u8 mptcp_pm_get_endp_fullmesh_max(const struct mptcp_sock *msk);
>  u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
>  u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
>  
> +void mptcp_reclassify_socket(struct sock *sk);
> +
>  /* called under PM lock */
>  static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
>  {

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

