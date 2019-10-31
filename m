Content-Type: multipart/mixed; boundary="===============7505459456330545576=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] Fix issues in prerequisite patches
Date: Thu, 31 Oct 2019 17:45:25 +0100
Message-ID: <f5c2c32b-c3d0-d800-8e3b-c274fe54a22d@tessares.net>
In-Reply-To: 0c770735b26da65189bcf16a1eb8c4cf4cbab67e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2379

--===============7505459456330545576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 30/10/2019 11:42, Paolo Abeni wrote:
> On Tue, 2019-10-29 at 09:55 -0700, Peter Krystad wrote:
>> Fix issues found by Mat in the "IPv6 prerequisite" patch series
>> when running against the multipath.org implementation.
>>
>> v2: Only announce address if same family as listener
>>      Only bind local address if same family as remote
>>      Patch 1 of v1 set already merged.
>>
>> Peter Krystad (2):
>>    mptcp: Save address family when creating socket
>>    mptcp: Use correct address family when creating subflows
>>
>>   net/mptcp/basic.c    | 36 ++++++++++++++++++++++--------------
>>   net/mptcp/protocol.c |  1 +
>>   net/mptcp/protocol.h |  1 +
>>   3 files changed, 24 insertions(+), 14 deletions(-)
>>
> =

> The patches LGTM, thanks!

Thank you for the patches and reviews!
I am going to apply this ASAP!

> Note: patch 2/2 will allow mptcp clients to either ipv4 and ipv6
> subflows, if the server allows/supports that - e.g. mptcp.org server
Peter: will you send a new patch later? Or should we add this in the =

TODO list?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7505459456330545576==--
