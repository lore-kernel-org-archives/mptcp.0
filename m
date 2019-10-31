Content-Type: multipart/mixed; boundary="===============8246335632002386514=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] Fix issues in prerequisite patches
Date: Thu, 31 Oct 2019 17:53:41 +0100
Message-ID: <7f3e305a-de85-a302-1662-679a31451cbd@tessares.net>
In-Reply-To: f5c2c32b-c3d0-d800-8e3b-c274fe54a22d@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2380

--===============8246335632002386514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 31/10/2019 17:45, Matthieu Baerts wrote:
> Hi Peter, Paolo,
> =

> On 30/10/2019 11:42, Paolo Abeni wrote:
>> On Tue, 2019-10-29 at 09:55 -0700, Peter Krystad wrote:
>>> Fix issues found by Mat in the "IPv6 prerequisite" patch series
>>> when running against the multipath.org implementation.
>>>
>>> v2: Only announce address if same family as listener
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Only bind local address if same family as remo=
te
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Patch 1 of v1 set already merged.
>>>
>>> Peter Krystad (2):
>>> =C2=A0=C2=A0 mptcp: Save address family when creating socket
>>> =C2=A0=C2=A0 mptcp: Use correct address family when creating subflows
>>>
>>> =C2=A0 net/mptcp/basic.c=C2=A0=C2=A0=C2=A0 | 36 ++++++++++++++++++++++-=
-------------
>>> =C2=A0 net/mptcp/protocol.c |=C2=A0 1 +
>>> =C2=A0 net/mptcp/protocol.h |=C2=A0 1 +
>>> =C2=A0 3 files changed, 24 insertions(+), 14 deletions(-)
>>>
>>
>> The patches LGTM, thanks!
> =

> Thank you for the patches and reviews!
> I am going to apply this ASAP!

- 09a7aae56509: "squashed" patch 1/2 in "mptcp: Associate MPTCP context =

with TCP socket"
- 8cdc9c136c25: conflict in =

t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- 9a353e51c68e: conflict in t/mptcp-Add-key-generation-and-token-tree
- ee2921b42ea4: conflict in t/mptcp-Implement-MPTCP-receive-path
- c6ab7a9bfe74: conflict in =

t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
- f117c4d20b54: conflict in =

t/mptcp-implement-and-use-MPTCP-level-retransmission
- 46bbb9476623..c23d324d27ee: result
- b077793b215f: "squashed" patch 2/2 in "mptcp: Implement basic path =

manager"
- c23d324d27ee..3a4c8696fb26: result

Tests are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8246335632002386514==--
