Content-Type: multipart/mixed; boundary="===============0795704732662139082=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 05/10] mptcp: add port number
 announced check
Date: Thu, 19 Nov 2020 18:19:45 +0800
Message-ID: <fffe5a2aa8ec491955857eb4698764fc2e4a03a7.1605780306.git.geliangtang@gmail.com>
In-Reply-To: 98d6d28d73dcb5cb2a7ff40fb3d264dc2af05933.1605780306.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6816

--===============0795704732662139082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When we received the MP_JOIN's SYN/ACK, we do the port number checks. If
the subflow's source port number is different, we use a new helper
mptcp_pm_sport_in_anno_list to check whether this port number is announced.
If it isn't, we need to abort this connection.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h   |  1 +
 net/mptcp/subflow.c    |  6 ++++++
 3 files changed, 25 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1f9583e92d72..27aff32516dd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -203,6 +203,24 @@ lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 	return NULL;
 }
 =

+bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock=
 *sk)
+{
+	struct mptcp_pm_add_entry *entry;
+	bool ret =3D false;
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.anno_list, list) {
+		if (entry->addr.port =3D=3D inet_sk(sk)->inet_sport) {
+			ret =3D true;
+			goto out;
+		}
+	}
+
+out:
+	spin_unlock_bh(&msk->pm.lock);
+	return ret;
+}
+
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
 	struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer, add_timer);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d6ea2a6a7237..ba0c5f628637 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -526,6 +526,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
+bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock=
 *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       struct mptcp_addr_info *addr);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3ae365130a08..76fdaa57eb1d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -192,6 +192,10 @@ static void subflow_init_req(struct request_sock *req,
 			pr_debug("syn inet_sport=3D%d %d",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
+			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
+				subflow_req->mp_join =3D 0;
+				return;
+			}
 		}
 	}
 }
@@ -638,6 +642,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 				pr_debug("ack inet_sport=3D%d %d",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
+				if (!mptcp_pm_sport_in_anno_list(owner, sk))
+					goto out;
 			}
 		}
 	}
-- =

2.26.2

--===============0795704732662139082==--
