Content-Type: multipart/mixed; boundary="===============5962079804586786665=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/5] Revert "Fix building mptcp_fullmesh as module"
Date: Thu, 29 Nov 2018 17:05:11 -0800
Message-ID: <20181130010514.18251-3-cpaasch@apple.com>
In-Reply-To: 20181130010514.18251-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 850

--===============5962079804586786665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Kostas Peletidis <kostas(a)peletidis.net>

This reverts commit 64a808507dc425759bed331742fdbb62f0061870.

(cherry picked from commit 4b720160a051d82439314990c007065b0329c4d9)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_fullmesh.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/mptcp_fullmesh.c b/net/mptcp/mptcp_fullmesh.c
index 636642287541..e699c0e89224 100644
--- a/net/mptcp/mptcp_fullmesh.c
+++ b/net/mptcp/mptcp_fullmesh.c
@@ -606,7 +606,7 @@ static void announce_remove_addr(u8 addr_id, struct soc=
k *meta_sk)
 	mpcb->addr_signal =3D 1;
 =

 	if (sk)
-		__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
+		tcp_send_ack(sk);
 }
 =

 static void update_addr_bitfields(struct sock *meta_sk,
@@ -897,7 +897,7 @@ static void mptcp_address_worker(struct work_struct *wo=
rk)
 =

 				sk =3D mptcp_select_ack_sock(meta_sk);
 				if (sk)
-					__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
+					tcp_send_ack(sk);
 =

 				full_mesh_create_subflows(meta_sk);
 			}
@@ -980,7 +980,7 @@ static void mptcp_address_worker(struct work_struct *wo=
rk)
 							tp->mptcp->send_mp_prio =3D 1;
 							tp->mptcp->low_prio =3D event->low_prio;
 =

-							__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
+							tcp_send_ack(sk);
 						}
 					}
 =

@@ -991,7 +991,7 @@ static void mptcp_address_worker(struct work_struct *wo=
rk)
 							tp->mptcp->send_mp_prio =3D 1;
 							tp->mptcp->low_prio =3D event->low_prio;
 =

-							__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
+							tcp_send_ack(sk);
 						}
 					}
 				}
@@ -1399,10 +1399,10 @@ static void full_mesh_new_session(const struct sock=
 *meta_sk)
 		fmp->announced_addrs_v6 |=3D (1 << index);
 =

 	for (i =3D fmp->add_addr; i && fmp->add_addr; i--)
-		__tcp_send_ack(mpcb->master_sk, tcp_sk(mpcb->master_sk)->rcv_nxt);
+		tcp_send_ack(mpcb->master_sk);
 =

 	if (master_tp->mptcp->send_mp_prio)
-		__tcp_send_ack(mpcb->master_sk, tcp_sk(mpcb->master_sk)->rcv_nxt);
+		tcp_send_ack(mpcb->master_sk);
 =

 	return;
 =

@@ -1492,7 +1492,7 @@ static void full_mesh_release_sock(struct sock *meta_=
sk)
 				tp->mptcp->send_mp_prio =3D 1;
 				tp->mptcp->low_prio =3D mptcp_local->locaddr4[i].low_prio;
 =

-				__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
+				tcp_send_ack(sk);
 			}
 		}
 =

@@ -1504,7 +1504,7 @@ static void full_mesh_release_sock(struct sock *meta_=
sk)
 =

 			sk =3D mptcp_select_ack_sock(meta_sk);
 			if (sk)
-				__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
+				tcp_send_ack(sk);
 			full_mesh_create_subflows(meta_sk);
 		}
 	}
@@ -1536,7 +1536,7 @@ static void full_mesh_release_sock(struct sock *meta_=
sk)
 				tp->mptcp->send_mp_prio =3D 1;
 				tp->mptcp->low_prio =3D mptcp_local->locaddr6[i].low_prio;
 =

-				__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
+				tcp_send_ack(sk);
 			}
 		}
 =

@@ -1548,7 +1548,7 @@ static void full_mesh_release_sock(struct sock *meta_=
sk)
 =

 			sk =3D mptcp_select_ack_sock(meta_sk);
 			if (sk)
-				__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
+				tcp_send_ack(sk);
 			full_mesh_create_subflows(meta_sk);
 		}
 	}
-- =

2.16.2


--===============5962079804586786665==--
