Content-Type: multipart/mixed; boundary="===============7216926536449347568=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 5/6] Squash-to: "mptcp: add and use MIB counter
 infrastructure"
Date: Fri, 27 Mar 2020 16:53:26 +0100
Message-ID: <20200327155327.605375-6-matthieu.baerts@tessares.net>
In-Reply-To: 20200327155327.605375-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4092

--===============7216926536449347568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove inline in foo.c files, let the compiler decide.

Request from David S. Miller.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/subflow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index edf5b543bdf5..b5180c81588e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -22,8 +22,8 @@
 #include "protocol.h"
 #include "mib.h"
 =

-static inline void SUBFLOW_REQ_INC_STATS(struct request_sock *req,
-					 enum linux_mptcp_mib_field field)
+static void SUBFLOW_REQ_INC_STATS(struct request_sock *req,
+				  enum linux_mptcp_mib_field field)
 {
 	MPTCP_INC_STATS(sock_net(req_to_sk(req)), field);
 }
-- =

2.25.1

--===============7216926536449347568==--
