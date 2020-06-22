Content-Type: multipart/mixed; boundary="===============5707069398881341369=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2] mptcp: drop sndr_key in mptcp_syn_options
Date: Mon, 22 Jun 2020 19:45:58 +0800
Message-ID: <60f8315d6ae7b62d175c573f75cee50f14ce988b.1592826171.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 4767

--===============5707069398881341369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In RFC 8684, we don't need to send sndr_key in SYN package anymore, so drop
it.

Fixes: cc7972ea1932 ("mptcp: parse and emit MP_CAPABLE option according to =
v1 spec")
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 490b92534afc..df9a51425c6f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -336,9 +336,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk=
_buff *skb,
 	 */
 	subflow->snd_isn =3D TCP_SKB_CB(skb)->end_seq;
 	if (subflow->request_mptcp) {
-		pr_debug("local_key=3D%llu", subflow->local_key);
 		opts->suboptions =3D OPTION_MPTCP_MPC_SYN;
-		opts->sndr_key =3D subflow->local_key;
 		*size =3D TCPOLEN_MPTCP_MPC_SYN;
 		return true;
 	} else if (subflow->request_join) {
-- =

2.17.1

--===============5707069398881341369==--
