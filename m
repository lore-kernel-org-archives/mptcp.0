Content-Type: multipart/mixed; boundary="===============7216217814023790890=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/3] selftests: mptcp: report more errors
 and details
Date: Wed, 24 Feb 2021 17:49:25 +0100
Message-ID: <20210224164928.2409821-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7941

--===============7216217814023790890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To help analysing unstable selftests, the scripts are now launching
'mptcp_connect' with a timeout in order to avoid stalled tests and print
more details if supported (patch 1).
'nstat' history is also cleared just before starting a test -- just in
case -- (patch 2) and more info is printed in case of errors in
mptcp_join.sh

Matthieu Baerts (3):
  selftests: mptcp: launch mptcp_connect with timeout
  selftests: mptcp: init nstat history
  selftests: mptcp: dump more info on mpjoin errors

 tools/testing/selftests/net/mptcp/diag.sh     | 38 +++++++++++++++---
 .../selftests/net/mptcp/mptcp_connect.sh      | 22 +++++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 39 +++++++++++++++----
 .../selftests/net/mptcp/simult_flows.sh       | 13 +++++--
 4 files changed, 91 insertions(+), 21 deletions(-)

-- =

2.30.0

--===============7216217814023790890==--
