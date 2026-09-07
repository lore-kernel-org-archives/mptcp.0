Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530B4657C6
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776690; cv=none; b=t6DFl1Hxc7WBT86xZtZrwHkioT/IQ6pPBoOBGd9j8j6pUFbKNR3SLqVUIOwPgXR3223N0eMG7sPIMbLFjcRoBEzcUrW9FVrdtHOwnkorft16F/dbi+S2lcGfNdty4G2yxr6fp51mkKsMdP2LDJgcXb4wgFzk6iCJB4CCeRVMyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776690; c=relaxed/simple;
	bh=Wt0NUwcMAvd2XpqU4nLOxG9+bGJHbsJMcS8cVwyRBac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hi7Jrpx9VNf25nI38iLeGSPVNAag2jclHJ4X412tw4QnMKZMgoRzkUyA8D3nmuQKmUrp+Q1RUBcCig3EBnLIxaK7C/fki8tbnjr2x6SkRHDLXwuTFn68kkCx4n5RKLPHUU1XUPwkLP9OYKg3iP+9nhkQHx/JZ2nSaLYH4pY42Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noYvuZ5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noYvuZ5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C55E1F00A3A;
	Mon,  7 Sep 2026 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776687;
	bh=dRGKrIypA1nE8PaFORmx7sK0ge4HLUaFueAff6K7hco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=noYvuZ5jGkfYlMtUkTP6lV7m57Y2crMzaU1crKZjkCkjJ3sCuXLnaNqhnLW0cL90S
	 hiM8G4gqCgJBnB4TKk3UL3iqi0dXvflIwpKXk/ys3gYMrH+FrcuEko3MMxe61DngbF
	 IP5dNKuFI/oqpSOi5Ms9W/td+b6A4wjKnaAp1BhPzuyuZRiWCPl9zsQch6CJH646ce
	 zbGDCYGVVCvCMMIAfkVKAtgG5oGiaubknOV6SOdXxkRpT8zo1bPZ+EiTCPYyCU53NA
	 RbMakvxhX0dDbPB+DkOsBvXEOvO2c/1roBhBjtcU1sCXpH1eOsq7NR187OLoJWbRs4
	 kPFQMsN55hetg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net v3 3/3] tcp: fix data-race in do_recvmmsg /
 mptcp_recvmsg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Quanye Yang" <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260907-mptcp-snd-una-race-v3-3-65ba0d5f0221@proton.me>
References: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me>
 <20260907-mptcp-snd-una-race-v3-3-65ba0d5f0221@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:24:46 +0000
Message-Id: <20260907102447.4C55E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for `sk->sk_err` data race leading to false EOFs. T=
he patch fixes a lockless data race in `tcp_recv_should_stop()` by adding `=
READ_ONCE()`, but overlooks identical plain reads followed by `sock_error()=
` in `tcp_recvmsg_locked()`, `tcp_splice_read()`, `mptcp_recvmsg()`, and `t=
cp_bpf_sendmsg()`. If `sk->sk_err` is checked and evaluates to true, but is=
 concurrently cleared to 0 by another thread calling `sock_error()` (e.g. v=
ia `do_recvmmsg` or `getsockopt(SO_ERROR)`), the subsequent assignment `cop=
ied =3D sock_error(sk)` will evaluate to 0. For receive and splice function=
s, this results in returning 0, which falsely signals a graceful connection=
 closure (EOF) to the application rather than an error.
--

commit 0f561938f67b19245ef8889cb9ecc077fb82d7d0
Author: Quanye Yang <quanyeyang@proton.me>

tcp: fix data-race in do_recvmmsg / mptcp_recvmsg

This commit fixes a lockless data race in tcp_recv_should_stop() by using
READ_ONCE() for reading sk->sk_err. This prevents issues when sock_error()
atomically clears the error using xchg() without holding the socket lock.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 436495ff2271d..c61d8678eafd3 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -3082,7 +3082,8 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *=
sk,
> =20
>  static inline int tcp_recv_should_stop(struct sock *sk)
>  {
> -	return sk->sk_err ||
> +	/* sk_err can be cleared locklessly by sock_error(). */
> +	return READ_ONCE(sk->sk_err) ||

[Severity: High]
This is a pre-existing issue, but does this fix also need to be applied to
other locations that read sk->sk_err locklessly?

If sk->sk_err is evaluated as non-zero, but the error is concurrently clear=
ed
by another thread calling sock_error() (for example, via concurrent recvmmsg
or getsockopt calls), a subsequent call to sock_error(sk) will return 0. Th=
is
masks the socket error and falsely signals a graceful connection closure (E=
OF)
or 0 bytes sent.

This pattern appears to be present in several other functions:

net/ipv4/tcp.c:tcp_recvmsg_locked() {
...
    if (sk->sk_err) {
        copied =3D sock_error(sk);
        break;
    }
...
}

net/ipv4/tcp.c:tcp_splice_read() {
...
    if (sk->sk_err) {
        ret =3D sock_error(sk);
        break;
    }
...
}

net/mptcp/protocol.c:mptcp_recvmsg() {
...
    if (sk->sk_err) {
        copied =3D sock_error(sk);
        break;
    }
...
}

net/ipv4/tcp_bpf.c:tcp_bpf_sendmsg() {
...
    if (sk->sk_err) {
        err =3D -sk->sk_err;
        goto out_err;
    }
...
}

Would it be appropriate to update these instances as well to prevent
Time-Of-Check to Time-Of-Use races?

>  	       sk->sk_state =3D=3D TCP_CLOSE ||
>  	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
>  	       signal_pending(current);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-mptcp-snd-=
una-race-v3-0-65ba0d5f0221@proton.me?part=3D3
