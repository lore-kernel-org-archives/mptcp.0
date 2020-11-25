Content-Type: multipart/mixed; boundary="===============1916114530212182133=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: add port number
 announced check"
Date: Wed, 25 Nov 2020 13:28:45 +0800
Message-ID: <c2933d16461c96e6389b7b16f2eb8c48ebf6ce93.1606281979.git.geliangtang@gmail.com>
In-Reply-To: c61d4b901a34c788dec44b264f2bc669ddb57d2c.1606272852.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6918

--===============1916114530212182133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use a more strict check in mptcp_pm_sport_in_anno_list.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 09e96007a56a..da8d2c77a02d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -111,6 +111,19 @@ static void remote_address(const struct sock_common *s=
kc,
 #endif
 }
 =

+static void source_address(const struct sock *sk,
+			   struct mptcp_addr_info *addr)
+{
+	addr->family =3D ((struct sock_common *)sk)->skc_family;
+	addr->port =3D inet_sk(sk)->inet_sport;
+	if (addr->family =3D=3D AF_INET)
+		addr->addr.s_addr =3D inet_sk(sk)->inet_saddr;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (addr->family =3D=3D AF_INET6)
+		addr->addr6 =3D inet_sk(sk)->pinet6->saddr;
+#endif
+}
+
 static bool lookup_subflow_by_saddr(const struct list_head *list,
 				    struct mptcp_addr_info *saddr)
 {
@@ -205,11 +218,14 @@ lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock=
 *sk)
 {
 	struct mptcp_pm_add_entry *entry;
+	struct mptcp_addr_info saddr;
 	bool ret =3D false;
 =

+	source_address(sk, &saddr);
+
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (entry->addr.port =3D=3D inet_sk(sk)->inet_sport) {
+		if (addresses_equal(&entry->addr, &saddr, true)) {
 			ret =3D true;
 			goto out;
 		}
-- =

2.26.2

--===============1916114530212182133==--
