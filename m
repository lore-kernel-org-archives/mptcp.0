Content-Type: multipart/mixed; boundary="===============7136581218248216363=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 1/5] Squash-to: "mptcp: Add ADD_ADDR handling"
Date: Fri, 20 Mar 2020 19:34:39 +0100
Message-ID: <b4439e27f0c42d429f714b1d8afc69fd3f240fba.1584728932.git.pabeni@redhat.com>
In-Reply-To: cover.1584728931.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4027

--===============7136581218248216363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

subflow->conn is always valid for is_mptcp socket, drop
unneeded check

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9b90bdc419ac..633bda691fff 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -486,9 +486,6 @@ static bool mptcp_established_options_addr(struct sock =
*sk,
 	struct sockaddr_storage saddr;
 	u8 id;
 =

-	if (!msk)
-		return false;
-
 	id =3D 0;
 	memset(&saddr, 0, sizeof(saddr));
 =

-- =

2.21.1

--===============7136581218248216363==--
