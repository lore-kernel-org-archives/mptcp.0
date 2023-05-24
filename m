Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32915B9
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 06:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684910198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rU6Rc3UEW+v8/ambIvubldoMsjZQMjui8g9QZ9LlGro=;
	b=OsLHMbwsIpaBfBTx8y5C0BtHc2kWhCM4uL/DZcDzt8ULP7Aas/XXiz0k3t5f3E0T8EZdbC
	P82Vs7aaRlxUn4mKLGgp5uoCDkwQ5s5+rYrg3tTv5Kd5os4aZNdXPwvESrpN+cbh9Zy7ZW
	srXcVSzGobwq8AxuAsDChlTKMLkXvgc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-qRntJTzwNBmgDbzk-JyD-A-1; Wed, 24 May 2023 02:36:36 -0400
X-MC-Unique: qRntJTzwNBmgDbzk-JyD-A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f602cec801so1018975e9.1
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 23:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910195; x=1687502195;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjhgYZ3hu8VpEMh52yynH3qQaNv4QRBdrrocx0c/9lU=;
        b=IddCF2gCcWJ/xoM2MEhh3C20tz7s8XtMcnc7SKE8FGSHGlinqt3Gxxnwi4nEYeB677
         NRraR3oktaWwcfWWQd3bSg1ujLOrZds19oIf8xVcK+PP38Fgk7w5yPFYtbt3j5impIvg
         Y7SiIkVAaeNShcjSDomgUbUO1kiL9cgNB9fcOGdjW6el6Ba7rf7Fz6HC51vmA0TH7uEp
         4o9HfvPx7S4BcAu/nd1knDXyH8kUfvJreRijD97+s1uYQSgTHw11XCG36bmr0HzXQnnG
         cL4+8p7cs92XDt9yYzYarQCMMghnHTLLFUF+jCltGJGusjuE5zDjcc8uhMigllfCpi/M
         /y2g==
X-Gm-Message-State: AC+VfDxL07YPPA2vA47Z81l7PgvPXgwNl2CIAgp7HxOL+XU5Hm3Ggme4
	WueQ0H3oD2sOKo/p8e3KOTmB5PJ2pV58U8wzpg2MHSXrpZLeF/mm6GHK7j+LExyEzy6YBOnwIU+
	HnlQ5wUsIzIsehtQ=
X-Received: by 2002:a05:600c:4e93:b0:3f1:7490:e595 with SMTP id f19-20020a05600c4e9300b003f17490e595mr1155600wmq.2.1684910195370;
        Tue, 23 May 2023 23:36:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5rgA4n8Ogim/GXsV3mqzWkkhLXeL2E5E7InKseX5Y6ze89TF4Afai2gSfXCgr07NbZVZL4TQ==
X-Received: by 2002:a05:600c:4e93:b0:3f1:7490:e595 with SMTP id f19-20020a05600c4e9300b003f17490e595mr1155579wmq.2.1684910195037;
        Tue, 23 May 2023 23:36:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-207.dyn.eolo.it. [146.241.242.207])
        by smtp.gmail.com with ESMTPSA id n11-20020a7bcbcb000000b003f5ffba9ae1sm1169040wmi.24.2023.05.23.23.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:36:34 -0700 (PDT)
Message-ID: <d48dcb197962141d36529c16f6bb365d4599846f.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Wed, 24 May 2023 08:36:33 +0200
In-Reply-To: <62d7d915a3536e9bf37770952838308d8f41ad8b.camel@redhat.com>
References: <cover.1684863309.git.pabeni@redhat.com>
	 <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
	 <ZG0FL9XM-MFgfyQ-@strlen.de>
	 <62d7d915a3536e9bf37770952838308d8f41ad8b.camel@redhat.com>
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

On Wed, 2023-05-24 at 08:34 +0200, Paolo Abeni wrote:
> On Tue, 2023-05-23 at 20:25 +0200, Florian Westphal wrote:
> > Paolo Abeni <pabeni@redhat.com> wrote:
> > > Some user-space applications want to monitor the subflows utilization=
.
> > >=20
> > > Dumping the per subflow tcp_info is not enough, as the PM could close
> > > and re-create the subflows under-the-hood, fooling the accounting.
> > > Even checking the src/dst addresses used by each subflow could not
> > > be enough, because new subflows could re-use the same address/port of
> > > the just closed one.
> > >=20
> > > This patch introduces a new socket option, allow dumping all the rele=
vant
> > > information all-at-once (everything, everywhere...), in a consistent =
manner.
> > >=20
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > v2 -> v3:
> > >  - added missing changelog (oops)
> > > ---
> > >  include/uapi/linux/mptcp.h | 16 ++++++++
> > >  net/mptcp/sockopt.c        | 75 ++++++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 91 insertions(+)
> > >=20
> > > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> > > index 32af2d278cb4..f4f42d88e58b 100644
> > > --- a/include/uapi/linux/mptcp.h
> > > +++ b/include/uapi/linux/mptcp.h
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/in.h>=09=09/* for sockaddr_in=09=09=09*/
> > >  #include <linux/in6.h>=09=09/* for sockaddr_in6=09=09=09*/
> > >  #include <linux/socket.h>=09/* for sockaddr_storage and sa_family=09=
*/
> > > +#include <linux/tcp.h>=09=09/* for tcp_info=09=09=09=09*/
> > > =20
> > >  #define MPTCP_SUBFLOW_FLAG_MCAP_REM=09=09_BITUL(0)
> > >  #define MPTCP_SUBFLOW_FLAG_MCAP_LOC=09=09_BITUL(1)
> > > @@ -244,9 +245,24 @@ struct mptcp_subflow_addrs {
> > >  =09};
> > >  };
> > > =20
> > > +struct mptcp_subflow_info {
> > > +=09__u32=09=09=09=09id;
> > > +=09struct mptcp_subflow_addrs=09addrs;
> > > +};
> > > +
> > > +/* struct subflow_info is not supposed nor allowed to grow in
> > > + * future versions.
> > > + * If need will arise, a new socket option should be added.
> > > + */
> > > +struct mptcp_subflow_full_info {
> > > +=09struct mptcp_subflow_info=09subflow_info;
> > > +=09struct tcp_info=09=09=09tcp_info;
> > > +};
> >=20
> > I dislike this constraint.
> >=20
> > Why not do something like this:
> >=20
> > struct mptcp_subflow_full_info {
> > =09__u32=09=09size_subflow_full_info;         /* size of this structure=
 in userspace */
> > =09__u32           num_subflows_user;              /* max subflows that=
 userspace is interested in */
> > =09__u32           num_subflows_kern;              /* must be 0, set by=
 kernel (real subflow count) */
> > =09__u32=09=09num_subflows_copied;=09=09/* must be 0, set by kernel (nu=
mber of subflow infos copied back)
> >         __u32           size_sfinfo_kernel;=09=09/* must be 0, set by k=
ernel */
> >         __u32           size_sfinfo_user;
> >         __u32           size_tcpinfo_kernel;            /* must be 0, s=
et by kernel */
> >         __u32           size_tcpinfo_user;
> > =09__aligned_u64=09subflow_info_addr;
> > =09__aligned_u64=09tcp_info_addr;
> > };
> >=20
> > userspace does:
> >=20
> > x =3D calloc(sizeof(struct mptcp_subflow_info), 42);
> > y =3D calloc(sizeof(struct tcp_info), 42);
> >=20
> > struct mptcp_subflow_full_info {
> > =09.size_subflow_full_info =3D sizeof(struct mptcp_subflow_full_info),
> > =09.num_subflows_user =3D 42,
> > =09.size_sfinfo_user =3D sizeof(struct mptcp_subflow_info),
> > =09.size_tcpinfo_user =3D sizeof(struct mptcp_subflow_info),
> > =09.subflow_info_addr =3D (u64)x,
> > =09.tcp_info_addr =3D (u64)y,
> > };
> >=20
> > kernel does:
> > 1. put_user() the real sizes uses by the kernel
> > 2. put_user() the real subflow count
> > 3. copy subflow_info_addr and tcp_info_addr addresses
> > 4. treat as userspace pointers
> >=20
> > for each subflow, copy tcpinfo and subflow info to the
> > two arrays provided by userspace.
> >=20
> > Kernel truncates copied data via size_sfinfo_user/size_tcpinfo_user so
> > that new kernel won't populate fields that don't exist in userspace.
> >=20
> > Kernel stops copying after 'num_subflows_user' or 'num_subflows_kern',
> > whatever comes first and updates num_subflows_copied to the real copied
> > value.
> >=20
> > This allows userspace to discover when kernel had more subflows
> > but could not place the data due to lack of space in the
> > userspace-provided arrays.
> >=20
> > This is more complicated but no need to add new MPTCP_FULL_INFO_V2/V3/V=
4
> > etc. in the future.
> >=20
> > What do you think?
>=20
> I ended-up with the current code trying to re-use as much as possible
> from the existing infra - specifically the
> mptcp_get_subflow_data()/mptcp_put_subflow_data() helpers.
>=20
> I agree the constraint on mptcp_subflow_full_info is not nice,
> especially if we want to include subflow level indormation alike
> local/remote address id, flags, etc...
>=20
> Isn't num_subflows_copied always implied? =3D=3D min(num_subflows_user,
> num_subflows_kern).
>=20
> Otherwise LGTM, I'll try to have a spin.

Oops, I forgot... should mptcp_subflow_full_info contain mptcp_info,
too? Overall layout:

struct mptcp_subflow_full_info {
=09__u32=09=09size_subflow_full_info;         /* size of this structure in =
userspace */
=09__u32           num_subflows_user;              /* max subflows that use=
rspace is interested in */
=09__u32           num_subflows_kern;              /* must be 0, set by ker=
nel (real subflow count) */
        __u32           size_sfinfo_kernel;=09=09/* must be 0, set by kerne=
l */
        __u32           size_sfinfo_user;
        __u32           size_tcpinfo_kernel;            /* must be 0, set b=
y kernel */
        __u32           size_tcpinfo_user;
=09__aligned_u64=09subflow_info_addr;
=09__aligned_u64=09tcp_info_addr;
=09struct mptcp_info mptcp_indo;
};

