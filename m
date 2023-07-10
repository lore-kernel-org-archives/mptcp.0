Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A513AC3
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689008722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6HOk6vWwKDeOBwBvHSZoKL3N0enI9W8XMh2zXMWxQWc=;
	b=iJFi8TXfqOcMuyoqWY+KNO4GV1gUt7ajFAhs4S/ckMahgYSTiKyMBkOFcsLJJ/0ubtKlZZ
	PV8m6gDh+E4CQ78Pm6Mbkq5OZdyEl+FgVyYQV0jPzfKJ2sIgOyZuEFJVjfL+IhXuwuwd1z
	ztQL51y1HgyrjocSR0Hl3E9m8tCcOoo=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-LJ7-UQnNMKif0tq9bahjcw-1; Mon, 10 Jul 2023 13:05:21 -0400
X-MC-Unique: LJ7-UQnNMKif0tq9bahjcw-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-46609b859f3so163963e0c.1
        for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 10:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689008721; x=1689613521;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cn/j7+A5HLGgmRgrPlNqPLUFJdFfsxPadoagUTwkpLI=;
        b=AwMTjrerpQBnDxXQLxNCvKeX3HcMU+7FB9IntpUkm/NhF2iF0w8dolB/1raCJGfyrA
         46GIgLiTjc4eEdLyE3ih2CUF4hdgpxnUyQbAlB56D2D5aaRp6sNdp/i4aE3ZaPaJhbxv
         9TvqcqxT7gjs2YS2pK5se+JC7224RfrXa2yM1s31CpDHpvgmmVJHltcVM6cr80DhvNCe
         WjfspTriM3zB+ZaYFqEFMbukITCdVYDel6ntCDtLDj7zuSFUycvwTvLAhXJV8Sli7IZY
         8Orcgu0VL9zkO1AR9f3EQ9PWsuFRLmkEOG0zxO6P039Ua68RwdN8cP+lBDa2yoWW7WxX
         zX0w==
X-Gm-Message-State: ABy/qLbfW8erCjKJWZVJrJ7Pq5X+SMkNV8dS0jc5cCiqREbbmnuYWOT9
	JuyV9YvOkJIB29GFjjXvhE1UyTSlZuE2YEer5oGO4prrBdGR4EY7S5FJ6XudIQocZ7LjoIcYQVf
	yA4mLzcwbVOP7qI3f3EvnX14=
X-Received: by 2002:a05:6102:5590:b0:440:9794:fefa with SMTP id dc16-20020a056102559000b004409794fefamr4666274vsb.0.1689008720998;
        Mon, 10 Jul 2023 10:05:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGyMnkUXJqAk46yA33BAwLltlRfSbpCcqO4+DavQVHgrsqzfPjk3Rnd9PrGVtYy5HUI1aRhhw==
X-Received: by 2002:a05:6102:5590:b0:440:9794:fefa with SMTP id dc16-20020a056102559000b004409794fefamr4666261vsb.0.1689008720653;
        Mon, 10 Jul 2023 10:05:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id g4-20020a0cf084000000b0062168714c8fsm10505qvk.120.2023.07.10.10.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 10:05:20 -0700 (PDT)
Message-ID: <04b15a240e3f84e7de1f4593f8b70b1b0a88ddd4.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 5/6] mptcp: sockopt: set val in a generic way
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 10 Jul 2023 19:05:18 +0200
In-Reply-To: <20230707-mptcp-unify-sockopt-issue-353-v1-5-693e15c06646@tessares.net>
References: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
	 <20230707-mptcp-unify-sockopt-issue-353-v1-5-693e15c06646@tessares.net>
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

On Fri, 2023-07-07 at 18:00 +0200, Matthieu Baerts wrote:
> Currently, to set socket option, we mostly deal with them case by case
> by setting the right field in the socket structure and in fact, copying
> what is done elsewhere in SOL_IP(V6). Supporting a new option is then
> more complex and we can see some disparities on how things are done
> between the different options.
>=20
> Instead, we can rely on ip(v6)_setsockopt() to set the different values.
> By doing that, we uniform the way we deal with the different options and
> we can also go through the BPF et Netlink hooks if needed. We can also
> easily support new options later.
>=20
> Note that there are still two cases where we still need to deal with the
> end values directly, thus with something specific case by case:
>=20
> - For SOL_TCP socket options because we cannot store them in the MPTCP
>   socket. Note we can also store info in the different subflows (and
>   create a first one if there is no subflow) and retrieve info from
>   there.
>=20
> - To sync the socket options when a new subflow has been created to
>   minimise the work. But maybe it is fine to call some getsockopt() /
>   setsockopt(). We could also save a list of setsockopt() that have been
>   done in the past and only re-do these ones. That should help with the
>   maintenance of these socket options and ease the support of new ones.
>=20
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/353
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  net/mptcp/sockopt.c | 148 ++++++++++++++++++----------------------------=
------
>  1 file changed, 50 insertions(+), 98 deletions(-)
>=20
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index f0007fa7a0a8..a17739683fdb 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -385,51 +385,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_=
sock *msk, int optname,
>  =09return -EOPNOTSUPP;
>  }
> =20
> -static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
> -=09=09=09       sockptr_t optval, unsigned int optlen)
> -{
> -=09struct sock *sk =3D (struct sock *)msk;
> -=09int ret =3D -EOPNOTSUPP;
> -=09struct socket *ssock;
> -
> -=09switch (optname) {
> -=09case IPV6_V6ONLY:
> -=09case IPV6_TRANSPARENT:
> -=09case IPV6_FREEBIND:
> -=09=09lock_sock(sk);
> -=09=09ssock =3D __mptcp_nmpc_socket(msk);
> -=09=09if (IS_ERR(ssock)) {
> -=09=09=09release_sock(sk);
> -=09=09=09return PTR_ERR(ssock);
> -=09=09}
> -
> -=09=09ret =3D tcp_setsockopt(ssock->sk, SOL_IPV6, optname, optval, optle=
n);
> -=09=09if (ret !=3D 0) {
> -=09=09=09release_sock(sk);
> -=09=09=09return ret;
> -=09=09}
> -
> -=09=09sockopt_seq_inc(msk);
> -
> -=09=09switch (optname) {
> -=09=09case IPV6_V6ONLY:
> -=09=09=09sk->sk_ipv6only =3D ssock->sk->sk_ipv6only;
> -=09=09=09break;
> -=09=09case IPV6_TRANSPARENT:
> -=09=09=09inet_sk(sk)->transparent =3D inet_sk(ssock->sk)->transparent;
> -=09=09=09break;
> -=09=09case IPV6_FREEBIND:
> -=09=09=09inet_sk(sk)->freebind =3D inet_sk(ssock->sk)->freebind;
> -=09=09=09break;
> -=09=09}
> -
> -=09=09release_sock(sk);
> -=09=09break;
> -=09}
> -
> -=09return ret;
> -}
> -
>  static bool mptcp_supported_sockopt(int level, int optname)
>  {
>  =09if (level =3D=3D SOL_IP) {
> @@ -700,94 +655,65 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct =
mptcp_sock *msk, sockptr_t op
>  =09return 0;
>  }
> =20
> -static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *ms=
k, int optname,
> -=09=09=09=09=09=09   sockptr_t optval, unsigned int optlen)
> +static int mptcp_setsockopt_msk(struct mptcp_sock *msk, int level, int o=
ptname,
> +=09=09=09=09sockptr_t optval, unsigned int optlen)
>  {
>  =09struct sock *sk =3D (struct sock *)msk;
> -=09struct inet_sock *issk;
> -=09struct socket *ssock;
> -=09int err;
> =20
> -=09err =3D ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
> -=09if (err !=3D 0)
> -=09=09return err;
> +=09/* We cannot use tcp_setsockopt() with the msk */
> +=09if (level =3D=3D SOL_IP)
> +=09=09return ip_setsockopt(sk, level, optname, optval, optlen);
> =20
> -=09lock_sock(sk);
> +=09if (level =3D=3D SOL_IPV6)
> +=09=09return ipv6_setsockopt(sk, level, optname, optval, optlen);
> =20
> -=09ssock =3D __mptcp_nmpc_socket(msk);
> -=09if (IS_ERR(ssock)) {
> -=09=09release_sock(sk);
> -=09=09return PTR_ERR(ssock);
> -=09}
> +=09if (level =3D=3D SOL_TCP)
> +=09=09return 0;
> =20
> -=09issk =3D inet_sk(ssock->sk);
> -
> -=09switch (optname) {
> -=09case IP_FREEBIND:
> -=09=09issk->freebind =3D inet_sk(sk)->freebind;
> -=09=09break;
> --=09case IP_TRANSPARENT:
> -=09=09issk->transparent =3D inet_sk(sk)->transparent;
> -=09=09break;
> -=09default:
> -=09=09release_sock(sk);
> -=09=09WARN_ON_ONCE(1);
> -=09=09return -EOPNOTSUPP;
> -=09}
> -
> -=09sockopt_seq_inc(msk);
> -=09release_sock(sk);
> -=09return 0;
> +=09return -EOPNOTSUPP;
>  }
> =20
> -static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optna=
me,
> -=09=09=09=09       sockptr_t optval, unsigned int optlen)
> +static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
> +=09=09=09=09   int optname, sockptr_t optval,
> +=09=09=09=09   unsigned int optlen)
>  {
>  =09struct mptcp_subflow_context *subflow;
>  =09struct sock *sk =3D (struct sock *)msk;
> -=09int err, val;
> +=09int err;
> =20
> -=09err =3D ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
> +=09err =3D mptcp_setsockopt_msk(msk, level, optname, optval, optlen);
> =20
>  =09if (err !=3D 0)
>  =09=09return err;
> =20
>  =09lock_sock(sk);
>  =09sockopt_seq_inc(msk);
> -=09val =3D inet_sk(sk)->tos;
>  =09mptcp_for_each_subflow(msk, subflow) {
>  =09=09struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> =20
> -=09=09__ip_sock_set_tos(ssk, val);
> +=09=09tcp_setsockopt(ssk, level, optname, optval, optlen);

The above ignores the tcp_setsockopt() return value. What if the
sockopt fails on a single subflow? e.g. the 2nd one?

Perhaps not possible with the currently supported sockopt, but if the
goal is to extend the support in a generic way, we will likely hit
that. Note that even saving and e.v. restoring the value on failure is
prone to the same problem (restoring could fail, too).

>  =09}
>  =09release_sock(sk);
> =20
>  =09return 0;
>  }
> =20
> -static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
> -=09=09=09       sockptr_t optval, unsigned int optlen)
> -{
> -=09switch (optname) {
> -=09case IP_FREEBIND:
> -=09case IP_TRANSPARENT:
> -=09=09return mptcp_setsockopt_sol_ip_set_transparent(msk, optname, optva=
l, optlen);
> -=09case IP_TOS:
> -=09=09return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
> -=09}
> -
> -=09return -EOPNOTSUPP;
> -}
> -
>  static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int le=
vel, int optname,
>  =09=09=09=09=09  sockptr_t optval, unsigned int optlen)
>  {
>  =09struct sock *sk =3D (struct sock *)msk;
>  =09struct socket *sock;
> +=09struct sock *ssk;
>  =09int ret;
> =20
> -=09/* Limit to first subflow, before the connection establishment */
> +=09/* Limit to first subflow */
>  =09lock_sock(sk);
> +=09ssk =3D msk->first;
> +=09if (ssk) {
> +=09=09ret =3D tcp_setsockopt(ssk, level, optname, optval, optlen);
> +=09=09goto unlock;
> +=09}

Why do you need the above chunk? This change the behavior of existing
sockopt and possibly their return value in case of error?!?

> +
>  =09sock =3D __mptcp_nmpc_socket(msk);
>  =09if (IS_ERR(sock)) {
>  =09=09ret =3D PTR_ERR(sock);
> @@ -801,6 +727,32 @@ static int mptcp_setsockopt_first_sf_only(struct mpt=
cp_sock *msk, int level, int
>  =09return ret;
>  }
> =20
> +static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
> +=09=09=09       sockptr_t optval, unsigned int optlen)
> +{
> +=09switch (optname) {
> +=09case IP_FREEBIND:
> +=09case IP_TRANSPARENT:
> +=09case IP_TOS:
> +=09=09return mptcp_setsockopt_all_sf(msk, SOL_IP, optname, optval, optle=
n);

This changes the sockopt semantic a bit, applying the
IP_FREEBIND/IP_TRANSPARENT to all the subflows, while before this
change, only the MPC subflow was rightfull affected. Likely in practice
there are no visible functional effect change, but it sounds confusing
to me.

Cheers,

Paolo

