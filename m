Content-Type: multipart/mixed; boundary="===============2770633381651884540=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 3/4] mptcp: move tpext data_len initialization at
 option creation time
Date: Fri, 05 Apr 2019 16:46:38 +0200
Message-ID: <aa9f17441e53a1b1a44225f19533945fdf0784db.1554473233.git.pabeni@redhat.com>
In-Reply-To: cover.1554473233.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1048

--===============2770633381651884540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that we can cope easily with skb coalescing

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  | 2 ++
 net/mptcp/protocol.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1b6ac68c15ba..25a77e6dd5de 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -335,6 +335,8 @@ void mptcp_write_option_header(__be32 *ptr, struct sk_b=
uff *skb,
 	}
 =

 	mpext =3D mptcp_get_ext(skb);
+	if (mpext)
+		mpext->data_len =3D skb->len - tcp_hdrlen(skb);
 =

 	if ((OPTION_MPTCP_DSS_MAP | OPTION_MPTCP_DSS_ACK) &
 	    opts->suboptions) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index db7dcc687918..2fbfe3e30630 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -104,7 +104,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 		memset(mpext, 0, sizeof(*mpext));
 		mpext->data_seq =3D msk->write_seq;
 		mpext->subflow_seq =3D subflow_ctx(ssk)->rel_write_seq;
-		mpext->data_len =3D ret;
 		mpext->checksum =3D 0xbeef;
 		mpext->use_map =3D 1;
 		mpext->dsn64 =3D 1;
-- =

2.20.1


--===============2770633381651884540==--
