Content-Type: multipart/mixed; boundary="===============6463482993557321256=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 1/4] Squash-to: "mptcp: Add ADD_ADDR handling"
Date: Fri, 20 Mar 2020 01:59:46 +0100
Message-ID: <90b9b1c4bb27156d20ac71af370211031ca1528a.1584665520.git.pabeni@redhat.com>
In-Reply-To: cover.1584665520.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4008

--===============6463482993557321256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

a previous patch removed required initialization for
mp_opt->add_addr, re-add it.

Additionally use msk's key value instead of subflow's one:
for MPJ subflows keys are uninitialized.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cc31da79292a..9b90bdc419ac 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -204,6 +204,7 @@ void mptcp_parse_option(const struct sk_buff *skb, cons=
t unsigned char *ptr,
 				break;
 		}
 =

+		mp_opt->add_addr =3D 1;
 		mp_opt->addr_id =3D *ptr++;
 		pr_debug("ADD_ADDR: id=3D%d", mp_opt->addr_id);
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
@@ -497,8 +498,8 @@ static bool mptcp_established_options_addr(struct sock =
*sk,
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
 		opts->addr_id =3D id;
 		opts->addr =3D ((struct sockaddr_in *)&saddr)->sin_addr;
-		opts->ahmac =3D add_addr_generate_hmac(subflow->local_key,
-						     subflow->remote_key,
+		opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
+						     msk->remote_key,
 						     opts->addr_id,
 						     &opts->addr);
 		*size =3D TCPOLEN_MPTCP_ADD_ADDR;
@@ -509,8 +510,8 @@ static bool mptcp_established_options_addr(struct sock =
*sk,
 			return false;
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR6;
 		opts->addr_id =3D id;
-		opts->ahmac =3D add_addr6_generate_hmac(subflow->local_key,
-						      subflow->remote_key,
+		opts->ahmac =3D add_addr6_generate_hmac(msk->local_key,
+						      msk->remote_key,
 						      opts->addr_id,
 						      &opts->addr6);
 		opts->addr6 =3D ((struct sockaddr_in6 *)&saddr)->sin6_addr;
-- =

2.21.1

--===============6463482993557321256==--
