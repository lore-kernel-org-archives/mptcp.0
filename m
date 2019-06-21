Content-Type: multipart/mixed; boundary="===============5249930804188627594=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 3/3] net: Add IPPROTO_MPTCP to inet_sock_set_state
 tracepoint output
Date: Fri, 21 Jun 2019 16:55:34 -0700
Message-ID: <20190621235534.19690-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20190621235534.19690-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1442

--===============5249930804188627594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add MPTCP to the list of protocols that socket state change tracepoints
can output in symbolic form.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/trace/events/sock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index dc749c651318..bfbcba315a12 100644
--- a/include/trace/events/sock.h
+++ b/include/trace/events/sock.h
@@ -19,7 +19,8 @@
 #define inet_protocol_names		\
 		EM(IPPROTO_TCP)			\
 		EM(IPPROTO_DCCP)		\
-		EMe(IPPROTO_SCTP)
+		EM(IPPROTO_SCTP)		\
+		EMe(IPPROTO_MPTCP)
 =

 #define tcp_state_names			\
 		EM(TCP_ESTABLISHED)		\
-- =

2.22.0


--===============5249930804188627594==--
