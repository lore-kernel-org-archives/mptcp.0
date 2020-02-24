Content-Type: multipart/mixed; boundary="===============2667034422274171252=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] net: mptcp: rename MPTCP_SUBFLOW_* into
 MPTCP_SUBFLOW_ATTR_* in diag uAPI
Date: Mon, 24 Feb 2020 15:59:46 +0100
Message-ID: <3e6ba8371d82801358113ba14218b2b889f4098a.1582556386.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3749

--===============2667034422274171252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Squash-to: "mptcp: allow dumping subflow context to userspace"

otherwise MPTCP_SUBFLOW_MAX might recall the maximum possible number of
subflows in a MPTCP connection, which is not controlled by uAPI at all.

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 include/uapi/linux/mptcp.h | 28 ++++++++++++------------
 net/mptcp/diag.c           | 45 ++++++++++++++++++++------------------
 2 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 3912a9808fa2..d087048fb4a2 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -15,20 +15,20 @@
 #define MPTCP_SUBFLOW_FLAG_MAPVALID	BIT(8)
 =

 enum {
-	MPTCP_SUBFLOW_UNSPEC,
-	MPTCP_SUBFLOW_TOKEN_REM,
-	MPTCP_SUBFLOW_TOKEN_LOC,
-	MPTCP_SUBFLOW_RELWRITE_SEQ,
-	MPTCP_SUBFLOW_MAP_SEQ,
-	MPTCP_SUBFLOW_MAP_SFSEQ,
-	MPTCP_SUBFLOW_SSN_OFFSET,
-	MPTCP_SUBFLOW_MAP_DATALEN,
-	MPTCP_SUBFLOW_FLAGS,
-	MPTCP_SUBFLOW_ID_REM,
-	MPTCP_SUBFLOW_ID_LOC,
-	MPTCP_SUBFLOW_PAD,
-	__MPTCP_SUBFLOW_MAX
+	MPTCP_SUBFLOW_ATTR_UNSPEC,
+	MPTCP_SUBFLOW_ATTR_TOKEN_REM,
+	MPTCP_SUBFLOW_ATTR_TOKEN_LOC,
+	MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
+	MPTCP_SUBFLOW_ATTR_MAP_SEQ,
+	MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
+	MPTCP_SUBFLOW_ATTR_SSN_OFFSET,
+	MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
+	MPTCP_SUBFLOW_ATTR_FLAGS,
+	MPTCP_SUBFLOW_ATTR_ID_REM,
+	MPTCP_SUBFLOW_ATTR_ID_LOC,
+	MPTCP_SUBFLOW_ATTR_PAD,
+	__MPTCP_SUBFLOW_ATTR_MAX
 };
 =

-#define MPTCP_SUBFLOW_MAX (__MPTCP_SUBFLOW_MAX - 1)
+#define MPTCP_SUBFLOW_ATTR_MAX (__MPTCP_SUBFLOW_ATTR_MAX - 1)
 #endif /* _UAPI_MPTCP_H */
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 830a2adfc0fa..4b6d9f7e418f 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -50,17 +50,20 @@ static int subflow_get_info(const struct sock *sk, stru=
ct sk_buff *skb)
 	if (sf->map_valid)
 		flags |=3D MPTCP_SUBFLOW_FLAG_MAPVALID;
 =

-	if (nla_put_u32(skb, MPTCP_SUBFLOW_TOKEN_REM, sf->remote_token) ||
-	    nla_put_u32(skb, MPTCP_SUBFLOW_TOKEN_LOC, sf->token) ||
-	    nla_put_u32(skb, MPTCP_SUBFLOW_RELWRITE_SEQ, sf->rel_write_seq) ||
-	    nla_put_u64_64bit(skb, MPTCP_SUBFLOW_MAP_SEQ, sf->map_seq,
-			      MPTCP_SUBFLOW_PAD) ||
-	    nla_put_u32(skb, MPTCP_SUBFLOW_MAP_SFSEQ, sf->map_subflow_seq) ||
-	    nla_put_u32(skb, MPTCP_SUBFLOW_SSN_OFFSET, sf->ssn_offset) ||
-	    nla_put_u16(skb, MPTCP_SUBFLOW_MAP_DATALEN, sf->map_data_len) ||
-	    nla_put_u32(skb, MPTCP_SUBFLOW_FLAGS, flags) ||
-	    nla_put_u8(skb, MPTCP_SUBFLOW_ID_REM, sf->remote_id) ||
-	    nla_put_u8(skb, MPTCP_SUBFLOW_ID_LOC, sf->local_id)) {
+	if (nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_TOKEN_REM, sf->remote_token) ||
+	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_TOKEN_LOC, sf->token) ||
+	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
+			sf->rel_write_seq) ||
+	    nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, sf->map_seq,
+			      MPTCP_SUBFLOW_ATTR_PAD) ||
+	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
+			sf->map_subflow_seq) ||
+	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_SSN_OFFSET, sf->ssn_offset) ||
+	    nla_put_u16(skb, MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
+			sf->map_data_len) ||
+	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_FLAGS, flags) ||
+	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_REM, sf->remote_id) ||
+	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_LOC, sf->local_id)) {
 		err =3D -EMSGSIZE;
 		goto nla_failure;
 	}
@@ -80,16 +83,16 @@ static size_t subflow_get_info_size(const struct sock *=
sk)
 	size_t size =3D 0;
 =

 	size +=3D nla_total_size(0) +	/* INET_ULP_INFO_MPTCP */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_TOKEN_REM */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_TOKEN_LOC */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_RELWRITE_SEQ */
-		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_MAP_SEQ */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_MAP_SFSEQ */
-		nla_total_size(2) +	/* MPTCP_SUBFLOW_SSN_OFFSET */
-		nla_total_size(2) +	/* MPTCP_SUBFLOW_MAP_DATALEN */
-		nla_total_size(4) +	/* MPTCP_SUBFLOW_FLAGS */
-		nla_total_size(1) +	/* MPTCP_SUBFLOW_ID_REM */
-		nla_total_size(1) +	/* MPTCP_SUBFLOW_ID_LOC */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_TOKEN_REM */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_TOKEN_LOC */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
+		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
+		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
+		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
+		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_FLAGS */
+		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_REM */
+		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_LOC */
 		0;
 	return size;
 }
-- =

2.24.1

--===============2667034422274171252==--
