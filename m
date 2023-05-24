Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031288480
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684915897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZHbhNIbnkqmab/V7YEpVv8t6i3D7XGG+yUIy3u+dhA=;
	b=ebS/gcfakHJv68VGdo6PPnswud3+zrpch3sUdqoxFGNb+Uka90ceyNPr+79hNstDHLq2zh
	9VnOrMHFhrYbSWftECkqe87h1KzA/cTqyO/GdAqWUWr2VgluRd2D5o+/88j22xOqGicAgE
	Gf87qi/eZMR9Dd1V7m42nQNlYfENjxM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-UvpfIoO2MjGlw5EJJ1Kalg-1; Wed, 24 May 2023 04:11:36 -0400
X-MC-Unique: UvpfIoO2MjGlw5EJJ1Kalg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f607da7cdbso1189275e9.0
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 01:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684915895; x=1687507895;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UgZ4l81sUsLfdHOTOW0JGCFPv6Nf6AS9q1Zmm5Kjj54=;
        b=ID3OITFVqjzLjm3Paq1aqaS+xxH4TFhFpJ9ryvE8UNE1K4AWC0KHoane+GXA1ZabbV
         yWszCQclALqj5Df+oIis/tWzhWj+G/C3PxMfSlHdMCoTzGnZcnQwuQrWPf0sL6jIBGxO
         +MuChLBQ9FzghK+NATyZ8CytqKXFeeMSd18edQOBqVYUQc7UlAq6IlHVoZnjufYSXWNv
         dto2c1o/HsegtY18iwtCyDzfpwfzYL0B45r3iY48ByrFbUJyrIg8r0rJKEK1rspnwAJJ
         TzzHMbIwHJcfEr4Jhz2i+YqmV7s3jD7FwWt2RMzci/55vXbdCIZqv+Kwloxv7TEpPJ3J
         y9jg==
X-Gm-Message-State: AC+VfDzQ9cYrWvwUu+6YU+2d2IfcKyn5KCpobD4MFPMuppxqP3Rlm4/x
	AanlVQE1lxOR5p5k4FqEHZ6AmEqxOy8j6VIql765UzKBfkfSd4vBmBy7cdm9+0hqg9Yhfio5CpU
	/bRA3lSWVMc0Y1gM=
X-Received: by 2002:a05:600c:3844:b0:3f6:d8f:63a8 with SMTP id s4-20020a05600c384400b003f60d8f63a8mr1445055wmr.0.1684915895154;
        Wed, 24 May 2023 01:11:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61Wx/pxq+qwqhch0Ev0WDNjKB3EcIa1jVZalL6LpHt+Jm6wOEFlygzVhcy7SAmxcFObweVfA==
X-Received: by 2002:a05:600c:3844:b0:3f6:d8f:63a8 with SMTP id s4-20020a05600c384400b003f60d8f63a8mr1445028wmr.0.1684915894785;
        Wed, 24 May 2023 01:11:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-207.dyn.eolo.it. [146.241.242.207])
        by smtp.gmail.com with ESMTPSA id z26-20020a05600c221a00b003f60101074dsm1411831wml.33.2023.05.24.01.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 01:11:34 -0700 (PDT)
Message-ID: <b2db55ec8e8aaf06b562236150c4f111e38f6f21.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Florian Westphal
	 <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Wed, 24 May 2023 10:11:33 +0200
In-Reply-To: <f21e784f-8c97-f876-848b-f909d4e1daf0@tessares.net>
References: <cover.1684863309.git.pabeni@redhat.com>
	 <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
	 <ZG0FL9XM-MFgfyQ-@strlen.de>
	 <62d7d915a3536e9bf37770952838308d8f41ad8b.camel@redhat.com>
	 <d48dcb197962141d36529c16f6bb365d4599846f.camel@redhat.com>
	 <f21e784f-8c97-f876-848b-f909d4e1daf0@tessares.net>
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

On Wed, 2023-05-24 at 09:36 +0200, Matthieu Baerts wrote:
> Hi Paolo, Florian,
>=20
> On 24/05/2023 08:36, Paolo Abeni wrote:
> > On Wed, 2023-05-24 at 08:34 +0200, Paolo Abeni wrote:
> > > On Tue, 2023-05-23 at 20:25 +0200, Florian Westphal wrote:
> > > > Paolo Abeni <pabeni@redhat.com> wrote:
> > > > > Some user-space applications want to monitor the subflows utiliza=
tion.
> > > > >=20
> > > > > Dumping the per subflow tcp_info is not enough, as the PM could c=
lose
> > > > > and re-create the subflows under-the-hood, fooling the accounting=
.
> > > > > Even checking the src/dst addresses used by each subflow could no=
t
> > > > > be enough, because new subflows could re-use the same address/por=
t of
> > > > > the just closed one.
> > > > >=20
> > > > > This patch introduces a new socket option, allow dumping all the =
relevant
> > > > > information all-at-once (everything, everywhere...), in a consist=
ent manner.
> > > > >=20
> > > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > > ---
> > > > > v2 -> v3:
> > > > >  - added missing changelog (oops)
> > > > > ---
> > > > >  include/uapi/linux/mptcp.h | 16 ++++++++
> > > > >  net/mptcp/sockopt.c        | 75 ++++++++++++++++++++++++++++++++=
++++++
> > > > >  2 files changed, 91 insertions(+)
> > > > >=20
> > > > > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptc=
p.h
> > > > > index 32af2d278cb4..f4f42d88e58b 100644
> > > > > --- a/include/uapi/linux/mptcp.h
> > > > > +++ b/include/uapi/linux/mptcp.h
> > > > > @@ -12,6 +12,7 @@
> > > > >  #include <linux/in.h>=09=09/* for sockaddr_in=09=09=09*/
> > > > >  #include <linux/in6.h>=09=09/* for sockaddr_in6=09=09=09*/
> > > > >  #include <linux/socket.h>=09/* for sockaddr_storage and sa_famil=
y=09*/
> > > > > +#include <linux/tcp.h>=09=09/* for tcp_info=09=09=09=09*/
> > > > > =20
> > > > >  #define MPTCP_SUBFLOW_FLAG_MCAP_REM=09=09_BITUL(0)
> > > > >  #define MPTCP_SUBFLOW_FLAG_MCAP_LOC=09=09_BITUL(1)
> > > > > @@ -244,9 +245,24 @@ struct mptcp_subflow_addrs {
> > > > >  =09};
> > > > >  };
> > > > > =20
> > > > > +struct mptcp_subflow_info {
> > > > > +=09__u32=09=09=09=09id;
> > > > > +=09struct mptcp_subflow_addrs=09addrs;
> > > > > +};
> > > > > +
> > > > > +/* struct subflow_info is not supposed nor allowed to grow in
> > > > > + * future versions.
> > > > > + * If need will arise, a new socket option should be added.
> > > > > + */
> > > > > +struct mptcp_subflow_full_info {
> > > > > +=09struct mptcp_subflow_info=09subflow_info;
> > > > > +=09struct tcp_info=09=09=09tcp_info;
> > > > > +};
> > > >=20
> > > > I dislike this constraint.
> > > >=20
> > > > Why not do something like this:
> > > >=20
> > > > struct mptcp_subflow_full_info {
> > > > =09__u32=09=09size_subflow_full_info;         /* size of this struc=
ture in userspace */
> > > > =09__u32           num_subflows_user;              /* max subflows =
that userspace is interested in */
> > > > =09__u32           num_subflows_kern;              /* must be 0, se=
t by kernel (real subflow count) */
> > > > =09__u32=09=09num_subflows_copied;=09=09/* must be 0, set by kernel=
 (number of subflow infos copied back)
> > > >         __u32           size_sfinfo_kernel;=09=09/* must be 0, set =
by kernel */
> > > >         __u32           size_sfinfo_user;
> > > >         __u32           size_tcpinfo_kernel;            /* must be =
0, set by kernel */
> > > >         __u32           size_tcpinfo_user;
> > > > =09__aligned_u64=09subflow_info_addr;
> > > > =09__aligned_u64=09tcp_info_addr;
> > > > };
> > > >=20
> > > > userspace does:
> > > >=20
> > > > x =3D calloc(sizeof(struct mptcp_subflow_info), 42);
> > > > y =3D calloc(sizeof(struct tcp_info), 42);
> > > >=20
> > > > struct mptcp_subflow_full_info {
> > > > =09.size_subflow_full_info =3D sizeof(struct mptcp_subflow_full_inf=
o),
> > > > =09.num_subflows_user =3D 42,
> > > > =09.size_sfinfo_user =3D sizeof(struct mptcp_subflow_info),
> > > > =09.size_tcpinfo_user =3D sizeof(struct mptcp_subflow_info),
> > > > =09.subflow_info_addr =3D (u64)x,
> > > > =09.tcp_info_addr =3D (u64)y,
> > > > };
> > > >=20
> > > > kernel does:
> > > > 1. put_user() the real sizes uses by the kernel
> > > > 2. put_user() the real subflow count
> > > > 3. copy subflow_info_addr and tcp_info_addr addresses
> > > > 4. treat as userspace pointers
> > > >=20
> > > > for each subflow, copy tcpinfo and subflow info to the
> > > > two arrays provided by userspace.
> > > >=20
> > > > Kernel truncates copied data via size_sfinfo_user/size_tcpinfo_user=
 so
> > > > that new kernel won't populate fields that don't exist in userspace=
.
> > > >=20
> > > > Kernel stops copying after 'num_subflows_user' or 'num_subflows_ker=
n',
> > > > whatever comes first and updates num_subflows_copied to the real co=
pied
> > > > value.
> > > >=20
> > > > This allows userspace to discover when kernel had more subflows
> > > > but could not place the data due to lack of space in the
> > > > userspace-provided arrays.
> > > >=20
> > > > This is more complicated but no need to add new MPTCP_FULL_INFO_V2/=
V3/V4
> > > > etc. in the future.
> > > >=20
> > > > What do you think?
> > >=20
> > > I ended-up with the current code trying to re-use as much as possible
> > > from the existing infra - specifically the
> > > mptcp_get_subflow_data()/mptcp_put_subflow_data() helpers.
> > >=20
> > > I agree the constraint on mptcp_subflow_full_info is not nice,
> > > especially if we want to include subflow level indormation alike
> > > local/remote address id, flags, etc...
> > >=20
> > > Isn't num_subflows_copied always implied? =3D=3D min(num_subflows_use=
r,
> > > num_subflows_kern).
> > >=20
> > > Otherwise LGTM, I'll try to have a spin.
> >=20
> > Oops, I forgot... should mptcp_subflow_full_info contain mptcp_info,
> > too?
>=20
> Good point. Indeed I guess it is very likely someone who want info about
> MPTCP subflow will also want info about the MPTCP connection.
>=20
> > Overall layout:
> >=20
> > struct mptcp_subflow_full_info {
> > =09__u32=09=09size_subflow_full_info;         /* size of this structure=
 in userspace */
> > =09__u32           num_subflows_user;              /* max subflows that=
 userspace is interested in */
> > =09__u32           num_subflows_kern;              /* must be 0, set by=
 kernel (real subflow count) */
> >         __u32           size_sfinfo_kernel;=09=09/* must be 0, set by k=
ernel */
> >         __u32           size_sfinfo_user;
> >         __u32           size_tcpinfo_kernel;            /* must be 0, s=
et by kernel */
> >         __u32           size_tcpinfo_user;
> > =09__aligned_u64=09subflow_info_addr;
> > =09__aligned_u64=09tcp_info_addr;
> > =09struct mptcp_info mptcp_indo;
>=20
> I guess you will need a size for the mptcp_info structure, no?
>=20
> Maybe this should come before the previous ones?

I'm coding the thing right now: it turns out we are better of not
including mptcp_info inside mptcp_subflow_full_info, so the
manipulation schema will look alike the exiting
mptcp_{get,put}_subflow_data().

Also the user mptcp_info size is implied, since is always equal to =20
*optlen - mptcp_subflow_full_info.mptcp_subflow_full_info.=20

/P


