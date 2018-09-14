Content-Type: multipart/mixed; boundary="===============6989435875973410210=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 15/20] mptcp: Build-Fix
Date: Fri, 14 Sep 2018 10:25:19 -0700
Message-ID: <20180914172524.67961-18-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 741

--===============6989435875973410210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Need to declare a dummy-function when MPTCP is off.

Fixes: 7a662b690069 ("mptcp: Make subflow-list an RCU-list")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit f92ca04d8af5225292e8a375804bcb56fab56f58)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/mptcp.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 864796b2395c..b8b750034a91 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -1292,6 +1292,11 @@ bool mptcp_prune_ofo_queue(struct sock *sk);
 	do {				\
 	} while (0)
 =

+static inline struct sock *mptcp_to_sock(const struct mptcp_tcp_sock *mptc=
p)
+{
+	return NULL;
+}
+
 #define mptcp_for_each_sub(__mpcb, __mptcp)					\
 	if (0)
 =

-- =

2.16.2


--===============6989435875973410210==--
