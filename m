Content-Type: multipart/mixed; boundary="===============1691942698378130085=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] subflow: remove unneded memory barriers
Date: Wed, 15 Jan 2020 00:19:49 +0100
Message-ID: <20200114231949.20106-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3356

--===============1691942698378130085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: Implement MPTCP receive path

The bit set operation has no prior dependencies, so
smp_mb__before_atomic() is not needed.

It has no followup depenency: the woken task will always see the
bit set, plus wakeup code (called via sk_data_ready) acquires a spinlock.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index abd97d1a8645..ae9173040f17 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -712,9 +712,7 @@ static void subflow_data_ready(struct sock *sk)
 	}
 =

 	if (mptcp_subflow_data_available(sk)) {
-		smp_mb__before_atomic();
 		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
-		smp_mb__after_atomic();
 =

 		parent->sk_data_ready(parent);
 	}
@@ -869,9 +867,7 @@ static void subflow_state_change(struct sock *sk)
 	 * the data available machinery here.
 	 */
 	if (parent && subflow->mp_capable && mptcp_subflow_data_available(sk)) {
-		smp_mb__before_atomic();
 		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
-		smp_mb__after_atomic();
 =

 		parent->sk_data_ready(parent);
 	}
-- =

2.24.1

--===============1691942698378130085==--
