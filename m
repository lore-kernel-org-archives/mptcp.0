Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF970
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 10:23:00 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1leb9n-0001OK-7S; Thu, 06 May 2021 12:22:59 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 2/8] sock: expose so_timestamp options for mptcp
Date: Thu,  6 May 2021 12:22:37 +0200
Message-Id: <20210506102243.2390-3-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210506102243.2390-1-fw@strlen.de>
References: <20210506102243.2390-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This exports SO_TIMESTAMP_* function for re-use by MPTCP.

Without this there is too much copy & paste needed to support
this from mptcp setsockopt path.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/sock.h |  1 +
 net/core/sock.c    | 26 +++++++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 42bc5e1a627f..7ee2347846b6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2741,6 +2741,7 @@ static inline bool sk_dev_equal_l3scope(struct sock *sk, int dif)
 void sock_def_readable(struct sock *sk);
 
 int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
+void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
 void sock_enable_timestamps(struct sock *sk);
 void sock_no_linger(struct sock *sk);
 void sock_set_keepalive(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index c761c4a0b66b..294b5a9bf520 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -776,6 +776,24 @@ void sock_enable_timestamps(struct sock *sk)
 }
 EXPORT_SYMBOL(sock_enable_timestamps);
 
+void sock_set_timestamp(struct sock *sk, int optname, bool valbool)
+{
+	switch (optname) {
+	case SO_TIMESTAMP_OLD:
+		__sock_set_timestamps(sk, valbool, false, false);
+		break;
+	case SO_TIMESTAMP_NEW:
+		__sock_set_timestamps(sk, valbool, true, false);
+		break;
+	case SO_TIMESTAMPNS_OLD:
+		__sock_set_timestamps(sk, valbool, false, true);
+		break;
+	case SO_TIMESTAMPNS_NEW:
+		__sock_set_timestamps(sk, valbool, true, true);
+		break;
+	}
+}
+
 void sock_set_keepalive(struct sock *sk)
 {
 	lock_sock(sk);
@@ -989,16 +1007,10 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_TIMESTAMP_OLD:
-		__sock_set_timestamps(sk, valbool, false, false);
-		break;
 	case SO_TIMESTAMP_NEW:
-		__sock_set_timestamps(sk, valbool, true, false);
-		break;
 	case SO_TIMESTAMPNS_OLD:
-		__sock_set_timestamps(sk, valbool, false, true);
-		break;
 	case SO_TIMESTAMPNS_NEW:
-		__sock_set_timestamps(sk, valbool, true, true);
+		sock_set_timestamp(sk, valbool, optname);
 		break;
 	case SO_TIMESTAMPING_NEW:
 	case SO_TIMESTAMPING_OLD:
-- 
2.26.3

