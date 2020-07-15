Content-Type: multipart/mixed; boundary="===============0324520052824703895=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: silence warning in
 subflow_data_ready()
Date: Wed, 15 Jul 2020 22:27:05 +0200
Message-ID: <87f4954cfd7eacd6e220ab60d61e09f35ed32252.1594844608.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5023

--===============0324520052824703895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

since commit d47a72152097 ("mptcp: fix race in subflow_data_ready()"), it
is possible to observe a regression in MP_JOIN kselftests. For sockets in
TCP_CLOSE state, it's not sufficient to just wake up the main socket: we
also need to ensure that received data are made available to the reader.
Silence the WARN_ON_ONCE() in these cases: it preserves the syzkaller fix
and restores kselftests	when they are ran as follows:

  # while true; do
  > make KBUILD_OUTPUT=3D/tmp/kselftest TARGETS=3Dnet/mptcp kselftest
  > done

Reported-by: Florian Westphal <fw(a)strlen.de>
Fixes: d47a72152097 ("mptcp: fix race in subflow_data_ready()")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/47
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/subflow.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9f7f3772c13c..519122e66f17 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -869,18 +869,19 @@ void mptcp_space(const struct sock *ssk, int *space, =
int *full_space)
 static void subflow_data_ready(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	u16 state =3D 1 << inet_sk_state_load(sk);
 	struct sock *parent =3D subflow->conn;
 	struct mptcp_sock *msk;
 =

 	msk =3D mptcp_sk(parent);
-	if ((1 << inet_sk_state_load(sk)) & (TCPF_LISTEN | TCPF_CLOSE)) {
+	if (state & TCPF_LISTEN) {
 		set_bit(MPTCP_DATA_READY, &msk->flags);
 		parent->sk_data_ready(parent);
 		return;
 	}
 =

 	WARN_ON_ONCE(!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
-		     !subflow->mp_join);
+		     !subflow->mp_join && !(state & TCPF_CLOSE));
 =

 	if (mptcp_subflow_data_available(sk))
 		mptcp_data_ready(parent, sk);
-- =

2.26.2

--===============0324520052824703895==--
