Content-Type: multipart/mixed; boundary="===============8434753332407287989=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: "mptcp: cleanup
 mptcp_subflow_discard_data()"
Date: Tue, 25 Aug 2020 09:58:27 +0200
Message-ID: <f5d4639388e26c2750b8287039797677b03b194a.1598342270.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5617

--===============8434753332407287989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While discarding old data we also need to flush the
related map, if completed/exausted.

Additionally, use a safer condition to check for to-be-eaten
skbs

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
with this and pending Florian's patches, the kernel survived
the following loop for quite a bit.

while true; do
	./mptcp_connect.sh -d 10 -l 0 -r 0 -e "" -f $((100 * 1024 * 1024)) -m poll
done

I still see poll timeout with both ends not readable - not
investigated yet.
---
 net/mptcp/subflow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3585fd63c757..34c195ed1371 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -819,8 +819,10 @@ static void mptcp_subflow_discard_data(struct sock *ss=
k, struct sk_buff *skb,
 		 subflow->map_subflow_seq);
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
 	tcp_sk(ssk)->copied_seq +=3D incr;
-	if (incr >=3D skb->len)
+	if (tcp_sk(ssk)->copied_seq >=3D TCP_SKB_CB(skb)->end_seq)
 		sk_eat_skb(ssk, skb);
+	if (mptcp_subflow_get_map_offset(subflow) >=3D subflow->map_data_len)
+		subflow->map_valid =3D 0;
 }
 =

 static bool subflow_check_data_avail(struct sock *ssk)
-- =

2.26.2

--===============8434753332407287989==--
