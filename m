Content-Type: multipart/mixed; boundary="===============7334888438272040542=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 05/11] mptcp: add the outgoing ADD_ADDR port
 support
Date: Wed, 09 Dec 2020 15:51:22 -0800
Message-ID: <20201209235128.175473-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201209235128.175473-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7111

--===============7334888438272040542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch added a new add_addr_signal type named MPTCP_ADD_ADDR_PORT,
to identify it is an address with port to be added.

It also added a new parameter 'port' for both mptcp_add_addr_len and
mptcp_pm_add_addr_signal.

In mptcp_established_options_add_addr, we check whether the announced
address is added with port. If it is, we put this port number to
mptcp_out_options's port field.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c  | 10 +++++++---
 net/mptcp/pm.c       |  5 +++--
 net/mptcp/protocol.h | 12 ++++++++++--
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 51f560a26890..9d3b49254d38 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -587,6 +587,7 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 	unsigned int opt_size =3D *size;
 	struct mptcp_addr_info saddr;
 	bool echo;
+	bool port;
 	int len;
 =

 	if (mptcp_pm_should_add_signal_ipv6(msk) &&
@@ -598,10 +599,10 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
 	}
 =

 	if (!mptcp_pm_should_add_signal(msk) ||
-	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo)))
+	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo, &port)))
 		return false;
 =

-	len =3D mptcp_add_addr_len(saddr.family, echo);
+	len =3D mptcp_add_addr_len(saddr.family, echo, port);
 	if (remaining < len)
 		return false;
 =

@@ -609,6 +610,8 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 	if (drop_other_suboptions)
 		*size -=3D opt_size;
 	opts->addr_id =3D saddr.id;
+	if (port)
+		opts->port =3D ntohs(saddr.port);
 	if (saddr.family =3D=3D AF_INET) {
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
 		opts->addr =3D saddr.addr;
@@ -631,7 +634,8 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 		}
 	}
 #endif
-	pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d", opts->addr_id, opts->ah=
mac, echo);
+	pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
+		 opts->addr_id, opts->ahmac, echo, opts->port);
 =

 	return true;
 }
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 74ccc76a11cd..2c517046e2b5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -194,7 +194,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, =
u8 rm_id)
 /* path manager helpers */
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
-			      struct mptcp_addr_info *saddr, bool *echo)
+			      struct mptcp_addr_info *saddr, bool *echo, bool *port)
 {
 	int ret =3D false;
 =

@@ -205,8 +205,9 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, u=
nsigned int remaining,
 		goto out_unlock;
 =

 	*echo =3D mptcp_pm_should_add_signal_echo(msk);
+	*port =3D mptcp_pm_should_add_signal_port(msk);
 =

-	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo))
+	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *port))
 		goto out_unlock;
 =

 	*saddr =3D msk->pm.local;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5c45aabf4c6a..8e8f1f770a8e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -173,6 +173,7 @@ enum mptcp_add_addr_status {
 	MPTCP_ADD_ADDR_SIGNAL,
 	MPTCP_ADD_ADDR_ECHO,
 	MPTCP_ADD_ADDR_IPV6,
+	MPTCP_ADD_ADDR_PORT,
 };
 =

 struct mptcp_pm_data {
@@ -571,12 +572,17 @@ static inline bool mptcp_pm_should_add_signal_ipv6(st=
ruct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6);
 }
 =

+static inline bool mptcp_pm_should_add_signal_port(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_PORT);
+}
+
 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.rm_addr_signal);
 }
 =

-static inline unsigned int mptcp_add_addr_len(int family, bool echo)
+static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool =
port)
 {
 	u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
 =

@@ -584,12 +590,14 @@ static inline unsigned int mptcp_add_addr_len(int fam=
ily, bool echo)
 		len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
 	if (!echo)
 		len +=3D MPTCPOPT_THMAC_LEN;
+	if (port)
+		len +=3D TCPOLEN_MPTCP_PORT_LEN;
 =

 	return len;
 }
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
-			      struct mptcp_addr_info *saddr, bool *echo);
+			      struct mptcp_addr_info *saddr, bool *echo, bool *port);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
 			     u8 *rm_id);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-- =

2.29.2

--===============7334888438272040542==--
