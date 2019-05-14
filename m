Content-Type: multipart/mixed; boundary="===============5495788629217786921=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC mptcp 0/2] preliminary support for 'ss'
Date: Tue, 14 May 2019 11:14:07 +0200
Message-ID: <cover.1557824658.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1159

--===============5495788629217786921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

dumping subflow-related information from userspace tools can be useful
also in the early stages of developement, for writing functional tests
and for debugging purposes.

- patch 1 adds support for ULP-specific information in the output of
  INET_DIAG_INFO request.
- patch2 is a POC that dumps several members of struct subflow_context.


Davide Caratti (2):
  tcp: ulp: add functions to dump ulp-specific information
  mptcp: allow dumping subflow context to userspace

 include/net/tcp.h              |  3 ++
 include/uapi/linux/inet_diag.h |  7 ++++
 include/uapi/linux/mptcp.h     | 21 ++++++++++
 net/ipv4/tcp_diag.c            | 33 ++++++++++++++-
 net/mptcp/Makefile             |  2 +-
 net/mptcp/diag.c               | 73 ++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h           |  3 ++
 net/mptcp/subflow.c            |  2 +
 8 files changed, 141 insertions(+), 3 deletions(-)
 create mode 100644 include/uapi/linux/mptcp.h
 create mode 100644 net/mptcp/diag.c

-- =

2.20.1


--===============5495788629217786921==--
