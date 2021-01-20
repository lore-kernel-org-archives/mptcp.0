Content-Type: multipart/mixed; boundary="===============7743331595528730058=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/5] mptcp: do not queue excessive data on
 subflows
Date: Wed, 20 Jan 2021 11:40:38 +0100
Message-ID: <7b6b267c5d108f4fc74a632005f52f659196e0b0.1610991949.git.pabeni@redhat.com>
In-Reply-To: cover.1610991949.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7436

--===============7743331595528730058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current packet scheduler can enqueue up to sndbuf
data on each subflow. If the send buffer is large and
the subflows are not symmetric, this could lead to
suboptimal aggregate bandwidth utilization.

Limit the amount of queued data to the maximum send
window.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d07e60330df56..e741201acc98f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1389,7 +1389,7 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk)
 			continue;
 =

 		nr_active +=3D !subflow->backup;
-		if (!sk_stream_memory_free(subflow->tcp_sock))
+		if (!sk_stream_memory_free(subflow->tcp_sock) || !tcp_sk(ssk)->snd_wnd)
 			continue;
 =

 		pace =3D READ_ONCE(ssk->sk_pacing_rate);
@@ -1415,7 +1415,7 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk)
 	if (send_info[0].ssk) {
 		msk->last_snd =3D send_info[0].ssk;
 		msk->snd_burst =3D min_t(int, MPTCP_SEND_BURST_SIZE,
-				       sk_stream_wspace(msk->last_snd));
+				       tcp_sk(msk->last_snd)->snd_wnd);
 		return msk->last_snd;
 	}
 =

-- =

2.26.2

--===============7743331595528730058==--
