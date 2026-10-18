Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379EB39CCE1
	for <mptcp@lists.linux.dev>; Sun, 18 Oct 2026 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792301966; cv=none; b=C02CsdwFI8cSvRPtiClTeO7zDiViOsQysRXbqUcH6uc7iJ2dl0axNE6AatBZGovTtxlUGzZGEKTVPGThAg3YjmiU0b13r01X8+8K4m3fR1jpAX3dHL454Id7GAr+BLS5MGTHYlfIqdHj6eT21s3/C6xwiwxT5cEhmhckMm5QF1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792301966; c=relaxed/simple;
	bh=KUJBUvp4pn8/E0xRImMvIw71WfB+Zp0F4NZ7hUaTk0s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f75LnbgzM9sLtH8AfZux0Ha3+taFzhsmNVKP7p2IolKx01eR0aF3Yuo2HKQVI/pVbn9qOmklP1Kg4W5DyJSkp625GstxTM12hBttqsHuI75GSuhtl2CTxyt0ruxrofOBFkoL4+pCEPBLqUee6D7hs73cI/CIZUWjaKLd38MiKtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYNO7Vdq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYNO7Vdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E836E1F000C6;
	Sun, 18 Oct 2026 05:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792301965;
	bh=sYqYk6wiJlJ0P536lFJHPJt1TxSl3xBsH6+ucTkftmI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XYNO7VdqiLkFEGDkalHKOQsv3kWuJgIA8AikFhP11LMc8ZRwn5G9e0NzEPkWSHnRf
	 YNUi6uQrQi9fDKIjIWOt8NGEhkCZE+1TQHnVzVLa8k3dw2KKwQ7z+GNf+7THO0xUeR
	 NGeXCfOqejCUJpzanoACu56MGgMdGwJiaM784CbEpCiV3esXrQlGwve2NzxcPma9uY
	 A6LipWX5hcVCLY+h9it5yKTRCAFg4+gT6Y6SD4FKUzkeriKzRTXQSApiSJ1ELbmzwS
	 ykDK6lmEiqkIe8iHCEt35XTNKK2Zu0G4OFNQPoNoZELWYPOYVDz5sigGrJwLZe9sKl
	 zsdjHy5kR0gtA==
Subject: Re: [PATCH mptcp-next v5 5/7] mptcp: pm: in-kernel: retry subflows
 closed after an error
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sun, 18 Oct 2026 05:39:24 +0000
Message-ID: <179230196449.3133.4238470005815011879@kernel.org>
In-Reply-To: <20261016160926.1155262-6-anilkaushikwireless@gmail.com>
References: <20261016160926.1155262-6-anilkaushikwireless@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In mptcp_pm_kernel_retry_check() (net/mptcp/pm_kernel.c), the
  endpoint-removed check ("/* not if its endpoint has been removed */")…
- [Medium] mptcp_pm_kernel_retry_check() treats READ_ONCE(ssk->sk_err) at
  close time as the reason the subflow closed, but that value can be…
- [Medium] A subflow can be re-created towards a remote address the peer
  has just withdrawn with RM_ADDR.
- [Low] mptcp_close_retry_subflows() (net/mptcp/protocol.c), called from
  __mptcp_close(), tears down re-created subflows still in SYN_SENT…

--

mptcp: pm: in-kernel: retry subflows closed after an error

With this patch, the in-kernel PM re-creates a subflow initiated by this
side, using the same addresses, when TCP closes it after an error. The SYN
retransmissions of the new subflow are set by the subflow-retries limit,
and re-created subflows still in SYN_SENT are closed when the MPTCP socket
is closed. Subflows reset by the peer without the transient flag, aborted
locally, or whose endpoint was removed are not supposed to be retried.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index f4e23deda1403..f49224377aded 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1613,6 +1613,125 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)

[ ... ]

> +/* Called with the msk socket lock held, before the subflow is closed */
> +bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
> +				 const struct mptcp_subflow_context *subflow,
> +				 struct mptcp_pm_retry *retry)
> +{
> +	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
> +	bool established = READ_ONCE(subflow->fully_established);
> +	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +	struct sock *sk = (struct sock *)msk;
> +	int err = READ_ONCE(ssk->sk_err);
> +	bool endp_found;
> +	u8 id;
> +
> +	retry->syn_retries = mptcp_pm_get_limit_subflow_retries(msk);
> +	if (!retry->syn_retries || !err || sk->sk_state != TCP_ESTABLISHED ||
> +	    __mptcp_check_fallback(msk))
> +		return false;

[Severity: Medium]
Can ssk->sk_err here be left over from an earlier error that did not close
the subflow, rather than being the reason it closed?

MPTCP syncs IP_RECVERR / IPV6_RECVERR to the subflows. When it is set,
tcp_v4_err() on an established subflow can set sk_err (for example to
EHOSTUNREACH) and the subflow stays up. For an established, non-fallback
msk, __mptcp_subflow_error_report() returns without consuming the error:

net/mptcp/protocol.c:__mptcp_subflow_error_report() {
    ...
	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
		goto out;

	err = sock_error(ssk);
    ...
}

If the subflow is later closed without a new error, the !err filter does
not catch it and the subflow is retried. Two such closes:

- a graceful FIN from the peer, handled by the TCP_CLOSE_WAIT branch of
  __mptcp_close_subflow()
- a local mptcp_subflow_reset(), e.g. from mptcp_mp_fail_no_response(),
  which ends with the following and never touches sk_err:

	mptcp_send_active_reset_reason(ssk);
	tcp_done(ssk);

Would these subflows then be re-created? That would go against the commit
message, which says subflows "aborted locally" are not retried.

> +
> +	/* mptcp_close_ssk() will not handle it again, e.g. the initial
> +	 * subflow, kept in the list once closed
> +	 */

[ ... ]

> +	/* not if its endpoint has been removed */
> +	id = subflow_get_local_id(subflow);
> +	if (id) {
> +		rcu_read_lock();
> +		endp_found = !!__lookup_addr_by_id(pernet, id);
> +		rcu_read_unlock();
> +		if (!endp_found)
> +			return false;
> +	}

[Severity: Medium]
Is the endpoint-removed check skipped for the initial subflow?

The initial subflow always has local id 0, and so does any re-created copy
of it, since it is created with local.addr.id = 0. So the
__lookup_addr_by_id() lookup never runs for it.

The endpoint for that address is tracked in msk->mpc_endpoint_id, which is
reset when the endpoint is removed and is never read here:

net/mptcp/pm_kernel.c:mptcp_nl_remove_subflow_and_signal_addr() {
    ...
		if (msk->mpc_endpoint_id == entry->addr.id)
			msk->mpc_endpoint_id = 0;
    ...
}

When the endpoint is deleted, mptcp_pm_rm_addr_or_subflow() skips
subflows that are already in TCP_CLOSE:

			if ((1 << inet_sk_state_load(ssk)) &
			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
				continue;

Take a client whose initial subflow failed with ETIMEDOUT and is waiting
for MPTCP_WORK_CLOSE_SUBFLOW. That subflow is left to
__mptcp_close_subflow(). With a non-zero id, the lookup would refuse the
retry. With id 0, this function returns true.

Could this re-create a subflow on the address of an endpoint the admin
just removed? The commit message says subflows "whose endpoint has been
removed are not retried". Also, deleting the endpoint later could not
remove the new subflow, because the endpoint is already gone.

> +
> +	mptcp_remote_address((struct sock_common *)ssk, &retry->remote);
> +	retry->remote.id = READ_ONCE(subflow->remote_id);
> +	if (!retry->remote.id && READ_ONCE(msk->pm.remote_deny_join_id0))
> +		return false;

[Severity: Medium]
What happens if the peer has just withdrawn this remote address with
RM_ADDR?

In mptcp_worker(), the PM work runs before the subflow cleanup:

	mptcp_pm_worker(msk);
	...
	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
		__mptcp_close_subflow(sk);

mptcp_pm_rm_addr_or_subflow() skips TCP_CLOSE subflows before it matches
the removed remote id (the same TCPF_CLOSE check quoted above). A subflow
that already closed with a retryable error is therefore neither closed
nor marked by the RM_ADDR handling.

The only remote check here is remote_deny_join_id0, and it only applies
to remote id 0. Could mptcp_pm_kernel_retry() then open a new MP_JOIN to
an address the peer has withdrawn?

One possible trigger: the peer removes an endpoint, closes the matching
subflow (e.g. with an RST when data is unread), and sends RM_ADDR on
another subflow. Both events arrive before the worker runs.

> +
> +	mptcp_local_address((struct sock_common *)ssk, &retry->local.addr);

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 60cbd91be6320..354b80156bce6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -3494,6 +3499,22 @@ static void mptcp_check_listen_stop(struct sock *sk)
>  	release_sock(ssk);
>  }
>  
> +/* Re-created subflows still connecting are useless once the msk is closed,
> + * and their SYN retransmissions could keep them around for a long time.
> + */
> +static void mptcp_close_retry_subflows(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		if (subflow->retry && inet_sk_state_load(ssk) == TCP_SYN_SENT)
> +			mptcp_close_ssk(sk, ssk, subflow);

[Severity: Low]
mptcp_close_ssk() always calls __mptcp_close_ssk() with MPTCP_CF_PUSH. Is
that intended for subflows still in SYN_SENT while the msk is closing?

In __mptcp_close_ssk(), this re-injects the whole rtx queue and later
calls __mptcp_push_pending(sk, 0), even though a SYN_SENT subflow never
carried data:

	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);

In the fastclose branch of __mptcp_close(), mptcp_do_fastclose() has
already sent the RSTs. The other subflows are still TCP_ESTABLISHED
locally, though, so data segments could go out on them just before
__mptcp_destroy_sock().

The timeout-driven fastclose path in mptcp_worker() avoids this by
passing 0:

		mptcp_do_fastclose(sk);
		mptcp_for_each_subflow_safe(msk, subflow, tmp)
			__mptcp_close_ssk(sk, subflow->tcp_sock, subflow, 0);

On a graceful close, the unacked rtx queue would also be re-injected each
time a pending retry subflow is torn down.

Would it be better to close these subflows without MPTCP_CF_PUSH?

> +	}
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016160926.1155262-1-anilkaushikwireless%40gmail.com
