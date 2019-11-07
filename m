Content-Type: multipart/mixed; boundary="===============4864354745966221212=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/6] IPv6 support
Date: Thu, 07 Nov 2019 18:03:36 +0100
Message-ID: <56deed43-bfc7-fbac-dc49-3c055cc23c33@tessares.net>
In-Reply-To: 0a844a87aa4f8a2e214ba7e6c76092c98fd434a0.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2440

--===============4864354745966221212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 06/11/2019 10:04, Paolo Abeni wrote:
> On Tue, 2019-11-05 at 20:41 -0800, Peter Krystad wrote:
>> Implemented support for IPv6. selftests pass with ipv6=3Dtrue, but
>> they take twice as long to run...
>>
>> With re-factoring the addition of IPv6 is very clean
> =

> Indeed.

Thanks for the good work and the reviews!

>> but I did not
>> split files yet as it will be hard to squash any changes after the
>> such a split.
> =

> I think this is ok.
> =

> The series looks great, with a minor comment on patch 5.

Now in the repo!

patch 1/6:

- 43a479b6ae30: "squashed" part 1 in "mptcp: Handle MP_CAPABLE options =

for outgoing connections"
- 930dabfdf09d: "squashed" part 2 in "mptcp: Create SUBFLOW socket for =

incoming connections"
- 4f561ba867fb: "squashed" part 3 in "mptcp: Add key generation and =

token tree"
- 9d8b388097f8: conflict in t/mptcp-Implement-MPTCP-receive-path
- 580421d52995..eac1e244ac31: result

patch 2/6:

- 0da98dd8d6bb: "squashed" part 1 in "mptcp: Associate MPTCP context =

with TCP socket"
- cff7f9dac059: "squashed" part 2 in "mptcp: Create SUBFLOW socket for =

incoming connections"
- b545a42175be: "squashed" part 3 in "mptcp: add mptcp_poll"
- b74f268dd118: "Signed-off-by" + "Co-developed-by"
- eac1e244ac31..3373244a8bf8: result

patch 3/6:

- 85c57d519a60: "squashed" in "mptcp: Create SUBFLOW socket for incoming =

connections"
- 3373244a8bf8..9861cce0e086: result

patch 4/6:

- b12b955e0bfb: "squashed" in "mptcp: Create SUBFLOW socket for incoming =

connections"
- dc4f6f7ae3f4: conflict in t/mptcp-Add-key-generation-and-token-tree
- cdc85f221f44: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- 11899f111b38: conflict in =

t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
- 9861cce0e086..262129eadf29: result

patch 5/6:
- 8b158237c6dc: "squashed" part 1 in "tcp: Export TCP functions and ops =

struct"
=E2=86=92 without the chunk discussed on the ML
=E2=86=92 AND without "extern const struct inet_connection_sock_af_ops =

ipv6_specific;"
- 262129eadf29..619461df7b41: result

patch 6/6:
- new topic/commit added just before KSleftests
- AND with "extern const struct inet_connection_sock_af_ops ipv6_specific;"
- 3bf456c9250a: conflict in =

t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
- 46e50b50b072: conflict in =

t/mptcp-allow-dumping-subflow-context-to-userspace

Tests not launched yet.

I am rebooting my machine, coming in 2 minutes :)

Cheers,
Matt


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4864354745966221212==--
