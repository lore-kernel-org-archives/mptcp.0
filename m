Content-Type: multipart/mixed; boundary="===============5826934139230463016=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/3] mptcp: more token follow-up
Date: Wed, 10 Jun 2020 14:28:04 +0200
Message-ID: <56a7b82a-242f-d85b-f9ea-04f870834f00@tessares.net>
In-Reply-To: c20a5b3e8538f2fbd0a34ae61b87c30d2612b003.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4638

--===============5826934139230463016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat, Davide,

On 10/06/2020 11:20, Paolo Abeni wrote:
> On Tue, 2020-06-09 at 14:26 -0700, Mat Martineau wrote:
>> On Mon, 8 Jun 2020, Paolo Abeni wrote:
>>
>>> The patch 1 addesses a race on close which may possibly fix
>>> issues/36 && issues/29, the 2nd patch is resolve conflicts and the 3rd =
one
>>> is a follow-up cleanup.
>>>
>>> Patch 3 should be inserted just after "mptcp: refactor token container."
>>>
>>> v1 -> v2:
>>> - hopefully includes the correct patches
>>>
>>> protocol.c |    9 ++++---
>>> subflow.c  |   69 ++++++++++++++++++++++-------------------------------=
--------
>>> 2 files changed, 30 insertions(+), 48 deletions(-)
>>
>> Thanks Paolo, these fixes look good. From IRC and
>> https://github.com/multipath-tcp/mptcp_net-next/issues/36 it looks like
>> #36 is still happening, do you prefer to try more changes in a v3 or
>> squash these in the export branch and work from there?
> =

> I don't have anything more in my pocket, so I would opt for squashing
> this changes as is, thanks!

Thank you for the patches and reviews!

- 8f56b23f5662: "squashed" patch 1/3 in "mptcp: refactor token container."
- 7c391f0de905: conflict in t/net-mptcp-improve-fallback-to-TCP
- 358748f8e4d2..89cd01041d51: result

- b04d6cff8748: "squashed" patch 2/3 in "net: mptcp: improve fallback to =

TCP"
   (I removed an extra space in the context to avoid conflicts "} else  {")
- 1a420b54c8c3: "Signed-off-by" + "Co-developed-by"
- 89cd01041d51..ab59469e1460: result

The third patch has been added between "mptcp: refactor token =

container." and "mptcp: move crypto test to KUNIT".
- ab59469e1460..e1337aec1cf5: result

One last thing: I remove the dot at the end of "mptcp: refactor token =

container."
- d89075f9c5c2: tg:msg: remove dot at the end of the title

The "export" branch has already been updated. Tests are still OK.

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5826934139230463016==--
