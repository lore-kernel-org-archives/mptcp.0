Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812263;
	b=Qp1Bg7emeVecamCzf3el86Iv5+crEsSSut341qIeG6qDm/msoZn5WxYIhnkLjgc5Wiln
	 7PPjnwj/citxT/1LykHhr1wPea3bfoaiRgW8ZE7DXBYlKWMFYaIPm847J5DG3Vb+MSt0L
	 aPpLTOsh73B9uztsmBeCuiZFGM+Ip6mYISVg/H7Qc6DJlrX+jjJiO8o7cFqgo3M8aOSz+
	 bn/Zr4RqgdX3Q2I98c7OaCAuDbyTw9j0w5adknG8xp6GMeuJWaIh29G5vWIToOUGA13af
	 mLK26Ql//KvEKPP+1M1wBkNvqv1fjQm6Pif9bxklBAS0DqRAA06NIfl48TuK/XSaz3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812263;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I8xwGjkoaobcPtNmikw6s/1uAJoHHp5sldxMfV2CxPs=;
	b=VtS+S7NC6Yh7ucn9VzZlnMYNcYve3e2BkD0V00K76GlzTfWR1nKsYiBowBAhTz0I2JTh
	 oCnZjhSBI/xzug0o27puSBZNxUMFVWGzr7bjTDU3iAJ+JUnnQ+BVPaj/2VSiK0XW3l9sh
	 Haml7nYorRvDSjC2MPco3utNHqUFvUUMgTeUpMBd37Iv61uhF6oR+kbUXgv5gELyOexO8
	 3mpERPGgzF0U7VZ6o1sjCtfnwojMjY3auHyU4FvfnfXlhFK9gClFE8TZKqU1NYD71Di+X
	 QRXN0MF92hHbC9i5yf1QLupUiRrIZ6/X+n7Vxl5cQhahm35AfPdkjkpbcSQMZeXpNzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ap5g3md/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936C0606A32A
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ap5g3md/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB6E1F000C4;
	Mon, 16 Nov 2026 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812263;
	bh=I8xwGjkoaobcPtNmikw6s/1uAJoHHp5sldxMfV2CxPs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ap5g3md/SBgvPFaZ2eib5jMqJVxd2VmFjRG3xnKJi7694ALJFbtvrWnmSE/7iaVOK
	 5Cq9vjAKBkDcg48InBDEJYkNbjc2GS1NW8YKvBOsETnuMG3cSeHcVayVd16jPulRoY
	 NwUQ/5vBrgAeQQHi1E2JOP8U6faS6E+i773e5w/EXUvAJq3iFchS53FJqBHU7HSvYq
	 FliVwHcJCj+vCez2coRLl+qCcvVUAPMRSXl8Qu7WhNRHPHIz+UBJW5qB0yHVzG2ckn
	 WlbCd0j3WU1nnqa+djPjSYzMHoFutkxNcf8olrI4nZyETjlNLSeJJwk+H0EImCpopv
	 HyeCVeq3TRMVg==
Message-ID: <sashiko-outbox-216349@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v28 02/11] selftests: mptcp: connect: check
 TFO SIOCINQ overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <b10fc6fab784ca954d079569f58ed19155961e5d.1794810809.git.tanggeliang@kylinos.cn>
References: <cover.1794810809.git.tanggeliang@kylinos.cn>
 <b10fc6fab784ca954d079569f58ed19155961e5d.1794810809.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:57:42 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests: mptcp: wrong tcp_inq.last check in
  do_recvmsg_cmsg()
--

commit 433dfaca5d6ee692d7ae8856021861abcc097f8b
Author: Geliang Tang <geliang@kernel.org>

selftests: mptcp: connect: check TFO SIOCINQ overflow

This commit adds a SIOCINQ overflow check in mptcp_connect's server mode
when MPTFO is enabled and updates TCP_INQ EOF tracking in
do_recvmsg_cmsg().

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..3ae018a2a2155 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
[ ... ]
> @@ -571,6 +575,10 @@ static ssize_t do_recvmsg_cmsg(const int fd, char *b=
uf, const size_t len)
>  			} else {
>  				tcp_inq.expect_eof =3D true;
>  			}
> +		} else if ((size_t)ret < len &&
> +			   last_hint =3D=3D (unsigned int)ret &&
> +			   tcp_inq.last =3D=3D 0) {
> +			tcp_inq.expect_eof =3D true;
>  		}
>  	}

[Severity: Medium]
Should this check tcp_inq.last =3D=3D 1 instead of tcp_inq.last =3D=3D 0?

When the receive queue is drained after DATA_FIN (RCV_SHUTDOWN),
mptcp_inq_hint() returns 1, whereas it returns 0 when the receive queue
is empty on a still-open connection:

net/mptcp/protocol.c:mptcp_inq_hint() {
    ...
	if (!hint_val &&
	    (sk->sk_state =3D=3D TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
		return 1;

	return (unsigned int)hint_val;
}

If a read partially consumes the queued data (setting last_hint =3D N) and
the next read drains the remaining N bytes before the peer's next write
arrives, tcp_inq.last is 0 while the connection is still open.  Setting
tcp_inq.expect_eof =3D true here causes the next do_recvmsg_cmsg() call
that receives subsequent data to abort the test with xerror("expected
EOF..."), while actual EOF after DATA_FIN sets tcp_inq.last =3D 1 and
never matches this branch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794810809.gi=
t.tanggeliang@kylinos.cn?part=3D2
