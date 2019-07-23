Content-Type: multipart/mixed; boundary="===============2140406822449423799=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: avoid validating MP_CAPABLE keys on 3way
 HS handling
Date: Tue, 23 Jul 2019 19:22:50 +0200
Message-ID: <a7f732c8-58e5-15a7-603c-0474eb4887bb@tessares.net>
In-Reply-To: 7d182ff726cb95e049fd92e3d45eff23d89ed150.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1545

--===============2140406822449423799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Peter, Mat, Christoph,

On 17/07/2019 19:22, Peter Krystad wrote:
> =

> Looks good to me.
> =

> On Wed, 2019-07-17 at 10:57 +0200, Paolo Abeni wrote:
>> The server side already stored the key on syn, and 3way HS ack
>> reception is fragile: the ack can be lost, and the following
>> data pkts processed instead.
>>
>> This fixes the pending self-test issue in my testbed.
>>
>> Suggested-by: Peter Krystad <peter.krystad(a)linux.intel.com>
>> Suggested-by: Christoph Paasch <cpaasch(a)apple.com>
>> Fixes: af550dd282ca ("mptcp: Create SUBFLOW socket for incoming connecti=
ons")
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thank you for the patch, the reviews and the suggestions!

- 7f07e3f76561: "squashed" in "mptcp: Create SUBFLOW socket for incoming
connections"
- 17ba3a852c83: add Paolo Abeni' signed-off
- 1d55bee52791: conflict in
t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- 3e0f02bac2b3..57b73d36a000: result

Compilations is OK but tests are in progress. I has to relaunch them,
see [1] for more details. I will notify you if there are some issues
with the tests but I am sure they will be green ;-)

Cheers,
Matt

[1]
https://github.com/multipath-tcp/mptcp_net-next/commit/c53c4283cae29e73e262=
2d11c37cd05e90d90605
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============2140406822449423799==--
