Content-Type: multipart/mixed; boundary="===============6173046592276597228=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 0/9] selftests: add ipv6 support and reduce run time
Date: Fri, 25 Oct 2019 14:16:42 +0200
Message-ID: <20191025121651.25946-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2310

--===============6173046592276597228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is the 4th iteration of the selftest patchset.

Changes since v3:
 - get rid of unused variable warnings in patch 2
 - get rid of bogus fallthrough in patch 4
 - add patch 8: Get rid of redundant test cases, no need to
   test tcp fallback for all netns combinations.
 - add patch 9: allow to set delay/loss/reordering etc. to use.
   Default is random so selftests expose wider combinations.

All changes can be squashed into "mptcp: add basic kselftest for mptcp".

The following changes since commit 117a75c747bfe24c1ba08c295a289204c291f588:

  mptcp: Implement basic path manager (2019-10-25 01:30:45 +0000)

are available in the Git repository at:

  git://git.breakpoint.cc/fw/mptcp-next.git mptcp_selftest_04

for you to fetch changes up to ffc4ff6abe4fcc1701afa0b924fca7ec88823e1e:

  selftests: mptcp: add command line options to override netem/ethtool sett=
ings (2019-10-25 14:09:38 +0200)

----------------------------------------------------------------
Florian Westphal (9):
      selftests: mptcp: make tc delays random
      selftests: mptcp: add accept/getpeer checks
      selftests: mptcp: extend mptcp_connect tool for ipv6 family
      selftests: mptcp: random ethtool tweaking
      selftests: mptcp: allow parallel execution
      selftests: mptcp: fix spurious deadlock
      selftests: mptcp: track duration of each test
      selftests: mptcp: remove the redundant test cases
      selftests: mptcp: add command line options to override netem/ethtool =
settings

 tools/testing/selftests/net/mptcp/mptcp_connect.c  | 175 +++++++++--
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 326 +++++++++++++++++=
----
 2 files changed, 411 insertions(+), 90 deletions(-)

--===============6173046592276597228==--
