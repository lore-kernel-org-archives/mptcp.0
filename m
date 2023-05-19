Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6BC2F6
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 14:22:24 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-182-eNKQvqjvOHWCSGmOHW-ZdA-1; Fri, 19 May 2023 15:22:11 +0100
X-MC-Unique: eNKQvqjvOHWCSGmOHW-ZdA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 19 May
 2023 15:22:08 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 19 May 2023 15:22:08 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Breno Leitao' <leitao@debian.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "courmisch@gmail.com"
	<courmisch@gmail.com>, "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>
CC: "asml.silence@gmail.com" <asml.silence@gmail.com>, "alex.aring@gmail.com"
	<alex.aring@gmail.com>, "dccp@vger.kernel.org" <dccp@vger.kernel.org>,
	"mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"matthieu.baerts@tessares.net" <matthieu.baerts@tessares.net>,
	"marcelo.leitner@gmail.com" <marcelo.leitner@gmail.com>,
	"linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>, "leit@fb.com"
	<leit@fb.com>, "dsahern@kernel.org" <dsahern@kernel.org>
Subject: RE: [PATCH 1/1] net: ioctl: Use kernel memory on protocol ioctl
 callbacks
Thread-Topic: [PATCH 1/1] net: ioctl: Use kernel memory on protocol ioctl
 callbacks
Thread-Index: AQHZiloXkjARdT8YlUi1kSrEdFLkt69ho1RA
Date: Fri, 19 May 2023 14:22:08 +0000
Message-ID: <f2d1a07b3e954db8ae40a2d739372e6c@AcuMS.aculab.com>
References: <20230519135821.922326-1-leitao@debian.org>
 <20230519135821.922326-2-leitao@debian.org>
In-Reply-To: <20230519135821.922326-2-leitao@debian.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Breno Leitao
> Sent: 19 May 2023 14:58
>=20
> Most of the ioctls to net protocols operates directly on userspace
> argument (arg). Usually doing get_user()/put_user() directly in the
> ioctl callback.  This is not flexible, because it is hard to reuse these
> functions without passing userspace buffers.
>=20
> Change the "struct proto" ioctls to avoid touching userspace memory and
> operate on kernel buffers, i.e., all protocol's ioctl callbacks is
> adapted to operate on a kernel memory other than on userspace (so, no
> more {put,get}_user() and friends being called in the ioctl callback).
>=20
> This changes the "struct proto" ioctl format in the following way:
>=20
>     int                     (*ioctl)(struct sock *sk, int cmd,
> -                                        unsigned long arg);
> +                                        int *karg);

I think I'd add a karg_len field for the actual buffer length.
It will save embarrassment later on.

Do any of the ioctl functions return +ve values on success?
If not you can use the return value as the length for any
copy_to_user().

If all the current 'cmd' are 16bit, there is the option
of using 32bit IOR() etc commands to get automatic sizing.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

