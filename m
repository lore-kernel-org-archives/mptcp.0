Content-Type: multipart/mixed; boundary="===============6495430991376826499=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 00/10] selftests: IPv6 by default and time reduction
Date: Sat, 16 Nov 2019 13:59:26 +0100
Message-ID: <20191116125936.3563275-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2561

--===============6495430991376826499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here are a few improvements in the selftests. Nothing complex, some
details to have the results more readable (I think), IPv6 enabled by
default, the time of the execution is reduced (around 30 seconds now
with the same launched tests), and the script is more robust for the
future.

I hope we can apply the one before the last one: IPV6 is now forced in
the config, we can then always apply the IPv6 network config and remove
a lot of 'if $ipv6' in the code.

For the last one, I guess we should not apply it now because some tests
are really slow in some conditions. More details in the patch and a
separated email has been sent.

All the patches can be squashed in the commit introducing the selftests:

  mptcp: add basic kselftest for mptcp

Matthieu Baerts (10):
  selftests:mptcp: fix typo
  selftests:mptcp: enable v6 by default
  selftests:mptcp: align v4 and v6 results
  selftests:mptcp: reduce wait time for the listen
  selftests:mptcp: reduce time to wait for DAD
  selftests:mptcp: only display the NS id
  selftests:mptcp: avoid global var clash
  selftests:mptcp: do not reset "ret" when skipping
  selftests:mptcp: force MPTCP_IPV6 config
  [RFC] selftests:mptcp: decrease timeout to 100 sec

 tools/testing/selftests/net/mptcp/config      |   1 +
 .../selftests/net/mptcp/mptcp_connect.sh      | 245 +++++++++++-------
 tools/testing/selftests/net/mptcp/settings    |   2 +-
 3 files changed, 147 insertions(+), 101 deletions(-)

-- =

2.24.0

--===============6495430991376826499==--
