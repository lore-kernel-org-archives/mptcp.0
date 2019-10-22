Content-Type: multipart/mixed; boundary="===============3620512637792263883=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] selftests: increase the new default timeout
Date: Tue, 22 Oct 2019 19:06:55 +0200
Message-ID: <20191022170657.20129-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2263

--===============3620512637792263883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A new commit from upstream now sets a timeout of 45 seconds per test. That's
too low for MPTCP. We need more.

But increasing the timeout was not working because selftests scripts were
looking for this new 'settings' file in the wrong directory. I am going to =
send
the first patch upstream as it might be required for other selftests and not
specific to MPTCP.

Matthieu Baerts (2):
  selftests: settings: tests can be in subsubdirs
  selftests:mptcp: increase timeout

 tools/testing/selftests/kselftest/runner.sh        | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 7 +++++++
 tools/testing/selftests/net/mptcp/settings         | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/mptcp/settings

-- =

2.20.1

--===============3620512637792263883==--
