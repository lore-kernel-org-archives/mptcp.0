Content-Type: multipart/mixed; boundary="===============1688675284092094897=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 5/5] mptcp: fix 'use_ack' option access.
Date: Fri, 24 Apr 2020 19:14:12 +0200
Message-ID: <bc5732f961a6a02ede0852863ad876e5dde87300.1587738345.git.pabeni@redhat.com>
In-Reply-To: cover.1587738345.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4243

--===============1688675284092094897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mentioned RX option field is initialized only for DSS
packet, we must access it only if 'dss' is set too, or
the subflow will end-up in a bad status, leading to
RFC violations.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5a37dbfc8b4e..a35aa5c76f90 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -709,7 +709,7 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *sk,
 	if (TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1)
 		return subflow->mp_capable;
 =

-	if (rx_opt->mptcp.use_ack) {
+	if (mptcp_option_dss(rx_opt) && rx_opt->mptcp.use_ack) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack.
 		 */
-- =

2.21.1

--===============1688675284092094897==--
