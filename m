Content-Type: multipart/mixed; boundary="===============5878254718946777978=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 1/6] Squash to "mptcp: add rm_list
 in mptcp_out_options"
Date: Thu, 04 Mar 2021 14:42:43 +0800
Message-ID: <20210304064248.9636-2-geliangtang@gmail.com>
In-Reply-To: 20210304064248.9636-1-geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8010

--===============5878254718946777978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the type of argument rm_list from "struct mptcp_rm_list
rm_list" to "const struct mptcp_rm_list *rm_list".

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f8a99ef34a07..595b4b4279f7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -681,7 +681,7 @@ static bool mptcp_established_options_rm_addr(struct so=
ck *sk,
 	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
 		return false;
 =

-	len =3D mptcp_rm_addr_len(rm_list);
+	len =3D mptcp_rm_addr_len(&rm_list);
 	if (len < 0)
 		return false;
 	if (remaining < len)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 31dcc3840a56..61022ffbc85f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -707,12 +707,12 @@ static inline unsigned int mptcp_add_addr_len(int fam=
ily, bool echo, bool port)
 	return len;
 }
 =

-static inline int mptcp_rm_addr_len(struct mptcp_rm_list rm_list)
+static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 {
-	if (rm_list.nr =3D=3D 0 || rm_list.nr >=3D MPTCP_RM_IDS_MAX)
+	if (rm_list->nr =3D=3D 0 || rm_list->nr >=3D MPTCP_RM_IDS_MAX)
 		return -EINVAL;
 =

-	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list.nr - 1, 4) + 1;
+	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
 }
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
-- =

2.29.2

--===============5878254718946777978==--
