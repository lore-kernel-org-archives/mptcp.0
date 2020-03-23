Content-Type: multipart/mixed; boundary="===============9009045638868700709=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Additional part 3 squash suggestion
Date: Mon, 23 Mar 2020 20:34:45 +0100
Message-ID: <5cafbe20-acbd-21cf-5344-5d94379900e7@tessares.net>
In-Reply-To: 707528d2-5f45-2ea4-e82e-6272f0df6196@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4048

--===============9009045638868700709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 23/03/2020 18:07, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 20/03/2020 02:09, Paolo Abeni wrote:
>> On Thu, 2020-03-19 at 16:24 -0700, Mat Martineau wrote:
>>> What do you think about also squashing "mptcp: increment MIB counters =

>>> in a
>>> few places" in to the previous MIB commit? Seems like our patch count =

>>> for
>>> part 3 is still kind of high.
>>
>> Additionally I think we could submit:
>>
>> "mptcp: re-check dsn before reading from subflow"
>> "sendmsg: truncate source buffer if mptcp sndbuf size was set from =

>> userspace"
>> "subflow: check parent mptcp socket on subflow state change"
>>
>> independently from part 3 (either before or later, as it fit better).
>>
>> Togethar with the planned squashing, that makes 17 patches for part 3,
>> which I hope should be fine.
>>
>> WDYT?
> =

> As agreed on IRC, I just moved these 3 topic/commits to the end of the =

> series:
> =

> - fb09a7a55b86: tg: revert =

> t/subflow-check-parent-mptcp-socket-on-subflow-state-change
> - e8bd34ac0d03: tg: revert =

> t/sendmsg-truncate-source-buffer-if-mptcp-sndbuf-size-was-set-from-usersp=
ace =

> =

> - dde8f988d769: tg: now depending on t/mptcp-add-MIB-counter-infrastructu=
re
> - a9dba7031fe1: tg: now on top of =

> t/selftests-add-test-cases-for-MPTCP-MP_JOIN
> - 10ef670b2bbd: Revert "tg: revert =

> t/subflow-check-parent-mptcp-socket-on-subflow-state-change"
> - a44dbe63118d: Revert "tg: revert =

> t/sendmsg-truncate-source-buffer-if-mptcp-sndbuf-size-was-set-from-usersp=
ace" =

> =

> - 2574e7b58fa9: tg: now depending on =

> t/sendmsg-truncate-source-buffer-if-mptcp-sndbuf-size-was-set-from-usersp=
ace =

> =

> - ec499ad27205..267d3c188c55: result (empty as expected)
> =

> Tests + export is going to be launched soon.

Just added a small fix from Paolo:

- a8a525975bb3: Squash-to: "mptcp: queue data for mptcp level =

retransmission"
- 267d3c188c55..7deebe3e526b: result

And Mat' Signed-off-by:

[t/mptcp-Add-ADD_ADDR-handling 170851a2d026] tg:msg: add sender' =

Signed-off-by
[t/mptcp-Add-handling-of-incoming-MP_JOIN-requests 42c696413619] tg:msg: =

add sender' Signed-off-by
[t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests f56086980bce] tg:msg: =

add sender' Signed-off-by
[t/mptcp-Implement-path-manager-interface-commands 6aae10d4559b] tg:msg: =

add sender' Signed-off-by
[t/mptcp-update-per-unacked-sequence-on-pkt-reception e17ffe398290] =

tg:msg: add sender' Signed-off-by
[t/mptcp-queue-data-for-mptcp-level-retransmission b0062356dfbf] tg:msg: =

add sender' Signed-off-by
[t/mptcp-introduce-MPTCP-retransmission-timer 582861f31a25] tg:msg: add =

sender' Signed-off-by
[t/mptcp-implement-memory-accounting-for-mptcp-rtx-queue db9c40354d23] =

tg:msg: add sender' Signed-off-by
[t/mptcp-allow-partial-cleaning-of-rtx-head-dfrag 1cba9c047d0b] tg:msg: =

add sender' Signed-off-by
[t/mptcp-rework-mptcp_sendmsg_frag-to-accept-optional-dfrag =

e686543c2dde] tg:msg: add sender' Signed-off-by
[t/mptcp-implement-and-use-MPTCP-level-retransmission 65b9b3193cb7] =

tg:msg: add sender' Signed-off-by
[t/mptcp-allow-dumping-subflow-context-to-userspace 39a49d56c932] =

tg:msg: add sender' Signed-off-by
[t/mptcp-add-MIB-counter-infrastructure dc5578e17935] tg:msg: add =

sender' Signed-off-by
[t/mptcp-add-netlink-based-PM 7fc3e2f6d899] tg:msg: add sender' =

Signed-off-by
[t/selftests-add-PM-netlink-functional-tests 17a238a85b83] tg:msg: add =

sender' Signed-off-by
[t/selftests-add-test-cases-for-MPTCP-MP_JOIN 2d607ee0ff03] tg:msg: add =

sender' Signed-off-by
- 7deebe3e526b..515b70745e1a: result (empty as expected)

And a few fixes for checkpatch:

- b425e5f01502: Squash-to: "mptcp: Implement path manager interface =

commands"
- 515b70745e1a..a447c9c5ef68: result

- b4ae646b5fc9: Squash-to: "mptcp: allow partial cleaning of rtx head dfrag"

- 751501f4cf39: Squash-to: "mptcp: implement and use MPTCP-level =

retransmission"
- a447c9c5ef68..36d843bc5ff4: result

- 85b1104827d1: Squash-to: "mptcp: add and use MIB counter infrastructure"
- 36d843bc5ff4..81343107d0f4: result

- 4ccbbc868719: Squash-to: "mptcp: add netlink-based PM"
- 81343107d0f4..67488f21ed90: result

- 31a00e0ee272: Squash-to: "selftests: add PM netlink functional tests"
- 67488f21ed90..c72cbd89741a: result

Tests + export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============9009045638868700709==--
