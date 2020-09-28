Content-Type: multipart/mixed; boundary="===============5983087780222612102=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 1/2] mptcp: send out dedicated
 ADD_ADDR packet
Date: Mon, 28 Sep 2020 15:46:13 +0800
Message-ID: <f3ff31b79609d428322f82016bd765486d9de302.1601278543.git.geliangtang@gmail.com>
In-Reply-To: cover.1601278543.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6069

--===============5983087780222612102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When ADD_ADDR suboption includes an IPv6 address, the size is 28 octets.
It will not fit when other MPTCP suboptions are included in this packet,
e.g. DSS. So here we send out an ADD_ADDR dedicated packet to carry only
ADD_ADDR suboption, no other MPTCP suboptions.

In mptcp_pm_add_addr_signal, we check whether this is an IPv6 ADD_ADDR,
and whether there's no TCP option space in this packet now. If it is, we
set the flag add_addr_nospc to true, and sent out a new pure ACK packet.

In mptcp_established_options, we check whether this is a pure ACK packet
for ADD_ADDR. If it is, we put only ADD_ADDR suboption in this packet,
no other MPTCP suboptions.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 25 +++++++++++++++++++++----
 net/mptcp/pm.c       | 16 ++++++++++++++--
 net/mptcp/protocol.h |  4 +++-
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 411fd4a41796..417ba453d3e3 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -243,7 +243,9 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		mp_opt->add_addr =3D 1;
 		mp_opt->port =3D 0;
 		mp_opt->addr_id =3D *ptr++;
-		pr_debug("ADD_ADDR: id=3D%d, echo=3D%d", mp_opt->addr_id, mp_opt->echo);
+		pr_debug("ADD_ADDR%s: id=3D%d, echo=3D%d",
+			 (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6) ? "6" : "",
+			 mp_opt->addr_id, mp_opt->echo);
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
 			ptr +=3D 4;
@@ -584,7 +586,7 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk,
 	int len;
 =

 	if (!mptcp_pm_should_add_signal(msk) ||
-	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo)))
+	    !(mptcp_pm_add_addr_signal(msk, sk, remaining, &saddr, &echo)))
 		return false;
 =

 	len =3D mptcp_add_addr_len(saddr.family);
@@ -645,6 +647,17 @@ static bool mptcp_established_options_rm_addr(struct s=
ock *sk,
 	return true;
 }
 =

+static bool mptcp_check_add_addr_nospc(struct sock *sk, struct sk_buff *sk=
b)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+
+	if (skb && skb_is_tcp_pure_ack(skb) && READ_ONCE(msk->pm.add_addr_nospc))
+		return true;
+
+	return false;
+}
+
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
@@ -657,6 +670,9 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 	if (unlikely(mptcp_check_fallback(sk)))
 		return false;
 =

+	if (unlikely(mptcp_check_add_addr_nospc(sk, skb)))
+		goto add_addr;
+
 	if (mptcp_established_options_mp(sk, skb, &opt_size, remaining, opts))
 		ret =3D true;
 	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
@@ -671,6 +687,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 =

 	*size +=3D opt_size;
 	remaining -=3D opt_size;
+add_addr:
 	if (mptcp_established_options_add_addr(sk, &opt_size, remaining, opts)) {
 		*size +=3D opt_size;
 		remaining -=3D opt_size;
@@ -747,10 +764,10 @@ static bool check_fully_established(struct mptcp_sock=
 *msk, struct sock *sk,
 		goto fully_established;
 	}
 =

-	/* If the first established packet does not contain MP_CAPABLE + data
+	/* If the first established packet does not contain MP_CAPABLE + data or =
ADD_ADDR
 	 * then fallback to TCP
 	 */
-	if (!mp_opt->mp_capable) {
+	if (!mp_opt->mp_capable && !mp_opt->add_addr) {
 		subflow->mp_capable =3D 0;
 		pr_fallback(msk);
 		__mptcp_do_fallback(msk);
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7e81f53d1e5d..8015ee8ba621 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -172,7 +172,8 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, =
u8 rm_id)
 =

 /* path manager helpers */
 =

-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sock *ssk,
+			      unsigned int remaining,
 			      struct mptcp_addr_info *saddr, bool *echo)
 {
 	int ret =3D false;
@@ -183,16 +184,26 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 =

-	if (remaining < mptcp_add_addr_len(msk->pm.local.family))
+	if (remaining < mptcp_add_addr_len(msk->pm.local.family)) {
+		if (msk->pm.local.family =3D=3D AF_INET6)
+			WRITE_ONCE(msk->pm.add_addr_nospc, true);
 		goto out_unlock;
+	}
 =

 	*saddr =3D msk->pm.local;
 	*echo =3D READ_ONCE(msk->pm.add_addr_echo);
 	WRITE_ONCE(msk->pm.add_addr_signal, false);
+	WRITE_ONCE(msk->pm.add_addr_nospc, false);
 	ret =3D true;
 =

 out_unlock:
 	spin_unlock_bh(&msk->pm.lock);
+
+	if (READ_ONCE(msk->pm.add_addr_nospc)) {
+		pr_debug("send ack for add_addr6");
+		tcp_send_ack(ssk);
+	}
+
 	return ret;
 }
 =

@@ -237,6 +248,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
 	WRITE_ONCE(msk->pm.add_addr_echo, false);
+	WRITE_ONCE(msk->pm.add_addr_nospc, false);
 	msk->pm.status =3D 0;
 =

 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b1ea78474b84..078cf0945361 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -171,6 +171,7 @@ struct mptcp_pm_data {
 	bool		accept_addr;
 	bool		accept_subflow;
 	bool		add_addr_echo;
+	bool		add_addr_nospc;
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
@@ -472,7 +473,8 @@ static inline unsigned int mptcp_add_addr_len(int famil=
y)
 	return TCPOLEN_MPTCP_ADD_ADDR6;
 }
 =

-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sock *sk,
+			      unsigned int remaining,
 			      struct mptcp_addr_info *saddr, bool *echo);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
 			     u8 *rm_id);
-- =

2.17.1

--===============5983087780222612102==--
