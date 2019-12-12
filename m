Content-Type: multipart/mixed; boundary="===============2447995683121206701=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/2] Optimize struct mptcp_options_received
Date: Fri, 13 Dec 2019 00:07:13 +0100
Message-ID: <1e00aad1-614e-ae0a-725a-d89d6c3967fc@tessares.net>
In-Reply-To: 4a226bd78f9a7404c938c463ebda9a1f7bc88237.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2902

--===============2447995683121206701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 12/12/2019 16:31, Paolo Abeni wrote:
> Hi,
> =

> On Wed, 2019-12-11 at 21:08 -0800, Peter Krystad wrote:
>> Changes for part 1 commits. Conflicts are straightforward
>> when squashed.
>>
>> Peter Krystad (2):
>>    mptcp: Move struct mptcp_options_received
>>    mptcp: Remove version field from mptcp_options_received
>>
>>   include/linux/tcp.h  | 19 +++++++++++--------
>>   net/mptcp/options.c  |  7 ++++---
>>   net/mptcp/protocol.h |  2 ++
>>   3 files changed, 17 insertions(+), 11 deletions(-)
> =

> LGTM!

Thank you for the patches and the reviews!


Because there are a few conflicts and these patches were created on top =

of "mptcp: Handle MPTCP TCP options" (and it is late for me :) ), may =

you check that at least the "result" is OK for you?


- ca28c8b4337c: "squashed" patch 1/2 in "mptcp: Handle MPTCP TCP options"
- 29ddc320cce4: "squashed" patch 2/2 in "mptcp: Handle MPTCP TCP options"
- cadaa98e433f: conflict in t/mptcp-Add-key-generation-and-token-tree
- 92e51f00d505: conflict in t/mptcp-Implement-MPTCP-receive-path
- 651f0bfd3c50: conflict in t/mptcp-move-from-sha1-v0-to-sha256-v1
- eca85f157716: conflict in =

t/mptcp-parse-and-emit-MP_CAPABLE-option-according-to-v1-spec
- 93ae416aea97: conflict in t/mptcp-Add-path-manager-interface
- 3466814d0772: conflict in t/mptcp-Add-ADD_ADDR-handling
- b3ce6ad38226: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- e000e15dedfd: fix how the conflict was solved in =

t/mptcp-Implement-MPTCP-receive-path
- 62e097f0112b: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- c5b8ad49fc3a..3549fa17fbd3: result

Cheers;
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2447995683121206701==--
