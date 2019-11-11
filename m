Content-Type: multipart/mixed; boundary="===============5057938878787843321=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/4] mptcp: some cleanups
Date: Mon, 11 Nov 2019 12:28:57 +0100
Message-ID: <cover.1573471403.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2458

--===============5057938878787843321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This address the build issue we currently have on patch =

"mptcp: Add key generation and token tree", plus move around some related
code for consistency.

No differences in the resulting code vs current git tree.
The tree should build on each patch now.

Paolo Abeni (1):
  1/4 mptcp: drop most of mptcp_init_sock() impl
  2/4 mptcp: use customary name for tcp_sock variable
  3/4 mptcp: init ctx->icsk_af_ops in subflow_ulp_init()
  4/4 mptcp: init new_ctx->icsk_af_ops() in subflow_ulp_clone()

 net/mptcp/protocol.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

-- =

2.21.0

--===============5057938878787843321==--
