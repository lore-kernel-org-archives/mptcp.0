Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69E2573
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684918396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fx81oUN2Itbd/b5yiIAy+Q7P3tW+3PzZYYOwD4ftGRE=;
	b=J9ARhOP+REwmfxIXMsEGy2PhAw/vy19dFJNZlnV446UawaV59+/00wIkiLESx/yvJBMQae
	ZWHptEXs0E/xerQAMoi6XNYigEG6abyGBmRC24qbDC7gj1whi0kuH87o9GOpY7uo+nAdo8
	hTP8i/IGMllq2N222DqOu7C9JUoVTA4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-ZfQ5S_LMNoOvC7I9dlSdjA-1; Wed, 24 May 2023 04:53:14 -0400
X-MC-Unique: ZfQ5S_LMNoOvC7I9dlSdjA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30944ad9089so82193f8f.1
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 01:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684918393; x=1687510393;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjgPQ6L11qbS7TMm8bOFBNBC2OPithgfPvdMYOOWvNQ=;
        b=gICKuCzcnG1GvRaizJ/6f5oxSrW79WhewSsDkQSmUswqOCNqJX4tIiECPmP2pkpdN4
         ugtt5eersSC8k+1s3NXNw6lf7fglatEDvAF1Mqec1r8d/vy9BxigpN6ohqVEw/kjvy7M
         lIkL5xw2FNo0RuhSme5NSO/ZQVduIsjzkVGax8veg56q6hYda/A42yFR0JAlmXbn1vSV
         bqdpKHI5WwDQx6uAs7FpZogm8QUtcM94v9u3EFEj3ig7ef7hS9/XWbjyOzl1zFL1N+i3
         rGO/KVRRSwRhTgh6EpEfOAxSIHuZgqfRrNGMwx/SiaipuOk7wv18WT9nkD9H1B/3DuxH
         rrxg==
X-Gm-Message-State: AC+VfDx/znHHydORK+7loyF2I8qdeZvEHC5tJaFj6dtlYTeSDSlcW7kU
	TdQbfnT+GHmPTXacqcQPrGqp3o+/MalTmfgvEyr7V9d+5V7hMrBisfy+t/kg7GBM9WdxGVS1dSW
	8VQRHn4D14dthxR4=
X-Received: by 2002:a05:600c:5107:b0:3f6:487:f058 with SMTP id o7-20020a05600c510700b003f60487f058mr7430300wms.1.1684918393597;
        Wed, 24 May 2023 01:53:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ527Y5tR8xTuxqm35hmRI1rTCtYMnh96BwqYv+WJ6l+qlmwBLbm5OIJsO0MV/8SOZBj0UspkQ==
X-Received: by 2002:a05:600c:5107:b0:3f6:487:f058 with SMTP id o7-20020a05600c510700b003f60487f058mr7430282wms.1.1684918393227;
        Wed, 24 May 2023 01:53:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-207.dyn.eolo.it. [146.241.242.207])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bcd08000000b003f17848673fsm1551599wmj.27.2023.05.24.01.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 01:53:12 -0700 (PDT)
Message-ID: <af0b81822ea9a84da672c2f206e9c1635e57fb65.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Florian Westphal
	 <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Wed, 24 May 2023 10:53:11 +0200
In-Reply-To: <fe2191fe-6842-7662-d300-0aa88cdb9827@tessares.net>
References: <cover.1684863309.git.pabeni@redhat.com>
	 <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
	 <ZG0FL9XM-MFgfyQ-@strlen.de>
	 <fe2191fe-6842-7662-d300-0aa88cdb9827@tessares.net>
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

On Wed, 2023-05-24 at 10:13 +0200, Matthieu Baerts wrote:
> Hi Florian,
>=20
> Thank you for your nice review!
>=20
> On 23/05/2023 20:25, Florian Westphal wrote:
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
>=20
> (If we add mptcp_info (cf Paolo's email), better to strip 'subflow')
>=20
> > =09__u32=09=09size_subflow_full_info;         /* size of this structure=
 in userspace */
>=20
> Why do we need this field? Can we not use the option length (int __user
> *optlen) provided by the userspace?

With this we can append arbitrary/variable size mptcp_info at the end.

>=20
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
>=20
> Do we need to have the kernel and user size in different fields?

If we keep, we can re-use the existing code to manipulate this struct.
Also is consistent with other socket option.


> > This is more complicated but no need to add new MPTCP_FULL_INFO_V2/V3/V=
4
> > etc. in the future.
>=20
> If we add mptcp_info structure as mentioned by Paolo, we are getting
> very close the the getsockopt(MPTCP_INFO) from the fork kernel, see the
> section "Get detailed information of your subflows":
>=20
> https://multipath-tcp.org/pmwiki.php/Users/ConfigureMPTCP
>=20
> And the kernel header:
>=20
> https://github.com/multipath-tcp/mptcp/blob/mptcp_trunk/include/uapi/linu=
x/tcp.h#L321-L366
>=20
> > What do you think?
>=20
> If we want to be even more future prove, why not having something more
> flexible where the userspace puts flags of what it wants and then there
> is a kind of TLV structure? Maybe it would be too complex to read/write?
>=20
>=20
>   struct mptcp_tlv_info {
>       __u32 type;
>       __u32 length;
>       __aligned_u64 value;
>   };
>=20
>   struct mptcp_full_info {
>       __u32 flags;
>       __u32 num_subflows;
>       __u32 num_subflows_copied;
>       struct mptcp_tlv_info[];   /* number has to be linked to flags */
>   };
>=20
> Maybe it would be good to add a size for the subflow info structure: if
> we use such TLV structure, for info around subflows, we will need to set
> at least the ID for each subflow (maybe more later). We might then need:
>=20
>   struct mptcp_full_info {
>       (...)
>       __u32 size_mptcp_subflow_info;
>       (...)
>   };
>=20
>   struct mptcp_subflow_info {
>       __u32 id;
>   };
>=20
>   struct mptcp_subflow_addrs {
>       struct mptcp_subflow_info  info;
>       struct mptcp_subflow_addrs addrs;
>   };
>=20
>   struct mptcp_subflow_tcp_info {
>       struct mptcp_subflow_info info;
>       struct tcp_info           tcp_info;
>   };
>=20
> Again, just a quick idea, I didn't investigate more. With that, we will
> likely not need more getsockopt() to get info about the MPTCP connection
> and its subflows, just an all in one getsockopt().
>=20
> I'm just trying to reacting quickly before going into a direction :)

Uhm... I think TLV are not in the right direction: away from the
current convention for variable size/changing struct. If use TLV we
could as well move to NL, which will be again inconsistent to fetch
such kind of info IMHO.

I think it's preferable to keep the sockopt API self-consistent then be
aligned with out-of-tree.

The layout proposed by Florian fits what we already have.

With some little field re-order I can avoid code duplication to
parse/store the initial header.

Cheers,

Paolo

