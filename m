Content-Type: multipart/mixed; boundary="===============8005302685809981870=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 08/18] tcp_extra_option: Add missing static branch for
 tcp_extra_options_prepare
Date: Tue, 03 Oct 2017 09:21:54 -0700
Message-ID: <20171003162204.17945-9-cpaasch@apple.com>
In-Reply-To: 20171003162204.17945-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 94

--===============8005302685809981870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp_output.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 60b3b85ff2d3..ebf7b07e7589 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -699,8 +699,10 @@ static unsigned int tcp_established_options(struct soc=
k *sk, struct sk_buff *skb
 		size +=3D TCPOLEN_TSTAMP_ALIGNED;
 	}
 =

-	size +=3D tcp_extra_options_prepare(skb, 0, MAX_TCP_OPTION_SPACE - size,
-					  opts, tp);
+	if (static_branch_unlikely(&tcp_extra_options_enabled))
+		size +=3D tcp_extra_options_prepare(skb, 0,
+						  MAX_TCP_OPTION_SPACE - size,
+						  opts, tp);
 =

 	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
-- =

2.14.1


--===============8005302685809981870==--
