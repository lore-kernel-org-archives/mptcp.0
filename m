Content-Type: multipart/mixed; boundary="===============8938572735012809217=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC mptcp-next 2/6] mptcp: add echo field in
 mptcp_out_options
Date: Tue, 26 Jan 2021 21:21:49 +0800
Message-ID: <2ae1ee585b508fe596788a747dfac676127afa4c.1611667027.git.geliangtang@gmail.com>
In-Reply-To: 4234f6b39337db1410b2a26bd5f1aacb391d712e.1611667027.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7484

--===============8938572735012809217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new field echo in mptcp_out_options, it will be used
when using the trace event to dump the mptcp_out_options info.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/net/mptcp.h | 1 +
 net/mptcp/options.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 5694370be3d4..85b39d901150 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -46,6 +46,7 @@ struct mptcp_out_options {
 #endif
 	};
 	u8 addr_id;
+	u8 echo;
 	u16 port;
 	u64 ahmac;
 	u8 rm_id;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 331d460d82fa..465144afade8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -634,6 +634,7 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 	if (drop_other_suboptions)
 		*size -=3D opt_size;
 	opts->addr_id =3D saddr.id;
+	opts->echo =3D echo;
 	if (port)
 		opts->port =3D ntohs(saddr.port);
 	if (saddr.family =3D=3D AF_INET) {
@@ -659,7 +660,7 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 	}
 #endif
 	pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
-		 opts->addr_id, opts->ahmac, echo, opts->port);
+		 opts->addr_id, opts->ahmac, opts->echo, opts->port);
 =

 	return true;
 }
-- =

2.29.2

--===============8938572735012809217==--
