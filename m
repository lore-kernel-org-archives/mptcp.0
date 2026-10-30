Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793392976;
	b=41rPFp+/mxouoBIp+30b7CUfb0oWxtf5jIh0iCTPWdMSCFsilnFNPjWCjpK5oqOEy6x1
	 kV67aSJU6mFAa2+bXoYE3+s8ezSZEMBxL3WycjbAkEYhkzlpIDWdl2M4iBsaRnRBM7UNG
	 pr2Snfrpee3qbxiax0Sf7Df2PBSTr3KRVAbSwn1GV+qnFDixXHUTqNMVwJDn4ExFjD88W
	 R7ZtYJW7jZpOvR8e6PEM9FwREpQlZTJv7vFk9N2rCbY+Y/lRNp1n7CdQZN+9n6viODFbw
	 xPjwRXtyzLIIGS9ChpwqaRpblS0As0cd/7wFqFPfLMdSgP2TB119uSxphdkk4hxsAbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392976;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=US/20UB5NNid0dhP8KSySJMx+cZk10ysBLsN5yaGCM4=;
	b=OdzZCEYfQVrSoSmZoLraFRYylZiXRf+TQxxV9Bt1a6Gv4OvNLW0dB8qnuuPDrbcazjHv
	 qg0+o+B1RasH6yfHD5+gREQYphVTiY95C+tp2uO1cUPDHUAuBm7V6Wu0zVbV0fSntvPh3
	 IF5Z4XocIsyh14R8WoMgOtKtzwqXRGV+2UPfWuxgGjtvlnJrGd8FrFZmoVltLW9a6TV7I
	 6cGehKmY0rqSaxSPgBtQKHZLwsDLuUPva83bp3IdmonTHtgymo1ZmnwsULmFw9iJiA3T8
	 KY8dhbJ/pANVrv/PXBkDzDZSh/MaT6K0ZSVUlPZmGAevjgVRebZhv9t1BZbPsp8Gk5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mv3bYv+S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A0606A31D
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mv3bYv+S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1721F000C1;
	Fri, 30 Oct 2026 20:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793392975;
	bh=US/20UB5NNid0dhP8KSySJMx+cZk10ysBLsN5yaGCM4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mv3bYv+SBiGpExxMoSE3JIFbFJustjjQOyF8JFYMd3atj63rmlcVnPuVEpyGDyHeU
	 xSCp6hyGXbYnh7nr4jFEMrldqQww5sotQk3AX2dnl1NtX0aGQgAfFnnB7DEMuDXtA6
	 gzq5iJm0Q7AQGXxCCyF39oOTOo3Jk/wksmLMTW2NibyJBV8k1zOSe1XSFPOixdmjLl
	 7nMoul0GNzw8hoILwD+69JuylvWMOeFE28F4WIBL8WlIKx9924edwajNBUX6RdCwjV
	 bE3YNLS1TsCrzXknA2P1ek7pNXpsJABYRuHvHz5Ucq+zBMnrPlbrVr+1/+WPoKcb5T
	 dUewiIqYi0ewA==
Subject:
 Re: [PATCH mptcp-next v16 4/4] mptcp: defer read_sock cleanup to mptcp_worker
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, kuba@kernel.org
Date: Fri, 30 Oct 2026 20:42:54 +0000
Message-ID: <179339297485.3132.16698578134958675448@kernel.org>
In-Reply-To: =?utf-8?q?=3C636807b42883e8ec741f2535293e02ff751af276=2E1793255?=
 =?utf-8?q?126=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C636807b42883e8ec741f2535293e02ff751af276=2E17932551?=
 =?utf-8?q?26=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes a BH call path that does not
  exist in this tree.
- [Medium] The deferral in __mptcp_read_sock() is unconditional, so it
  changes every real caller, all of which run in process context with…

--

mptcp: defer read_sock cleanup to mptcp_worker

This commit moves the mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf()
calls out of __mptcp_read_sock() and into mptcp_worker(). It adds a
msk->read_copied accumulator and a MPTCP_WORK_READ_COMPLETE flag. It also
drops the backlog flush from mptcp_recv_skb() and the msk_owned_by_me()
assertion in __mptcp_read_sock().

> When MPTCP carries TLS, __mptcp_read_sock() is reached from BH context
> (via tls_strp_read_copyin() -> sk->sk_read_sock()), where calling
> mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() is not safe as both
> expect process context.

[Severity: Medium]
Does this call path exist in the current tree? tls_strp_read_copyin()
calls tcp_read_sock() directly, not through an indirection:

net/tls/tls_strp.c:tls_strp_read_copyin() {
    ...
	/* sk should be locked here, so okay to do read_sock */
	tcp_read_sock(strp->sk, &desc, tls_strp_copyin);
    ...
}

There also doesn't seem to be an sk_read_sock hook anywhere in
include/net, net/tls, net/mptcp or net/ipv4.

kTLS also can't be attached to an MPTCP socket right now, because
mptcp_setsockopt_sol_tcp() rejects TCP_ULP:

net/mptcp/sockopt.c:mptcp_setsockopt_sol_tcp() {
    ...
	case TCP_ULP:
		return -EOPNOTSUPP;
    ...
}

The other read_sock users don't seem to reach MPTCP from BH either:

- strparser is only reachable through KCM and sockmap. KCM only accepts
  IPPROTO_TCP. Sockmap rejects mptcp_prot because it has no
  psock_update_sk_prot.
- The NVMe-TCP host creates IPPROTO_TCP sockets and calls read_sock
  under lock_sock().

The new "Can be invoked in BH scope" note in __mptcp_read_sock() and the
removed msk_owned_by_me() also point to a BH caller that doesn't exist
yet.

Is this patch groundwork for a later TLS-over-MPTCP series? If so, could
the commit message say that and name the series it depends on? As
written, it reads like a fix for a context bug that can be hit today, so
it could get backported on its own.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index bbce1bafa40ee..322d7a5ba0b80 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4659,11 +4675,14 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	if (noack)
>  		goto out;
>  
> -	mptcp_rcv_space_adjust(msk, copied);
> -
> +	/* The backlog flushing is only needed when some data is actually
> +	 * moved and will take place in mptcp_release_cb() via
> +	 * release_sock() in the worker.
> +	 */
>  	if (copied > 0) {
> -		mptcp_recv_skb(sk, &offset);
> -		mptcp_cleanup_rbuf(msk, copied);
> +		msk->read_copied += copied;
> +		set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
> +		mptcp_schedule_work(sk);
>  	}

[Severity: Medium]
This deferral applies to every caller of __mptcp_read_sock(). All of the
current callers run in process context and own the msk. Is the change in
behaviour for them intended?

Before this patch, every read with copied > 0 ran
mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() inline.
mptcp_cleanup_rbuf() reaches tcp_cleanup_rbuf() on each subflow via
mptcp_subflow_cleanup_rbuf(). That sends the window update once the
reader has freed space.

Now each chunk costs a sock_hold() and a schedule_work(). The real work
only runs after mptcp_worker() takes lock_sock(sk).

mptcp_splice_read() holds the msk lock for the whole call. Between chunks
it only does this:

net/mptcp/protocol.c:mptcp_splice_read() {
    ...
		release_sock(sk);
		lock_sock(sk);
    ...
}

The splicer can retake the lock before the woken kworker gets it. For
splice() users, would window-update ACKs and rcvbuf autotuning then wait
until the splice call finishes or blocks, plus workqueue latency?

Autotuning samples are also now taken when the worker runs, not when the
data is read. The rcvq_space.time and mptcp_inq_hint() values that
mptcp_rcv_space_adjust() sees could skew the rate estimate.

mptcp_recvmsg() still does both steps inline, so the two read paths now
behave differently. The commit message only covers the BH caller and
doesn't mention splice() or read_sock.

Would it work to defer only when the caller doesn't own the msk, and keep
the inline calls otherwise?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793255126.git.tanggeliang%40kylinos.cn
