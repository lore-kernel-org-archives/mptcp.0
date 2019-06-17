Content-Type: multipart/mixed; boundary="===============1497484041219913392=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/16] mptcp: fix checkpatch issues
Date: Mon, 17 Jun 2019 15:31:46 +0200
Message-ID: <083a5260-3a48-50d1-6e41-c8c3d1355cb0@tessares.net>
In-Reply-To: 3a010c2f-e002-53ec-5f51-83c171e1f1af@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1413

--===============1497484041219913392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 15/06/2019 22:16, Matthieu Baerts wrote:
> Hi Florian,
> =

> On 15/06/2019 21:40, Florian Westphal wrote:
>> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>> These patches simply fix code style reported by checkpatch.pl without
>>> modifying the behaviour of the code.
>>
>> Thanks for doing this, aside from one nit this looks good, feel free
>> to squash as needed.
> =

> Thank you very much for the review!
> =

> I just sent a v2 of the problematic patch. If there is no issue, I will
> squash all of that on Monday!

Thank you again for the review.

I applied the different changes:
- 16a3730b4df2: fix (patch 1) in t/mptcp-Add-MPTCP-socket-stubs
- 96f5a5257e4a: fix (patch 2) in t/mptcp-Handle-MPTCP-TCP-options
- 2cb651944bde: fix (patch 3) in
t/mptcp-Associate-MPTCP-context-with-TCP-socket
- 5dfb458242a4: fix (patch 4) in
t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- a423084d56c3: - conflict in t/mptcp-add-mptcp_poll
- 340db29a1aca: fix (patch 5) in
t/mptcp-Create-SUBFLOW-socket-for-incoming-connections
- c12ea15b2707: fix (patch 6) in t/mptcp-Add-key-generation-and-token-tree
- 9b073c7163b7: - conflict in t/mptcp-Add-shutdown-socket-operation
- 7235c504b4ce: fix (patch 7) in
t/tcp-Prevent-coalesce-collapse-when-skb-has-MPTCP-extensions
- cc12478c4b12: - conflict in
t/mptcp-Write-MPTCP-DSS-headers-to-outgoing-data-packets
- 233967ed7653: fix (patch 8) in
t/mptcp-Write-MPTCP-DSS-headers-to-outgoing-data-packets
- f2b0032688bd: - conflict in t/mptcp-Implement-MPTCP-receive-path
- 42c068f65a35: fix (patch 9) in t/mptcp-Implement-MPTCP-receive-path
- 46613a7cc813: - conflict in
t/mptcp-Make-connection_list-a-real-list-of-subflows
- b11740209653: fix (patch 10) in
t/mptcp-Make-connection_list-a-real-list-of-subflows
- 08354673fb0f: fix (patch 11) in t/mptcp-add-and-use-mptcp_subflow_hold
- 35db7a5ba485: fix (patch 12) in t/mptcp-add-basic-kselftest-program
- 62e0982a571d: - conflict in
t/mptcp-selftests-switch-to-netns-veth-based-tests
- 69e267369baa: fix (patch 13) in
t/mptcp-selftests-switch-to-netns-veth-based-tests
- a7c01cc82aab: - conflict in
t/mptcp-accept-don-t-leak-mptcp-socket-structure
- 36c1ab20989b: - conflict in
t/mptcp-switch-sublist-to-mptcp-socket-lock-protection
- 7b27fbce2bbd: fix (patch 14) in t/mptcp-Add-path-manager-interface
- ee3a970a11bc: fix (patch 15) in t/mptcp-Add-ADD_ADDR-handling
- 533717289f01: fix (patch 16) in
t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- 24848c5a886d..a083a2836977: result

With the extra patch I just sent, tests are OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1497484041219913392==--
