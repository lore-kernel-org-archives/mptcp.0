Content-Type: multipart/mixed; boundary="===============4701274781651904134=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: "mptcp: add netlink-based PM"
Date: Thu, 26 Mar 2020 11:13:38 +0100
Message-ID: <bf07a8137067d1b3ed8139a5a5bea13d68a06b8d.1585217598.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4068

--===============4701274781651904134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let user space set a single limit at once and drop bogus
NL extack error message.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c    | 4 +++-
 net/mptcp/pm_netlink.c | 8 ++++----
 net/mptcp/protocol.c   | 6 +++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bd220ee4aac9..cc58059cdd6b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -715,7 +715,9 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *sk,
 		goto fully_established;
 	}
 =

-	WARN_ON_ONCE(subflow->can_ack);
+	if (WARN_ON_ONCE(subflow->can_ack))
+		printk(KERN_ERR "server side=3D%d dss=3D%d cap=3D%d seq_off=3D%d ssn=3D%=
d", msk->pm.server_side,
+		         mp_opt->dss, mp_opt->mp_capable, TCP_SKB_CB(skb)->seq - subflow=
->ssn_offset, subflow->ssn_offset);
 =

 	/* If the first established packet does not contain MP_CAPABLE + data
 	 * then fallback to TCP
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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2035bf15b886..bc18ac926a4f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -197,8 +197,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptc=
p_sock *msk,
 			seq +=3D len;
 			moved +=3D len;
 =

-			if (WARN_ON_ONCE(map_remaining < len))
+			if (WARN_ON_ONCE(map_remaining < len)) {
+				printk(KERN_ERR "map_remaining: %d len %ld copied_seq=3D%d offset=3D%d=
 map len=3D%d map_seq=3D%d ssn offset=3D%d ssn delta=3D%d",
+				         map_remaining, len, seq, offset, subflow->map_data_len,
+				         subflow->map_subflow_seq, subflow->ssn_offset, seq - subflow-=
>ssn_offset);
 				break;
+			}
 		} else {
 			WARN_ON_ONCE(!fin);
 			sk_eat_skb(ssk, skb);
-- =

2.21.1

--===============4701274781651904134==--
