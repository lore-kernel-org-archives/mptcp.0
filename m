Content-Type: multipart/mixed; boundary="===============2576514687898222073=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2] Squash-to: "mptcp: add netlink-based PM"
Date: Thu, 26 Mar 2020 11:19:58 +0100
Message-ID: <4a951891dbdb4812406e7dbf9af9f61d65b7353c.1585217878.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4070

--===============2576514687898222073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let user space set a single limit at once and drop bogus
NL extack error message.

v1 -> v2:
 - do not include dumb dbg messages

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/pm_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 743c3c58f826..caad73dfda64 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -702,10 +702,8 @@ static int parse_limit(struct genl_info *info, int id,=
 unsigned int *limit)
 {
 	struct nlattr *attr =3D info->attrs[id];
 =

-	if (!attr) {
-		GENL_SET_ERR_MSG(info, "missing announce accept limit");
-		return -EINVAL;
-	}
+	if (!attr)
+		return 0;
 =

 	*limit =3D nla_get_u32(attr);
 	if (*limit > MPTCP_PM_ADDR_MAX) {
@@ -723,10 +721,12 @@ mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct g=
enl_info *info)
 	unsigned int rcv_addrs, subflows;
 	int ret;
 =

+	rcv_addrs =3D pernet->add_addr_accept_max;
 	ret =3D parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
 	if (ret)
 		return ret;
 =

+	subflows =3D pernet->subflows_max;
 	ret =3D parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
 	if (ret)
 		return ret;
-- =

2.21.1

--===============2576514687898222073==--
