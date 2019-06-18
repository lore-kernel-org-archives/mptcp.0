Content-Type: multipart/mixed; boundary="===============8259235342437526453=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/3] MP_JOIN handling: v3 from Peter
Date: Tue, 18 Jun 2019 08:09:25 +0200
Message-ID: <841c26b3-4624-4ccb-26d0-c24dc1bc1923@tessares.net>
In-Reply-To: 404bf12b126e7b5def2ca096eeb256f4680aa634.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1422

--===============8259235342437526453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 17/06/2019 22:42, Paolo Abeni wrote:
> Hi all,
> =

> On Mon, 2019-06-17 at 16:11 +0200, Matthieu Baerts wrote:
>> Peter recently sent a v3 of his patch-set but I had already applied it i=
n the
>> repo. Here is what I extracted from the v3 using diff.
>>
>> If Paolo (or others) is OK, I can include this in what we are going to s=
end to
>> Eric.
>>
>> Peter Krystad (3):
>>   squash to: mptcp: Add path manager interface
>>   squash to: mptcp: Add ADD_ADDR handling
>>   squash to: mptcp: Add handling of incoming MP_JOIN requests
>>
>>  include/linux/tcp.h  |  9 +++++--
>>  include/net/mptcp.h  |  6 +++--
>>  net/mptcp/options.c  | 56 +++++++++++++++++++++-----------------------
>>  net/mptcp/pm.c       | 23 +++++++++---------
>>  net/mptcp/protocol.c |  2 +-
>>  net/mptcp/protocol.h |  9 +++++++
>>  net/mptcp/subflow.c  |  9 ++++---
>>  7 files changed, 65 insertions(+), 49 deletions(-)
>>
> =

> I'm unable to give a real review, because I'm currently relocating (yep
> in 2 days will leave the family alone in the worse possible caos -
> that's true love ;)
> =

> Anyhow it LGTM with a very cursory look,

Thank you for your review!

And have fun with the relocating! And good luck for the rest :-D

Cheers,
Matt

> Cheers,
> =

> Paolo
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8259235342437526453==--
