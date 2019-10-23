Content-Type: multipart/mixed; boundary="===============7602103068368793495=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 0/7] selftests: mptcp: increase test coverage
Date: Wed, 23 Oct 2019 15:13:18 +0200
Message-ID: <20191023131325.18895-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2277

--===============7602103068368793495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is resend of my selftest changes.  All commits may be sqaushed to
"mptcp: add basic kselftest for mptcp".

1. make tc delays random.  This is to make sure mptcp-level retransmits
   don't trigger more frequent when delay is large.
   Note that the existing selftests always test low delay in the
   loopback test case and in the ns1 <-> ns2 case, because there is no
   artificial delay in both cases.

2. add accept/getpeername checks to make sure the sockaddr returned
   from kernel is the expected endpoint.

3. add ipv6 capability to the test.
   This was tested by changing the test script to use TCP <-> TCP and
   setting both capture=3D1 ipv6=3Dtrue in the script.
   The tcpdump shows ipv6 is used.

4. use a random combination of tso/gso/gro.  Presence (or lack) of
   any of them cause slight changes in behaviour, we should make sure
   include as many combinations as possible.
   Because test duration is already large (~3m 45s in my vm), don't
   add more test cases but instead make it use random combination.

5. allow parallel execution of the test case.  This allows you to
   run e.g. 10 parallel instances instead of waiting for sequential
   completion.

6. Fix a possible deadlock in the test program where both ends
   block on write(), waiting for other side to drain the receive buffer.

7. track duration of each test.  This is useful to spot bugs in mptcp:
   if MPTCP <-> MPTCP test takes 31 seconds but TCP fallback took 3,
   something is wrong.
   With current export branch, I saw no absurd divergences, so mptcp seems
   fine right now.

Average test run time is about 2 minutes after these changes.

The changes are also available via git-pull:

The following changes since commit 85c93de446d3fd90e47605ba8ff161bef7558f09:

  mptcp: Implement basic path manager (2019-10-23 01:31:04 +0000)

are available in the Git repository at:

  git://git.breakpoint.cc/fw/mptcp-next.git mptcp_selftest_03

for you to fetch changes up to fc53dcc1b003887a25d3efb7238a351dab37ba8f:

  selftests: mptcp: track duration of each test (2019-10-23 15:08:17 +0200)

----------------------------------------------------------------
Florian Westphal (7):
      selftests: mptcp: make tc delays random
      selftests: mptcp: add accept/getpeer checks
      selftests: mptcp: extend mptcp_connect tool for ipv6 family
      selftests: mptcp: random ethtool tweaking
      selftests: allow parallel execution
      selftests: fix spurious deadlock
      selftests: mptcp: track duration of each test

 tools/testing/selftests/net/mptcp/mptcp_connect.c  | 176 +++++++++++++---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 224 +++++++++++++++--=
----
 2 files changed, 314 insertions(+), 86 deletions(-)


--===============7602103068368793495==--
