Content-Type: multipart/mixed; boundary="===============6442791218462004552=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] mptcp: send out ADD_ADDR with echo
 flag
Date: Wed, 12 Aug 2020 15:59:07 +0800
Message-ID: <767fcf49285f9242bb6a296b00f91e155be7c877.1597218966.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5541

--===============6442791218462004552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the ADD_ADDR suboption has been received, we need to send out the same
ADD_ADDR suboption with echo-flag=3D1.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    | 30 +++++++++++++++++++-----------
 net/mptcp/pm.c         |  1 +
 net/mptcp/pm_netlink.c |  1 +
 net/mptcp/protocol.h   |  1 +
 4 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a52a05effac9..0f8eb7f919f5 100644
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
@@ -883,8 +888,11 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 			addr.addr6 =3D mp_opt.addr6;
 		}
 #endif
-		if (!mp_opt.echo)
+		if (!mp_opt.echo) {
+			WRITE_ONCE(msk->pm.add_addr_echo, true);
+			mptcp_pm_announce_addr(msk, &addr);
 			mptcp_pm_add_addr_received(msk, &addr);
+		}
 		mp_opt.add_addr =3D 0;
 	}
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 558462d87eb3..4709b9562cb0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -226,6 +226,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	WRITE_ONCE(msk->pm.rm_addr_signal, false);
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
+	WRITE_ONCE(msk->pm.add_addr_echo, false);
 	msk->pm.status =3D 0;
 =

 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 848649a82649..1328d6460a48 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -188,6 +188,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 =

 		if (local) {
 			msk->pm.add_addr_signaled++;
+			WRITE_ONCE(msk->pm.add_addr_echo, false);
 			mptcp_pm_announce_addr(msk, &local->addr);
 		} else {
 			/* pick failed, avoid fourther attempts later */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4b8a5308aeed..425fbbc30b7a 100644
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
-- =

2.17.1

--===============6442791218462004552==--
