Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B07ED
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 17:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676914127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0m/OULLC/ZDr3JQKxK9TP4YJe8Brr1/Y0DVVOdJV82o=;
	b=YiKpX+rEJ4MVJMoVsDCbQAwp+LtzFpR0mIfmMsd3yU76wumwpOv6c3uocZgRuxxfGAiFgI
	R5Q4Pp1GEXz+FiYGpYKc7kHhs330WhAARUHoDRNx95E0vu1Niy49l1mw6iTUzUgT3+Z+kv
	LrQCyaz4za5Ap3rrlwP/WhUmRd4+4YY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-474-r7fNBYVuMY-EDM1tz7poAg-1; Mon, 20 Feb 2023 12:28:46 -0500
X-MC-Unique: r7fNBYVuMY-EDM1tz7poAg-1
Received: by mail-wm1-f72.google.com with SMTP id l23-20020a7bc457000000b003e206cbce8dso866987wmi.7
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 09:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676914124;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aoc9/RyM75ukdo0yfoCTLaj3Z6xRbqaa19AaQjlW2aY=;
        b=yDCVURu1ld5obCgfKPMarUiNckPV5nXWWImuCJ2ClL7x//cc5jdSxtLCQbgFS0kvsm
         vj4BAORIxGDty5XPBEvEixaii4YiSdgFD25A4nSZtBZvskhSraQ/ogeFZDzhrR+/mg2y
         6lvYQWysU09vO/qyZ4oLpc0tbbLfCHC39e6wGZDhxaHMwxwADnzJ0alHQTQlwKYgpq2c
         HdDteQ+rtthBSXd3perMXUNs2tglQSKdFv3A0JCni35Xtk6dEod5uIoeTVzsS8Tr1sHP
         EW8BGXNFPi1AH7lXRnphtVJfg9mDK+Fm1Maeyt/0K/xKj9CPJETrSp5X7SMkXOCJhpuk
         U/0A==
X-Gm-Message-State: AO0yUKVP+0ZEPQjBcC2hXoQr3OUELSs9iwHuGozOVvgWIz4ddyMwrDIY
	+zHSNW0QsJZiYJugfCP96S2NThkgJ/IIFTRycWW+qvYk/hpU9CkLUiTDhjYJk4CSZ9nZeSnCxHm
	GBZ5YlJ1hJWWi2fltvShZvi4jnDZ1oD8HOJZQomDvQGTJVHG2ZprHNn+Fe32Wq2Tvh6zXkQ==
X-Received: by 2002:a05:600c:c0b:b0:3e2:1d9d:f10 with SMTP id fm11-20020a05600c0c0b00b003e21d9d0f10mr1474483wmb.4.1676914124481;
        Mon, 20 Feb 2023 09:28:44 -0800 (PST)
X-Google-Smtp-Source: AK7set+kHKHvoehAgpyBBtEnVMCr8VSvsTAjzBP9pNxRrveTRKhHxDhw93xpdqDZcp/lXRqI8Tj+GQ==
X-Received: by 2002:a05:600c:c0b:b0:3e2:1d9d:f10 with SMTP id fm11-20020a05600c0c0b00b003e21d9d0f10mr1474471wmb.4.1676914124093;
        Mon, 20 Feb 2023 09:28:44 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id x8-20020a1c7c08000000b003dc4480df80sm863116wmc.34.2023.02.20.09.28.43
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:28:43 -0800 (PST)
Message-ID: <32645f98167e697c3138d7c9280692f7e885817e.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] Revert "mptcp: fix locking for in-kernel
 listener creation"
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Mon, 20 Feb 2023 18:28:42 +0100
In-Reply-To: <1cde3460ddf2e5fa7be0e81dd2c3060a663d4ccc.1676909181.git.pabeni@redhat.com>
References: <1cde3460ddf2e5fa7be0e81dd2c3060a663d4ccc.1676909181.git.pabeni@redhat.com>
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

On Mon, 2023-02-20 at 17:10 +0100, Paolo Abeni wrote:
> Christoph reports a lockdep splat in the mptcp_subflow_create_socket()
> error path, when such function is invoked by
> mptcp_pm_nl_create_listen_socket().
>=20
> Such code path acquires two separates, nested socket lock, with the
> internal lock operation lacking the "nested" annotation. Adding that
> in sock_release() for mptcp's sake only could be confusing.
>=20
> Instead we can revert the commit introducing the outermost lock as the
> relevant socket is not exposted in any way to ther user not to the
> stack and can't be touched by any other entity.
>=20
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Fixes: ad2171009d96 ("mptcp: fix locking for in-kernel listener creation"=
)
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/354
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/pm_netlink.c | 14 ++++++++------
>  net/mptcp/subflow.c    |  2 +-
>  2 files changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d1d859517d91..54b0aeb8bb01 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -999,8 +999,8 @@ static int mptcp_pm_nl_create_listen_socket(struct so=
ck *sk,
>  {
>  =09int addrlen =3D sizeof(struct sockaddr_in);
>  =09struct sockaddr_storage addr;
> +=09struct mptcp_sock *msk;
>  =09struct socket *ssock;
> -=09struct sock *newsk;
>  =09int backlog =3D 1024;
>  =09int err;
> =20
> @@ -1009,13 +1009,15 @@ static int mptcp_pm_nl_create_listen_socket(struc=
t sock *sk,
>  =09if (err)
>  =09=09return err;
> =20
> -=09newsk =3D entry->lsk->sk;
> -=09if (!newsk)
> +=09msk =3D mptcp_sk(entry->lsk->sk);
> +=09if (!msk)
>  =09=09return -EINVAL;
> =20
> -=09lock_sock(newsk);
> -=09ssock =3D __mptcp_nmpc_socket(mptcp_sk(newsk));

This can end-up calling mptcp_sockopt_sync() which in turn explicitly
check for the msk socket ownership. So something different is required
:(

I still would try to avoid adding the nested annotation in
sock_release()

/P

