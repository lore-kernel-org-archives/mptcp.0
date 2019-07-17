Content-Type: multipart/mixed; boundary="===============8450001295574968716=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 6/9] Fix return value if no DSS option is created.
Date: Wed, 17 Jul 2019 15:12:53 -0700
Message-ID: <20190717221256.7358-7-peter.krystad@linux.intel.com>
In-Reply-To: 20190717221256.7358-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1517

--===============8450001295574968716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Strictly speaking mptcp_established_options_dss() should
return false if no DSS option is created.

squashto: Write MPTCP DSS headers to outgoing data packets

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1a46cfb1f664..b0e3a1edc0ff 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -400,6 +400,9 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 		WARN(1, "MPTCP: Ack dropped");
 	}
 =

+	if (!dss_size)
+		return false;
+
 	*size =3D ALIGN(dss_size, 4);
 	return true;
 }
-- =

2.17.2


--===============8450001295574968716==--
