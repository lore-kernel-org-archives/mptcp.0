Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A761ED40
	for <mptcp@lists.linux.dev>; Tue,  1 Aug 2023 10:01:15 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so8875253e87.2
        for <mptcp@lists.linux.dev>; Tue, 01 Aug 2023 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690884073; x=1691488873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8Rmj6mejjDyMq10/c5ElVqxfT4Jc8y7fVBUerEHAFQ=;
        b=JYH38BiZyDWL0KXmQnng4sthQhdeV3NJBHfNi+ky1KBbpG9nVv/fbbULdTOLHrIkRc
         m+cW5Nuo1qJ+ZY/CEFkGrU+LjmOwtRZV5FZbO5P7+OM1zKnHgMDf1oBLHOA+NceI85gx
         JkZ47KaVpN9ZBvR6FoyVYB0FbHi8KbwxzoilvQtwUB2ij/UJya1TAMXC2C3UOm6p174z
         S6sbKiiIslls7win2DAPno+jCbJ72BXV6csVG9rjzIDvaWKjNZk+kKpKl91dwFSz63UN
         EHa/G4niaq852Xz2iz+Bde3Ap6qEvx6ZrdIxP94qmNM5EajZm2Xvu5/MSgK9i/6QI6uE
         Ds1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690884073; x=1691488873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8Rmj6mejjDyMq10/c5ElVqxfT4Jc8y7fVBUerEHAFQ=;
        b=QkU4chaxjORnO9MhQLA4ZrI6HsotKro4YoMOdECEpG0DZ/M3uoMua8Eg9nlvLHlBy5
         Wj0YD/uCqvq5+8cPBqvm2iIu+NKnFWQTiPZIMi2srUUy3FvUo5C1e6amqfOtKk224D3d
         m/V17Dv7yGF2b2Q+H1/QEnpal+lCtludxjcipxtDyvzWhFtle2a4Er/9mNPTsznX28C9
         PcIKQVf5Bl885qWzisexxvzUU/wzIZLEvRU8Z1F0Ncg2vxKyibj2V8rukfhnNemxy+cb
         kjeKFSE5M7tKdTEU0+aihCwpNP2YK91J0D3q4AvNp8MT5E2dErE+5HUNfAr6WhJEqWqD
         yu4w==
X-Gm-Message-State: ABy/qLY1LjC7MyuDYoCWiC0FfyMe/G0urkokIFU5Lf/kD79A2B/W5KgC
	hmIdwx4H0XxSEEn9KpsDLgc=
X-Google-Smtp-Source: APBJJlGhgKLwVApJiPoxJUiIuyS5KDw4uVrCOBzzVEwDynYHPSZXT5p7yB71zUjSFqNFlY26YLaTpA==
X-Received: by 2002:ac2:43b7:0:b0:4fd:fef7:95ae with SMTP id t23-20020ac243b7000000b004fdfef795aemr1664853lfl.9.1690884071826;
        Tue, 01 Aug 2023 03:01:11 -0700 (PDT)
Received: from localhost (0x934e1fc8.cust.fastspeed.dk. [147.78.31.200])
        by smtp.gmail.com with ESMTPSA id j29-20020ac2551d000000b004fe09920fe5sm2512701lfk.47.2023.08.01.03.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 03:01:11 -0700 (PDT)
Date: Tue, 1 Aug 2023 12:01:09 +0200
From: Joel Granados <joel.granados@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v2 00/14] sysctl: Add a size argument to register
 functions in sysctl
Message-ID: <20230801100109.ospf2gwsdewhhwzn@localhost>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <CGME20230731205134eucas1p1403a137418fcdaaaf78890de88d4a958@eucas1p1.samsung.com>
 <ZMgeoDT0t3NeALM0@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g6vdqxyc5hdpujuz"
Content-Disposition: inline
In-Reply-To: <ZMgeoDT0t3NeALM0@bombadil.infradead.org>


--g6vdqxyc5hdpujuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 01:50:40PM -0700, Luis Chamberlain wrote:
> On Mon, Jul 31, 2023 at 09:17:14AM +0200, Joel Granados wrote:
> > Why?
>=20
> It would be easier to read if the what went before the why.
haha. I totally misunderstood you in
lore.kernel.org/all/ZMFizKFkVxUFtSqa@bombadil.infradead.org I thought
you meant to put the why first. I'll switch it back to having the what
first for V3

>=20
> > This is a preparation patch set that will make it easier for us to apply
> > subsequent patches that will remove the sentinel element (last empty el=
ement)
> > in the ctl_table arrays.
> >=20
> > In itself, it does not remove any sentinels but it is needed to bring a=
ll the
> > advantages of the removal to fruition which is to help reduce the overa=
ll build
> > time size of the kernel and run time memory bloat by about ~64 bytes per
> > sentinel.
>=20
> s/sentinel/declared ctl array
>=20
> Because the you're suggesting we want to remove the sentinel but we
> want to help the patch reviewer know that a sentil is required per
> declared ctl array.
Ack

>=20
> You can also mention here briefly that this helps ensure that future move=
s of
> sysctl arrays out from kernel/sysctl.c to their own subsystem won't
> penalize in enlarging the kernel build size or run time memory consumptio=
n.
I worked it in

Thx for the review
>=20
> Thanks for spinning this up again!
>=20
>   Luis

--=20

Joel Granados

--g6vdqxyc5hdpujuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTI1+QACgkQupfNUreW
QU/tvQv8DSOiRBrGHskMVKuasQMrQO4cj/zOagQExBMcJnGj7M+jr4pvCvBo1Rce
fRZBBVfKDjeV4svmqKus54sNM27JPAJALJlnePPgsBqhuOeL6kKLSsCDyDv6bKOS
e0J6ZLE6EAqudCJqsxjGkPNEalpooX1Ip9OQqdPQxyfoSdDZQcKucP/rPx+Q4yzy
lKv9SqcK/1j7q8fMkiucrjwQF2woB16q6iXZmokZTt7vTX0rSfKFJ8isQOgimpll
Xv+hxQaRZEueIIc45dAL7MRYn/zukf8rExbIRNXCtUCsyfJxcdo6V0ubKfMAj/u3
X2J5FIUpf1ua/QX0idONlXIXU1kOWnFapnBPprKBKuBhO6xwSnrQhxgt7aKbbDGl
dBwWRbN59m3q7jrz17McOb+LjfA5ZMcs3K58bfg0PnrugQZA537GFL19es1dAssc
fy06XeNWXeUhvCjgQW53D2twqvhAhY4WU1D4sbV+8xwQihB416Zkc+ReqQs2cS6Y
zhTPrhl+
=F1x8
-----END PGP SIGNATURE-----

--g6vdqxyc5hdpujuz--
