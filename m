Content-Type: multipart/mixed; boundary="===============1413077729561143342=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 9/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:52 +0200
Message-ID: <20190615105259.15151-10-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1394

--===============1413077729561143342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - space required after that ',' (ctx:VxV)
 - Statements terminations use 1 semicolon
 - line over 80 characters

What has not been fixed:

 - line over 80 characters
   > only one char over and hard to split:

   mp_opt->data_fin =3D (mp_opt->dss_flags & MPTCP_DSS_DATA_FIN) !=3D 0;

Fixes: 76d3e3f81f61 (mptcp: Implement MPTCP receive path)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a6f1d18e8cc7..04eb5c6cbf76 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -135,7 +135,7 @@ static u64 expand_seq(u64 old_seq, u16 old_data_len, u6=
4 seq)
 		return old_seq;
 =

 	/* Assume map covers data not mapped yet. */
-	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63,32));
+	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
 }
 =

 static u64 get_map_offset(struct subflow_context *subflow)
@@ -267,7 +267,7 @@ static enum mapping_status mptcp_get_mapping(struct soc=
k *ssk)
 =

 del_out:
 	__skb_ext_del(skb, SKB_EXT_MPTCP);
-	return ret;;
+	return ret;
 }
 =

 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
@@ -283,7 +283,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 	long timeo;
 =

 	if (!msk->connection_list) {
-		pr_debug("fallback-read subflow=3D%p", subflow_ctx(msk->subflow->sk));
+		pr_debug("fallback-read subflow=3D%p",
+			 subflow_ctx(msk->subflow->sk));
 		return sock_recvmsg(msk->subflow, msg, flags);
 	}
 =

-- =

2.20.1


--===============1413077729561143342==--
