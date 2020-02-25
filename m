Content-Type: multipart/mixed; boundary="===============5751476320443005274=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] net: mptcp: rename MPTCP_SUBFLOW_* into
 MPTCP_SUBFLOW_ATTR_* in diag uAPI
Date: Tue, 25 Feb 2020 17:06:33 +0100
Message-ID: <dd7a5d8a-53ca-5e38-510b-ae0a2ffed0fe@tessares.net>
In-Reply-To: 3e6ba8371d82801358113ba14218b2b889f4098a.1582556386.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3788

--===============5751476320443005274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 24/02/2020 15:59, Davide Caratti wrote:
> Squash-to: "mptcp: allow dumping subflow context to userspace"
> =

> otherwise MPTCP_SUBFLOW_MAX might recall the maximum possible number of
> subflows in a MPTCP connection, which is not controlled by uAPI at all.

Thank you for the patch, LGTM!

I guess you did a find & replace and adapt lines that are now too big.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5751476320443005274==--
