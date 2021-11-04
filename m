Received: from router.helenandmark.org (vps-eefd1937.vps.ovh.net [51.38.38.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05B468
	for <mptcp@lists.linux.dev>; Thu,  4 Nov 2021 11:20:24 +0000 (UTC)
Received: from smtpclient.apple (unknown [192.168.1.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mark@helenandmark.org)
	by router.helenandmark.org (Postfix) with ESMTPSA id 9C8491416A1
	for <mptcp@lists.linux.dev>; Thu,  4 Nov 2021 12:11:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=helenandmark.org;
	s=mail; t=1636024265;
	bh=JDfRE2UGjn+jimtBinHt4pyMhlt/9SeRRjJqwVrK8tM=;
	h=From:Subject:Date:To;
	b=hxyCg0M2Ylo8MGC0QC3XUN9qe9wCoKhKt1sjNiePq87rhd1sfAia1imz47EGsRDAt
	 lYM3/1IP/lREnsYIrG35KiDIPiIteUyLhulm92jTGzkL7Mjuvdf18po0o55+TSe5E/
	 Y3usE8v665rzLTyRQ9NcIq98GtFztPRsfLWcXQdE=
From: Mark Burton <mark@helenandmark.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Linux 5.15 + v2ray + mptcp
Message-Id: <8DB8DCC4-A85C-4A1A-8A82-5D53F256C09A@helenandmark.org>
Date: Thu, 4 Nov 2021 12:10:05 +0100
To: mptcp@lists.linux.dev
X-Mailer: Apple Mail (2.3654.120.0.1.13)

Just a very brief note to say I have this working with good results:

Kernel 5.15.0-rc6

V2Ray - I hacked the =E2=80=98go=E2=80=99 library as follows:
diff -s go/src/net/ipsock_posix.go go1.17.1/src/net/ipsock_posix.go
138,139d137
<         family, ipv6only :=3D favoriteAddrFamily(net, laddr, raddr, =
mode)
<=20
143,145c141
< 	if (sotype =3D=3D syscall.SOCK_STREAM && !laddr.isWildcard()) {
<             return socket(ctx, net, family, sotype, =
syscall.IPPROTO_TCP+256, false , laddr, raddr, ctrlFn)
<         }
---
> 	family, ipv6only :=3D favoriteAddrFamily(net, laddr, raddr, =
mode)

This is far from a good fix, but for testing purposes it suffices. NOTE =
v2ray must listen to the correct endpoint address, not just 0.0.0.0 or =
[::]


I enabled fq  qdiscs and BBR congestion control.

In my case I have a VDSL line and a 4g line, I am reliably able to get =
very close to 100% utilisation of both lines - (I say =E2=80=98very =
close=E2=80=99 - both lines fluctuate somewhat wildly from minute to =
minute, so it=E2=80=99s nearly impossible for me to measure with any =
degree of certainty).

Cheers

Mark.



