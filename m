Content-Type: multipart/mixed; boundary="===============1765250169660319169=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 5/5] Squash-to: "mptcp: update per unacked sequence
 on pkt reception"
Date: Fri, 20 Mar 2020 19:34:43 +0100
Message-ID: <5c1d1dd6307b20c9ed1cc7e96855de630218a9e6.1584728932.git.pabeni@redhat.com>
In-Reply-To: cover.1584728931.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4030

--===============1765250169660319169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Drop another unneeded check

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 353f9e74876d..4b86f1bbd6f1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -839,7 +839,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	/* we can't wait for recvmsg() to update the ack_seq, otherwise
 	 * monodirectional flows will stuck
 	 */
-	if (msk && mp_opt->use_ack)
+	if (mp_opt->use_ack)
 		update_una(msk, mp_opt);
 =

 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
-- =

2.21.1

--===============1765250169660319169==--
