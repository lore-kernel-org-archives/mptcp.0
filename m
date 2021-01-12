Content-Type: multipart/mixed; boundary="===============4704419656030619597=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 mptcp-next 3/4] mptcp: do not queue excessive data
 on subflows.
Date: Tue, 12 Jan 2021 12:09:59 +0100
Message-ID: <771ddde94d0f6bc8f11da5dd3b3d176ee86d6cc4.1610449705.git.pabeni@redhat.com>
In-Reply-To: cover.1610449705.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7325

--===============4704419656030619597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current packet scheduler can enqueue up to sndbuf
data on each subflow. If the send buffer is large and
the subflows are not symmetric, this could lead to
suboptimal aggregate bandwidth utilization.

Limit the amount of queued data to the maximum cwnd.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ab623e9690f3..f2e440d40fbd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1390,7 +1390,7 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk)
 			continue;
 =

 		nr_active +=3D !subflow->backup;
-		if (!sk_stream_memory_free(subflow->tcp_sock))
+		if (!sk_stream_memory_free(subflow->tcp_sock) || !tcp_sk(ssk)->snd_wnd)
 			continue;
 =

 		pace =3D READ_ONCE(ssk->sk_pacing_rate);
@@ -1416,7 +1416,7 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
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

--===============4704419656030619597==--
