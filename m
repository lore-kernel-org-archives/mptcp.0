Content-Type: multipart/mixed; boundary="===============1101994718427608689=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: mptcp: refactor shutdown and close
Date: Fri, 09 Oct 2020 12:57:00 +0200
Message-ID: <24df6b98e251b2d67c25f12eb3c6c974aafa0101.1602241020.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6267

--===============1101994718427608689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

the format specifier for 'write_seq' in __mptcp_check_send_data_fin()
should be the same as the one used for 'snd_nxt', to prevent humans
from becoming suddenly sad while inspecting the output of pr_debug().
Change both 'snd_nxt' and 'write_seq' to be %llu.

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f8812097d63d..736a6481d20f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2033,7 +2033,7 @@ static void __mptcp_check_send_data_fin(struct sock *=
sk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	pr_debug("msk=3D%p snd_data_fin_enable=3D%d pending=3D%d snd_nxt=3D%lld w=
rite_seq=3D%llx",
+	pr_debug("msk=3D%p snd_data_fin_enable=3D%d pending=3D%d snd_nxt=3D%llu w=
rite_seq=3D%llu",
 		 msk, msk->snd_data_fin_enable, !!mptcp_send_head(sk),
 		 msk->snd_nxt, msk->write_seq);
 =

-- =

2.26.2

--===============1101994718427608689==--
