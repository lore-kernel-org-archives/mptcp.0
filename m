Content-Type: multipart/mixed; boundary="===============4585235337067326934=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 09/11] tcp: Check for filled TCP option space
 before SACK
Date: Fri, 13 Dec 2019 15:00:20 -0800
Message-ID: <20191213230022.28144-10-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191213230022.28144-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3033

--===============4585235337067326934==
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
index 9e04d45bc0e4..710ab45badfa 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -748,6 +748,9 @@ static unsigned int tcp_established_options(struct sock=
 *sk, struct sk_buff *skb
 		size +=3D TCPOLEN_TSTAMP_ALIGNED;
 	}
 =

+	if (size + TCPOLEN_SACK_BASE_ALIGNED >=3D MAX_TCP_OPTION_SPACE)
+		return size;
+
 	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
-- =

2.24.1

--===============4585235337067326934==--
