Content-Type: multipart/mixed; boundary="===============0510543280514663359=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 05/12] mptcp: add the outgoing
 ADD_ADDR port support
Date: Thu, 05 Nov 2020 16:01:05 +0800
Message-ID: <88cb173acb83efe181b7a1845feabcc316c9a722.1604562475.git.geliangtang@gmail.com>
In-Reply-To: 4bc3b1864748e9e5bc54539a283145f2d6d93dda.1604562475.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6549

--===============0510543280514663359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new add_addr_signal type named MPTCP_ADD_ADDR_PORT,
to identify it is an address with port to be added.

It also added a new parameter 'port' for both mptcp_add_addr_len and
mptcp_pm_add_addr_signal.

In mptcp_established_options_add_addr, we check whether the announced
address is added with port. If it is, we put this port number to
mptcp_out_options's port field.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 10 +++++++---
 net/mptcp/pm.c       |  5 +++--
 net/mptcp/protocol.h | 12 ++++++++++--
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 464cb63b7d2b..156ff4d63ec1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -586,6 +586,7 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 	unsigned int opt_size =3D *size;
 	struct mptcp_addr_info saddr;
 	bool echo;
+	bool port;
 	int len;
 =

 	if (mptcp_pm_should_add_signal_ipv6(msk) &&
@@ -597,10 +598,10 @@ static bool mptcp_established_options_add_addr(struct=
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

@@ -608,6 +609,8 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 	if (drop_other_suboptions)
 		*size -=3D opt_size;
 	opts->addr_id =3D saddr.id;
+	if (port)
+		opts->port =3D ntohs(saddr.port);
 	if (saddr.family =3D=3D AF_INET) {
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
 		opts->addr =3D saddr.addr;
@@ -630,7 +633,8 @@ static bool mptcp_established_options_add_addr(struct s=
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
index 75c5040e8d5d..6d4be02681fa 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -188,7 +188,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, =
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

@@ -199,8 +199,9 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, u=
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
index 948992b1615f..4a7257cf8ba2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -172,6 +172,7 @@ enum mptcp_add_addr_status {
 	MPTCP_ADD_ADDR_SIGNAL,
 	MPTCP_ADD_ADDR_ECHO,
 	MPTCP_ADD_ADDR_IPV6,
+	MPTCP_ADD_ADDR_PORT,
 };
 =

 struct mptcp_pm_data {
@@ -540,12 +541,17 @@ static inline bool mptcp_pm_should_add_signal_ipv6(st=
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

@@ -553,12 +559,14 @@ static inline unsigned int mptcp_add_addr_len(int fam=
ily, bool echo)
 		len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
 	if (!echo)
 		len +=3D TCPOLEN_MPTCP_ADD_ADDR_HMAC;
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

2.26.2

--===============0510543280514663359==--
