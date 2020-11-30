Content-Type: multipart/mixed; boundary="===============3611564206320802729=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 3/7] mptcp: add port number
 announced check
Date: Mon, 30 Nov 2020 14:17:51 +0800
Message-ID: <8778018030d1dc833b40fb8ff1afa1bbe02551b0.1606716547.git.geliangtang@gmail.com>
In-Reply-To: 86984323249f08d04d6bff717afbdc94f314e291.1606716547.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6974

--===============3611564206320802729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When we received the MP_JOIN's SYN/ACK, we do the port number checks. If
the subflow's source port number is different, we use a new helper
mptcp_pm_sport_in_anno_list to check whether this port number is announced.
If it isn't, we need to abort this connection.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 34 ++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h   |  1 +
 net/mptcp/subflow.c    | 10 ++++++++++
 3 files changed, 45 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c296927bf167..a41c41974eb9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -111,6 +111,19 @@ static void remote_address(const struct sock_common *s=
kc,
 #endif
 }
 =

+static void source_address(struct sock_common *skc,
+			   struct mptcp_addr_info *addr)
+{
+	addr->family =3D skc->skc_family;
+	addr->port =3D htons(skc->skc_num);
+	if (addr->family =3D=3D AF_INET)
+		addr->addr.s_addr =3D skc->skc_rcv_saddr;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (addr->family =3D=3D AF_INET6)
+		addr->addr6 =3D skc->skc_v6_rcv_saddr;
+#endif
+}
+
 static bool lookup_subflow_by_saddr(const struct list_head *list,
 				    struct mptcp_addr_info *saddr)
 {
@@ -202,6 +215,27 @@ lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 	return NULL;
 }
 =

+bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock=
 *sk)
+{
+	struct mptcp_pm_add_entry *entry;
+	struct mptcp_addr_info saddr;
+	bool ret =3D false;
+
+	source_address((struct sock_common *)sk, &saddr);
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.anno_list, list) {
+		if (addresses_equal(&entry->addr, &saddr, true)) {
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
index ec179f3a6b4b..014acecae649 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -554,6 +554,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
+bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock=
 *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       struct mptcp_addr_info *addr);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 89fe7c1744d5..7da6a00a35a6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -184,6 +184,14 @@ static void subflow_init_req(struct request_sock *req,
 			pr_debug("syn inet_sport=3D%d %d",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
+			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
+				sock_put((struct sock *)subflow_req->msk);
+				mptcp_token_destroy_request(req);
+				tcp_request_sock_ops.destructor(req);
+				subflow_req->msk =3D NULL;
+				subflow_req->mp_join =3D 0;
+				return;
+			}
 		}
 =

 		if (unlikely(req->syncookie) && subflow_req->msk) {
@@ -642,6 +650,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
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

--===============3611564206320802729==--
