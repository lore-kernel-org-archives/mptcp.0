Content-Type: multipart/mixed; boundary="===============1368909091793176802=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/12] pm netlink: followup and fixes
Date: Wed, 11 Mar 2020 20:59:57 +0100
Message-ID: <60fd12e6-fdf3-f370-d0cc-c113be5b9cf4@tessares.net>
In-Reply-To: alpine.OSX.2.22.394.2003051735400.45396@mlee22-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3925

--===============1368909091793176802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Paolo,

On 06/03/2020 02:37, Mat Martineau wrote:
> =

> On Thu, 5 Mar 2020, Paolo Abeni wrote:

[...]

>> The up2date branch for this series (v2) is available here:
>>
>> https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_7
>>
>> v1 -> v2:
>> - comments and readability changes in patch 04
>>
> =

> Thanks for the fixes - I don't have any further comments, looks good to =

> integrate in the topgit tree.

Thank you for the patches and the review!


*Paolo* : there is one comment for you below:


- the first patch has been applied as a new topic (exported commit) at =

the beginning of the series. =E2=86=92 t/mptcp-rename-fourth-ack-field
- 5a5f6637f84f: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- b5b033c18651..a6e8ad2a3769: result

- 1e9a3e8639eb: "squashed" patch 2/12 in "mptcp: Add path manager =

interface" (not on top of "mptcp: Add ADD_ADDR handling")
- 02ebff8a2889: conflict in =

t/mptcp-Implement-path-manager-interface-commands
- a6e8ad2a3769..b9678d1875a3: result

- 0e515e7616d3: "squashed" patch 3/12 in "mptcp: Add handling of =

incoming MP_JOIN requests"
=E2=86=92 *Paolo*: I removed the new comment "passive connection, attach to=
 msk =

socket" as you did in your branch. Was it OK?
- a8393200f126: conflict in =

t/subflow-place-further-subflows-on-new-join_list
- b9678d1875a3..16774063f32f: result

- d1a5f94551a0: "squashed" patch 4/12 in "mptcp: Add handling of =

outgoing MP_JOIN requests"
- 16774063f32f..98f82f13c815: result

- 90aea70d750f: "squashed" patch 5/12 (with conflicts) in "mptcp: =

Implement path manager interface commands"
- 98f82f13c815..9f20f16976d5: result

- 55fcf97eb8a2: "squashed" patch 6/12 in "mptcp: allow dumping subflow =

context to userspace"
- bac8494b909d: "Signed-off-by" + "Co-developed-by"
- 9f20f16976d5..bd72cf4868c2: result

- ab0626ee746d: "squashed" patch 7/12 in "mptcp: add MIB counter =

infrastructure"
- 4938832cda6f: "Signed-off-by" + "Co-developed-by"
- bd72cf4868c2..9d4cccd2f4f2: result

- e73584a30099: "squashed" patch 8/12 in "mptcp: increment MIB counters =

in a few places"
- 9d4cccd2f4f2..565f38422c7e: result

- b163eff329fe: "squashed" patch 9/12 in "subflow: place further =

subflows on new 'join_list'"
- 565f38422c7e..6f8e4ee41d9b: result

- e51fa26aad11: "squashed" patch 10/12 in "mptcp: add netlink based PM"
- 6f8e4ee41d9b..4e1be8fa7025: result

- 02c781aa2467: "squashed" patch 11/12 in "selftests: add PM netlink =

functional tests"
- 4e1be8fa7025..284d58a7ac6d: result

- 4db8e0bf06fd: "squashed" patch 12/12 (with conflicts) in "selftests: =

add test-cases for MPTCP MP_JOIN"
- 284d58a7ac6d..96df58122739: result

Tests + export will be launched soon.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1368909091793176802==--
