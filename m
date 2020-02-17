Content-Type: multipart/mixed; boundary="===============0545458600826069337=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/7] Squash-to: "mptcp: Add ADD_ADDR handling"
Date: Mon, 17 Feb 2020 19:28:27 +0100
Message-ID: <0155ff6dc2c1125c897273d55526856df8a184d9.1581963738.git.pabeni@redhat.com>
In-Reply-To: cover.1581963738.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3679

--===============0545458600826069337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Drop addr_signal flag: it belong to the PM and
needs additional locking

Signed-off-by: Paolo Abeni<pabeni(a)redhat.com>
---
 net/mptcp/options.c  | 5 -----
 net/mptcp/protocol.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 439bb14e29dc..331b020d64ae 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -438,9 +438,6 @@ static bool mptcp_established_options_addr(struct sock =
*sk,
 	if (!msk)
 		return false;
 =

-	if (!msk->addr_signal)
-		return false;
-
 	id =3D 0;
 	memset(&saddr, 0, sizeof(saddr));
 =

@@ -463,8 +460,6 @@ static bool mptcp_established_options_addr(struct sock =
*sk,
 	}
 #endif
 =

-	msk->addr_signal =3D 0;
-
 	return true;
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fa707a57f000..65ba8ddb62e6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -91,7 +91,6 @@ struct mptcp_sock {
 	struct skb_ext	*cached_ext;	/* for the next sendmsg */
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
-	u8		addr_signal;
 };
 =

 #define mptcp_for_each_subflow(__msk, __subflow)			\
-- =

2.21.1

--===============0545458600826069337==--
