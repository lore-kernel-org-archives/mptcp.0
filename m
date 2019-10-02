Content-Type: multipart/mixed; boundary="===============4562598959606930473=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] mptcp: removed unused fields in structure: mptcp.h
Date: Wed, 02 Oct 2019 18:40:30 +0200
Message-ID: <20191002164032.11111-2-matthieu.baerts@tessares.net>
In-Reply-To: 20191002164032.11111-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1984

--===============4562598959606930473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

checksum feature is no longer (partly) supported, we can remove them as
well.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To be squashed in "mptcp: Add MPTCP to skb extensions"

 include/net/mptcp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 50cd1b31ebdd..49b282b6b4c7 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -14,10 +14,8 @@ struct mptcp_ext {
 	u64		data_seq;
 	u32		subflow_seq;
 	u16		data_len;
-	__sum16		checksum;
 	u8		use_map:1,
 			dsn64:1,
-			use_checksum:1,
 			data_fin:1,
 			use_ack:1,
 			ack64:1,
-- =

2.20.1

--===============4562598959606930473==--
