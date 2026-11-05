Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793861744;
	b=RHfwdaRYFxV6q9W/VZDyM5eIZEZCiLi6zxv/FssiYEnJlRo4zQEg11TyHvTP/FQZrRoV
	 3KmdD9l/1ybdZCAmcUnS4KcAzlQr/8Ii/IzxXqwPVZX+nsnxPOdDz2vlr7fTZry01fhJB
	 GpjUFvZW0tfjUF6Dpx+SuGMFrypD/6nHPlLzWergUsndz68zBmwnj5XkPYZOwl1YtTSey
	 l2AYDSRPDl2vzsU9PQ8wX5EU2X/76IoY8/NskuOdOOmptwzuJgU4eaHQcRc6Z4gSvD+O5
	 YA2yk7VloZ+azla8k+yL+m/ou36UeJ00XVFJ8xfBSr1XSd1TcQXt1vfrPeDDIFTV2Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793861744;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PR1szi1FsbMgnppLjUeXzfoB7CUZg9jZt4Ru4bmT4kQ=;
	b=3QQfDi8cWxTI5TqkJUsq2syPRXX5Ccpf22PeI3bNt+GncehaedJep8+R2RRIkqWA8tc6
	 DoGMxJD2MaF0ZPzGKvafAxfLVyDuVX7JwRiTzHnPONS736avLCdt0RG/ty6xJ/TVVzr8v
	 rKvdHtMiqIW918jnc5/H22LTdAOR5suPHKVcPtzVVwxcsR3On8zLniEpkZdK+pyUksRuy
	 KxbN5bOKdgpaj+b/1XaakxqPUU0pcLaGr2L5CH9nfjhuXRtJYz9hIGYps8lHVCf6Tjbkf
	 UwFa67FNC1NPwWK1fUNeqM6L5ZwWIVYDEUEZIcskoeMde575kDu0JRADDpYOWYYthbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rvepu4mw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9C606A326
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rvepu4mw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F431F000C1;
	Thu,  5 Nov 2026 06:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793861743;
	bh=PR1szi1FsbMgnppLjUeXzfoB7CUZg9jZt4Ru4bmT4kQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Rvepu4mwxPymdrTiAHi+VZUmYAUihm9a4RVvM3wMt4VP2lyiPTCZfGx9jmqPf2wnR
	 DoxCQHHXrwqUoTydngbsikcfPlQXYoCqNy4hVsM0TOcpgFok4Rj4y8KhHMEW/T27h4
	 /ofbEB5+oUIQVFnmgyp4F7Ad4c84XGjomAaK3WYWE3ZNYbPmW36IQuhdwe9lOJG3qU
	 Wl5dseaS3IQV8WDbDrCVNbPBjA9xEm/GlwEMGmNglNpDtnikT1HNPOcCclXiGMJkCG
	 ry82Q0P9zszgPD0A/yImnllE7gNM4Si99xZW1r0dZbusQL7k4RiqZx2UL6O1/X8r9X
	 +2mtOq+rmzfeQ==
Message-ID: <sashiko-outbox-198640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v6 3/7] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <da22fd79c625e4eed90e83cf91bdddcb165a4a78.1793860134.git.tanggeliang@kylinos.cn>
References: <cover.1793860134.git.tanggeliang@kylinos.cn>
 <da22fd79c625e4eed90e83cf91bdddcb165a4a78.1793860134.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 06:55:42 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests: mptcp: commit message mismatch on polling remotesock =
in main_loop_s()
- [Medium] selftests: mptcp: SIOCINQ check in main_loop_s() races with TFO =
third ACK
--

commit d076cef4545cfcddd6e28fb675be9a4054df1b3b
Author: Geliang Tang <geliang@kernel.org>

selftests: mptcp: connect: check TFO SIOCINQ overflow

This commit adds a SIOCINQ check in mptcp_connect's server mode when the
MPTFO socket option is enabled to detect TFO SIOCINQ overflow regressions.

>     selftests: mptcp: connect: check TFO SIOCINQ overflow
>    =20
>     Add a check in mptcp_connect's server mode to detect TFO SIOCINQ over=
flow.
>     When a TFO connection is accepted, poll for data to arrive, then chec=
k if
>     SIOCINQ returns INT_MAX. This detects the regression where mptcp_inq_=
hint()
>     incorrectly returns INT_MAX for passive TFO connections.
>    =20
>     The check runs when the MPTFO sockopt is set. It polls the accepted s=
ocket
>     for up to one second, then uses ioctl(SIOCINQ) to verify the available
>     byte count. If SIOCINQ returns INT_MAX, the test fails.
>    =20
>     This test verifies the fix in the preceding commit "mptcp: fix TFO SI=
OCINQ
>     overflow in mptcp_inq_hint".
>    =20
>     Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Medium]
Does the commit message match the actual code in main_loop_s()? The commit
message states in two places that the test polls the accepted socket for up=
 to
one second before calling ioctl(SIOCINQ), whereas main_loop_s() in
tools/testing/selftests/net/mptcp/mptcp_connect.c invokes ioctl(remotesock,
SIOCINQ, &avail) directly without calling poll().

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..83db495704fec 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1207,6 +1207,17 @@ int main_loop_s(int listensock)
>  		check_sockaddr(pf, &ss, salen);
>  		check_getpeername(remotesock, &ss, salen);
> =20
> +		if (cfg_sockopt_types.mptfo) {
> +			int avail;
> +
> +			if (ioctl(remotesock, SIOCINQ, &avail) =3D=3D 0 &&
> +			    avail =3D=3D INT_MAX) {
> +				fprintf(stderr, "TFO SIOCINQ overflow\n");
> +				close(remotesock);
> +				return 1;
> +			}
> +		}

[Severity: Medium]
Can this SIOCINQ check in main_loop_s() race with the TFO third ACK and miss
the overflow regression on unfixed kernels?

When a passive MPTCP Fast Open SYN+data packet with a valid cookie arrives =
in
tcp_conn_request(), the child msk is created via:

  tcp_try_fastopen()
    -> tcp_fastopen_create_child()
      -> subflow_syn_recv_sock()
        -> mptcp_sk_clone_init()

At that point mp_opt->suboptions only has OPTION_MPTCP_MPC_SYN (not
OPTION_MPTCP_MPC_ACK), leaving msk->ack_seq at 0. Next, af_ops->send_synack=
()
calls subflow_prep_synack() -> mptcp_fastopen_subflow_synack_set_params() in
net/mptcp/fastopen.c:

	MPTCP_SKB_CB(skb)->map_seq =3D -skb->len;
	MPTCP_SKB_CB(skb)->end_seq =3D 0;
	...
	__skb_queue_tail(&sk->sk_receive_queue, skb);

Then tcp_fastopen_create_child() immediately adds the child socket to the
listener accept queue via inet_csk_reqsk_queue_add() and wakes the listener=
 via
sk->sk_data_ready().

Before the client receives the SYN-ACK and replies with the third ACK carry=
ing
OPTION_MPTCP_MPC_ACK, msk->ack_seq is still 0. If main_loop_s() accepts the
socket and calls ioctl(remotesock, SIOCINQ, &avail) before the third ACK is
processed, even an unfixed mptcp_inq_hint() computes:

  READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq =3D 0 - (-skb->len) =
=3D skb->len

rather than overflowing to INT_MAX. The overflow to subflow->iasn + skb->le=
n >=3D
INT_MAX only occurs after the server processes the third ACK in:

  tcp_rcv_state_process()
    -> tcp_data_queue()
      -> mptcp_incoming_options()
        -> check_fully_established()
          -> __mptcp_subflow_fully_established()
            -> subflow_set_remote_key()

which sets WRITE_ONCE(msk->ack_seq, subflow->iasn) in net/mptcp/subflow.c.
Note also that simply polling POLLIN on remotesock would return immediately
because mptcp_fastopen_subflow_synack_set_params() already queued the SYN d=
ata
onto sk_receive_queue prior to accept().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793860134.gi=
t.tanggeliang@kylinos.cn?part=3D3
