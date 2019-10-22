Content-Type: multipart/mixed; boundary="===============2586371454906985320=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Selftests: 1 error last night 20191022
Date: Tue, 22 Oct 2019 15:09:46 +0200
Message-ID: <775393a3-5c71-e388-698a-14f37cfc183d@tessares.net>
In-Reply-To: 9e06c4068331d54776b9079e81b35dfbabe2723b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2260

--===============2586371454906985320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 22/10/2019 14:56, Paolo Abeni wrote:
> On Tue, 2019-10-22 at 14:14 +0200, Matthieu Baerts wrote:

[...]

>> - 9669fffc1415 (net: ensure correct skb->tstamp in various fragmenters)
> =

> This one possibly could, even if it's quite unlikely, I think.

Yes, I am not sure what's wrong with the recent update. Maybe some =

changes in the drivers?

> Is this failure easily reproducible or it happens once in a lot of
> runs?

Yes, it is easy to reproduce with the virtme scripts [1]:

   cp ../scripts/ci/virtme.sh patches && \
       bash -x ../scripts/ci/Dockerfile.virtme.sh patches/virtme.sh

[1] https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/ci

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2586371454906985320==--
