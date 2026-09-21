Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41442B33D;
	Mon, 21 Sep 2026 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983824; cv=none; b=NCSJ2ex7g9bIFXBjnvGQcdCw7RDPbXryVfYuMAc49Hkz5GnL0YrdhxIJK7QmhT5v7AA3PrWa9GJvHe9V72ALkBa8MbtUvsU4Iu/jwPrweRXkRTR9BEYFbsyliYtr69IycBwHrxujrfYyP6YWlt5/FZhWbDxzlNzU7kOw90kiLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983824; c=relaxed/simple;
	bh=pgeL39ISlMWaWsmKnujIlUIL/Ju+yLUXD1rw3iueAtU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=R3Grg8mTKN0nnyDtT72L9j6G/Ix5PGvnaZAA1YMCR5DgmhYUvoaO1JZuBJTFoAvcLsRvu405UFx8hD4IT3d8VW2BoyztwbtrmChVmQbB3+lyAhM819rKntq+K44qGYCH2Qtsdo60PY9+2+afz774aALON7nnZVxOsWpOEukN+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojhsiAGH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojhsiAGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED50C1F000FF;
	Mon, 21 Sep 2026 09:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789983820;
	bh=pgeL39ISlMWaWsmKnujIlUIL/Ju+yLUXD1rw3iueAtU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ojhsiAGHfyw7QSfeB6T7h3TzxVkQtRUKsc+O78gcxpLaSs0+X+b7FBp+0WATjdLpR
	 NtZ9lTkk3CfDAWvNYu7ZGwpy69ouoDbNYnuM8Dr5mjtROlLr5yRcrpqjI++VN0zKef
	 n31ZVKSGxxMR3qUkZAdXRZO6l5yG8xtiFA8l0BtPdFKn5gKlAfm4vhvci7mZkUN+uL
	 +lFblDwaya6XlCr2wrPOTc6GuT8xECMfe9h5NQaZAR+78iRkihrTbAcdUwvJrpMvD+
	 yjYxjnYKbSxzK6Ce66ZjAxlx1J8YIJw4TKzTLSRK3I3WGPsxUbd3OBMAA7mJ+6MTJH
	 ptVsbhF37WkLQ==
Date: Mon, 21 Sep 2026 11:43:32 +0200
From: Matthieu Baerts <matttbe@kernel.org>
To: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: Mat Martineau <martineau@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, Kimi Security Team <bug-report@moonshot.ai>
Message-ID: <aa299737-002e-43b4-ad1e-881720798470@kernel.org>
In-Reply-To: <20260920061904.3575780-1-yilinzhang@moonshot.ai>
References: <20260903094010.4066892-1-yilinzhang@moonshot.ai> <20260920061904.3575780-1-yilinzhang@moonshot.ai>
Subject: Re: [PATCH v3] mptcp: do not use Fast Open on MP_JOIN subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <aa299737-002e-43b4-ad1e-881720798470@kernel.org>

Hi Yilin,

20 Sept 2026 08:19:21 Yilin Zhang <yilinzhang@moonshot.ai>:

> tcp_fastopen_create_child() hands the SYN packet itself to
> subflow_syn_recv_sock(). For an MP_JOIN request this takes the
> fatal fallback: the cloned child is destroyed and handed back with
> drop_req flagged, but tcp_fastopen_create_child() does not check
> the flag and queues it, so accept() can expose the freed child.
>
> MP_JOIN cannot use Fast Open: data on a subflow requires the
> completed HMAC exchange (RFC 8684, sec. 3.2). Refuse it (only the
> TFO path passes a SYN skb here) and let tcp_conn_request() fall
> back to the regular MP_JOIN handshake; also strip the Fast Open
> cookie from MP_JOIN SYN/ACKs.
>
> Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows=
")
> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Suggested-by: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
> ---
> v3:
> - refuse TFO for MP_JOIN in subflow_syn_recv_sock() and fall back to
> =C2=A0 the regular handshake; the TCP-side hunks from v2 are dropped
> - strip the TFO cookie from MP_JOIN SYN/ACKs

Thank you for the V3.

Please start a new thread when sending a new version.

> v2:
> - https://lore.kernel.org/netdev/20260903094010.4066892-1-yilinzhang@moon=
shot.ai/
> v1:
> - https://lore.kernel.org/netdev/20260902121247.3248539-1-yilinzhang@moon=
shot.ai/
>
> net/mptcp/subflow.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index af81ad5..2b454d4 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -348,6 +348,10 @@ static void subflow_prep_synack(const struct sock *s=
k, struct request_sock *req,
> =C2=A0=C2=A0=C2=A0 if (foc && foc->len > -1)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ireq->tstamp_ok =3D 0;
>
> +=C2=A0=C2=A0 /* MP_JOIN cannot use TFO, do not send a cookie in the SYN/=
ACK */
> +=C2=A0=C2=A0 if (foc && mptcp_subflow_rsk(req)->mp_join)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 foc->len =3D -1;

This should go above the previous block, not to disable TCP timestamps
in this case.

> +
> =C2=A0=C2=A0=C2=A0 if (synack_type =3D=3D TCP_SYNACK_FASTOPEN)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_fastopen_subflow_synack_=
set_params(subflow, req);
> }
> @@ -832,6 +836,12 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
> =C2=A0=C2=A0=C2=A0 if (fallback)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto create_child;
>
> +=C2=A0=C2=A0 /* a SYN skb here comes from TFO, which MP_JOIN cannot use:=
 just
> +=C2=A0=C2=A0=C2=A0 * fall back to the regular path.
> +=C2=A0=C2=A0=C2=A0 */

Can be shorter and on one line maybe?

=C2=A0 MP_JOIN + TFO: unsupported now, drop TFO data, back later on

(Or something similar)

> +=C2=A0=C2=A0 if (subflow_req->mp_join && (TCP_SKB_CB(skb)->tcp_flags & T=
CPHDR_SYN))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> +
> =C2=A0=C2=A0=C2=A0 /* if the sk is MP_CAPABLE, we try to fetch the client=
 key */
> =C2=A0=C2=A0=C2=A0 if (subflow_req->mp_capable) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* we can receive and accept a=
n in-window, out-of-order pkt,
> --
> 2.34.1

Cheers,
Matt
