Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0753E46D
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710162634; cv=none; b=FTkYBezPD3ModKzumYZkAKtVzacQ0WD+BsenauqgcqsVAL63BSngbdvRUNpwId4/rwOxYVM2ZvVoOFATvyPRyUF58bXtBO11bEQLy6y/kh32ps3vtFkFd65zmKbCTUN7qZbRKg7QVQx+nCngPVD9mRMRn5jz3bCmYHU2BboDLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710162634; c=relaxed/simple;
	bh=+yXG0FXKtYP3u3HQSoN1vgPv3pvIVTlzpaL9Vkj/AkM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpoR5RYqU30YlYdHhTPWKrxbLP4Yk3N5jgrAym1pfDO33SLnGe83cYmhF9jQwTlbBU6UUt3hcpqjI2fJTKexFCjILQ3XRvNsvIXQod4QqL/IO1XUwUSkkdvllcOoNbbN9pZy+uzGk4Ll0SWxJwLjM6qcL3c68ovzeU319RB2X3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiSfD3+B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiSfD3+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710162631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Dr+dehASa9ioeLp4ljQ24jBt+JMtXH26CeEDUXrZZMU=;
	b=OiSfD3+BkHLfbFejkDKqLXTLdZjODybYSfe0Mfyn1q2b8UbCoT3eU8OMEHNi1+OvzsbBz7
	At6bHAll9WyMamGZD5H6CJ2MUnzf/grtMO7fD/ZiJpqdHmsObRK3e/XCrYhcGejv2+ckQm
	wd7UnB5XI82VLIDFLF+oFSyYIKXedLM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-GgJQ0ve6N7yXDjd9HjMdgA-1; Mon, 11 Mar 2024 09:10:29 -0400
X-MC-Unique: GgJQ0ve6N7yXDjd9HjMdgA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33e7940790fso719368f8f.0
        for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 06:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710162628; x=1710767428;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xem7rpsyJBCVbuyv4gBDP65b21HpA7Ea4j8W/LUcSM8=;
        b=ZNgolldKGAN2P0lZh6QFhZbKA5OLeHEE03/hF6vMES112AbN0WGvkzl9MS+f/LS37m
         SFjbq4CbPluCNfiK1MJ3g8r1FIbQgehGIM2yv32XHCaZ7lOsZDQOfa671lLxgtpQNWQl
         HcrevJehpai3tFwSm32YIUgXlyDajgJUreoWRf3WySQduH/1WOe530UHepW3ttjxSzB6
         6uWZb3FWOFV+z94XCAylgYbpGtTlvv90wONhJNBlr79lnDNz1bFYC0pnTevcR8rgWCSI
         ENFay5QF/yzwW2kI1LdOJs1zOoTKl0ngbpBcTM9kdHm7mTzroWrHxWJvGyWS/sr5qgZA
         xA2A==
X-Forwarded-Encrypted: i=1; AJvYcCWdm19nLb6IkjjU2ogaS0zDz2dt+p2ex9JjMW/FRGSc7Zhqffp1LI+/PVOTrrQ6L2E5+OUuwH6yWfJGVxL1kUPjbeRbw14=
X-Gm-Message-State: AOJu0Yx8UD7DDl3fZjtQuECWlDRe0iPirHtPwmr0KZi7T7s/ed60x2zx
	DVqMWdQa4W8cJl/PkV2bCtoFzPaw2Cm5W9X0AWuv7XDcR2H5zIsyORF6uJl3SGywPA6Q/qPUUxB
	CiSCBZW/0EXo5I40p/l1XZy7YoKYcI5a0feK1Qstu3dqOTgBu+9tSahnT/wk5
X-Received: by 2002:a05:600c:3b8c:b0:412:b802:787a with SMTP id n12-20020a05600c3b8c00b00412b802787amr4925025wms.4.1710162628004;
        Mon, 11 Mar 2024 06:10:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL1MMc2IDeakPge8AUYGe472tz94z+WrhNgTv1g6HzoJiURw9RhphBvMj97a6WId48EhUc4Q==
X-Received: by 2002:a05:600c:3b8c:b0:412:b802:787a with SMTP id n12-20020a05600c3b8c00b00412b802787amr4925013wms.4.1710162627558;
        Mon, 11 Mar 2024 06:10:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-208.dyn.eolo.it. [146.241.232.208])
        by smtp.gmail.com with ESMTPSA id fl7-20020a05600c0b8700b004132f4ff20esm961701wmb.33.2024.03.11.06.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:10:27 -0700 (PDT)
Message-ID: <54acb706fee5467bffa460e82146579469c5cdb6.camel@redhat.com>
Subject: Re: [PATCH RFC] mptcp: react scheduler when subflow events pop up
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 11 Mar 2024 14:10:25 +0100
In-Reply-To: <433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn>
References: <433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-03-06 at 10:55 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> The current packet scheduler will not react by queuing more packets if
> some subflows only events are emitted, e.g. new TCP ACKs are received
> only acking things at TCP-level but not at MPTCP level. The scheduler
> should be called when such events happen.
>=20
> ack_update_msk() is invoked when an ACK is received, so it's the right
> place to call the scheduler by invoking __mptcp_check_push().
>=20
> mptcp_subflow_timeout() is implemented to call the scheduler when a
> subflow timeout happens. But I'm not sure where is the right place to
> invoke it. I mean where is the right place when a RTO is fired. So I
> temporarily do it in mptcp_worker().
>=20
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/343
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/tcp.h    |  3 +++
>  net/ipv4/tcp_timer.c |  6 +++---
>  net/mptcp/options.c  |  1 +
>  net/mptcp/protocol.c | 23 ++++++++++++++++++++++-
>  net/mptcp/protocol.h |  1 +
>  5 files changed, 30 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6ae35199d3b3..431a23a8ebfa 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -347,6 +347,9 @@ void tcp_release_cb(struct sock *sk);
>  void tcp_wfree(struct sk_buff *skb);
>  void tcp_write_timer_handler(struct sock *sk);
>  void tcp_delack_timer_handler(struct sock *sk);
> +bool retransmits_timed_out(struct sock *sk,
> +=09=09=09   unsigned int boundary,
> +=09=09=09   unsigned int timeout);
>  int tcp_ioctl(struct sock *sk, int cmd, int *karg);
>  enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_bu=
ff *skb);
>  void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index d1ad20ce1c8c..cfedafc4ca36 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -212,9 +212,9 @@ static unsigned int tcp_model_timeout(struct sock *sk=
,
>   * after "boundary" unsuccessful, exponentially backed-off
>   * retransmissions with an initial RTO of TCP_RTO_MIN.
>   */
> -static bool retransmits_timed_out(struct sock *sk,
> -=09=09=09=09  unsigned int boundary,
> -=09=09=09=09  unsigned int timeout)
> +bool retransmits_timed_out(struct sock *sk,
> +=09=09=09   unsigned int boundary,
> +=09=09=09   unsigned int timeout)
>  {
>  =09struct tcp_sock *tp =3D tcp_sk(sk);
>  =09unsigned int start_ts, delta;

If we access the function from outside the tcp code, we additionally
need to rename it as 'tcp_retransmits_timed_out' or the like.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 5926955625cf..4b091d3bce00 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1069,6 +1069,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
>  =09=09__mptcp_snd_una_update(msk, new_snd_una);
>  =09=09__mptcp_data_acked(sk);
>  =09}
> +=09__mptcp_check_push(sk, ssk);

It we call __mptcp_check_push() unconditionally here, we must remove
the previous conditional call, a few lines above.

Still I think we should not call it unconditionally: only if msk ack
seq or the subflow ack seq changed.

Additionally we need some performance figures the ensure this is not
impacting [too much] the bulk transfer performances

Somewhat related. I *think* there is a possible issue WRT the current
(prior to this patch) packet scheduler strategy:

When the msk ack sequence increases, we unconditionally push data on
the subflow receiving such update:

https://elixir.bootlin.com/linux/latest/source/net/mptcp/protocol.c#L1643

That choice could be sup-optimal. I *think* we should always call the
scheduler, and I'm not sure (I can't recall) the why of the current
implementation.

This could also explain some simult-subflow self-tests failures

>  =09mptcp_data_unlock(sk);
> =20
>  =09trace_ack_update_msk(mp_opt->data_ack,
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index cdf9ec67795e..c935f6a7adb0 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -486,6 +486,26 @@ static long mptcp_timeout_from_subflow(const struct =
mptcp_subflow_context *subfl
>  =09       inet_csk(ssk)->icsk_timeout - jiffies : 0;
>  }
> =20
> +static void __mptcp_subflow_timeout(struct sock *sk, struct sock *ssk, l=
ong tout)
> +{
> +=09unsigned int boundary =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ret=
ries1) + 1;
> +
> +=09if (retransmits_timed_out(ssk, boundary, tout))
> +=09=09__mptcp_check_push(sk, ssk);

Both retransmits_timed_out() and __mptcp_check_push() must be called
under the ssk socket lock.

I think we should look for a better solution then acquiring such lock
unconditionally for each subflow.

More importantly why this hook is needed? the subflow did make any
progress, we can't enqueue more data there.

A possible alternative would be use this hook to mark the subflow as
stale, but... do we have any issues with the current schema to detect
stale subflows?

Thanks!

Paolo

