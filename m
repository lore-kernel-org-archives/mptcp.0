Content-Type: multipart/mixed; boundary="===============7031950922458365184=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/6] mptcp: remove all "inline" in foo.c files
Date: Fri, 27 Mar 2020 17:39:00 +0100
Message-ID: <5cf367bf-0d84-1441-bc50-97477b5dc6eb@tessares.net>
In-Reply-To: alpine.OSX.2.22.394.2003270900350.41044@amitamah-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4096

--===============7031950922458365184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 27/03/2020 17:01, Mat Martineau wrote:
> On Fri, 27 Mar 2020, Matthieu Baerts wrote:
> =

>> This remove all the "inline" in net/mptcp/*.c files as requested by =

>> davem.
>>
>> Matthieu Baerts (6):
>> =C2=A0Squash-to: "mptcp: queue data for mptcp level retransmission"
>> =C2=A0topmsg: mptcp: queue data for mptcp level retransmission
>> =C2=A0Squash-to: "mptcp: rework mptcp_sendmsg_frag to accept optional df=
rag"
>> =C2=A0topmsg: mptcp: rework mptcp_sendmsg_frag to accept optional dfrag
>> =C2=A0Squash-to: "mptcp: add and use MIB counter infrastructure"
>> =C2=A0topmsg: mptcp: add and use MIB counter infrastructure
>>
>> .topmsg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 7 +++++--
>> net/mptcp/protocol.c | 8 ++++----
>> 2 files changed, 9 insertions(+), 6 deletions(-)
>> .topmsg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 3 +++
>> net/mptcp/protocol.c | 6 +++---
>> 2 files changed, 6 insertions(+), 3 deletions(-)
>> .topmsg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 3 +++
>> net/mptcp/subflow.c | 4 ++--
>> 2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> -- =

>> 2.25.1
> =

> All of these are good, thanks for the fixes!

Thank you for the quick review!

- df2317351c03: "squashed" patch 1/6 in "mptcp: queue data for mptcp =

level retransmission"
- 3ca135cd38f8: "squashed" patch 2/6 in "mptcp: queue data for mptcp =

level retransmission"
- c0278fca42e9..1e32ece055b4: result

- 6d5f52025e96: "squashed" patch 3/6 in "mptcp: rework =

mptcp_sendmsg_frag to accept optional dfrag"
- 0f5cad683f41: "squashed" patch 4/6 in "mptcp: rework =

mptcp_sendmsg_frag to accept optional dfrag"
- 1e32ece055b4..52c0b52a3ffb: result

- e094de42eb1f: "squashed" patch 5/6 in "mptcp: add and use MIB counter =

infrastructure"
- cb65c93667b2: "squashed" patch 6/6 in "mptcp: add and use MIB counter =

infrastructure"
- 52c0b52a3ffb..c32f026cdf86: result

(I didn't change the signed-off-by)

Tests + export are in progress

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7031950922458365184==--
