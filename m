Content-Type: multipart/mixed; boundary="===============0326391464395725169=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/2] ss: msk diag support
Date: Thu, 02 Jul 2020 13:35:52 +0200
Message-ID: <cover.1593689647.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4901

--===============0326391464395725169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

basic support for MPTCP sockets diag interface.

The first patch update the required headers, while the 2nd one bring in
the actual implementation

v1 -> v2:
 - updated to diag uAPI change (ack,fallback -> flags)

Paolo Abeni (2):
  include: update mptcp uAPI
  ss: mptcp: add msk diag interface support

 include/uapi/linux/inet_diag.h |   1 +
 include/uapi/linux/mptcp.h     |  17 +++++
 misc/ss.c                      | 115 ++++++++++++++++++++++++++++++---
 3 files changed, 123 insertions(+), 10 deletions(-)

-- =

2.26.2

--===============0326391464395725169==--
