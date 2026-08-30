Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E11F1537
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101408; cv=none; b=RxZaT+qrqJ3kZMapvjv3UU2WocWMNig4GMLqHX9oRjRtnBC532qzYM+5rF1kEBu/5bwKGGrWoenxv67CJoeJVxmSuxuqzyJ+jFnaBSuBXqGvJE4psecaoYfIoUpGOHkU7v37NyOummDMXjV/Vzga2EhGDi3iIjtW3rD4J2zPqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101408; c=relaxed/simple;
	bh=8RMt/IppJsb6f7o8qZ7DUquUbhKyFb+w9FjZKgCYhMM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZszqDltkGuJX7Z1mPqaj+un2lzCEkLLbZNGZfZ+Fk5PJaYmtUW1cXbxOCR+eBv7SDDyCQe989u5MW0mXKrYtiKiO3VLah33d4uizTPULH6SwD7wJFJNzvTI47jKhYPQwGKa3Boh7Z7gUroxQCIN3DRS1PyehF1sRpXirZtP5Q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B33860Lx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B33860Lx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8DD1F000E9;
	Sun, 30 Aug 2026 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788101406;
	bh=T1QGdnNsRpWck6aNhigVQ0BBk3gRXbRsg9LIgRHZE5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B33860LxXRVed5UCJv0e5kZd04idraUGDjq0BfQQTZ6q1PyAdPXr0rZ1fw03Pfvdd
	 MXP1OgsU9M5xZw15cXlXv3gT2cwcfHR1jWXu+ChdfGXpe7b4Ud21VJfhJgzNlOCoQu
	 qss2njdTMcew6LxeWs4CwQUTGkLreLQ9KQv4mcdbYY0eKTS2WKVb/hdDA4zHWOt5zl
	 ueI4HkHkBeNv+F1/ABs8EuD2ukYamhDCwDOOX73SatrRosC2iV0kRG/rV81crriGzl
	 CM1/jm1r7EaBrPIgVgurF0XhMUwOmwgj1W713WIJU0/2pmLwYXKUZYfxZZc3JdkCZ9
	 gw/RhoISgX8CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v11 07/10] mptcp: implement peek_len for
 proto_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <5333db5976d6a9fbfd18fb33eb017d7ab30d0f45.1788099847.git.tanggeliang@kylinos.cn>
References: <cover.1788099847.git.tanggeliang@kylinos.cn>
 <5333db5976d6a9fbfd18fb33eb017d7ab30d0f45.1788099847.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:50:05 +0000
Message-Id: <20260830145006.4A8DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing memory barriers between `ack_seq` and `SOCK_DONE` updates =
in `mptcp_check_data_fin()` and their lockless reads in `mptcp_inq()` allow=
 `mptcp_inq()` to observe `SOCK_DONE` without observing the `ack_seq` incre=
ment, leading to an under-reporting of available data.
--

commit 3b3f825ecdc0054e45c6ee37b3404a7c1aeaead3
Author: Geliang Tang <geliang@kernel.org>

mptcp: implement peek_len for proto_ops

This commit introduces mptcp_inq() to compute readable bytes at the MPTCP
level using ack_seq and copied_seq. It returns 0 during handshakes and
subtracts 1 if a FIN is received (SOCK_DONE flag is set), mirroring
tcp_inq(). It is wired up as the .peek_len proto_op.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2c0822ef4ae3b..81452a2b6fd0c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -4809,6 +4809,37 @@ static ssize_t mptcp_splice_read(struct socket *so=
ck, loff_t *ppos,
>  	return ret;
>  }
> =20
> +static int mptcp_inq(struct sock *sk)
> +{
> +	const struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	int answ;
> +
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
> +		answ =3D 0;
> +	} else if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +		answ =3D 0;
> +	} else {
> +		u64 hint_val;
> +
> +		hint_val =3D READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq);
> +		if (hint_val >=3D INT_MAX)
> +			hint_val =3D INT_MAX;
> +
> +		answ =3D (unsigned int)hint_val;
> +
> +		/* Subtract 1, if FIN was received. Mirror tcp_inq() */
> +		if (answ && sock_flag(sk, SOCK_DONE))
> +			answ--;

[Severity: High]
Could this lockless read observe SOCK_DONE without observing the updated
ack_seq?

In net/mptcp/protocol.c:mptcp_check_data_fin(), the write side updates
ack_seq and SOCK_DONE without a separating memory barrier:

    WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
    WRITE_ONCE(msk->rcv_data_fin, 0);

    WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
    sock_set_flag(sk, SOCK_DONE);
    smp_mb__before_atomic(); /* SHUTDOWN must be visible first */

If mptcp_inq() is called locklessly (e.g., from strp_data_ready) concurrent=
ly
with mptcp_check_data_fin(), could the lack of an smp_wmb() on the write si=
de
and an smp_rmb() on this read side allow the CPU to reorder operations?

If mptcp_inq() reads SOCK_DONE as true but reads the old, un-incremented
ack_seq, it would calculate the available bytes and erroneously subtract 1.

If only 1 byte of payload remains, returning 1 byte less causes it to return
0. This could cause the upper layer (like TLS or BPF sockmap/strparser) to
skip waking up the process, resulting in an infinite wait for data that will
never arrive. This could be triggered remotely by network traffic (a data F=
IN
packet) on an MPTCP socket, leading to a denial of service.

Should there be an smp_rmb() added here before checking SOCK_DONE, and an
smp_wmb() added to mptcp_check_data_fin() after incrementing ack_seq?

> +	}
> +
> +	return answ;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788099847.gi=
t.tanggeliang@kylinos.cn?part=3D7
