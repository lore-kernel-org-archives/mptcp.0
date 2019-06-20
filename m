Content-Type: multipart/mixed; boundary="===============4349852029750343559=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix remaining checkpatch issue
Date: Thu, 20 Jun 2019 15:11:07 +0200
Message-ID: <20190620131107.14035-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1428

--===============4349852029750343559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A typo (with 'length') was introduced when fixing another issue.

Fixes: 233967ed7653 (mptcp: fix checkpatch issues)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    Can be squashed in:
      mptcp: Write MPTCP DSS headers to outgoing data packets

 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 625cd93fb9a8..532482bbbc2a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -241,7 +241,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 	if (mpext && mpext->use_ack) {
 		ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
 =

-		/* Add kind/lenght/subtype/flag overhead if mapping is not
+		/* Add kind/length/subtype/flag overhead if mapping is not
 		 * populated
 		 */
 		if (dss_size =3D=3D 0)
-- =

2.20.1


--===============4349852029750343559==--
