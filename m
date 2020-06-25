Content-Type: multipart/mixed; boundary="===============2360670269443165444=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH iproute2-next 0/2] ss: msk diag support
Date: Thu, 25 Jun 2020 12:34:41 +0200
Message-ID: <cover.1593081210.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4800

--===============2360670269443165444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

basic support for MPTCP sockets diag interface.

The first patch update the required headers, while the 2nd one bring in
the actual implementation

Paolo Abeni (2):
  include: update mptcp uAPI
  ss: mptcp: add msk diag interface support

 include/uapi/linux/inet_diag.h |   1 +
 include/uapi/linux/mptcp.h     |  15 +++++
 misc/ss.c                      | 115 ++++++++++++++++++++++++++++++---
 3 files changed, 121 insertions(+), 10 deletions(-)

-- =

2.26.2

--===============2360670269443165444==--
