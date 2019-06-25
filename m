Content-Type: multipart/mixed; boundary="===============6201340023742852500=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Re-factor mptcp_create_subflow()
Date: Tue, 25 Jun 2019 16:27:40 +0200
Message-ID: <cca03adb-eddf-b9b5-6741-01815b13f214@tessares.net>
In-Reply-To: 9cb24894-ed60-294a-330c-a5eeec1c70a4@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1446

--===============6201340023742852500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 25/06/2019 14:32, Matthieu Baerts wrote:
> Hi Peter,
> =

> On 25/06/2019 01:06, Peter Krystad wrote:
>> Move to subflow.c (because it belongs there) and rename.
>> Outgoing MP_JOIN requests will use this routine to create
>> subflow sockets.
> =

> Good idea and thank you for the patch!
> =

> I can apply it later today if nobody is against that. (it is easy to
> revert anyway).
> =

> Cheers,
> Matt
> =

>> squashto: Associate MPTCP context with TCP socket

Just applied:
- 5e767308567e + d442d01ba8f1: "squash" in "mptcp: Associate MPTCP
context with TCP socket"
- 9d3014b27993: conflict in
t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- bbcd3e436f8f + 5cc99acf0f23: conflict in
t/mptcp-Create-SUBFLOW-socket-for-incoming-connections
- 9456db61cc94: "squash" in "mptcp: Create SUBFLOW socket for incoming
connections"
- e50d314e3d44: conflict in t/mptcp-Implement-MPTCP-receive-path
- d73c270e1ed9..7f5c1f309977: result

Tests are still OK!

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6201340023742852500==--
