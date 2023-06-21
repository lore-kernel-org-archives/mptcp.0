Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F061C3E
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687332197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rj7/MI/VPKGppzD1eBp/GMTcv+OLUtvgJAeH/FX9jrk=;
	b=JMTVJzrMoVXWQDgX1JJnUYA3sXUS1BRP1gaVvTuBKbBLSHyFm+GeroL7gtkZWVwRceM9bI
	AutvntXipkpB0yAI7O2vfpxzH+P8ZGPafo/cd6OXFRyJksCHI9jTp1EVUVbqorBWe+Ax1M
	VomZ0l+GIBqsU5pYOJsxOYJTDC6UwSE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-SAhZWZydP-aU1cV4-zgqKw-1; Wed, 21 Jun 2023 03:23:15 -0400
X-MC-Unique: SAhZWZydP-aU1cV4-zgqKw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f8751a9ac5so419314e87.0
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 00:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687332194; x=1689924194;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYvg4E56vl301hCkpxYQuVxUMmozgTXEuecs4PGuL4Q=;
        b=XrCLJNg1gonzRN6Fdus6RtM+skeAdOmUYH/GeUJOwIbsQr1lEfSy1iEjDz7+b6Z3Pt
         nSe7l3o/MHBqg7/GckZd6iIv6ooVU95Shx2zO+HjtltCbTjCimPa80RYMp1zQms2ikPR
         P/LNgP3xv/LDnsTqNjDpvIbKc4Xr8LtWagSswqFn3vQxvqaGtiPodyB7atH45GFS1Iba
         6htOpGeHwtE/aOloeH1qcFD999bReNNLYBa+KfBbn3K1xbyC276HDTTdSghPLIVKR51M
         fWqfGRBj8Jg3xPg4TP8+9PZVodR33QG9n7wWhCzslXPMf7BhJkp/bu4ARtZ6WM4Hski1
         emAw==
X-Gm-Message-State: AC+VfDwdY0Q5fszqCq/ZSv5B30XHNxKJvS2VVyuYtVcpPMjU5SaERNX1
	i4y6k94JN/DcAcCjD97kf5ZoN0rGsybY7+ur57bqJ/Gt//Rlqas6z5/q4GigyJcjngPFu87csdm
	EYl3IdyvP2IPxP0woj+Lp3sJZonSng9Y2j0Sfd3STITLVgQ3WhGR3pzTWNOj9fEl2b7YzUD+0Ax
	Y=
X-Received: by 2002:a2e:b804:0:b0:2b4:5bc8:3f1a with SMTP id u4-20020a2eb804000000b002b45bc83f1amr7657332ljo.2.1687332193998;
        Wed, 21 Jun 2023 00:23:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wm3pQh351yRLuao5VemJ7+/r0TotRjSgLSZkeSFKNXvmaYVgT7h1x8MPz6jf9u6aUlSoCCA==
X-Received: by 2002:a2e:b804:0:b0:2b4:5bc8:3f1a with SMTP id u4-20020a2eb804000000b002b45bc83f1amr7657312ljo.2.1687332193577;
        Wed, 21 Jun 2023 00:23:13 -0700 (PDT)
Received: from gerbillo.redhat.com ([85.93.125.228])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709063a5600b00988e699d07fsm2608723ejf.112.2023.06.21.00.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 00:23:12 -0700 (PDT)
Message-ID: <a99660b20eb4499bb259371f959e307cdda6d2aa.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: ensure listener is unhashed before
 updating the sk status
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Date: Wed, 21 Jun 2023 09:23:12 +0200
In-Reply-To: <b96e12c9dd08dca94ce2539b01d0e609d472a22a.1686754464.git.pabeni@redhat.com>
References: <b96e12c9dd08dca94ce2539b01d0e609d472a22a.1686754464.git.pabeni@redhat.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
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

On Wed, 2023-06-14 at 16:54 +0200, Paolo Abeni wrote:
> The MPTCP protocol access the listener subflow in a lockless
> manner in a couple of places (poll, diag). That works only if
> the msk itself leaves the listener status only after that the
> subflow itself has been closed/disconnected. Otherwise we risk
> deadlock in diag, as reported by Christoph.
>=20
> Address the issue ensuring that the first subflow (the listener
> one) is always disconnected before updating the msk socket status.
>=20
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> should close issues/407 for good
> ---
>  net/mptcp/pm_netlink.c                        |  1 +
>  net/mptcp/protocol.c                          | 31 ++++++++++++-------
>  .../testing/selftests/net/mptcp/mptcp_join.sh |  3 ++
>  3 files changed, 23 insertions(+), 12 deletions(-)
>=20
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ba1406e601e4..333c7e2a7f78 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1043,6 +1043,7 @@ static int mptcp_pm_nl_create_listen_socket(struct =
sock *sk,
>  =09if (err)
>  =09=09return err;
> =20
> +=09inet_sk_state_store(newsk, TCP_LISTEN);
>  =09err =3D kernel_listen(ssock, backlog);
>  =09if (err)
>  =09=09return err;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index feaedfd2b3eb..015745108d8b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2395,13 +2395,6 @@ static void __mptcp_close_ssk(struct sock *sk, str=
uct sock *ssk,
>  =09=09kfree_rcu(subflow, rcu);
>  =09} else {
>  =09=09/* otherwise tcp will dispose of the ssk and subflow ctx */
> -=09=09if (ssk->sk_state =3D=3D TCP_LISTEN) {
> -=09=09=09tcp_set_state(ssk, TCP_CLOSE);
> -=09=09=09mptcp_subflow_queue_clean(sk, ssk);
> -=09=09=09inet_csk_listen_stop(ssk);
> -=09=09=09mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
> -=09=09}
> -
>  =09=09__tcp_close(ssk, 0);
> =20
>  =09=09/* close acquired an extra ref */
> @@ -2952,10 +2945,24 @@ static __poll_t mptcp_check_readable(struct mptcp=
_sock *msk)
>  =09return EPOLLIN | EPOLLRDNORM;
>  }
> =20
> -static void mptcp_listen_inuse_dec(struct sock *sk)
> +static void mptcp_check_listen_stop(struct sock *sk)
>  {
> -=09if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN)
> -=09=09sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> +=09struct sock *ssk;
> +
> +=09if (inet_sk_state_load(sk) !=3D TCP_LISTEN)
> +=09=09return;
> +
> +=09sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> +=09ssk =3D mptcp_sk(sk)->first;
> +=09if (WARN_ON_ONCE(!ssk || inet_sk_state_load(ssk) !=3D TCP_LISTEN))
> +=09=09return;
> +
> +=09lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> +=09mptcp_subflow_queue_clean(sk, ssk);
> +=09
> +=09mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
> +=09tcp_set_state(ssk, TCP_CLOSE);

Ooops, too late I saw the above is wrong, should be:

=09lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);

=09tcp_set_state(ssk, TCP_CLOSE);
=09mptcp_subflow_queue_clean(sk, ssk);
=09inet_csk_listen_stop(ssk);
=09mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
=09
tcp_set_state() also unhash the TCP socket, and that action should be
taken first.

I hope I'll be able to send a follow-up by the end of the week.

/P

