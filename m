Content-Type: multipart/mixed; boundary="===============6225743337294665230=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] mptcp: Ignore incoming MPTCP options when not
 MP_CAPABLE
Date: Tue, 22 Oct 2019 15:54:59 -0700
Message-ID: <20191022225459.15312-3-peter.krystad@linux.intel.com>
In-Reply-To: 20191022225459.15312-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2270

--===============6225743337294665230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Any options received on a fallback subflow should be ignored.

squashto: Add handling of incoming MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dcd7273e488c..1b08e1193991 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -591,7 +591,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	struct mptcp_options_received *mp_opt;
 	struct mptcp_ext *mpext;
 =

-	if (!subflow->mp_capable)
+	if (!subflow->mp_capable && !subflow->mp_join)
 		return;
 =

 	mp_opt =3D &opt_rx->mptcp;
-- =

2.17.2

--===============6225743337294665230==--
