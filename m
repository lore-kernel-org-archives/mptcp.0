Content-Type: multipart/mixed; boundary="===============8022532404688142651=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] KSelftests: warnings last night (20190703)
Date: Wed, 03 Jul 2019 13:59:05 +0200
Message-ID: <a69c3723-0574-f329-dc93-32a745f093b1@tessares.net>
In-Reply-To: 890b358c-71ce-8039-791b-f387792ec05d@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1467

--===============8022532404688142651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/07/2019 13:56, Matthieu Baerts wrote:
> Hello,
> =

> Here is just a small note to say that I got one warning last night. It
> seems not related to MPTCP but I prefer to share it, it might be useful
> for some people, just in case.
> =

> [    9.380277] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    9.380836] WARNING: suspicious RCU usage
> [    9.381454] 5.2.0-rc6+ #4 Not tainted
> [    9.382003] -----------------------------
> [    9.382628] ./include/linux/rtnetlink.h:85 suspicious
> rcu_dereference_protected() usage!

It has already been reported on netdev this night:
https://lkml.org/lkml/2019/7/2/511

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8022532404688142651==--
