Content-Type: multipart/mixed; boundary="===============1838049110827986246=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 4/4] mptcp: do not wakeup listener for MPJ subflows
Date: Fri, 19 Feb 2021 18:35:40 +0100
Message-ID: <039d97d7c7d90a52e55aa90760585eea7cb0d027.1613755058.git.pabeni@redhat.com>
In-Reply-To: cover.1613755058.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7866

--===============1838049110827986246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

MPJ subflows are not exposed as fds to user spaces. As such,
incoming MPJ subflows are removed from the accept queue by
tcp_check_req()/tcp_get_cookie_sock().

Later tcp_child_process() invokes subflow_data_ready() on the
parent socket regardless of the subflow kind, leading to poll
wakeups even if the later accept will block.

Address the issue by double-checking the queue state before
waking the user-space.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/164
Reported-by: Dr. David Alan Gilbert <dgilbert(a)redhat.com>
Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8b2338dfdc80..59f992fe6728 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1018,6 +1018,12 @@ static void subflow_data_ready(struct sock *sk)
 =

 	msk =3D mptcp_sk(parent);
 	if (state & TCPF_LISTEN) {
+		/* MPJ subflow are removed from accept queue before reaching here,
+		 * avoid stray wakeups
+		 */
+		if (reqsk_queue_empty(&inet_csk(sk)->icsk_accept_queue))
+			return;
+
 		set_bit(MPTCP_DATA_READY, &msk->flags);
 		parent->sk_data_ready(parent);
 		return;
-- =

2.26.2

--===============1838049110827986246==--
