Content-Type: multipart/mixed; boundary="===============5998378116543004278=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 3/5] mptcp: avoid a WARN on bad input.
Date: Wed, 29 Apr 2020 12:41:47 +0200
Message-ID: <388f5aba3a30dfd827f95efbe40ccb6d4ad42fe1.1588156257.git.pabeni@redhat.com>
In-Reply-To: cover.1588156257.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4269

--===============5998378116543004278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Syzcaller has found a way to trigger the WARN_ON_ONCE condition
in check_fully_established().

The root cause is a legit fallback to TCP scenario, so replace
the WARN with a plain message on a more strict condition.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index eadbd59586e4..ecf41d52d2fc 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -703,8 +703,6 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *sk,
 		goto fully_established;
 	}
 =

-	WARN_ON_ONCE(subflow->can_ack);
-
 	/* If the first established packet does not contain MP_CAPABLE + data
 	 * then fallback to TCP
 	 */
@@ -714,6 +712,8 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *sk,
 		return false;
 	}
 =

+	if (unlikely(!READ_ONCE(msk->pm.server_side)))
+		pr_warn_once("bogus mpc option on established client sk");
 	subflow->fully_established =3D 1;
 	subflow->remote_key =3D mp_opt->sndr_key;
 	subflow->can_ack =3D 1;
-- =

2.21.1

--===============5998378116543004278==--
