Content-Type: multipart/mixed; boundary="===============3767207839398011416=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/5] squash and cleanup
Date: Fri, 20 Mar 2020 22:49:47 +0100
Message-ID: <49561b91-53a0-295a-282b-a59003bb48f7@tessares.net>
In-Reply-To: alpine.OSX.2.22.394.2003201207560.19124@mcgray1-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4035

--===============3767207839398011416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat

@Paolo: I have a comment for you below

On 20/03/2020 20:08, Mat Martineau wrote:
> =

> On Fri, 20 Mar 2020, Paolo Abeni wrote:
> =

>> This series contains a "squashable" version of:
>>
>> subflow: place further subflows on new 'join_list'
>>
>> and a bunch of minor cleanup (unneeded check after not so recent net-next
>> changes)
>>
>> Rebased tree available at:
>>
>> https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_14
>>
>> this supersede the squashed branch posted previously.
>>
>> Self-tests loop running. Will update here with results.
>>
>> options.c=C2=A0 |=C2=A0=C2=A0 11 +++--------
>> protocol.c |=C2=A0=C2=A0 31 ++++++++++++++++++++++++++++++-
>> protocol.h |=C2=A0=C2=A0=C2=A0 2 ++
>> subflow.c=C2=A0 |=C2=A0=C2=A0=C2=A0 5 ++++-
>> 4 files changed, 39 insertions(+), 10 deletions(-)
> =

> Changes look good to me - thanks Paolo!

Thank you for the patches, the tests and the reviews!

- d9c29116606a: "squashed" patch 1/5 in "mptcp: Add ADD_ADDR handling"
- 348e235ba3d5: conflict in t/mptcp-Add-path-manager-interface
- c011ac35dcba..dffdcd105251: result

- e7ac600fc440: "squashed" patch 2/5 in "mptcp: Add path manager interface"
- 7c7660a7e9d8: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- dffdcd105251..83e0a152c29b: result (empty, as expected)

- fe80488ecbae: "squashed" patch 3/5 in "mptcp: Add handling of incoming =

MP_JOIN requests"
- 83e0a152c29b..082785f12357: result

- 5079f6bd9a9b: "squashed" patch 4/5 in "mptcp: Add handling of outgoing =

MP_JOIN requests"
- 49a712650dca: tg: add a description from parent commit
- 6303bcfe7f27: conflict in =

t/mptcp-queue-data-for-mptcp-level-retransmission
- 9f05cafd0fc3: conflict in t/mptcp-introduce-MPTCP-retransmission-timer
- 66c69c29abdc: conflict in =

t/mptcp-implement-and-use-MPTCP-level-retransmission
- 082785f12357..9345f86134a1: result

*Paolo* : the result is not empty because the commit to squash was not =

empty. I guess in your previous message (squashing of "subflow: place =

further subflows on new 'join_list'") the diff was inverted, right?

Additional commit:
- 1c46c069c95d: mptcp:worker: flush the join list sooner
- c85ce15b5be0..2bfb96355343: result

- 7585b5b02c27: "squashed" patch 5/5 in "mptcp: update per unacked =

sequence on pkt reception"
- 9345f86134a1..c85ce15b5be0: result

- 4ae633d18908: tg: depend on =

t/sendmsg-truncate-source-buffer-if-mptcp-sndbuf-size-was-set-from-userspace
- 2bfb96355343..49bd5a76f678: result (empty as expected)

Tests + export are going to be launched soon.

Cheers
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3767207839398011416==--
