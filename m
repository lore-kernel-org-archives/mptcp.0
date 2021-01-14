Content-Type: multipart/mixed; boundary="===============2798401725355081788=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v6 0/5] add IPv4-mapped address support
Date: Thu, 14 Jan 2021 18:29:21 +0100
Message-ID: <20210114172926.2563610-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7376

--===============2798401725355081788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset adds IPv4-mapped address support and testcases.

v6:
 - Extract the modifications to reduce the scope of the 'remote' variable i=
n a
   dedicated commit (patch 3/5)

v5:
 - Add missing Mat' Suggesting-by tag on patch 2/4 (sorry, I forgot that)
 - Address Geliang's comments (thx for the review! - patches 2-3/4)
 - Increase selftests timeout (new patch 4/4)
 - Rebase on latest export branch

v4:
 - do not try to create subflows between v4 and v6 addresses: with v3, we w=
ould
   try to do that and it could succeed if the IPv6 address ends with a vali=
d v4
   address. See patch 2/3
 - add two testcases checking that in 3/3: the 1st one was failing with v3.
 - add #ifdef MPTCP_IPV6 in patch 1/3 (Mat)
 - split the code I previously sent into two commits to allow backports: to=
 be
   checked if they can really be considered as "fixes" or "new features".
 - @Geliang: I hope this is OK for you, I quickly did these modifications d=
uring
   a lunch break and ran mp_join selftests + mpjoin packetdrill. Please tel=
l me
   if I did anything wrong :)

v3:
 - add Matt's code in it.
 - deal with the IPv4-mapped back to IPv4 case too.
 - add two new IPv4-mapped back to IPv4 testcases.

v2:
 - v1 calls mptcp_pm_addr_convert_v4mapped in mptcp_pm_nl_add_addr_received,
on the receiving side. v2 calls it in select_signal_address, on the
sending side.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/122

Geliang Tang (1):
  selftests: mptcp: add IPv4-mapped IPv6 testcases

Matthieu Baerts (4):
  mptcp: support MPJoin with IPv4 mapped in v6 sk
  mptcp: pm nl: support IPv4 mapped in v6 addresses
  mptcp: pm nl: reduce variable scope
  selftests: increase timeout to 10 min

 net/mptcp/pm_netlink.c                        | 39 +++++++---
 net/mptcp/subflow.c                           | 24 ++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++++
 tools/testing/selftests/net/mptcp/settings    |  2 +-
 4 files changed, 120 insertions(+), 20 deletions(-)

-- =

2.29.2

--===============2798401725355081788==--
