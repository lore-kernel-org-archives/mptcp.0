Content-Type: multipart/mixed; boundary="===============7222459769801395628=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 1/4] protocol.h: mptcp_subflow_get_map_offset
 arg can be const
Date: Tue, 05 Nov 2019 18:05:28 +0100
Message-ID: <20191105170531.30407-2-fw@strlen.de>
In-Reply-To: 20191105170531.30407-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2394

--===============7222459769801395628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: Implement MPTCP receive path

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8fe5f9383d38..46f7becd9a45 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -248,7 +248,7 @@ mptcp_subflow_tcp_socket(const struct mptcp_subflow_con=
text *subflow)
 }
 =

 static inline u64
-mptcp_subflow_get_map_offset(struct mptcp_subflow_context *subflow)
+mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
 {
 	return tcp_sk(mptcp_subflow_tcp_socket(subflow)->sk)->copied_seq -
 		      subflow->ssn_offset -
@@ -256,7 +256,7 @@ mptcp_subflow_get_map_offset(struct mptcp_subflow_conte=
xt *subflow)
 }
 =

 static inline u64
-mptcp_subflow_get_mapped_dsn(struct mptcp_subflow_context *subflow)
+mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow_context *subflow)
 {
 	return subflow->map_seq + mptcp_subflow_get_map_offset(subflow);
 }
-- =

2.23.0

--===============7222459769801395628==--
