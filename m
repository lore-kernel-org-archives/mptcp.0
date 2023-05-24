Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5C15B9
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 06:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684910051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptVhqVUkAgwUKUntKhSC3glMbJ/PqButhQH2NfPzSzk=;
	b=TM7ze2QsKcw5srZncmkpOP9mipS6/EHZSgsRd0Z4yKOLVi97xyuGFNvVhw6xTpqOSuCcTY
	pgJMSJ/JaIRanAvUyzTA+Y1PbXWf18aPGClf/seifhmh7/6M+z/+D9cGffYQp0lKT6y9xi
	sgh6DA3m1J2o1w5OPYSm44w5eaiYc+c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-D_HXUQYxNRmrb9-N7Ipjyg-1; Wed, 24 May 2023 02:34:09 -0400
X-MC-Unique: D_HXUQYxNRmrb9-N7Ipjyg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f603380047so20745e9.1
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 23:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910048; x=1687502048;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BomtncFG/HJTSXwlUFR48qEKB+5bcPLPWLiXgDAlc3c=;
        b=RaYKCUnLqqPvlDtVATeBt3o4FfXdY3WClTTA2cBYIoOUXCpROeTUi7V0LtUNhS7TFy
         mjYetL8/iDaiVprypQc6+4e2/mgnStk4qLuJ0iMgtbYulB2ABJy4G1MZO40zPL4IXCwb
         Qs2jA59SGoJf7KSGDGFx/oYZWjG4uyZjP/KF2PXEuoRqidWe53FDhFhlv6xPMX9rsbxz
         J1eR5S0eyoZD2rJNgar2nZiYaZ7rVZleEgynkTLqK3qVo3bNgFNqLntk5giAnlX4AwVb
         +cOWbIT/ix7evC6gYWd4KmqGuS1w1z1U+IklMgpCbUfsEPdO5xz0ZdWGy/3XFfj7QVoy
         umJg==
X-Gm-Message-State: AC+VfDyLZNZrvO7KIhilinVafzgK6ZXMyNuhEba1CV5UCtQcuRFSQ1B3
	DnOU2tm2leupkFmxXXBOrxoiZoJUABXAcpzFL3Ae5SoYGypR4JjVVw2SAJgRfh1sZf0d7Apw4G/
	zqI40lFYBAS6COxA505NOils=
X-Received: by 2002:a05:600c:3ba5:b0:3f5:ffe8:94ac with SMTP id n37-20020a05600c3ba500b003f5ffe894acmr9574005wms.0.1684910048552;
        Tue, 23 May 2023 23:34:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7u2DmBBphKgiKFKa4QeTkHB0qTGAqAnfw03RryI6qaQj824UxXeq7T4Dbxz0pLDFWYfunuyA==
X-Received: by 2002:a05:600c:3ba5:b0:3f5:ffe8:94ac with SMTP id n37-20020a05600c3ba500b003f5ffe894acmr9573984wms.0.1684910048202;
        Tue, 23 May 2023 23:34:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-207.dyn.eolo.it. [146.241.242.207])
        by smtp.gmail.com with ESMTPSA id q2-20020a5d61c2000000b00309382eb047sm13302769wrv.112.2023.05.23.23.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:34:07 -0700 (PDT)
Message-ID: <62d7d915a3536e9bf37770952838308d8f41ad8b.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Wed, 24 May 2023 08:34:06 +0200
In-Reply-To: <ZG0FL9XM-MFgfyQ-@strlen.de>
References: <cover.1684863309.git.pabeni@redhat.com>
	 <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
	 <ZG0FL9XM-MFgfyQ-@strlen.de>
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

On Tue, 2023-05-23 at 20:25 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > Some user-space applications want to monitor the subflows utilization.
> >=20
> > Dumping the per subflow tcp_info is not enough, as the PM could close
> > and re-create the subflows under-the-hood, fooling the accounting.
> > Even checking the src/dst addresses used by each subflow could not
> > be enough, because new subflows could re-use the same address/port of
> > the just closed one.
> >=20
> > This patch introduces a new socket option, allow dumping all the releva=
nt
> > information all-at-once (everything, everywhere...), in a consistent ma=
nner.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v2 -> v3:
> >  - added missing changelog (oops)
> > ---
> >  include/uapi/linux/mptcp.h | 16 ++++++++
> >  net/mptcp/sockopt.c        | 75 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 91 insertions(+)
> >=20
> > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> > index 32af2d278cb4..f4f42d88e58b 100644
> > --- a/include/uapi/linux/mptcp.h
> > +++ b/include/uapi/linux/mptcp.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/in.h>=09=09/* for sockaddr_in=09=09=09*/
> >  #include <linux/in6.h>=09=09/* for sockaddr_in6=09=09=09*/
> >  #include <linux/socket.h>=09/* for sockaddr_storage and sa_family=09*/
> > +#include <linux/tcp.h>=09=09/* for tcp_info=09=09=09=09*/
> > =20
> >  #define MPTCP_SUBFLOW_FLAG_MCAP_REM=09=09_BITUL(0)
> >  #define MPTCP_SUBFLOW_FLAG_MCAP_LOC=09=09_BITUL(1)
> > @@ -244,9 +245,24 @@ struct mptcp_subflow_addrs {
> >  =09};
> >  };
> > =20
> > +struct mptcp_subflow_info {
> > +=09__u32=09=09=09=09id;
> > +=09struct mptcp_subflow_addrs=09addrs;
> > +};
> > +
> > +/* struct subflow_info is not supposed nor allowed to grow in
> > + * future versions.
> > + * If need will arise, a new socket option should be added.
> > + */
> > +struct mptcp_subflow_full_info {
> > +=09struct mptcp_subflow_info=09subflow_info;
> > +=09struct tcp_info=09=09=09tcp_info;
> > +};
>=20
> I dislike this constraint.
>=20
> Why not do something like this:
>=20
> struct mptcp_subflow_full_info {
> =09__u32=09=09size_subflow_full_info;         /* size of this structure i=
n userspace */
> =09__u32           num_subflows_user;              /* max subflows that u=
serspace is interested in */
> =09__u32           num_subflows_kern;              /* must be 0, set by k=
ernel (real subflow count) */
> =09__u32=09=09num_subflows_copied;=09=09/* must be 0, set by kernel (numb=
er of subflow infos copied back)
>         __u32           size_sfinfo_kernel;=09=09/* must be 0, set by ker=
nel */
>         __u32           size_sfinfo_user;
>         __u32           size_tcpinfo_kernel;            /* must be 0, set=
 by kernel */
>         __u32           size_tcpinfo_user;
> =09__aligned_u64=09subflow_info_addr;
> =09__aligned_u64=09tcp_info_addr;
> };
>=20
> userspace does:
>=20
> x =3D calloc(sizeof(struct mptcp_subflow_info), 42);
> y =3D calloc(sizeof(struct tcp_info), 42);
>=20
> struct mptcp_subflow_full_info {
> =09.size_subflow_full_info =3D sizeof(struct mptcp_subflow_full_info),
> =09.num_subflows_user =3D 42,
> =09.size_sfinfo_user =3D sizeof(struct mptcp_subflow_info),
> =09.size_tcpinfo_user =3D sizeof(struct mptcp_subflow_info),
> =09.subflow_info_addr =3D (u64)x,
> =09.tcp_info_addr =3D (u64)y,
> };
>=20
> kernel does:
> 1. put_user() the real sizes uses by the kernel
> 2. put_user() the real subflow count
> 3. copy subflow_info_addr and tcp_info_addr addresses
> 4. treat as userspace pointers
>=20
> for each subflow, copy tcpinfo and subflow info to the
> two arrays provided by userspace.
>=20
> Kernel truncates copied data via size_sfinfo_user/size_tcpinfo_user so
> that new kernel won't populate fields that don't exist in userspace.
>=20
> Kernel stops copying after 'num_subflows_user' or 'num_subflows_kern',
> whatever comes first and updates num_subflows_copied to the real copied
> value.
>=20
> This allows userspace to discover when kernel had more subflows
> but could not place the data due to lack of space in the
> userspace-provided arrays.
>=20
> This is more complicated but no need to add new MPTCP_FULL_INFO_V2/V3/V4
> etc. in the future.
>=20
> What do you think?

I ended-up with the current code trying to re-use as much as possible
from the existing infra - specifically the
mptcp_get_subflow_data()/mptcp_put_subflow_data() helpers.

I agree the constraint on mptcp_subflow_full_info is not nice,
especially if we want to include subflow level indormation alike
local/remote address id, flags, etc...

Isn't num_subflows_copied always implied? =3D=3D min(num_subflows_user,
num_subflows_kern).

Otherwise LGTM, I'll try to have a spin.

Thanks!

Paolo

