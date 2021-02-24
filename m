Content-Type: multipart/mixed; boundary="===============4439943256922164099=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 mptcp-net] mptcp: fix missing wakeup
Date: Wed, 24 Feb 2021 16:58:38 +0100
Message-ID: <4d31b9f59807913ba3eacf71dc939177027d6f5d.1614182254.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7939

--===============4439943256922164099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2: =

 - drop self-tests changes, slipped here due to PEBKAC

 net/mptcp/protocol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2859ad2c6990c..87f62fe66317d 100644
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
@@ -2263,7 +2269,7 @@ static void __mptcp_retrans(struct sock *sk)
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

2.26.2

--===============4439943256922164099==--
