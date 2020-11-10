Content-Type: multipart/mixed; boundary="===============6320156355171654941=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 09/13] mptcp: add port number
 check for MP_JOIN
Date: Tue, 10 Nov 2020 13:14:57 +0800
Message-ID: <c32afb7d145744ba936bf37097c4120bd51c6c1a.1604984546.git.geliangtang@gmail.com>
In-Reply-To: a86b6f8b46a1145685cfd4d44f429c2ea49e6e18.1604984546.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6636

--===============6320156355171654941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added two new helpers, subflow_use_different_sport and
subflow_use_different_dport, to check whether the subflow's source or
destination port number is different from the msk's port number.

When we received the MP_JOIN's SYN/SYNACK/ACK, we do these port number
checks. If the subflow's source port number is different, we use another
new helper mptcp_pm_sport_in_anno_list to check whether this port number
is announced. If it isn't, we need to abort this connection.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h   |  1 +
 net/mptcp/subflow.c    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2560c502356b..f3d69cc3ab06 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -201,6 +201,24 @@ lookup_anno_list_by_saddr(struct mptcp_sock *msk,
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
index b01c1fae9d8f..e575823c3077 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -516,6 +516,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
+bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock=
 *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       struct mptcp_addr_info *addr);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fd356dc9d580..a20f4a9ee765 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -112,6 +112,11 @@ static int __subflow_init_req(struct request_sock *req=
, const struct sock *sk_li
 	return 0;
 }
 =

+static bool subflow_use_different_sport(struct mptcp_sock *msk, const stru=
ct sock *sk)
+{
+	return inet_sk(sk)->inet_sport !=3D inet_sk((struct sock *)msk)->inet_spo=
rt;
+}
+
 static void subflow_init_req(struct request_sock *req,
 			     const struct sock *sk_listener,
 			     struct sk_buff *skb)
@@ -182,6 +187,16 @@ static void subflow_init_req(struct request_sock *req,
 =

 		pr_debug("token=3D%u, remote_nonce=3D%u msk=3D%p", subflow_req->token,
 			 subflow_req->remote_nonce, subflow_req->msk);
+
+		if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
+			pr_debug("syn inet_sport=3D%d %d",
+				 ntohs(inet_sk(sk_listener)->inet_sport),
+				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
+			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
+				subflow_req->mp_join =3D 0;
+				return;
+			}
+		}
 	}
 }
 =

@@ -284,6 +299,11 @@ void mptcp_subflow_reset(struct sock *ssk)
 		sock_hold(sk);
 }
 =

+static bool subflow_use_different_dport(struct mptcp_sock *msk, const stru=
ct sock *sk)
+{
+	return inet_sk(sk)->inet_dport !=3D inet_sk((struct sock *)msk)->inet_dpo=
rt;
+}
+
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *=
skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
@@ -349,6 +369,12 @@ static void subflow_finish_connect(struct sock *sk, co=
nst struct sk_buff *skb)
 =

 		subflow->mp_join =3D 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
+
+		if (subflow_use_different_dport(mptcp_sk(parent), sk)) {
+			pr_debug("synack inet_dport=3D%d %d",
+				 ntohs(inet_sk(sk)->inet_dport),
+				 ntohs(inet_sk(parent)->inet_dport));
+		}
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
 		mptcp_rcv_space_init(mptcp_sk(parent), sk);
@@ -611,6 +637,14 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 =

 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
 			tcp_rsk(req)->drop_req =3D true;
+
+			if (subflow_use_different_sport(owner, sk)) {
+				pr_debug("ack inet_sport=3D%d %d",
+					 ntohs(inet_sk(sk)->inet_sport),
+					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
+				if (!mptcp_pm_sport_in_anno_list(owner, sk))
+					goto out;
+			}
 		}
 	}
 =

-- =

2.26.2

--===============6320156355171654941==--
