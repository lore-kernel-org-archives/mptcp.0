Content-Type: multipart/mixed; boundary="===============8708664685107684893=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH/RFC 0/7] improve subflow join handling
Date: Tue, 26 Nov 2019 18:49:19 +0100
Message-ID: <8d81174d-a996-c398-9007-00445ab08c45@tessares.net>
In-Reply-To: 6fc6a45b9d42fa6196cc85943f922149c9008029.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2697

--===============8708664685107684893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 25/11/2019 13:06, Paolo Abeni wrote:
> On Mon, 2019-11-25 at 03:15 +0100, Florian Westphal wrote:
>> This set aims to improve handling of multiple subflows.
>> There are multiple remaining problems, see below, but I wanted to send w=
hat
>> I have now rather than keep this back.
>>
>> The first 3 patches are fixes to handle refcount leaks found while worki=
ng
>> on this, I've added the commit name of where they could be squashed to.

[...]

> LGTM! I think the firs 3 patches can be squashed as-is. [...]

Thank you for the nice work and the review!

- b6f0623fedf6: "squashed" patch 1/7 in "mptcp: Add key generation and =

token tree"
- 07ec6803478e: "squashed" patch 2/7 in "mptcp: Add handling of incoming =

MP_JOIN requests"
- 1be614c6efe0: "Signed-off-by" + "Co-developed-by"
- 3af80e92c8cd..d5e48af1fc7f: result
- 4291db56b807: "squashed" patch 3/7 in "mptcp: Handle MP_CAPABLE =

options for outgoing connections"
- 8c236d0f5ad2: "Signed-off-by" + "Co-developed-by"
- d5e48af1fc7f..722fd4571d61: results

Tests are still OK, each commit can still compile.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8708664685107684893==--
