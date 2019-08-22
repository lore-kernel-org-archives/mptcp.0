Content-Type: multipart/mixed; boundary="===============8883981993844622351=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Restore lost hunk
Date: Thu, 22 Aug 2019 15:46:56 -0700
Message-ID: <20190822224656.6414-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1684

--===============8883981993844622351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This chunk from Patch 01 "Extend path manager interface" of
the Implement outgoing MP_JOIN patchset did not survive
getting squashed and needs to be restored.

squashto: Add path manager interface

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0e7abcea5bae..be7afa5aac6a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -534,6 +534,16 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 =

 	mp_opt =3D &opt_rx->mptcp;
 =

+	if (msk && mp_opt->add_addr) {
+		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
+			pm_add_addr(msk, &mp_opt->addr, mp_opt->addr_id);
+#if IS_ENABLED(CONFIG_IPV6)
+		else if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6)
+			pm_add_addr6(msk, &mp_opt->addr6, mp_opt->addr_id);
+#endif
+		mp_opt->add_addr =3D 0;
+	}
+
 	if (!mp_opt->dss)
 		return;
 =

-- =

2.17.2


--===============8883981993844622351==--
