Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793167871;
	b=Jh0qFZ6+xE8X6wflgCDD+3wWXBkzDX/fDgLV1aRrb6CXeHQh5ID27aYxVj2pYOBw1IT1
	 neZzrW0lhMXFOQw1zFfF3wnmbIrrxDRFW4LmA7tBnKVY/ADRmmCQKv2h7FZRyd8oQ1tq/
	 AnkmDgg+3XvBaVZLwD0RYQZvUdgQAYOpVmSlo+wRj771bki7QcuIT00I689N9fbF1xkS0
	 P6Wi5k4YH+snbuKKy6keJ9+DyiWssLCupKmyGQrps8pJmK0QPGoXpPl09DTSs8rOY626J
	 EsE+bx32s4vcUcyaoZaoD+FnDps9MGEWaAAiDxPr6QnNpfXyQX+HDPVq21rzwfKWbvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793167871;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MtiX8+1sHyWTRYoUANNCZBpstp8ZhylNpSIODWGRvqk=;
	b=whBKTrY2cd6ybV5oZtCAongEMDUsnPaPqiGyvx4og2qWLQVWcdqNk9z7nRGWW64kW0M8
	 /1OPy7HeClMvhMAeVhGag9RLEorRwN2jY4hZEkHFB4loIbt8vK9QW6I65qaolFMF+miu0
	 E9BVL4XR88PHnXGBaPwIEwD4xthNlR75ORkujp8Ft3e1EXxqGmp67NNYLB4PeDWI75ndT
	 SSPRIsC/lJnFQZg7jRm6QDMDD4UrZT3te586iKCVp+kOIDIGp0YSzRT63rvklpmCtgfvY
	 k3MsJGHBv8pVqII4Ffg9Y7bgM27j5V+1DKgtfyPnoiebeWES6Ik46agqqa9CfOv++wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iV3udQdi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66235606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iV3udQdi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80481F01825;
	Wed, 28 Oct 2026 06:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793167871;
	bh=MtiX8+1sHyWTRYoUANNCZBpstp8ZhylNpSIODWGRvqk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iV3udQdiXn0N5QV527UC8VS2y7Gi9Tbbv3QOgNpKMU/Y6gBhXXY1esi2SZb6Hxf0g
	 Kg01odRkk5vdmC90dpvy8+X0XUpIzGcfvVDSL21e6krBLp47wPNiZHeXspPMbOOFyt
	 Xap/3iIk8JNuj/EKq6xqo1M6QH629dC8Le+DFoVwFzmuHcykgAQcU6paXwftyMAMrp
	 RCeLcxMBi3bwbdGxxQAJZ23Ur7B/EFUaUGxi8gM+VklsRFyOVb2pLSBK4Kq0fSxTME
	 gYJbP0oG1asCP05JvMJjxnzWR/jZgG1YRW2o0nd7/KTX1gNQXfM50+gEE4u3x2i2Yh
	 HJUuDHaTbvdpw==
Message-ID: <sashiko-outbox-187550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v12 4/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261028054143.3222998-5-anilkaushikwireless@gmail.com>
References: <20261028054143.3222998-1-anilkaushikwireless@gmail.com>
 <20261028054143.3222998-5-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 06:11:10 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mptcp: unclosed non-SYN_SENT retry subflows in mptcp_close_retry_s=
ubflows()
--

commit de5632976a598bbd4a3db378be502a28582f26e1
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

mptcp: pm: in-kernel: retry subflows closed after an error

This commit teaches the in-kernel path manager to re-create an established
subflow initiated by the local host after TCP closes it due to a path timeo=
ut
while another subflow can still send data. It also adds cleanup logic to
close re-created subflows that are not yet fully established when no other
subflow can send data or when the MPTCP socket is shut down or closed.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 02a4f479d8c..257059ffdc7e9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -736,6 +736,10 @@ static void mptcp_check_data_fin(struct sock *sk)
>  		if (!__mptcp_check_fallback(msk))
>  			mptcp_send_ack(msk);
>  		mptcp_close_wake_up(sk);
> +
> +		/* not always called from the worker, which closes them */
> +		if (mptcp_retry_subflows_stale(msk))
> +			mptcp_schedule_work(sk);
>  	}
>  }

[ ... ]

> @@ -2788,6 +2795,49 @@ static void __mptcp_close_ssk(struct sock *sk, str=
uct sock *ssk,
>  	}
>  }
> =20
> +/* Re-created subflows not established yet are useless once the msk is
> + * closed or shut down. When no other subflow can send data, see
> + * mptcp_retry_subflows_stale(), only the ones still connecting are: a j=
oined
> + * one is fully established soon. Not called while iterating on the subf=
lows.
> + */
> +static void mptcp_close_retry_subflows(struct sock *sk, bool connecting)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +		if (!subflow->retry || READ_ONCE(subflow->fully_established))
> +			continue;
> +
> +		if (connecting) {
> +			if (inet_sk_state_load(ssk) !=3D TCP_SYN_SENT)
> +				continue;
> +			/* another one got established in the meantime */
> +			if (!mptcp_retry_subflows_stale(msk))
> +				break;
> +		}

[ ... ]

> @@ -3185,6 +3246,9 @@ static void mptcp_worker(struct work_struct *work)
>  	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
>  		__mptcp_close_subflow(sk);
> =20
> +	if (mptcp_retry_subflows_stale(msk))
> +		mptcp_close_retry_subflows(sk, true);

[Severity: High]
Can this leave unestablished retry subflows open when the MPTCP socket is no
longer established or when all other subflows have closed?

When mptcp_check_data_fin() transitions sk->sk_state out of TCP_ESTABLISHED
(for example to TCP_CLOSE_WAIT or TCP_CLOSING), mptcp_retry_subflows_stale()
returns true for any retry subflow with !subflow->fully_established and
schedules mptcp_worker().

However, mptcp_worker() unconditionally calls
mptcp_close_retry_subflows(sk, true) with connecting set to true rather than
checking sk->sk_state =3D=3D TCP_ESTABLISHED. Inside
mptcp_close_retry_subflows(), when connecting is true:

	if (connecting) {
		if (inet_sk_state_load(ssk) !=3D TCP_SYN_SENT)
			continue;
		...
	}

This skips any retry subflow with !subflow->fully_established that is alrea=
dy
in TCP_SYN_RECV or TCP_ESTABLISHED (such as one that received the MP_JOIN
SYN-ACK and is waiting for the 4th ACK).

Similarly, if sk->sk_state is TCP_ESTABLISHED and the last active subflow
closes via mptcp_close_ssk(), leaving only the closed msk->first and a
joined (!subflow->fully_established) retry subflow in TCP_ESTABLISHED or
TCP_SYN_RECV, mptcp_close_retry_subflows(sk, true) also skips that retry
subflow.

Because the unestablished retry subflow remains in msk->conn_list alongside
msk->first, list_is_singular(&msk->conn_list) at the end of
__mptcp_close_ssk() evaluates to false:

	if (list_is_singular(&msk->conn_list) && msk->first &&
	    inet_sk_state_load(msk->first) =3D=3D TCP_CLOSE) {
		if (sk->sk_state !=3D TCP_ESTABLISHED ||
		    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
			mptcp_set_state(sk, TCP_CLOSE);
			mptcp_close_wake_up(sk);
		} else {
			mptcp_start_tout_timer(sk);
		}
	}

As a result, neither mptcp_set_state(sk, TCP_CLOSE) nor
mptcp_start_tout_timer(sk) is called. Meanwhile, on the joined retry subflow
with !subflow->fully_established, __mptcp_subflow_active(subflow) is false,
so no data is queued on its TCP write queue and tcp_write_err() never fires.
If the 4th ACK never arrives, schedule_3rdack_retransmission() re-arms
icsk_delack_timer to send pure 0-byte 3rd ACKs indefinitely without a retry
limit, keeping the connection hung.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028054143.3222=
998-1-anilkaushikwireless@gmail.com?part=3D4
