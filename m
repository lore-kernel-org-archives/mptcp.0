Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8DB4F797E;
	Mon,  7 Sep 2026 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787451; cv=none; b=OcR7kTuuBU1TKqCOXHFjAz50ogLRp+2yrK8BUx2qYrAoaB7qB5uVsFPqC5yuc+qncQO5ngNdeg7rLuIeJ1qiX/q+a63qNtDmcNTyq0Fw/9YMj+UUOr+pjeuS2MBKNfqIZgh5f5xFNs1dmxVfW9SrnkOqhtvF3kjnB+VtQBHRGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787451; c=relaxed/simple;
	bh=VOlppPcAZaihuaybY3MbXojKeN0i17vEAfbdDCdlvuw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZC3m58wZyN2HkvpQjbUQ0MsZLSQEBzeviX3hh5Uo96Vg2iDDZ6emosaoY1tIM/L4SrWmFB8ALa3eaAbqEdxlYXIQAb2+USxHaFYql186uyUdkBT/EiZ4RmpfaDRtpW6vUSg94J3+ztGY3sb6pRBr7xdae4whJ7SmhK/Rpvg2Z9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Sz0fUd9E; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Sz0fUd9E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788787429; x=1789046629;
	bh=hnfY5g75qigvrd0jz2ODhHdnwo4ylq3b80QtLQG7WnI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Sz0fUd9EhJMPyRuALvCe32NE28SFMKTj1sfqywMEzai31yJm4m1AWa4X56Okp73Uz
	 Q44gP/t8L1nKLltB5e7+RPDWWq63vWgaqJtw4XVfIY5ihUOoAX10BBLz0g9o1vY0Kz
	 3M+FwMAeAbGgIxbVJrAsrB9m+VkNZtU+pcuJZ6y/ubwx7Xud7IL9H3EDR5RjGNZDzP
	 yJZFsLBFXO8MDbfufMDQWdpC5w25X+tVkXP9QHl9FBpz/VXjkc4vvW2nBzjnxZuBxv
	 W8XlFUUs4zEG9miFoFToBNbRuUnmv60yA+C6JGCBcf+jeU8JougGjQ6BagpJjfXDhu
	 1vou9WEUlN3ng==
Date: Mon, 07 Sep 2026 13:23:44 +0000
To: sashiko-reviews@lists.linux.dev
From: quanyeyang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v3 3/3] tcp: fix data-race in do_recvmmsg / mptcp_recvmsg
Message-ID: <BRjPl-qSRxy3Fx7z3OYPbh_uVGAO2xAiTOEhENKwfmLBuZLMw6Gdmlc2zip02u5tK-JJY197mUzv4YjtBk_lTq6Agc80Kj48b6owoUA2_yI=@proton.me>
In-Reply-To: <20260907102447.4C55E1F00A3A@smtp.kernel.org>
References: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me> <20260907-mptcp-snd-una-race-v3-3-65ba0d5f0221@proton.me> <20260907102447.4C55E1F00A3A@smtp.kernel.org>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: c523e9205894885af1a3a5eff0a6b5ae23752976
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, September 7th, 2026 at AM 3:24, sashiko-bot@kernel.org <sashiko-=
bot@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] Incomplete fix for `sk->sk_err` data race leading to false EOFs.=
 The patch fixes a lockless data race in `tcp_recv_should_stop()` by adding=
 `READ_ONCE()`, but overlooks identical plain reads followed by `sock_error=
()` in `tcp_recvmsg_locked()`, `tcp_splice_read()`, `mptcp_recvmsg()`, and =
`tcp_bpf_sendmsg()`. If `sk->sk_err` is checked and evaluates to true, but =
is concurrently cleared to 0 by another thread calling `sock_error()` (e.g.=
 via `do_recvmmsg` or `getsockopt(SO_ERROR)`), the subsequent assignment `c=
opied =3D sock_error(sk)` will evaluate to 0. For receive and splice functi=
ons, this results in returning 0, which falsely signals a graceful connecti=
on closure (EOF) to the application rather than an error.
> --
>=20
> commit 0f561938f67b19245ef8889cb9ecc077fb82d7d0
> Author: Quanye Yang <quanyeyang@proton.me>
>=20
> tcp: fix data-race in do_recvmmsg / mptcp_recvmsg
>=20
> This commit fixes a lockless data race in tcp_recv_should_stop() by using
> READ_ONCE() for reading sk->sk_err. This prevents issues when sock_error(=
)
> atomically clears the error using xchg() without holding the socket lock.
>=20
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 436495ff2271d..c61d8678eafd3 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -3082,7 +3082,8 @@ enum skb_drop_reason tcp_inbound_hash(struct sock=
 *sk,
> >
> >  static inline int tcp_recv_should_stop(struct sock *sk)
> >  {
> > -=09return sk->sk_err ||
> > +=09/* sk_err can be cleared locklessly by sock_error(). */
> > +=09return READ_ONCE(sk->sk_err) ||
>=20
> [Severity: High]
> This is a pre-existing issue, but does this fix also need to be applied t=
o
> other locations that read sk->sk_err locklessly?
>=20
> If sk->sk_err is evaluated as non-zero, but the error is concurrently cle=
ared
> by another thread calling sock_error() (for example, via concurrent recvm=
msg
> or getsockopt calls), a subsequent call to sock_error(sk) will return 0. =
This
> masks the socket error and falsely signals a graceful connection closure =
(EOF)
> or 0 bytes sent.
>=20
> This pattern appears to be present in several other functions:
>=20
> net/ipv4/tcp.c:tcp_recvmsg_locked() {
> ...
>     if (sk->sk_err) {
>         copied =3D sock_error(sk);
>         break;
>     }
> ...
> }
>=20
> net/ipv4/tcp.c:tcp_splice_read() {
> ...
>     if (sk->sk_err) {
>         ret =3D sock_error(sk);
>         break;
>     }
> ...
> }
>=20
> net/mptcp/protocol.c:mptcp_recvmsg() {
> ...
>     if (sk->sk_err) {
>         copied =3D sock_error(sk);
>         break;
>     }
> ...
> }
>=20
> net/ipv4/tcp_bpf.c:tcp_bpf_sendmsg() {
> ...
>     if (sk->sk_err) {
>         err =3D -sk->sk_err;
>         goto out_err;
>     }
> ...
> }
>=20
> Would it be appropriate to update these instances as well to prevent
> Time-Of-Check to Time-Of-Use races?
>=20
> >  =09       sk->sk_state =3D=3D TCP_CLOSE ||
> >  =09       (sk->sk_shutdown & RCV_SHUTDOWN) ||
> >  =09       signal_pending(current);
>=20
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-mptcp-sn=
d-una-race-v3-0-65ba0d5f0221@proton.me?part=3D3
>=20

Thanks for the review.

The TOCTOU issue is valid, but it is separate from the reported KCSAN
race fixed by this patch. tcp_recv_should_stop() only peeks at sk_err
after data has already been copied, so READ_ONCE() is appropriate there
and the error must not be consumed.

For the no-data paths, the correct approach is to call sock_error()
once and only stop when it returns a non-zero error. This avoids
returning a false EOF if another thread consumes the error between the
check and sock_error().

The BPF function is tcp_bpf_recvmsg_parser(), not tcp_bpf_sendmsg().
There are also additional instances, including mptcp_splice_read() and
the LLC receive path, so updating only the locations listed above would
still be incomplete.

I will audit these check-then-sock_error() patterns and handle the
pre-existing TOCTOU issue separately, unless the maintainers prefer it
to be included as an additional patch in v4.

Thanks,
Quanye

