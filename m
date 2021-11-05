Received: from router.helenandmark.org (vps-eefd1937.vps.ovh.net [51.38.38.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E02C9B
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 11:00:17 +0000 (UTC)
Received: from smtpclient.apple (unknown [192.168.1.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mark@helenandmark.org)
	by router.helenandmark.org (Postfix) with ESMTPSA id 50DEC14187A;
	Fri,  5 Nov 2021 12:00:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=helenandmark.org;
	s=mail; t=1636110015;
	bh=+rwgT3ySddp5Ruzi4veQb9j8HV/tTFqwiZ93FfAXf6k=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=DRPt5Znk540l5W8vWnosrfTmSDdklzI+k8de7nX9+HzZe0KPpPMgEh4F8uXatM1pP
	 TcDAnIs0JhuxZrh8fxwhHOV7xdf+CV489gX+K4mkWRGTRnhswa59WSUZlggVW1XdOO
	 OJQK/wQt5E21pBOJbQQFBddGJS2sZfMfAaSUyt/g=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: Linux 5.15 + v2ray + mptcp
From: Mark Burton <mark@helenandmark.org>
In-Reply-To: <8141891e5388b61b8f07371dcd6e4b253e6213d1.camel@redhat.com>
Date: Fri, 5 Nov 2021 11:59:09 +0100
Cc: mptcp@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C4D8D7F-FB89-4F8A-8CC4-DDB0250A7FA7@helenandmark.org>
References: <8DB8DCC4-A85C-4A1A-8A82-5D53F256C09A@helenandmark.org>
 <8141891e5388b61b8f07371dcd6e4b253e6213d1.camel@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)



> On 5 Nov 2021, at 11:48, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> Hello,
>=20
> On Thu, 2021-11-04 at 12:10 +0100, Mark Burton wrote:
>> Just a very brief note to say I have this working with good results:
>>=20
>> Kernel 5.15.0-rc6
>>=20
>> V2Ray - I hacked the =E2=80=98go=E2=80=99 library as follows:
>> diff -s go/src/net/ipsock_posix.go go1.17.1/src/net/ipsock_posix.go
>> 138,139d137
>> <         family, ipv6only :=3D favoriteAddrFamily(net, laddr, raddr,
>> mode)
>> <=20
>> 143,145c141
>> < 	if (sotype =3D=3D syscall.SOCK_STREAM && !laddr.isWildcard()) {
>> <             return socket(ctx, net, family, sotype,
>> syscall.IPPROTO_TCP+256, false , laddr, raddr, ctrlFn)
>> <         }
>> ---
>>> 	family, ipv6only :=3D favoriteAddrFamily(net, laddr, raddr, =
mode)
>>=20
>> This is far from a good fix, but for testing purposes it suffices.=20
>=20
> Thanks for sharing your experience. Note that alternatively you can =
use
> the mptcpize command available in the mptcpd project:
>=20

Yes - agreed.

> https://github.com/intel/mptcpd
>=20
> for the details, please, see the related man-page.
>=20
>> NOTE v2ray must listen to the correct endpoint address, not just
>> 0.0.0.0 or [::]
>=20
> I'm unsure I read the above correctly?!? do you mean that while
> listening on 0.0.0.0 the v2ray server using mptcp does not accept
> incoming subflows and/or does not signal the addresses ?!?
>=20

This is purely a result of the =E2=80=98hack=E2=80=99 above.  Basically =
the code above only requests a MPTCP socket in the (one) case that V2Ray =
is setting up sockets that will be used for the tunnel itself, and it =
does so by checking the address being used isn=E2=80=99t a wildcard. In =
other words, it=E2=80=99s a crap hack.

I wanted to try to be =E2=80=98clean=E2=80=99 about which sockets were =
MPTCP and which were not - in the end, that =E2=80=98cleanliness=E2=80=99 =
comes with a lot of =E2=80=98dirtiness=E2=80=99 :-))))

Cheers
Mark.


> If so, that is quite unexpected...
>=20
> Cheers,
>=20
> Paolo
>=20

