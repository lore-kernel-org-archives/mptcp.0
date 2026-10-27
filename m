Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136192;
	b=ZhOI8Bw9Y+YucSnyFY/PuxF3Kef528I36XpX4xJ8FvCBj0I9dgIwhy7iibtUAy/qwUXR
	 azLNQ6Dmb96eOf35RSG4Z459gvv+BwSW4GECjRBaMJnhmeQ6huLgxdxstAjXG5ICiKJbA
	 304h1K6BB5Q5gzMDCgvswES9s0FDX1m8wBLmZ13I30fnXi2e/6Iial12GaoKyxMWCXmKC
	 AHG60+StCcOOEFiexP3mL0gmRkmLcJWCVEJqEB0XvpaUjQqWt8hB8iixDVQDgDYrNVkqg
	 g6r/RLuI7E/NTgfn9kMpjctX9Rmh2ICRs0AaWUDjsOb1ZJkYqcC5DSq4bgu0esEqe2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136192;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZBhhFUDTuAumtHZajXY2OKzTvSe26HmxLLs6mGkX10I=;
	b=XtcarjyLqC3MkOCaOYa9vtu641falbD/PYw98erwhSCsEOvVBo7H06112pgE8TCK0lz2
	 46CBBj3XiBQYzmF1L0gjvo8BCrxomWYfi+vLAwnijEB8kdOZm5s9ydfsPs3gVXAEPrwTW
	 kaL+kaA0H9XaQKTfxvEvxe2fqVBjgOVzo6MFMYQE+K4z4nEhU/ATog2x6+Aa6D0CXVueW
	 HrHq3asVfl3fLhWwfGbcpY3a3yl/wom8hl4DMEHyVspiDUE3FyO2nAvZvnmPy3aODyHED
	 2mJxRqogHkugE+rPM5nC7CV30q/QFFSmowNDMo7ienDDZybHY+PWpA4Cv0JKCr5zszQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UXPginR9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E14606A31D
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UXPginR9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD2A1F01283;
	Tue, 27 Oct 2026 21:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793136191;
	bh=ZBhhFUDTuAumtHZajXY2OKzTvSe26HmxLLs6mGkX10I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UXPginR9pJTuVmboblJFOc7Gtb0ANzd4vPJ4fP4ofx3tWDtSXqzeNb6VmHX0TQEEd
	 7p8bJCDDGUi8BvvFRW5E3zCwt/kBRwNCbmPC+olb/Sle31hnrdEJmCKZ0wB+gfDzOm
	 /q3Lp3N5NCIRW0oJG+hHqBCZh5lyuYx5Ps7MA00ILgWYpfUHsfJIrm1wi4wAN9495S
	 KRPkq7x1IZx8q1DVE9A0g4Bwt3VV/QWRUaU89vSbrbyEX3Zf3XDo3MU5KQ/684q8eH
	 cGrli4R8K0dJ1biVVBDiJRg+QYHqoT8uKiunxK/Uwol4EU+9mOX9ccCAFNp5XwAfR+
	 58+v000oKcbQQ==
Subject: Re: [PATCH mptcp-next v10 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 27 Oct 2026 21:23:11 +0000
Message-ID: <179313619104.3132.10360149057341401838@kernel.org>
In-Reply-To: <20261026063657.2955783-5-anilkaushikwireless@gmail.com>
References: <20261026063657.2955783-5-anilkaushikwireless@gmail.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Use-after-free and list corruption in net/mptcp/protocol.c.
- [Medium] mptcp_retry_check_tout() (net/mptcp/protocol.c) arms the close
  timeout while a re-created subflow is connecting.

--

mptcp: pm: in-kernel: retry subflows closed after an error

With this patch, the in-kernel PM re-creates an established subflow it
initiated once TCP gives up on it after a retransmission or keepalive
timeout. The SYN retries of the new subflow come from the subflow-retries
limit. Re-created subflows that are still connecting are closed when the
msk is closed or is no longer established, and the close timeout is kept
when no other subflow can send.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d9d8c..6d3232dc2b19d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -2788,6 +2791,78 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,

[ ... ]

> +static void mptcp_close_retry_subflows(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {

[ ... ]

> +		mptcp_pm_subflow_check_next(msk, subflow);
> +		__mptcp_close_ssk(sk, ssk, subflow, 0);
> +	}
> +}

[ ... ]

> +static void mptcp_retry_check_tout(struct sock *sk)
> +{

[ ... ]

> +	if (sk->sk_state == TCP_ESTABLISHED)
> +		mptcp_start_tout_timer(sk);
> +	else
> +		mptcp_close_retry_subflows(sk);
> +}
> +
>  void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  		     struct mptcp_subflow_context *subflow)
>  {
> @@ -2806,6 +2881,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	mptcp_pm_subflow_check_next(mptcp_sk(sk), subflow);
>  
>  	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
> +	mptcp_retry_check_tout(sk);
>  }

[Severity: Critical]

Can this free a subflow that the caller's list walk has already cached as
the next entry?

mptcp_close_ssk() is called from inside mptcp_for_each_subflow_safe()
loops in __mptcp_close_subflow() and in mptcp_pm_rm_addr_or_subflow() in
net/mptcp/pm.c. Suppose the msk is not TCP_ESTABLISHED, no subflow is
active, and a re-created subflow is still connecting. The new call then
goes to mptcp_close_retry_subflows(), which runs __mptcp_close_ssk() on
other entries of conn_list.

For the re-created subflow, that does list_del() on its node and calls
__tcp_close(). It also drops the msk's ssk reference. Because the context
is disposable, subflow_ulp_release() then frees it with kfree_rcu().

__mptcp_subflow_connect() adds the re-created subflow R with
list_add_tail(). So R is usually the tmp the outer loop has cached while
it processes the initial subflow F. This sequence looks like it reaches
that case:

  client msk, in-kernel PM, conn_list [F, A]
  A times out, __mptcp_close_subflow() re-creates R: conn_list [F, R]
  R stays in SYN_SENT because its SYNs are dropped
  peer sends DATA_FIN, mptcp_check_data_fin() sets TCP_CLOSE_WAIT
  peer resets F (or sends RM_ADDR for id 0)

  __mptcp_close_subflow()          /* subflow = F, tmp = R */
    mptcp_close_ssk(F)
      __mptcp_close_ssk(F)
      mptcp_retry_check_tout()
        mptcp_close_retry_subflows()
          __mptcp_close_ssk(R, 0)  /* list_del() and free of R */
  loop continues with subflow = R

The outer loop then reads R->tcp_sock and calls mptcp_close_ssk(R) a
second time. close_event_done stays unset because
mptcp_close_retry_subflows() never sets it.

That second call:

  - decrements extra_subflows again in mptcp_pm_subflow_check_next()
  - calls lock_sock_nested() on a socket that may already be freed
  - calls list_del() on a poisoned node

After that, the loop takes its next entry from R->node.next, which is
LIST_POISON1.

The peer, or an on-path attacker, can drive every step of this sequence.
The feature is enabled by default for the in-kernel PM.

Could mptcp_close_retry_subflows() be deferred from here, for example to
the top level of mptcp_worker(), so that it never runs inside a caller's
safe iteration?

> @@ -2823,6 +2899,8 @@ static void __mptcp_close_subflow(struct sock *sk)
>  	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
>  		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>  		int ssk_state = inet_sk_state_load(ssk);
> +		struct mptcp_pm_retry retry;
> +		bool do_retry;

[ ... ]

> +		do_retry = mptcp_pm_subflow_retry_check(msk, subflow, &retry);
>  		mptcp_close_ssk(sk, ssk, subflow);
> +		if (do_retry) {
> +			mptcp_pm_subflow_retry(msk, &retry);
> +			/* creating a subflow stopped the close timeout */
> +			mptcp_retry_check_tout(sk);
> +		}
>  	}
>  
>  }
> @@ -3188,10 +3272,19 @@ static void mptcp_worker(struct work_struct *work)
>  	if (mptcp_close_tout_expired(sk)) {
>  		struct mptcp_subflow_context *subflow, *tmp;
>  
> -		mptcp_do_fastclose(sk);
> -		mptcp_for_each_subflow_safe(msk, subflow, tmp)
> -			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);
> -		mptcp_close_wake_up(sk);
> +		/* a re-created subflow connected in the meantime, see
> +		 * mptcp_retry_check_tout()
> +		 */
> +		if (sk->sk_state == TCP_ESTABLISHED &&
> +		    mptcp_has_active_subflow(msk)) {
> +			mptcp_stop_tout_timer(sk);
> +		} else {
> +			mptcp_do_fastclose(sk);

[Severity: Medium]

Can this fastclose a half-closed connection that already has an
established re-created subflow?

When the msk is TCP_ESTABLISHED and the only subflow left is a re-created
one that is still connecting, mptcp_retry_check_tout() arms the close
timer with mptcp_start_tout_timer(). When that subflow later completes its
MP_JOIN, mptcp_finish_join() returns early because the subflow is already
in conn_list:

	if (!list_empty(&subflow->node)) {
		...
		mptcp_subflow_joined(msk, ssk);
		spin_unlock_bh(&msk->fallback_lock);
		mptcp_propagate_sndbuf(parent, ssk);
		return true;
	}

So __mptcp_finish_join(), which calls mptcp_stop_tout_timer(), is never
reached, and the timer stays armed.

The msk can then move to TCP_CLOSE_WAIT before close_timeout expires,
either through a peer DATA_FIN in mptcp_check_data_fin() or through a
local shutdown(SHUT_WR). The check above then fails on sk_state, and
mptcp_do_fastclose() resets the active subflow.

Could the timer be stopped when the re-created subflow joins? Another
option would be for this check to also accept the states where the
connection is still usable.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026063657.2955783-1-anilkaushikwireless%40gmail.com
