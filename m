Content-Type: multipart/mixed; boundary="===============3026039383662790824=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 1/3] mptcp: schedule worker when subflow is
 closed
Date: Tue, 02 Feb 2021 18:47:52 +0100
Message-ID: <20210202174754.6861-2-fw@strlen.de>
In-Reply-To: 20210202174754.6861-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7595

--===============3026039383662790824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When remote side closes a subflow we should schedule the worker to
dispose of the subflow in a timely manner.

Otherwise, SF_CLOSED event won't be generated until the mptcp
socket itself is closing or local side is closing another subflow.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b8b670cb6116..57f6361eb07c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1413,6 +1413,13 @@ static void subflow_state_change(struct sock *sk)
 	if (mptcp_subflow_data_available(sk))
 		mptcp_data_ready(parent, sk);
 =

+	if (sk->sk_state =3D=3D TCP_CLOSE &&
+	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(parent)->flags)=
) {
+		sock_hold(parent);
+		if (!schedule_work(&mptcp_sk(parent)->work))
+			sock_put(parent);
+	}
+
 	if (__mptcp_check_fallback(mptcp_sk(parent)) &&
 	    !subflow->rx_eof && subflow_is_done(sk)) {
 		subflow->rx_eof =3D 1;
-- =

2.26.2

--===============3026039383662790824==--
