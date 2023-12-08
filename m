Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517C8374
	for <mptcp@lists.linux.dev>; Fri,  8 Dec 2023 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBHVtNY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98DBC433C7
	for <mptcp@lists.linux.dev>; Fri,  8 Dec 2023 00:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701995057;
	bh=GoFl/XT3RUST/DSv05mB72CltmUF62Jsmnxq3Up0ohU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SBHVtNY2nLvmemOXBAuBxXc0ixHBVHsthKRIt/d1QwN759Gbzf3L7uzlPw30PmX5C
	 uRFBAZZ8/gx+xfnizj0BZ4/kzc/pq+bH9mHjVyUcAvgaoFs1N5h3UGRq9SPYELi8JR
	 1gwv1TcPrU8V7c1xPXf52AywRxy/kgURNxoG3vd6C1IJzI/J7XokPFzT2FA9EazDDU
	 4sqgb93dDB4OGTp0LHAeoXsJeq0dILMsx+Wy15E/i/su/A4zLm97MqdVtFVPQt+Syr
	 YL/CW5WIo8evGmhzHFSj5K0dyeXJsfb1Z0mJS3jWI85JjbsPqTemp445FP+Jw44r8q
	 4fbtH1G09QyEw==
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso1610164276.0
        for <mptcp@lists.linux.dev>; Thu, 07 Dec 2023 16:24:17 -0800 (PST)
X-Gm-Message-State: AOJu0YzvIBPYCfsPIRob+IitCxE8p6jr9MWyyMN/b0KAYOp76kRlreUG
	Cca18k8C5X7oSbSMrqd85xqQGBfgSiLcFZ304fAWwg==
X-Google-Smtp-Source: AGHT+IH/Im7wHt5rQm1BXfHoPT3bYmiqrkM2FT0nKcUvhBAJm1cZc+vtdkWUQ5IFbvtHqYfVn2eo9qbsPAAoHUoV35o=
X-Received: by 2002:a25:d74e:0:b0:db7:dacf:6fc0 with SMTP id
 o75-20020a25d74e000000b00db7dacf6fc0mr3145328ybg.72.1701995056930; Thu, 07
 Dec 2023 16:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231129113403.157953-1-max@internet.ru> <20231129113403.157953-3-max@internet.ru>
 <7d400717-0bfd-5dcc-3ea7-fc12db4c4759@kernel.org> <2da11695-1691-bf06-4554-427b18820a97@kernel.org>
In-Reply-To: <2da11695-1691-bf06-4554-427b18820a97@kernel.org>
From: Mat Martineau <martineau@kernel.org>
Date: Thu, 7 Dec 2023 16:24:06 -0800
X-Gmail-Original-Message-ID: <CABbSpcgKEkA8iu8FD5vLAvb6c-mawRJyFMm7LnEmuQSRtpKXRQ@mail.gmail.com>
Message-ID: <CABbSpcgKEkA8iu8FD5vLAvb6c-mawRJyFMm7LnEmuQSRtpKXRQ@mail.gmail.com>
Subject: Re: [PATCH v2 mptcp-next 2/3] mptcp: sockopt: support
 IP_LOCAL_PORT_RANGE and IP_BIND_ADDRESS_NO_PORT
To: Maxim Galaganov <max@internet.ru>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 3:59=E2=80=AFPM Mat Martineau <martineau@kernel.org>=
 wrote:
>
> On Wed, 29 Nov 2023, Mat Martineau wrote:
>
> > On Wed, 29 Nov 2023, Maxim Galaganov wrote:
> >
> >> Support for IP_BIND_ADDRESS_NO_PORT sockopt was introduced in [1].
> >> Recently [2] allowed its value to be accessed without locking the
> >> socket.
> >>
> >> Support for (newer) IP_LOCAL_PORT_RANGE sockopt was introduced in [3].
> >> In the same series a selftest was added in [4]. This selftest also
> >> covers the IP_BIND_ADDRESS_NO_PORT sockopt.
> >>
> >> This patch enables getsockopt()/setsockopt() on MPTCP sockets for thes=
e
> >> socket options, syncing set values to subflows in sync_socket_options(=
).
> >> Ephemeral port range is synced to subflows, enabling NAT usecase
> >> described in [3].
> >>
> >> [1] commit 90c337da1524 ("inet: add IP_BIND_ADDRESS_NO_PORT to overcom=
e
> >> bind(0) limitations")
> >> [2] commit ca571e2eb7eb ("inet: move inet->bind_address_no_port to
> >> inet->inet_flags")
> >> [3] commit 91d0b78c5177 ("inet: Add IP_LOCAL_PORT_RANGE socket option"=
)
> >> [4] commit ae5439658cce ("selftests/net: Cover the IP_LOCAL_PORT_RANGE
> >> socket option")
> >>
> >> Signed-off-by: Maxim Galaganov <max@internet.ru>
> >
> > Thanks for the v2 Maxim, looks good to me:
> >
> > Reviewed-by: Mat Martineau <martineau@kernel.org>
> >
>
> Now that I've signed off on this, I see that there's work going on to
> change the implementation of local_port_range:
>
> https://lore.kernel.org/netdev/a4f5b61c9cd44eada41d8f09d3848806@AcuMS.acu=
lab.com/
>
> I think it makes sense to do a v3 of this series if a version of David's
> patch gets merged soon (I expect a v2 as he got some feedback from me and
> some others). I'll watch for progress with his patch on netdev.

Maxim -

It looks like this patch will be merged to net-next soon:

https://lore.kernel.org/netdev/4e505d4198e946a8be03fb1b4c3072b0@AcuMS.acula=
b.com/

Please cherry-pick that and update your IP_LOCAL_PORT_RANGE patch to
fit the new implementation.

Thanks!

- Mat


>
> >> ---
> >> net/mptcp/sockopt.c | 29 ++++++++++++++++++++++++++++-
> >> 1 file changed, 28 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> >> index a4bf337e6f77..a164a3e21be4 100644
> >> --- a/net/mptcp/sockopt.c
> >> +++ b/net/mptcp/sockopt.c
> >> @@ -440,6 +440,8 @@ static bool mptcp_supported_sockopt(int level, int
> >> optname)
> >>              /* should work fine */
> >>              case IP_FREEBIND:
> >>              case IP_TRANSPARENT:
> >> +            case IP_BIND_ADDRESS_NO_PORT:
> >> +            case IP_LOCAL_PORT_RANGE:
> >>
> >>              /* the following are control cmsg related */
> >>              case IP_PKTINFO:
> >> @@ -455,7 +457,6 @@ static bool mptcp_supported_sockopt(int level, int
> >> optname)
> >>              /* common stuff that need some love */
> >>              case IP_TOS:
> >>              case IP_TTL:
> >> -            case IP_BIND_ADDRESS_NO_PORT:
> >>              case IP_MTU_DISCOVER:
> >>              case IP_RECVERR:
> >>
> >> @@ -688,6 +689,7 @@ static int mptcp_setsockopt_sol_ip_set(struct
> >> mptcp_sock *msk, int optname,
> >> {
> >>      struct sock *sk =3D (struct sock *)msk;
> >>      struct sock *ssk;
> >> +    bool slow;
> >>      int err;
> >>
> >>      err =3D ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
> >> @@ -710,6 +712,16 @@ static int mptcp_setsockopt_sol_ip_set(struct
> >> mptcp_sock *msk, int optname,
> >>              inet_assign_bit(TRANSPARENT, ssk,
> >>                              inet_test_bit(TRANSPARENT, sk));
> >>              break;
> >> +    case IP_BIND_ADDRESS_NO_PORT:
> >> +            inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk,
> >> +                            inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
> >> +            break;
> >> +    case IP_LOCAL_PORT_RANGE:
> >> +            slow =3D lock_sock_fast(ssk);
> >> +            inet_sk(ssk)->local_port_range.lo =3D
> >> inet_sk(sk)->local_port_range.lo;
> >> +            inet_sk(ssk)->local_port_range.hi =3D
> >> inet_sk(sk)->local_port_range.hi;
> >> +            unlock_sock_fast(ssk, slow);
> >> +            break;
> >>      default:
> >>              release_sock(sk);
> >>              WARN_ON_ONCE(1);
> >> @@ -755,6 +767,8 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *=
msk,
> >> int optname,
> >>      switch (optname) {
> >>      case IP_FREEBIND:
> >>      case IP_TRANSPARENT:
> >> +    case IP_BIND_ADDRESS_NO_PORT:
> >> +    case IP_LOCAL_PORT_RANGE:
> >>              return mptcp_setsockopt_sol_ip_set(msk, optname, optval,
> >> optlen);
> >>      case IP_TOS:
> >>              return mptcp_setsockopt_v4_set_tos(msk, optname, optval,
> >> optlen);
> >> @@ -1346,10 +1360,20 @@ static int mptcp_getsockopt_v4(struct mptcp_so=
ck
> >> *msk, int optname,
> >>                             char __user *optval, int __user *optlen)
> >> {
> >>      struct sock *sk =3D (void *)msk;
> >> +    bool slow;
> >> +    int val;
> >>
> >>      switch (optname) {
> >>      case IP_TOS:
> >>              return mptcp_put_int_option(msk, optval, optlen,
> >> READ_ONCE(inet_sk(sk)->tos));
> >> +    case IP_BIND_ADDRESS_NO_PORT:
> >> +            return mptcp_put_int_option(msk, optval, optlen,
> >> +                            inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
> >> +    case IP_LOCAL_PORT_RANGE:
> >> +            slow =3D lock_sock_fast(sk);
> >> +            val =3D inet_sk(sk)->local_port_range.hi << 16 |
> >> inet_sk(sk)->local_port_range.lo;
> >> +            unlock_sock_fast(sk, slow);
> >> +            return mptcp_put_int_option(msk, optval, optlen, val);
> >>      }
> >>
> >>      return -EOPNOTSUPP;
> >> @@ -1450,6 +1474,9 @@ static void sync_socket_options(struct mptcp_soc=
k
> >> *msk, struct sock *ssk)
> >>
> >>      inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk))=
;
> >>      inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
> >> +    inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk,
> >> inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
> >> +    inet_sk(ssk)->local_port_range.lo =3D inet_sk(sk)->local_port_ran=
ge.lo;
> >> +    inet_sk(ssk)->local_port_range.hi =3D inet_sk(sk)->local_port_ran=
ge.hi;
> >> }
> >>
> >> void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ss=
k)
> >> --
> >> 2.43.0
> >>
> >>
> >>
> >
