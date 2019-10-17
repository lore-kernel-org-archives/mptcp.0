Content-Type: multipart/mixed; boundary="===============5793571339200919604=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/4] mptcp: relax map checking
Date: Thu, 17 Oct 2019 11:00:37 +0200
Message-ID: <101f64932bbd1477510ce40483b56a81b6c5172c.1571258477.git.pabeni@redhat.com>
In-Reply-To: cover.1571258477.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2201

--===============5793571339200919604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We don't need to have the current skb fully covered by the mapping,
just some bytes at the skb start. The previously enforced condition
was too restrictive and wrong, as it did not take in account that
copied_seq/ssn does not correspond to the skb start.

Squash-to: "mptcp: Implement MPTCP receive path"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ec0c269d07df..8e6e0f782f5e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -192,9 +192,9 @@ static bool validate_mapping(struct sock *ssk, struct s=
k_buff *skb)
 		warn_bad_map(subflow, ssn);
 		return false;
 	}
-	if (unlikely(after(ssn + skb->len, subflow->map_subflow_seq +
-					   subflow->map_data_len))) {
-		/* Mapping does not cover the full skb. Invalid */
+	if (unlikely(!before(ssn, subflow->map_subflow_seq +
+				  subflow->map_data_len))) {
+		/* Mapping does covers past subflow data, invalid */
 		warn_bad_map(subflow, ssn + skb->len);
 		return false;
 	}
-- =

2.21.0

--===============5793571339200919604==--
