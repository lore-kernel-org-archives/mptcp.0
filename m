Content-Type: multipart/mixed; boundary="===============5365954714201609913=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: tcp: Check for filled TCP option space
 before SACK
Date: Mon, 16 Dec 2019 19:28:01 +0100
Message-ID: <3f57b43a-b547-c2b0-cc36-b40eff022939@tessares.net>
In-Reply-To: 3cf172bb-fd16-5934-6160-21436c2b4669@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3086

--===============5365954714201609913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 16/12/2019 14:05, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 16/12/2019 13:37, Paolo Abeni wrote:
>> Less invasive checks, so that the number of branchs when hitting
>> the sack code path decreses compared to the current vanilla tree.
>> -- =

>> Some addictional check in tcp_established_options() is needed, otherwise
>> the tcp header will be corrupted when mptcp_established_options() fully
>> consumes the TCP option space. This condition can be reached without
>> MPTCP, so not sure if the result patch is still worthy for -net ?!?
> =

> =

> Thank you for the patch!
> =

> It looks good to me!

- b474fba77e6f: "squashed" in "tcp: Check for filled TCP option space =

before SACK"
- 5920a223da80: "Signed-off-by" + "Co-developed-by"
- 7ed2a1728574: conflict in =

t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- b8aff0a1a12d..66880827b48f: result

> I guess we will need to update the commit message for "tcp: Check for =

> filled TCP option space before SACK" :)

What can I put here? :)

   v1:
     - less invasive checks (Eric Dumazet)

Should we also mention that with MPTCP and TS, we can use all the option =

space?

I will launch the tests + export soon.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5365954714201609913==--
