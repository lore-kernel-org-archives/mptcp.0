Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A912B6C
	for <mptcp@lists.linux.dev>; Tue,  8 Aug 2023 15:23:43 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fe07f0636bso9549031e87.1
        for <mptcp@lists.linux.dev>; Tue, 08 Aug 2023 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691508221; x=1692113021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKR/mQxiWCp6UmZoc/ZIdm/CvMRbYORnLL2Bmf5WunY=;
        b=TpisWaFuryn84hwDAI/nJx1g/+I/Q+8Bt69v895SwG2nRTVcmTB+q0SVXuKBPt6N51
         Rawqjt70YhCPEkSJZgZEYAbNUFQJJ00JOBEmt6tfwvHqk2/lZxpGgZqkNjvHfZqtD1gc
         FoBqzgQdts3iSK8uQih1Lvlqx2zE2cS16XmH497VWVgDTVsUGwOCMiCxgCp0XiYw+voU
         WHEnerBT6CjafIFaZceFoB/6uMHODH8hOJTTqp4JluVt/b+MeOOAeby/zdkOwrRZTdGe
         /0E3RyvXAqo9LWHWpkyuizb1DiCOxlIC01izr+IXJw1F0ZscKunSYNeKa+Cbj7brfXid
         C1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691508221; x=1692113021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKR/mQxiWCp6UmZoc/ZIdm/CvMRbYORnLL2Bmf5WunY=;
        b=U3Yez5krG9St7YIaSLWoLPwAq2YMZUG+lCbdjEcuY/aVbwU9xuQqHan2CFTqNClNxh
         50ENNeVfS90xNagCKiyWlqQEwKxiyA+Mxs0Urklay3+tlbditOeal4STkYyK6aemi8oP
         EASd2QNUIp8mWlaJ+TyM6+ySGTf4VVJHknYUq/QNWz9gOFhfAsYUxXXAlWi+qJAgp6q6
         ehli6q9Ph/lxbfgjPSqBGXBR8i3XMtavrEAoiaHnpYfs2zhAlu9tbQ5FNYuuTRIyR6hH
         vyGidwjMDc2jlrKd+KigCvrVM/xOBNB+x71LXA2dDAn6J8zpxBTZlfibLnwQHnVR3vd1
         xGDg==
X-Gm-Message-State: AOJu0YydMP2UsXyJtmfjKKbjNgVEKhAHJTYj/EOsUtlXtbX367a6tNvf
	1IueVRZ7CVczzS2q7iTPyzQ=
X-Google-Smtp-Source: AGHT+IFnYhIzaS3Y+KcV0Lrw6qJXYUrYWCoAb9tRY2N+65/72vnKp1uSD5k97nShAi0GFBixW7Zi2Q==
X-Received: by 2002:a05:6512:3b0a:b0:4fe:3f2:2efc with SMTP id f10-20020a0565123b0a00b004fe03f22efcmr11495192lfv.0.1691508221319;
        Tue, 08 Aug 2023 08:23:41 -0700 (PDT)
Received: from localhost (0x934e1fc8.cust.fastspeed.dk. [147.78.31.200])
        by smtp.gmail.com with ESMTPSA id a3-20020a056512020300b004fcdd81355csm1920516lfo.269.2023.08.08.08.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:23:40 -0700 (PDT)
Date: Tue, 8 Aug 2023 17:23:38 +0200
From: Joel Granados <joel.granados@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: mcgrof@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Iurii Zaikin <yzaikin@google.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Kees Cook <keescook@chromium.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>, mptcp@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>, coreteam@netfilter.org,
	Jan Karcher <jaka@linux.ibm.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Will Deacon <will@kernel.org>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	bridge@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	Joerg Reuter <jreuter@yaina.de>, Julian Anastasov <ja@ssi.bg>,
	David Ahern <dsahern@kernel.org>, netfilter-devel@vger.kernel.org,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org,
	Karsten Graul <kgraul@linux.ibm.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-sctp@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Ralf Baechle <ralf@linux-mips.org>, Florian Westphal <fw@strlen.de>,
	willy@infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>, linux-rdma@vger.kernel.org,
	Roopa Prabhu <roopa@nvidia.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Simon Horman <horms@verge.net.au>,
	Mat Martineau <martineau@kernel.org>, josh@joshtriplett.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Eric Dumazet <edumazet@google.com>, linux-hams@vger.kernel.org,
	Wenjia Zhang <wenjia@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
	linux-s390@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com
Subject: Re: [PATCH v2 11/14] networking: Update to register_net_sysctl_sz
Message-ID: <20230808152338.aoubpvauxpcuwfuz@localhost>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <20230731071728.3493794-12-j.granados@samsung.com>
 <CGME20230808112110eucas1p1332795fa88d771ac3f05825f33052cf9@eucas1p1.samsung.com>
 <22e0e672-f9f6-6afe-6ce6-63de264e7b6d@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ry2jlv6i2gzplzus"
Content-Disposition: inline
In-Reply-To: <22e0e672-f9f6-6afe-6ce6-63de264e7b6d@intel.com>


--ry2jlv6i2gzplzus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 01:20:36PM +0200, Przemek Kitszel wrote:
> On 7/31/23 09:17, Joel Granados wrote:
> > Move from register_net_sysctl to register_net_sysctl_sz for all the
> > networking related files. Do this while making sure to mirror the NULL
> > assignments with a table_size of zero for the unprivileged users.
> >=20
> > We need to move to the new function in preparation for when we change
> > SIZE_MAX to ARRAY_SIZE() in the register_net_sysctl macro. Failing to do
> > so would erroneously allow ARRAY_SIZE() to be called on a pointer. We
> > hold off the SIZE_MAX to ARRAY_SIZE change until we have migrated all
> > the relevant net sysctl registering functions to register_net_sysctl_sz
> > in subsequent commits.
> >=20
> > An additional size function was added to the following files in order to
> > calculate the size of an array that is defined in another file:
> >      include/net/ipv6.h
> >      net/ipv6/icmp.c
> >      net/ipv6/route.c

=2E..

> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 64e873f5895f..51c6cdae8723 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -6447,14 +6447,19 @@ struct ctl_table * __net_init ipv6_route_sysctl=
_init(struct net *net)
> >   		table[8].data =3D &net->ipv6.sysctl.ip6_rt_min_advmss;
> >   		table[9].data =3D &net->ipv6.sysctl.ip6_rt_gc_min_interval;
> >   		table[10].data =3D &net->ipv6.sysctl.skip_notify_on_dev_down;
> > -
> > -		/* Don't export sysctls to unprivileged users */
> > -		if (net->user_ns !=3D &init_user_ns)
> > -			table[1].procname =3D NULL;
Here I remove the setting of the procname to NULL for ipv6 sysctl
registers in route.c and I do not replace that assignment anywhere.
This means that we will export sysctls to unprivilged users for ipv6.
I'll correct this in V3.

> >   	}
> >   	return table;
> >   }
> > +
> > +size_t ipv6_route_sysctl_table_size(struct net *net)
> > +{
> > +	/* Don't export sysctls to unprivileged users */
> > +	if (net->user_ns !=3D &init_user_ns)
> > +		return 0;
> > +
> > +	return ARRAY_SIZE(ipv6_route_table_template);
> > +}
> >   #endif
> >   static int __net_init ip6_route_net_init(struct net *net)

--=20

Joel Granados

--ry2jlv6i2gzplzus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTSXfgACgkQupfNUreW
QU9uhwv/YNoyTbkHH/5RMLpQdKDepd7w6f8Rtax3cD35VYfVbj2aNFy9lcELq0sL
WWEkcnq1tZav3I+it4as5M7BUfGePS1Zj/D2OYSS7sR0ehwJMaO19qvfuGLiQLP9
XQe6cyy071sk9U5fxmpZkZgfKtldzchYMt1GluPzw0/a1CRkUlQqaDkHS0/hiOAn
JCY8mDLWC5DZwVZjz1Ai3UZ3lSIoxFqZbIk8IWpB6E6r9j+ulQUBw6CnYpSu8HMg
JNHA2wqyYaNLKxwQzSDhG3E0AaK59dPzneyrLVRnpJhc4yMFY+yDSPAzAZTgr1Ny
+/lASH2c7d0obmafitPwIOhxg7xPPnp+AYKDP65ZMGp0olUCNYKqUhF0Mc8sWq75
1kzOSul2jqUCTCkODYWut1aoqApizX5phuRCj/wCorVWBazLV7J9fDNopmAtmTYY
MKPmbbgWQdQHKDCEN7aSL5GGY51bp1dl4M0G+rkmW3RXRPl1OJLTsxP6Vk7ZizpE
4CYHvD9R
=8NUh
-----END PGP SIGNATURE-----

--ry2jlv6i2gzplzus--
