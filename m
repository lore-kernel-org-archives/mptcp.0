Content-Type: multipart/mixed; boundary="===============3614292665902760265=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 1/2] mptcp: more strict state checking for acks
Date: Tue, 12 Jan 2021 18:25:23 +0100
Message-ID: <5566ba1c4409a652440d84ff49b99e58ca998a0e.1610471474.git.pabeni@redhat.com>
In-Reply-To: cover.1610471474.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7329

--===============3614292665902760265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Syzkaller found a way to trigger division by zero
in mptcp_subflow_cleanup_rbuf().

The current checks implemented into tcp_can_send_ack()
are too week, let's be more accurate.

Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling")
Fixes: fd8976790a6c ("mptcp: be careful on MPTCP-level ack.")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6628d8d74203..2ff8c7caf74f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -427,7 +427,7 @@ static bool mptcp_subflow_active(struct mptcp_subflow_c=
ontext *subflow)
 static bool tcp_can_send_ack(const struct sock *ssk)
 {
 	return !((1 << inet_sk_state_load(ssk)) &
-	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE));
+	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCP=
F_LISTEN));
 }
 =

 static void mptcp_send_ack(struct mptcp_sock *msk)
-- =

2.26.2

--===============3614292665902760265==--
