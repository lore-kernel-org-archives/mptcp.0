Content-Type: multipart/mixed; boundary="===============2527349673966408023=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net 0/5] mptcp: mix fixes
Date: Mon, 08 Feb 2021 20:29:53 +0100
Message-ID: <7cc45946-5c18-3528-96aa-8f2854cb9ed1@tessares.net>
In-Reply-To: 733af518d4bf037c8bf4c7e6d608c81c18476135.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7688

--===============2527349673966408023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 08/02/2021 10:33, Paolo Abeni wrote:
> On Fri, 2021-02-05 at 17:35 -0800, Mat Martineau wrote:
>> On Fri, 5 Feb 2021, Paolo Abeni wrote:
>>
>>> This includes new versions of 2 already posted patches (1/5 && 2/5)
>>> a rewrite of an already posted RFC patch (3/5) and a new fix.
>>>
>>> Patch 1 should address issues/126
>>> Patch 2 should address issues/130 && 125
>>> Patch 3 is mostly a clean-up, possibly could land to net-next
>>> Patch 4 should fix issue 146
>>> Finally patch 5 allow mptcp_connect to dump more info when errors happen
>>>
>>> Paolo Abeni (5):
>>>   mptcp: fix spurious retransmissions
>>>   mptcp: init mptcp request socket earlier
>>>   mptcp: better msk receive window updates
>>>   mptcp: add a missing retransmission timer scheduling
>>>   selftests: mptcp: dump more info on errors
>>>
>>> net/mptcp/options.c                           | 10 ++---
>>> net/mptcp/protocol.c                          | 44 +++++++++++--------
>>> net/mptcp/protocol.h                          | 14 ++----
>>> net/mptcp/subflow.c                           | 40 +++++++----------
>>> .../selftests/net/mptcp/mptcp_connect.sh      | 11 +++--
>>> 5 files changed, 58 insertions(+), 61 deletions(-)
>>>
>>> -- =

>>> 2.26.2
>>
>> Given the discussion on IRC, does it make sense to apply these on the
>> export branch and continue testing? Not sure if the error Matthieu
>> encountered was introduced here or possibly an existing issue.
> =

> I suggest applying these ones. The issue reported by matttbe looks
> really a different one sharing the same synthoms as issues/147.

Thank you for the patches and the reviews!
Just applied in our tree with Mat's RvB tag and a small modification, =

see below:

- f880caea34bf: mptcp: fix spurious retransmissions
- 2195b4539cdb: mptcp: init mptcp request socket earlier
- 980b6b800d23: mptcp: better msk receive window updates
- 773725f66d5c: mptcp: add a missing retransmission timer scheduling
- 7580f0d0573e: selftests: mptcp: dump more info on errors:
   - Small modification, see my comment in 5/5 patch
   - 4e11f1e2d526: selftests: mptcp: update nstat history
- Results: 3335749a2aa4..0976cfad9f6a

Tests + exports are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2527349673966408023==--
