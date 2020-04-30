Content-Type: multipart/mixed; boundary="===============4998107897940583530=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2 3/5] mptcp: avoid a WARN on bad input.
Date: Thu, 30 Apr 2020 15:01:53 +0200
Message-ID: <44726bfb7c1f4d3f8e90f61b6a70d055b8333064.1588243786.git.pabeni@redhat.com>
In-Reply-To: cover.1588243786.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4287

--===============4998107897940583530==
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

--===============4998107897940583530==--
