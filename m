Content-Type: multipart/mixed; boundary="===============6734138492288837017=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: Ignore incoming MPTCP options when not
 MP_CAPABLE
Date: Tue, 22 Oct 2019 15:54:58 -0700
Message-ID: <20191022225459.15312-2-peter.krystad@linux.intel.com>
In-Reply-To: 20191022225459.15312-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2269

--===============6734138492288837017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Any options received on a fallback subflow should be ignored.

squashto: Implement MPTCP receive path

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8f199039971f..dcd7273e488c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -591,6 +591,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	struct mptcp_options_received *mp_opt;
 	struct mptcp_ext *mpext;
 =

+	if (!subflow->mp_capable)
+		return;
+
 	mp_opt =3D &opt_rx->mptcp;
 =

 	if (msk && mp_opt->add_addr) {
-- =

2.17.2

--===============6734138492288837017==--
