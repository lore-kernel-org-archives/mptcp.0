Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606010;
	b=P45DdyC0jycg+KnTj+UFFNyghNgagr106k+8Mcivb1TYoVHPDZSgaPs5OAHGauNm6pyj
	 sCnAdUzYOyYtrHo/SY/fyQYx6W70qnj5BwcyuybOYPKm23F9TNQyklVsDNFhBjHxIEZLf
	 342sBv0vAkVR4m3fTNpqraofjngUspmW+JKDxJhsp6vfvX2OTP1Z9O4lzCQxGbUq2mN72
	 J4JcwQ3KSDzudIAvealK3wEhQS0wk9Fd1JApp9P7bRN4/F82HGsBwx6pzam3pTYNPEkaS
	 K1BNHWIW58AnqL5M53lb+umie52gZr2m9b8FQvUIwbqGFAegbCrzo2JH4S3T/6PJLlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606010;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dcu8ucf5VKo7j0+IzxeOcvLy4o9493vy8PrjWFo7GCo=;
	b=2+C5dVI4IIlFjsZ0TQx9qRBJMFhMTFlShrPajgz3bxkgNFQgiN1PbZsPMjRczlrvsCbi
	 CeFix0tORKO252U6Z/kwhVjK2EDXI4eHtHZI40k9IR4YeLE35TyO7ShmMsyaVDkuSen9T
	 6B3SRbACnOZoum7Tvau8iQdIHMAV+h4RvtxJEP/EYeOA7CUmBu6SIEryPDJB/NPsdFZIk
	 yKGU3bHk65iJXcmoCYdhEdprc1nH35goYTTeRLQ0NQkDQ3C2xlUHu1oX6tNgU2NgafgfX
	 bf+ASs1CDCaFF51cSopaAoeuZrOw81sEUW+GMjUE6y0x9+V2iA2mBNkug4rMeQqLdzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozBMf92v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B120B60A3835
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozBMf92v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9891F000D0;
	Fri, 13 Nov 2026 21:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606010;
	bh=dcu8ucf5VKo7j0+IzxeOcvLy4o9493vy8PrjWFo7GCo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ozBMf92v/pR4oSfEGw9AXNQ9LaikeO/bO3Vlk9vy6PtwMnK9uw5JqwjSvo6SlkHoT
	 VcYj9wr3VhGQx87hmv9WCPRDNuculkqJaANqZA4rg2QMHr6uG8liq1aPDB7uXvV3vQ
	 Tv2Eg0fWscYW0TuHdd8IH+OLW9ASd5JaPRMrwbO/lATRWtFEWM/PaVGGeNAqQz+ql5
	 pl0syaQoDPuk3WciEP6zEjGM4f+EAJ2z55BEFf0Wxh8p248orK0LXb4gi/c8YAbo3a
	 hpLHTrqZ7dAcg690V9Yaimn3jMMbdHzYd5aOoO1qHHIO/hBZK404IODQ8oPMnqSbmR
	 WvmI20inqtTZg==
Message-ID: <sashiko-outbox-213730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net 15/34] mptcp: close a subflow reset for a bad
 mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-15-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
 <20261113-mptcp-cmason-fixes-v1-15-9205b77e9a2f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:40:09 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] mptcp: first stream byte lost on simultaneous connect fallback
  in subflow_finish_connect() [1]
--

commit 68bf5d98c7b71382964b2e0b6553373923662fac
Author: Chris Mason <mason@kernel.org>

mptcp: close a subflow reset for a bad mapping

This commit calls subflow_sched_work_if_closed() after resetting a subflow
due to a bad mapping when TCP fallback is not possible, so the MPTCP worker
closes the subflow and updates the MPTCP socket state.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d23da4ac19684..7b8183b6a13e2 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1499,8 +1499,8 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
>  		}
> =20
>  		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
> -			/* fatal protocol error, close the socket.
> -			 * subflow_error_report() will introduce the appropriate barriers
> +			/* fatal protocol error, reset the subflow and let the
> +			 * worker close it
>  			 */
>  			subflow->reset_transient =3D 0;
>  			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSRESET);
> @@ -1515,6 +1515,7 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
>  				sk_eat_skb(ssk, skb);
>  			mptcp_send_active_reset_reason(ssk);
>  			WRITE_ONCE(subflow->data_avail, false);
> +			subflow_sched_work_if_closed(msk, ssk);
>  			return false;
>  		}
>  	}

[Severity: High]
This problem wasn't introduced by this patch, but can the fallback dummy
mapping right below this hunk in subflow_check_data_avail() drop the first
byte of incoming data after a TCP simultaneous connect [1]?

During simultaneous connect in TCP_SYN_SENT, mptcp_syn_options() detects
subflow_simultaneous_connect(), calls mptcp_try_fallback(), and clears
subflow->request_mptcp without setting subflow->conn_finished or
subflow->ssn_offset.  Because tcp_rcv_state_process() moves the socket from
TCP_SYN_RECV to TCP_ESTABLISHED without calling sk_rx_dst_set(),
subflow_finish_connect() is only invoked when the first packet in
TCP_ESTABLISHED reaches tcp_rcv_established().  At that point
TCP_SKB_CB(skb)->seq is peer_isn + 1 instead of peer_isn:

net/mptcp/subflow.c:subflow_finish_connect() {
	...
	subflow->rel_write_seq =3D 1;
	subflow->conn_finished =3D 1;
	subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
	...
}

net/mptcp/subflow.c:subflow_check_data_avail() {
	...
fallback:
	...
	skb =3D skb_peek(&ssk->sk_receive_queue);
	subflow->map_valid =3D 1;
	subflow->map_data_len =3D skb->len;
	subflow->map_subflow_seq =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
	subflow->map_seq =3D __mptcp_expand_seq(subflow->map_seq,
					      subflow->iasn +
					      TCP_SKB_CB(skb)->seq -
					      subflow->ssn_offset - 1);
}

When the first data segment (with seq =3D=3D peer_isn + 1) reaches the fall=
back
path in subflow_check_data_avail(), subflow->iasn + TCP_SKB_CB(skb)->seq -
subflow->ssn_offset - 1 evaluates to -1, setting subflow->map_seq to -1ULL
while msk->ack_seq is 0.  In __mptcp_move_skb(), a 1-byte initial segment
is then dropped as duplicate data, or a multi-byte segment has its offset
advanced by 1 byte, corrupting the stream.

[1] https://sashiko.dev/#/bug/linux-17755322-ec78-468c-aabb-cd93fe7c5a2f

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-mptcp-cmas=
on-fixes-v1-0-9205b77e9a2f@kernel.org?part=3D15
