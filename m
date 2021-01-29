Content-Type: multipart/mixed; boundary="===============0523226223155155555=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 10/16] mptcp: add port number check for
 MP_JOIN
Date: Thu, 28 Jan 2021 17:11:09 -0800
Message-ID: <20210129011115.133953-11-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210129011115.133953-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7517

--===============0523226223155155555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch adds two new helpers, subflow_use_different_sport and
subflow_use_different_dport, to check whether the subflow's source or
destination port number is different from the msk's port number. When
receiving the MP_JOIN's SYN/SYNACK/ACK, we do these port number checks
and print out the different port numbers.

And furthermore, when receiving the MP_JOIN's SYN/ACK, we also use a new
helper mptcp_pm_sport_in_anno_list to check whether this port number is
announced. If it isn't, we need to abort this connection.

This patch also populates the local address's port field in
local_address.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm_netlink.c | 23 ++++++++++++++++++++++-
 net/mptcp/protocol.h   |  1 +
 net/mptcp/subflow.c    | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5ab79f659c6d..d6e23e079fb0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -97,8 +97,8 @@ static bool address_zero(const struct mptcp_addr_info *ad=
dr)
 static void local_address(const struct sock_common *skc,
 			  struct mptcp_addr_info *addr)
 {
-	addr->port =3D 0;
 	addr->family =3D skc->skc_family;
+	addr->port =3D htons(skc->skc_num);
 	if (addr->family =3D=3D AF_INET)
 		addr->addr.s_addr =3D skc->skc_rcv_saddr;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -254,6 +254,27 @@ lookup_anno_list_by_saddr(struct mptcp_sock *msk,
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
+	local_address((struct sock_common *)sk, &saddr);
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
index 7e0d8774c673..1d6076f1c538 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -649,6 +649,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
 				 u8 bkup);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
+bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock=
 *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       struct mptcp_addr_info *addr);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 94926ab74d48..ebfbf6a9b669 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -120,6 +120,11 @@ static int __subflow_init_req(struct request_sock *req=
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
 /* Init mptcp request socket.
  *
  * Returns an error code if a JOIN has failed and a TCP reset
@@ -192,6 +197,20 @@ static int subflow_init_req(struct request_sock *req,
 		if (!subflow_req->msk)
 			return -EPERM;
 =

+		if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
+			pr_debug("syn inet_sport=3D%d %d",
+				 ntohs(inet_sk(sk_listener)->inet_sport),
+				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
+			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
+				sock_put((struct sock *)subflow_req->msk);
+				mptcp_token_destroy_request(req);
+				tcp_request_sock_ops.destructor(req);
+				subflow_req->msk =3D NULL;
+				subflow_req->mp_join =3D 0;
+				return -EPERM;
+			}
+		}
+
 		subflow_req_create_thmac(subflow_req);
 =

 		if (unlikely(req->syncookie)) {
@@ -336,6 +355,11 @@ void mptcp_subflow_reset(struct sock *ssk)
 	sock_put(sk);
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
@@ -402,6 +426,12 @@ static void subflow_finish_connect(struct sock *sk, co=
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
@@ -667,6 +697,14 @@ static struct sock *subflow_syn_recv_sock(const struct=
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

2.30.0

--===============0523226223155155555==--
