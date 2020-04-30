Content-Type: multipart/mixed; boundary="===============4819490014637948730=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2 4/5] mptcp: fix 'use_ack' option access.
Date: Thu, 30 Apr 2020 15:01:54 +0200
Message-ID: <c8b028f7471cb0a9ae2604a5e81eec2299e4d365.1588243786.git.pabeni@redhat.com>
In-Reply-To: cover.1588243786.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4286

--===============4819490014637948730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mentioned RX option field is initialized only for DSS
packet, we must access it only if 'dss' is set too, or
the subflow will end-up in a bad status, leading to
RFC violations.

Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ecf41d52d2fc..9486720c3256 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -695,7 +695,7 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *sk,
 	if (TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1)
 		return subflow->mp_capable;
 =

-	if (mp_opt->use_ack) {
+	if (mp_opt->dss && mp_opt->use_ack) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack.
 		 */
-- =

2.21.1

--===============4819490014637948730==--
