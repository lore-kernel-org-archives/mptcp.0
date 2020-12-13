Content-Type: multipart/mixed; boundary="===============5030415728121905287=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: add the address
 ID assignment bitmap"
Date: Sun, 13 Dec 2020 09:31:52 +0800
Message-ID: <8b3705ff8b05e3aae5afdf1cf4d6a6a755941aab.1607823077.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7152

--===============5030415728121905287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Initialize addr.id to zero in mptcp_pm_nl_get_local_id, otherwise it will
be a random number.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4aa88a697b74..9b1f6298bbdb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -656,6 +656,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, st=
ruct sock_common *skc)
 	entry->addr =3D skc_local;
 	entry->addr.ifindex =3D 0;
 	entry->addr.flags =3D 0;
+	entry->addr.id =3D 0;
 	ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
-- =

2.29.2

--===============5030415728121905287==--
