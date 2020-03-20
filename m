Content-Type: multipart/mixed; boundary="===============4035093603346246729=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 0/4] more MP_JOIN self-tests fixes
Date: Fri, 20 Mar 2020 01:59:45 +0100
Message-ID: <cover.1584665520.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4010

--===============4035093603346246729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series bring in more MP_JOIN self-tests fixes.

It also includes a couple of last minute fixes for add_addr hmac, please see
individual patches for detailed info.

With a previous iteration of this series applied, the  self-tests survided >
1500 iterations without any failures. This iteration went through smaller =

test-cycles, still without issues.

The rebased export branch is available here:

https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_12


 options.c  |   25 +++++++++++++------------
 protocol.c |   16 +++++++++-------
 subflow.c  |    4 ++--
 3 files changed, 24 insertions(+), 21 deletions(-)

--===============4035093603346246729==--
