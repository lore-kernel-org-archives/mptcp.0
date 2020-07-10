Content-Type: multipart/mixed; boundary="===============8372233416718117966=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH iproute2-next 0/2] ss: MPTCP diag interface support
Date: Fri, 10 Jul 2020 15:52:33 +0200
Message-ID: <cover.1594388640.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4972

--===============8372233416718117966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series implements support for the MPTCP diag interface, as recently
introduced on net-next.

The first patch updates the relevant uAPI definition to current net-next,
while the 2nd one brings in the actual implementation

Paolo Abeni (2):
  include: update mptcp uAPI
  ss: mptcp: add msk diag interface support

 include/uapi/linux/inet_diag.h |   1 +
 include/uapi/linux/mptcp.h     |  17 +++++
 misc/ss.c                      | 115 ++++++++++++++++++++++++++++++---
 3 files changed, 123 insertions(+), 10 deletions(-)

-- =

2.26.2

--===============8372233416718117966==--
