Content-Type: multipart/mixed; boundary="===============4769625753819139610=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/4] more MP_JOIN self-tests fixes
Date: Fri, 20 Mar 2020 14:08:11 +0100
Message-ID: <287d81d2-6030-36cc-8eaf-8571261d125c@tessares.net>
In-Reply-To: cover.1584665520.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4016

--===============4769625753819139610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 20/03/2020 01:59, Paolo Abeni wrote:
> This series bring in more MP_JOIN self-tests fixes.
> =

> It also includes a couple of last minute fixes for add_addr hmac, please =
see
> individual patches for detailed info.
> =

> With a previous iteration of this series applied, the  self-tests survide=
d >
> 1500 iterations without any failures. This iteration went through smaller
> test-cycles, still without issues.
> =

> The rebased export branch is available here:
> =

> https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_12

Thank you for the patches!

- 07ba7723f14f: "squashed" patch 1/4 in "mptcp: Add ADD_ADDR handling"
- 79ced2399cff: conflict in t/mptcp-Add-path-manager-interface
- 75fd7fbcff54..57b87fa20529: result

- 9e1e12b0253a: "squashed" patch 2/4 in "mptcp: Add path manager interface"
- a116910e09e2: conflict in =

t/mptcp-update-per-unacked-sequence-on-pkt-reception
- 57b87fa20529..a60d43a78ea9: result

- f1c4bd2b5b30: "squashed" patch 3/4 in "mptcp: Add handling of incoming =

MP_JOIN requests"
- 0a5b28b67886: conflict in =

t/subflow-place-further-subflows-on-new-join_list
- a60d43a78ea9..dd40c4166ba2: result

- 08ef7db1c8c7: "squashed" patch 4/4 in "subflow: place further subflows =

on new 'join_list'"
- dd40c4166ba2..10a5c66719de: result

Tests + export will be launched soon!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4769625753819139610==--
