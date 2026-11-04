Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812598;
	b=vd046rUhWQu24BbiR/GuETd/gtWBObfOGtBfTC+4ZkGJt9w53uCVaO6cw+I0OtO1utIR
	 9IBqpsRUs45xd4cWJD8YiBgbetCQLhjCsD1zoEAmf+kNYNkFIGkAKCa2C8SkrErKjn3NZ
	 vKNUQzxo7LYAkj7lOmku8KKeXLABZ2851LyxZn00DmXayzNIAKxuXzUbQZspqaZzO/0ve
	 9h2L2KOM1TdIVwONLHrBYDPxVXDgJP2PNN++zEqsFDCelM3sM/oNCZEwZ+Iu6HX1t+d07
	 KUIXDK2vY/WoOzahTrli8j+Q2P/vB42l0PKC/n77JHWhC+hitUVpIiZMjzgF3+MzqtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812598;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0s2nBtbnWuH0ZTycLq7X4He/EdWkh8IOfg7xgNOECno=;
	b=BsfLBMW2Ixv1zgxn00hvR6pC43PsmoBfFvO+sY0IM1RvmcFAdl0qniHFjo1Talxdy2Cu
	 wUdPBSv+my0okiVu2BRHh/wsaL7WwQCBUr/0jXfNZuIRIwzqGlh4BuNzAD1KKyjxCLrzS
	 OFqqsxqvcYW44beBkyoR/OmvHPSH4TtxIN8uzfUkttUOe+tVKmSPxWviUuZ0yQ5qun8Ha
	 2dZ8KDL3ulJ1nycCW+kas0VblVuGXyolown6A7cJKffjmvigwjw934I8wCZvgDXSmy4D4
	 sRsevlnBTk79wHzXaBpkOuuhZ1rHMoKFEHNbe+i/r7PFZw2QdDMM42CR+rAguqQ3iyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IW1IdsIa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7310606A328
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IW1IdsIa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CEF1F000C1;
	Wed,  4 Nov 2026 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793812597;
	bh=0s2nBtbnWuH0ZTycLq7X4He/EdWkh8IOfg7xgNOECno=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IW1IdsIazPL20MGQmzw0XykCFhwHc7X2j8qYOFzgaXLfDjYSVOXmVsdq9O/G3SvVZ
	 rSw7CnZCHaPqVAS26yALjRYY3c39QEuvfBxBjq0zFDaB1GMUJV0e32/S9IZFCBLXlj
	 4psYqAghrsUVR5p3PycbyYMTyF6RKHuefOKjWRFlrgQOotsdOT9PBkgJ4DwMCqslAo
	 yvpncTtnD6sQd0R4rnRAOxUU9BVFjERIlwlsOsnFx7T3nnW6Hcz+OjwuhIXPhP2Vho
	 mPbOBYB9McWKSf/GD0QJDMnhvvdQPHHwpRSurz7CDPGxBSqHSLfNzMNHeto+GHnDwB
	 XRGsGn83kodAg==
Subject:
 Re: [PATCH mptcp-next v5 6/7] mptcp: track app-limited state in mptcp_sendmsg
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Wed, 04 Nov 2026 17:16:36 +0000
Message-ID: <179381259673.488855.3588626927456217680@kernel.org>
In-Reply-To: <eb467edffa6bd66e1c4bcc7939a131066b1c21a6.1793676064.git.tanggeliang@kylinos.cn>
References: <eb467edffa6bd66e1c4bcc7939a131066b1c21a6.1793676064.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "mptcp: track app-limited state in
  mptcp_sendmsg" says mptcp_rate_check_app_limited() bails out on "skbs…
- [Low] The commit author is "Geliang Tang <geliang@kernel.org>", but the
  only Signed-off-by is "Geliang Tang <tanggeliang@kylinos.cn>".
- [Low] mptcp_sendmsg_locked() now calls mptcp_rate_check_app_limited()
  unconditionally (protocol.c:2092).
- [Low] mptcp_rate_check_app_limited() reads msk->cb_flags with
  test_bit(MPTCP_RETRANSMIT, &msk->cb_flags) (protocol.c:2048) without…

--

mptcp: track app-limited state in mptcp_sendmsg

This commit adds mptcp_rate_check_app_limited(). The helper walks every
subflow and calls tcp_rate_check_app_limited() under each subflow socket
lock, unless the msk still has unsent data, pending dfrags or a pending
retransmission. It is called from mptcp_sendmsg_locked() so that BBR and
similar congestion controllers can ignore rate samples taken while the
connection is application-limited.

> The
> helper bails out early when MPTCP still has data to send: unsent data
> (write_seq != snd_nxt), skbs on the send queue (mptcp_send_head), or
> pending retransmission (MPTCP_WORK_RTX or MPTCP_RETRANSMIT flags).

[Severity: Low]
Is "skbs on the send queue" accurate here? mptcp_send_head() returns a
dfrag pointer, not an skb:

net/mptcp/protocol.h:mptcp_send_head() {
	const struct mptcp_sock *msk = mptcp_sk(sk);

	return msk->first_pending;
}

msk->first_pending is a struct mptcp_data_frag pointing at the first
unsent dfrag on msk->rtx_queue. The msk itself has no skb send queue.

The check is still needed even though write_seq != snd_nxt is also
tested. __mptcp_retransmit_pending_data() resets first_pending without
moving snd_nxt:

	msk->first_pending = rtx_head;

Could the message describe this check as pending or re-injected dfrags
at the msk level?

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but this Signed-off-by does not match the author
address "Geliang Tang <geliang@kernel.org>". checkpatch.pl flags this as
a From:/Signed-off-by: mismatch.

Other patches in this series, such as "mptcp: update
mptcp_check_readable", sign off as geliang@kernel.org. Could the trailer
be changed to match the From: address, or a matching Signed-off-by be
added?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b9c7b0bb6f742..c0a0b28f6af16 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2038,6 +2038,26 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
>  	}
>  }
>  
> +static void mptcp_rate_check_app_limited(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> +
> +	if (msk->write_seq != msk->snd_nxt || mptcp_send_head(sk) ||
> +	    test_bit(MPTCP_WORK_RTX, &msk->flags) ||
> +	    test_bit(MPTCP_RETRANSMIT, &msk->cb_flags))
> +		return;

[Severity: Low]
Is it safe to read msk->cb_flags here without the msk data lock? Every
other access to cb_flags in net/mptcp happens under sk->sk_lock.slock and
uses non-atomic read-modify-write. For example, mptcp_retransmit_timer()
does this under bh_lock_sock():

	} else {
		/* delegate our work to tcp_release_cb() */
		__set_bit(MPTCP_RETRANSMIT, &msk->cb_flags);
	}
	bh_unlock_sock(sk);

mptcp_release_cb() is __must_hold(slock), and it clears the bits with:

	msk->cb_flags &= ~flags;

mptcp_sendmsg_locked() only owns the msk (msk_owned_by_me()). The timer
softirq on another CPU can therefore run the __set_bit() at the same time
as this test_bit(). This seems to be the only lockless reader of
cb_flags, and KCSAN may report it.

The check also runs only once, before the subflow loop. If the
retransmit timer fires during the loop, tp->app_limited still ends up
set on every subflow. Taking mptcp_data_lock() here would not close that
window, because the lock cannot be held across lock_sock_fast_nested().

Could the read be annotated as an intentionally racy heuristic, with
data_race() or READ_ONCE()? The other option is to take mptcp_data_lock()
around the msk-level checks.

> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
> +
> +		slow = lock_sock_fast_nested(ssk);
> +		tcp_rate_check_app_limited(ssk);
> +		unlock_sock_fast(ssk, slow);
> +	}
> +}
> +
>  static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -2068,6 +2088,9 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
>  
>  	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
>  
> +	/* is sending application-limited? */
> +	mptcp_rate_check_app_limited(sk);
> +

[Severity: Low]
Does this add a lock round trip per subflow to every sendmsg() on an
idle msk? This call is unconditional. When there is no unsent or
re-injected data and no retransmit flag is pending,
mptcp_rate_check_app_limited() calls lock_sock_fast_nested() and
unlock_sock_fast() on every ssk in msk->conn_list.

Each one costs a spin_lock_bh()/spin_unlock_bh() pair. If the ssk is
owned, it costs a full lock_sock()/release_sock() with backlog
processing instead.

Small-write and request/response workloads usually hit this state on
every call, because the previous send has already been pushed
(write_seq == snd_nxt and first_pending == NULL). The equivalent check
in tcp_sendmsg_locked() is plain arithmetic on a socket the caller
already owns. Here the work is done even when no subflow uses a
rate-sample consumer such as BBR.

The number of subflows is bounded, and __mptcp_push_pending() already
locks subflows on this path, so the impact is probably small. Could the
commit message mention this cost, or include a measurement?

>  	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
>  		ret = sk_stream_wait_connect(sk, &timeo);
>  		if (ret)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793676064.git.tanggeliang%40kylinos.cn
