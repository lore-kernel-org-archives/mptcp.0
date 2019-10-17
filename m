Content-Type: multipart/mixed; boundary="===============1228342433822690666=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/2] mptcp: fix compilation warnings with i386
Date: Thu, 17 Oct 2019 16:26:45 +0200
Message-ID: <b739a189-b66d-da40-aa55-abce8f3be0b6@tessares.net>
In-Reply-To: f0893b2e7c1b8df2d9cfc7a926f2408b0f178ec2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2228

--===============1228342433822690666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 17/10/2019 15:21, Paolo Abeni wrote:
> On Wed, 2019-10-16 at 18:34 +0200, Matthieu Baerts wrote:
>> To be squashed in two different commits.
>>
>> Matthieu Baerts (2):
>>    mptcp: fix compilation warning with i386
>>    mptcp: fix compilation warning with i386
>>
>>   net/mptcp/protocol.c | 2 +-
>>   net/mptcp/subflow.c  | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
> =

> =

> The patches LGTM, thank you for fixing my mistakes !

My pleasure. Thank you for the review.
Now the CI will notify me if there are new issues with i386.

- 970070f070a2: "squashed" patch 1/2 in "mptcp: recvmsg() can drain data =

from multiple subflows"
- f5ca38cb0a11: "squashed" patch 2/2 in "mptcp: Implement MPTCP receive =

path"
- 4c046ac001b8..f3397e47be58: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1228342433822690666==--
