Content-Type: multipart/mixed; boundary="===============1034194659842784740=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] tcp: Check for filled TCP option space before SACK
Date: Thu, 09 May 2019 10:06:52 -0700
Message-ID: <20190509170652.25147-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1137

--===============1034194659842784740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The SACK code would potentially add four bytes to the expected
TCP option size even if all option space was already used.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/ipv4/tcp_output.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 12c9e8ebc86d..1cd915890ce5 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -814,6 +814,9 @@ static unsigned int tcp_established_options(struct sock=
 *sk, struct sk_buff *skb
 		}
 	}
 =

+	if (size + TCPOLEN_SACK_BASE_ALIGNED >=3D MAX_TCP_OPTION_SPACE)
+		return size;
+
 	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
-- =

2.21.0


--===============1034194659842784740==--
