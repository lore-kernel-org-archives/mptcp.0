Content-Type: multipart/mixed; boundary="===============2070488020854241910=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/5] IPv6 prerequisite patches
Date: Wed, 16 Oct 2019 18:37:43 +0200
Message-ID: <dae9fee0-2900-0a1f-980d-c7c23cbcc4c0@tessares.net>
In-Reply-To: 20191015230613.16981-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2190

--===============2070488020854241910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 16/10/2019 01:06, Peter Krystad wrote:
> IPv6 changes to the path manager and option handling. May all
> be squashed as specified in each patch.
> =

> Peter Krystad (5):
>    mptcp: Update path manager interface for IPv6
>    mptcp: Add missing ADD_ADDR handling
>    mptcp: Make mptcp_subflow_connect() IPv4/6 agnostic
>    mptcp: Update path manager interface commands for IPv6
>    mptcp: Update basic path manager for IPv6
> =

>   net/mptcp/basic.c    |  40 ++++++++++------
>   net/mptcp/options.c  |  24 ++++++----
>   net/mptcp/pm.c       | 106 ++++++++++++++++++++++++++++++++++++-------
>   net/mptcp/protocol.h |  15 +++---
>   net/mptcp/subflow.c  |  16 ++++---
>   5 files changed, 150 insertions(+), 51 deletions(-)

Thank you for the patches and the reviews!

patch 1:
- 783161cb589b: "squashed" in "mptcp: Add path manager interface"
- signed-off already there
- 9fd478f3331c..eea26159d20e: result

patch 2:
- 9dfbbd1eedec: "squashed" in "mptcp: Add ADD_ADDR handling"
- signed-off already there
- 0b515fa5e27a: avoid IPv6 check if already IPv4: see ML.
- eea26159d20e..2dca0ad11f4b: result

patch 3:
- 2be980b466cf: "squashed" patch3 in "mptcp: Add handling of outgoing =

MP_JOIN requests"
- signed-off already there
- 2dca0ad11f4b..095657af2a52: result

patch 4:
- b0cdad25c90a: "squashed" in "mptcp: Implement path manager interface =

commands"
- signed-off already there
- 095657af2a52..74a2252d510a: result
- e3c234a79105: move code from "mptcp: Implement path manager interface =

commands" ...
- d1e0874d331c: ... to "mptcp: Add path manager interface"
- 74a2252d510a..c30aad35ee54: result

patch 5:
- 01af9af62437: "squashed" in "mptcp: Implement basic path manager"
- signed-off already there
- c30aad35ee54..9ed47f1c5595: result

Tests seems OK (if we omit the warning previously mentioned in the ML).

Just some compilation errors with IPv6, I sent follow-up patches for =

that ;-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2070488020854241910==--
