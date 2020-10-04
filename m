Content-Type: multipart/mixed; boundary="===============2786075338632105310=="
MIME-Version: 1.0
From: Rikard Falkeborn <rikard.falkeborn at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 1/2] mptcp: Constify mptcp_pm_ops
Date: Mon, 05 Oct 2020 01:44:16 +0200
Message-ID: <20201004234417.12768-2-rikard.falkeborn@gmail.com>
In-Reply-To: 20201004234417.12768-1-rikard.falkeborn@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6190

--===============2786075338632105310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The only usages of mptcp_pm_ops is to assign its address to the small_ops
field of the genl_family struct, which is a const pointer, and applying
ARRAY_SIZE() on it. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9f9cd41b7733..0d6f3d912891 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1054,7 +1054,7 @@ mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct g=
enl_info *info)
 	return -EMSGSIZE;
 }
 =

-static struct genl_small_ops mptcp_pm_ops[] =3D {
+static const struct genl_small_ops mptcp_pm_ops[] =3D {
 	{
 		.cmd    =3D MPTCP_PM_CMD_ADD_ADDR,
 		.doit   =3D mptcp_nl_cmd_add_addr,
-- =

2.28.0

--===============2786075338632105310==--
