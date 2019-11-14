Content-Type: multipart/mixed; boundary="===============3816791161173910081=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 4/4] mptcp: remove unneeded check in
 mptcp_established_options_mp()
Date: Thu, 14 Nov 2019 19:15:52 +0100
Message-ID: <73a0f63505099116d8f4fbba9e4c9399d007c555.1573738703.git.pabeni@redhat.com>
In-Reply-To: cover.1573738652.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2548

--===============3816791161173910081==
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
index 80c0cff135c0..cde6ba918686 100644
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

--===============3816791161173910081==--
