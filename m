Content-Type: multipart/mixed; boundary="===============4181179561907160179=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] some squashing needed?
Date: Wed, 25 Sep 2019 19:01:19 +0200
Message-ID: <fefa0c0e-6263-f8d8-b51f-c487b5d1ea33@tessares.net>
In-Reply-To: 98dbc8863e23c4662815d9df5f8f5d7c8d2d4405.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1929

--===============4181179561907160179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Florian,

On 25/09/2019 18:45, Paolo Abeni wrote:
> Hi,
> =

> On Mon, 2019-09-23 at 14:03 +0200, Matthieu Baerts wrote:
>>> Resending the whole squashed series/specific patches for a
>>> partial/complete replace?
>>
>> I understand that "because of" Topgit, some people might not want to do
>> the rebase. But if someone prefers to do the rebase himself, it is
>> indeed still possible to do that directly with Git using the last
>> "export" branch.
> =

> We (well, mainly poor Florian) are working to a rebase. Main reason for
> rebase is that the squashing proved to be quite complex. Likely a pull
> request could be shared very soon, but any export branch change from
> now one will likely be omitted.

Thank you for this notification and for working on that!

Do you want me to temporary stop the CI job which recreates the "export"
branch each night?

> Can we please postpone a bit additional patches till the
> rebase/squashing is completed?
There were also some ideas requiring changes in many commits:
- prefix mptcp_ for all exposed functions: in fact, only the ones only
used in net/mptcp needs to be updated.
- Split protocol.h and have an header file for each .c file we have in
net/mptcp
- Move some code out of protocol.c in different files: e.g. input.c /
output.c
- IPv6 support? Can we also do that in commits at the end?

Do we still want to do that before the initial submission? Should we do
that now if we are starting a big work of rebase.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============4181179561907160179==--
