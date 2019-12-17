Content-Type: multipart/mixed; boundary="===============5620852673544281304=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 09/11] tcp: Check for filled TCP option
 space before SACK
Date: Mon, 16 Dec 2019 16:24:53 -0800
Message-ID: <20191217002455.24849-10-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191217002455.24849-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3105

--===============5620852673544281304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update the SACK check to work with zero option space available, a case
that's possible with MPTCP but not MD5+TS. Maintained only one
conditional branch for insufficient SACK space.

Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---

Changes for v2:

Takes recent SACK fix (9424e2e7ad93ffff) in to account, but modifies it
to work in MPTCP scenarios beyond the MD5+TS corner case. Given the
discussion on the v1 patch, we are including this in the patch set
again but can drop it and respin for -net if it qualifies as a bug fix.


 net/ipv4/tcp_output.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9e04d45bc0e4..e797ca6c6d7d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -751,13 +751,17 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
+		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
+					 TCPOLEN_SACK_PERBLOCK))
+			return size;
+
 		opts->num_sack_blocks =3D
 			min_t(unsigned int, eff_sacks,
 			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
 			      TCPOLEN_SACK_PERBLOCK);
-		if (likely(opts->num_sack_blocks))
-			size +=3D TCPOLEN_SACK_BASE_ALIGNED +
-				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+
+		size +=3D TCPOLEN_SACK_BASE_ALIGNED +
+			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
 	}
 =

 	return size;
-- =

2.24.1

--===============5620852673544281304==--
