Content-Type: multipart/mixed; boundary="===============6882835614489368688=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v4 0/9] add locking to PM APis,
 implement PM netlink
Date: Fri, 28 Feb 2020 22:37:13 +0100
Message-ID: <8062424e-5469-0770-2592-3e7bb64af6fc@tessares.net>
In-Reply-To: cover.1582558805.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3826

--===============6882835614489368688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 24/02/2020 16:51, Paolo Abeni wrote:
> This implement the locking required by the PM to allow concurent subflow
> accessing the msk PM data in a safe way. Such data is protected via a msk=
-level
> spinlock. It relies on the Double checked locking to avoid contention in =
the
> most common scenarion (no or very little PM "actions").
> =

> Additionally changes more than a bit the PM hooks/APIs, to be hopefully s=
impler
> and avoiding duplicate code (no v4/v6 variant, work queue management done=
 by the
> core PM infra).
> =

> It also introduce the PM netlink - it replace the current basic ones, the
> related patch has been dropped locally.
> =

> git tree available at:
> =

> https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_7

Thank you for the good and huge work!

- 74d2503e1c62: mptcp: remove 'basic' PM =E2=86=92 empty =

t/mptcp-Implement-basic-path-manager topic.
- cb84d6f267fe..54c154e2c0ac: result

- b2f4dc591ecd: "squashed" patch 1/9 in "mptcp: Add ADD_ADDR handling"
- fa8348e24d53: "Signed-off-by" + "Co-developed-by"
- 2d125a76bc1e: conflict in t/mptcp-Add-path-manager-interface
- 54c154e2c0ac..66aa68608025: result

- cb6c1764eb31: "squashed" patch 2/9 in "mptcp: Add path manager interface"
- e16ecd3f2df3: "Signed-off-by" + "Co-developed-by"
- f8513e13c445: conflict in =

t/mptcp-Implement-path-manager-interface-commands
- ce2d7fb36478: conflict in t/mptcp-introduce-MPTCP-retransmission-timer
- 66aa68608025..930fad27493a: result

- f990e741f3e8: "squashed" patch 3/9 in "mptcp: Add handling of incoming =

MP_JOIN requests"
- 930fad27493a..928bf2dd018c: result

- f88ff34735b9: "squashed" patch 4/9 in "mptcp: Add handling of outgoing =

MP_JOIN requests"
- a0a90d3f6dcd: conflict in =

t/subflow-place-further-subflows-on-new-join_list
- 928bf2dd018c..9cb150eeeed4: result

- d90e5e0f64eb: "squashed" patch 5/9 (with conflicts) in "mptcp: =

Implement path manager interface commands"
- a28e79bf6de0: "Signed-off-by" + "Co-developed-by"
- 9cb150eeeed4..cadd51934361: result

- 959311c1ef2e: "squashed" patch 6/9 in "subflow: place further subflows =

on new 'join_list'"
- 78b52ea186cb: "Signed-off-by" + "Co-developed-by"
- cadd51934361..74cd9cb07e28: result

The 3 last patches have been added at the end of the series:

- c3a214585944: mptcp: add netlink based PM
     - simple conflict with MPTCP_SUBFLOW_ATTR_MAX
- 46dcb6276168: selftests: add PM netlink functional tests
     - no conflict
- a17132c420b0: selftests: add test-cases for MPTCP MP_JOIN
     - no conflict
- 74cd9cb07e28..fa603a295c69: result

Tests + export are in progress.

Please tell me if there is anything wrong.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6882835614489368688==--
