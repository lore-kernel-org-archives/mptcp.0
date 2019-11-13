Content-Type: multipart/mixed; boundary="===============4099972213024728465=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 4/4] mptcp: remove unneeded check in
 mptcp_established_options_mp()
Date: Wed, 13 Nov 2019 09:00:21 +0100
Message-ID: <41d6276cc9ae9fe95605a7ac1f74a2a3ee009d4c.1573552924.git.pabeni@redhat.com>
In-Reply-To: cover.1573552877.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2501

--===============4099972213024728465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

we now have centralized check in mptcp_established_options()

Squash-to: "mptcp: Add handling of outgoing MP_JOIN requests"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e0c6a3b98544..9080a5fed918 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -371,8 +371,7 @@ static bool mptcp_established_options_mp(struct sock *s=
k, unsigned int *size,
 		pr_debug("subflow=3D%p, local_key=3D%llu, remote_key=3D%llu",
 			 subflow, subflow->local_key, subflow->remote_key);
 		return true;
-	} else if (subflow->mp_join && !subflow->fourth_ack &&
-		   remaining >=3D TCPOLEN_MPTCP_MPJ_ACK) {
+	} else if (subflow->mp_join && !subflow->fourth_ack) {
 		opts->suboptions =3D OPTION_MPTCP_MPJ_ACK;
 		memcpy(opts->hmac, subflow->hmac, MPTCPOPT_HMAC_LEN);
 		*size =3D TCPOLEN_MPTCP_MPJ_ACK;
-- =

2.21.0

--===============4099972213024728465==--
