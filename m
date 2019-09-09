Content-Type: multipart/mixed; boundary="===============4220358688408149233=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 1/6] protocol: add discard_one_skb helper
Date: Mon, 09 Sep 2019 17:53:13 +0200
Message-ID: <20190909155317.31119-2-fw@strlen.de>
In-Reply-To: 20190909155317.31119-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1800

--===============4220358688408149233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This can be re-used in followup patch.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 266a1028c9fd..3eecd9ae0c77 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -384,6 +384,15 @@ static enum mapping_status mptcp_get_mapping(struct so=
ck *ssk)
 	return ret;
 }
 =

+static bool mptcp_discard_one_skb(struct sock *sk)
+{
+	read_descriptor_t rd =3D {
+		.count =3D SIZE_MAX,
+	};
+
+	return tcp_read_sock(sk, &rd, mptcp_flush_actor) >=3D 0;
+}
+
 static void mptcp_wait_data(struct sock *sk, long *timeo)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
@@ -471,16 +480,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 			if (!subflow->map_valid) {
 				pr_debug("Mapping missing, trying next skb");
 =

-				arg.msg =3D NULL;
-				desc.count =3D SIZE_MAX;
-
-				bytes_read =3D tcp_read_sock(ssk, &desc,
-							   mptcp_flush_actor);
-
-				if (bytes_read < 0)
-					break;
-
-				continue;
+				if (mptcp_discard_one_skb(ssk))
+					continue;
+				break;
 			}
 		} else if (status =3D=3D MAPPING_EMPTY) {
 			goto wait_for_data;
-- =

2.21.0


--===============4220358688408149233==--
