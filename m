Content-Type: multipart/mixed; boundary="===============7813888446139007482=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 1/3] mptcp: send out ADD_ADDR
 with echo flag
Date: Wed, 19 Aug 2020 14:19:34 +0800
Message-ID: <40a08b783f41e3dffa99132dbd86fa8858d26426.1597817375.git.geliangtang@gmail.com>
In-Reply-To: cover.1597817375.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5574

--===============7813888446139007482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the ADD_ADDR suboption has been received, we need to send out the same
ADD_ADDR suboption with echo-flag=3D1, and no HMAC.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    | 34 ++++++++++++++++++++++------------
 net/mptcp/pm.c         | 13 +++++++++----
 net/mptcp/pm_netlink.c |  2 +-
 net/mptcp/protocol.h   |  8 +++++---
 4 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a52a05effac9..f91238ff3200 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -242,7 +242,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		mp_opt->add_addr =3D 1;
 		mp_opt->port =3D 0;
 		mp_opt->addr_id =3D *ptr++;
-		pr_debug("ADD_ADDR: id=3D%d", mp_opt->addr_id);
+		pr_debug("ADD_ADDR: id=3D%d, echo=3D%d", mp_opt->addr_id, mp_opt->echo);
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
 			ptr +=3D 4;
@@ -579,6 +579,7 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk,
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	struct mptcp_addr_info saddr;
+	bool echo =3D READ_ONCE(msk->pm.add_addr_echo);
 	int len;
 =

 	if (!mptcp_pm_should_add_signal(msk) ||
@@ -594,22 +595,26 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk,
 	if (saddr.family =3D=3D AF_INET) {
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
 		opts->addr =3D saddr.addr;
-		opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
-						     msk->remote_key,
-						     opts->addr_id,
-						     &opts->addr);
+		if (!echo) {
+			opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
+							     msk->remote_key,
+							     opts->addr_id,
+							     &opts->addr);
+		}
 	}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else if (saddr.family =3D=3D AF_INET6) {
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR6;
 		opts->addr6 =3D saddr.addr6;
-		opts->ahmac =3D add_addr6_generate_hmac(msk->local_key,
-						      msk->remote_key,
-						      opts->addr_id,
-						      &opts->addr6);
+		if (!echo) {
+			opts->ahmac =3D add_addr6_generate_hmac(msk->local_key,
+							      msk->remote_key,
+							      opts->addr_id,
+							      &opts->addr6);
+		}
 	}
 #endif
-	pr_debug("addr_id=3D%d, ahmac=3D%llu", opts->addr_id, opts->ahmac);
+	pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d", opts->addr_id, opts->ah=
mac, echo);
 =

 	return true;
 }
@@ -883,8 +888,13 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 			addr.addr6 =3D mp_opt.addr6;
 		}
 #endif
-		if (!mp_opt.echo)
-			mptcp_pm_add_addr_received(msk, &addr);
+		if (!mp_opt.echo) {
+			if (!mptcp_pm_add_addr_received(msk, &addr)) {
+				spin_lock_bh(&msk->pm.lock);
+				mptcp_pm_announce_addr(msk, &addr, true);
+				spin_unlock_bh(&msk->pm.lock);
+			}
+		}
 		mp_opt.add_addr =3D 0;
 	}
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 558462d87eb3..27662d795b9a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -13,11 +13,13 @@
 /* path manager command handlers */
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
-			   const struct mptcp_addr_info *addr)
+			   const struct mptcp_addr_info *addr,
+			   bool echo)
 {
 	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
 =

 	msk->pm.local =3D *addr;
+	WRITE_ONCE(msk->pm.add_addr_echo, echo);
 	WRITE_ONCE(msk->pm.add_addr_signal, true);
 	return 0;
 }
@@ -127,8 +129,8 @@ void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8=
 id)
 	pr_debug("msk=3D%p", msk);
 }
 =

-void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+int mptcp_pm_add_addr_received(struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
 =

@@ -137,7 +139,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 =

 	/* avoid acquiring the lock if there is no room for fouther addresses */
 	if (!READ_ONCE(pm->accept_addr))
-		return;
+		return -EINVAL;
 =

 	spin_lock_bh(&pm->lock);
 =

@@ -147,6 +149,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 		pm->remote =3D *addr;
 =

 	spin_unlock_bh(&pm->lock);
+
+	return 0;
 }
 =

 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
@@ -226,6 +230,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	WRITE_ONCE(msk->pm.rm_addr_signal, false);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
+	WRITE_ONCE(msk->pm.add_addr_echo, false);
 	msk->pm.status =3D 0;
 =

 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ad7232a1d9f1..d3e57573c307 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -188,7 +188,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 =

 		if (local) {
 			msk->pm.add_addr_signaled++;
-			mptcp_pm_announce_addr(msk, &local->addr);
+			mptcp_pm_announce_addr(msk, &local->addr, false);
 		} else {
 			/* pick failed, avoid fourther attempts later */
 			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4b8a5308aeed..4a73d0526f06 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -169,6 +169,7 @@ struct mptcp_pm_data {
 	bool		work_pending;
 	bool		accept_addr;
 	bool		accept_subflow;
+	bool		add_addr_echo;
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
@@ -438,12 +439,13 @@ void mptcp_pm_connection_closed(struct mptcp_sock *ms=
k);
 void mptcp_pm_subflow_established(struct mptcp_sock *msk,
 				  struct mptcp_subflow_context *subflow);
 void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
-void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr);
+int mptcp_pm_add_addr_received(struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
-			   const struct mptcp_addr_info *addr);
+			   const struct mptcp_addr_info *addr,
+			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id);
 =

-- =

2.17.1

--===============7813888446139007482==--
