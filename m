Content-Type: multipart/mixed; boundary="===============4974237357638861875=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] topmsg: mptcp: implement and use MPTCP-level
 retransmission
Date: Thu, 19 Mar 2020 17:23:06 -0700
Message-ID: <20200320002307.89947-4-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4002

--===============4974237357638861875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .topmsg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.topmsg b/.topmsg
index 33c007398123..d0f9f41aa08f 100644
--- a/.topmsg
+++ b/.topmsg
@@ -2,7 +2,7 @@ From: Paolo Abeni <pabeni(a)redhat.com>
 Subject: [PATCH] mptcp: implement and use MPTCP-level retransmission
 =

 On timeout event, schedule a work queue to do the retransmission.
-Retransmission code resemple closely sendmsg() implementation and
+Retransmission code closely resembles the sendmsg() implementation and
 re-uses mptcp_sendmsg_frag, providing a dummy msghdr - for flags'
 sake - and peeking the relevant dfrag from the rtx head.
 =

-- =

2.25.2

--===============4974237357638861875==--
