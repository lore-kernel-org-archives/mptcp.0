Content-Type: multipart/mixed; boundary="===============1382461530872360576=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 8/9] mptcp: fix missing wakeup
Date: Thu, 04 Mar 2021 13:32:15 -0800
Message-ID: <20210304213216.205472-9-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210304213216.205472-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8035

--===============1382461530872360576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

__mptcp_clean_una() can free write memory and should wake-up
user-space processes when needed.

When such function is invoked by the MPTCP receive path, the wakeup
is not needed, as the TCP stack will later trigger subflow_write_space
which will do the wakeup as needed.

Other __mptcp_clean_una() call sites need an additional wakeup check
Let's bundle the relevant code in a new helper and use it.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/165
Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Fixes: 64b9cea7a0af ("mptcp: fix spurious retransmissions")
Tested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d2a2169e6d9e..76958570ae7f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1061,6 +1061,12 @@ static void __mptcp_clean_una(struct sock *sk)
 	}
 }
 =

+static void __mptcp_clean_una_wakeup(struct sock *sk)
+{
+	__mptcp_clean_una(sk);
+	mptcp_write_space(sk);
+}
+
 static void mptcp_enter_memory_pressure(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2270,7 +2276,7 @@ static void __mptcp_retrans(struct sock *sk)
 	struct sock *ssk;
 	int ret;
 =

-	__mptcp_clean_una(sk);
+	__mptcp_clean_una_wakeup(sk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag)
 		return;
@@ -2983,7 +2989,7 @@ static void mptcp_release_cb(struct sock *sk)
 	}
 =

 	if (test_and_clear_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk)->flags))
-		__mptcp_clean_una(sk);
+		__mptcp_clean_una_wakeup(sk);
 	if (test_and_clear_bit(MPTCP_ERROR_REPORT, &mptcp_sk(sk)->flags))
 		__mptcp_error_report(sk);
 =

-- =

2.30.1

--===============1382461530872360576==--
