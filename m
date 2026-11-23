Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415549;
	b=Zjbp+lFXbf/2Rw6t/4PHaFY1k216E0c5kZIWWeTG7Rh51wCzfe2X+TBBIhfCFbPjmwrn
	 1NhZE8y4DLiaRbmmRTRXNKBhqPgfNbjMzJzqvm3rc1hp+vQ1Qphh6pmGNcCLgzlOtYOUF
	 Km33SOJGP0DXemx13np8MP/w++/XArM3LTvEpFy+9M6rUKdSufk5LB/6dLpE5FU1zu8mu
	 rTYgcIzxsCtoHjJtzKycR7NZ0hbem1ezoBa3PSsdEG5sZh4NRj64mDYtoDZllvDfGV8Vn
	 m4N7NfM3jz4UBz96KP4JD2SOF9oGxDLAR+/HNPhs8Xl6DN4FlZ3v3Mo126tBaqcEI+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415549;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fJEoVx8U5gOvwMmFrnlyJiBalqDUbhg8/fLlethv5Qg=;
	b=w4uS/oK2zMiri/SLw/p1iMqnN/0/n4a989pOUOD5C+CCpc2t5cjQ3A4Ycp2fuCbXRU3V
	 9VzV/iuSUgINL1hi/vu6T3KjnKPLcJg/s4zdhwXw8mwd7mlaVBQG7J2DJiB5nynhWMKv8
	 uoYo1IPFnFN7FZH3DoQiZ2kqVt1L1SAOqbQnke++j7a8thmmJfn6N3uFQHxTJNnzsgUH2
	 EjcmOlHm5eGC9rWKwpKer7pEAEzs5x1yNoQqbm9bdHJ40XoafM3+7p0ajVFmRiOfEtHqh
	 KqZbMQK/8VfD7Dfw9VUZjkZZJgHmYntj4klhfT/tJJTDiDmLPYMJeLPpEMykgTON4og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMJinekc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C4606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMJinekc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092E11F000CF;
	Mon, 23 Nov 2026 06:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415549;
	bh=fJEoVx8U5gOvwMmFrnlyJiBalqDUbhg8/fLlethv5Qg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fMJinekcPDKYTQj//ymFF4q6P0ju5o514mdPA0xj9hrzENopSfg9MMDVFzz//kI7b
	 BZt7NQIClOQdwY0pRJaY5lR+/1u9Nj4nvsbG0Bo+2hic0l7R0dGM9JCbLNp8xiIRWF
	 9ZdCnCLlkZTb/546GMhQIuFbA48d5vdbpJOSojZbJqOsA9d6GFLfsXG1o7OxPp9oYY
	 M39h0EvzEaSklU90rZm7B8J1Vyc+VkGsNz4dgNzTa58V1CBsi0qf7b7CZ7JrCfV5Q9
	 PkgZx/3namiODQIdwNBF0bDY0vRWZpy3Vnw4cGKCLE9hDe+cL9x8lTXhTJx+nxvvk+
	 7dJjP9Py4uvQA==
Subject: Re: [PATCH mptcp-net v2 20/62] mptcp: start close timeout on initial
 sf shutdown
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:28 +0000
Message-ID: <179541554861.3133.16159737553641124171@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-20-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-20-00327fd1de1f@kernel.org>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In __mptcp_close_ssk() (net/mptcp/protocol.c:2826-2834), the
  new else-if arms the close timeout for every msk state except…

--

mptcp: start close timeout on initial sf shutdown

This patch adds a branch to __mptcp_close_ssk() that starts the MPTCP
close timeout when the initial subflow is the only one left and has been
shut down but not closed. Without it, an msk whose peer sent a FIN without
DATA_FIN on the only subflow could keep send() or recv() blocked forever.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 835796fd4f771..d3a793e96c9cc 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2823,6 +2823,14 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  		} else {
>  			mptcp_start_tout_timer(sk);
>  		}
> +	} else if (list_is_singular(&msk->conn_list) && msk->first &&
> +		   mptcp_subflow_ctx(msk->first)->closing &&
> +		   !inet_csk(sk)->icsk_mtup.probe_timestamp &&
> +		   sk->sk_state != TCP_CLOSE) {
> +		/* The initial subflow has only been shut down, and its later
> +		 * close will be ignored: start the close timeout now.
> +		 */
> +		mptcp_start_tout_timer(sk);

[Severity: Medium]
Should this branch use the same per-state handling as the branch just
above it? That branch covers the same "only the initial subflow is left"
case, but it treats each msk state differently:

net/mptcp/protocol.c:__mptcp_close_ssk() {
    ...
	 * For established sockets, allow an additional timeout before closing,
	 * as the protocol can still create more subflows.
	 */
	if (list_is_singular(&msk->conn_list) && msk->first &&
	    inet_sk_state_load(msk->first) == TCP_CLOSE) {
		if (sock_flag(sk, SOCK_DEAD)) {
			...
		} else if (sk->sk_state != TCP_ESTABLISHED ||
			   msk->in_accept_queue) {
			mptcp_set_state(sk, TCP_CLOSE);
			...
		} else {
			mptcp_start_tout_timer(sk);
		}
    ...
}

The new branch arms the timer in every state except TCP_CLOSE. That
includes msks still in the accept queue and msks that are not
ESTABLISHED.

Take an msk that has not been accepted yet: it is ESTABLISHED, with
in_accept_queue set by mptcp_sk_clone_init(). If the peer sends a FIN
without DATA_FIN on the MP_CAPABLE subflow before accept(), this path
seems reachable:

subflow_sched_work_if_closed()
  -> MPTCP_WORK_CLOSE_SUBFLOW
mptcp_worker()
  __mptcp_close_subflow()
    mptcp_close_ssk()
      __mptcp_close_ssk()
        __mptcp_subflow_disconnect()  /* only tcp_shutdown(), closing = 1 */
        mptcp_start_tout_timer(sk)    /* new branch */

Before this patch, a live in_accept_queue msk never had probe_timestamp
set.

If accept() is not called within close_timeout (60s by default),
mptcp_worker() then calls mptcp_do_fastclose(). With fastclosing set,
__mptcp_close_ssk(..., 0) reaches this code:

__mptcp_subflow_disconnect() {
    ...
		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
		mptcp_subflow_ctx_reset(subflow);
    ...
}

At that point the child socket is still in the TCP listener's accept
queue. Is that sequence safe? Tracing accept() and listener teardown
after it did not show a crash. Still, no pre-patch path did this for
in_accept_queue msks.

Now take an accepted msk that is not ESTABLISHED, for example FIN_WAIT1/2
after shutdown(SHUT_WR), or CLOSE_WAIT, LAST_ACK or CLOSING. The initial
subflow can be shut down instead of disposed through
mptcp_pm_rm_addr_or_subflow(). That happens on a peer RM_ADDR for id 0 or
on a userspace PM subflow destroy. The new branch then waits the full
close_timeout before the fastclose.

__mptcp_finish_join() refuses new subflows unless the msk is
ESTABLISHED:

	if (sk->sk_state != TCP_ESTABLISHED)
		return false;

So nothing can recover the connection during that wait, and send() or
recv() stays blocked for the whole timeout. In the same states, the
branch above closes the msk as soon as the subflow reaches TCP_CLOSE.

This also differs from Documentation/networking/mptcp-sysctl.rst. It
says close_timeout applies "in absence of any close or shutdown syscall"
and "after the last subflow removal".

Could the new branch follow the branch above? That would mean arming the
timer only for an accepted ESTABLISHED msk, not for in_accept_queue, and
closing the other states once the subflow reaches TCP_CLOSE.

If the different handling is intended, could the commit message say so?
It currently only says "start the close timeout, if it is not running
yet". The code comment and the sysctl documentation would also need an
update.

>  	}
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
