Content-Type: multipart/mixed; boundary="===============7539444434125804422=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 1/2] mptcp: convert IPv4 address to
 IPv4-mapped
Date: Fri, 11 Dec 2020 14:27:45 +0800
Message-ID: <a8bf19595848dc9800cf982d408137b2138ca5c5.1607667912.git.geliangtang@gmail.com>
In-Reply-To: cover.1607667912.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7145

--===============7539444434125804422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, PM doesn't create subflow with IPv4-mapped IPv6 socket. This
patch converts the IPv4 address to IPv4-mapped IPv6 address to fix it.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4aa88a697b74..34627843f0f1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -132,6 +132,19 @@ static bool lookup_subflow_by_saddr(const struct list_=
head *list,
 	return false;
 }
 =

+static void mptcp_pm_addr_convert_v4mapped(struct mptcp_sock *msk,
+					   struct mptcp_addr_info *addr)
+{
+	struct mptcp_addr_info local;
+
+	local_address((struct sock_common *)msk, &local);
+	if (ipv6_addr_v4mapped(&local.addr6) &&
+	    addr->family =3D=3D AF_INET) {
+		ipv6_addr_set_v4mapped(addr->addr.s_addr, &addr->addr6);
+		addr->family =3D AF_INET6;
+	}
+}
+
 static struct mptcp_pm_addr_entry *
 select_local_address(const struct pm_nl_pernet *pernet,
 		     struct mptcp_sock *msk)
@@ -144,6 +157,8 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
 =

+		mptcp_pm_addr_convert_v4mapped(msk, &entry->addr);
+
 		/* avoid any address already in use by subflows and
 		 * pending join
 		 */
@@ -397,6 +412,7 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *m=
sk)
 		remote.port =3D sk->sk_dport;
 	else
 		use_port =3D true;
+	mptcp_pm_addr_convert_v4mapped(msk, &remote);
 	memset(&local, 0, sizeof(local));
 	local.family =3D remote.family;
 =

-- =

2.26.2

--===============7539444434125804422==--
