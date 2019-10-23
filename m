Content-Type: multipart/mixed; boundary="===============5478257956679280945=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/2] selftests: increase the new default timeout
Date: Wed, 23 Oct 2019 08:48:52 +0200
Message-ID: <20191023064854.20453-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2272

--===============5478257956679280945==
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

v2: fix typo in the second patch.

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

--===============5478257956679280945==--
