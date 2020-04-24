Content-Type: multipart/mixed; boundary="===============2962205053466915278=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 4/5] mptcp: avoid a WARN on bad input.
Date: Fri, 24 Apr 2020 19:14:11 +0200
Message-ID: <7b521d09f4ba2b739740958a5ab684e7108fe011.1587738345.git.pabeni@redhat.com>
In-Reply-To: cover.1587738345.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4242

--===============2962205053466915278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Syzcaller has found a way to trigger the WARN_ON_ONCE condition
in check_fully_established().

The root cause is actually a legit fallback to TCP scenario,
so replace the WARN with a plain message on a more strict
condition.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 282f12772fe2..5a37dbfc8b4e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -717,8 +717,6 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *sk,
 		goto fully_established;
 	}
 =

-	WARN_ON_ONCE(subflow->can_ack);
-
 	/* If the first established packet does not contain MP_CAPABLE + data
 	 * then fallback to TCP
 	 */
@@ -728,6 +726,8 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *sk,
 		return false;
 	}
 =

+	if (unlikely(!READ_ONCE(msk->pm.server_side)))
+		pr_warn_once("bogus mpc option on established client sk");
 	subflow->fully_established =3D 1;
 	subflow->remote_key =3D rx_opt->mptcp.sndr_key;
 	subflow->can_ack =3D 1;
-- =

2.21.1

--===============2962205053466915278==--
