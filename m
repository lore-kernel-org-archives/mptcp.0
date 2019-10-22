Content-Type: multipart/mixed; boundary="===============5723384362079032298=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/3] mptcp: Use correct address family when
 creating subflows
Date: Tue, 22 Oct 2019 14:52:54 +0200
Message-ID: <c2f9e44e-9dd8-0b28-ffa6-44d7659aea86@tessares.net>
In-Reply-To: 4a33621a6b7dfc1ed11064d9f771463c45e4814d.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2258

--===============5723384362079032298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 22/10/2019 14:35, Paolo Abeni wrote:
> On Tue, 2019-10-22 at 13:12 +0200, Matthieu Baerts wrote:
>> On 22/10/2019 10:35, Paolo Abeni wrote:
>>> but what if the peer sends an ADD_ADDR v4,
>>> and the local msk socket is a v6 (or vice versa)?
> =

> Sorry, I was not clear enough. With the posted code, when msk is v6,
> pernet->has_announce_v6 is 1 and ADD_ADDR is ipv4 (pm->remote_family =3D=
=3D
> AF_INET), I think mptcp_pm_create_subflow6() will end-up using
> uninitialized bytes for mptcp_subflow_connect().
> =

> To avoid that, we should check that the local and the remote address
> used to establish the connection belong to the same family.

I see, thank you for the clarification! Indeed, there is no check when =

doing this, good catch!

   remote.sin_family =3D msk->pm.remote_family
   remote.sin6_family =3D msk->pm.remote_family

>> So accept a mix of v4 and v6 later?
> =

> The idea would be to keep the code as simple as possible. The listening
> socket in the current status can't accept easily a mix of ipv4 and ipv6
> subflow, I think.
> =

> On the flip side, should be quite straigh-forward support mixed family
> for client sockets; that was my overall proposal here.

Sounds like a good idea!

>> It would make sense but it will need
>> to be documented somewhere with a TODO I guess :)
> =

> Agreed.
> =

>> PS: Paolo: is it OK for you if I apply the first patch of the series?
> =

> too late, but... "yes"

Sorry, the fix was straightforward, I went ahead without waiting :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5723384362079032298==--
