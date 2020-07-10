Content-Type: multipart/mixed; boundary="===============4180285156577255329=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: multipath-tcp.org / net-next netlink PM API merge plans
Date: Fri, 10 Jul 2020 15:37:52 +0200
Message-ID: <0545d4d9-ff50-545e-68d4-03f24e1c8f9c@tessares.net>
In-Reply-To: CAPyD+=Bz-0g++GRsv6TEN-ctDEgP-Vwon3Gapw2qK-wTGgxfCQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4971

--===============4180285156577255329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ossama,

On 09/07/2020 22:45, Othman, Ossama wrote:
> Matthieu, Paolo,
> =

> What are your plans for merging the netlink PM API in the =

> multipath-tcp.org kernel to the net-next kernel?=C2=A0 Will they
> remain two separate APIs in the same kernel, or are =

> they going to be merged?

For me, the two APIs (global and per connection) should co-exist in the =

upstream kernel.

- For a server, it's likely possible that the PM job would be always the =

same: announce the same IP(s) and accept new subflow(s). No need to =

overload the server with Netlink messages send for each connection if =

the decision is basic and always the same.

- While on the client side, more control might be required: Do we want a =

real fullmesh support? ndiffport? one subflow per interface? mix v4/v6? =

do that per app, per netns, per cgroup? etc. A control per connection =

will be required not to define a PM in the kernel per connection.

Many clients might also have everything they need with the current API =

but at some points, I think we will need the Netlink PM from mptcp.org.

I don't know if I would be able to but I would like to look at this. =

Clearly not all the API can be ported (and implemented) to the upstream =

kernel for the moment because some stuffs are still missing but we can =

do some progress there.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4180285156577255329==--
