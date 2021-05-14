Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198571
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 09:49:14 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lhURV-0006sA-6I; Fri, 14 May 2021 11:49:13 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v3 mptcp-next 2/7] sock: expose so_timestamping options for mptcp
Date: Fri, 14 May 2021 11:48:52 +0200
Message-Id: <20210514094857.10663-3-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210514094857.10663-1-fw@strlen.de>
References: <20210514094857.10663-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to previous patch: expose SO_TIMESTAMPING helper so we do not
have to copy & paste this into the mptcp core.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/sock.h |  2 ++
 net/core/sock.c    | 71 +++++++++++++++++++++++-----------------------
 2 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7ee2347846b6..636416631913 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2742,6 +2742,8 @@ void sock_def_readable(struct sock *sk);
 
 int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
 void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
+int sock_set_timestamping(struct sock *sk, int optname, int val);
+
 void sock_enable_timestamps(struct sock *sk);
 void sock_no_linger(struct sock *sk);
 void sock_set_keepalive(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index 294b5a9bf520..aba9d8de5303 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -794,6 +794,40 @@ void sock_set_timestamp(struct sock *sk, int optname, bool valbool)
 	}
 }
 
+int sock_set_timestamping(struct sock *sk, int optname, int val)
+{
+	if (val & ~SOF_TIMESTAMPING_MASK)
+		return -EINVAL;
+
+	if (val & SOF_TIMESTAMPING_OPT_ID &&
+	    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
+		if (sk->sk_protocol == IPPROTO_TCP &&
+		    sk->sk_type == SOCK_STREAM) {
+			if ((1 << sk->sk_state) &
+			    (TCPF_CLOSE | TCPF_LISTEN))
+				return -EINVAL;
+			sk->sk_tskey = tcp_sk(sk)->snd_una;
+		} else {
+			sk->sk_tskey = 0;
+		}
+	}
+
+	if (val & SOF_TIMESTAMPING_OPT_STATS &&
+	    !(val & SOF_TIMESTAMPING_OPT_TSONLY))
+		return -EINVAL;
+
+	sk->sk_tsflags = val;
+	sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname == SO_TIMESTAMPING_NEW);
+
+	if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
+		sock_enable_timestamp(sk,
+				      SOCK_TIMESTAMPING_RX_SOFTWARE);
+	else
+		sock_disable_timestamp(sk,
+				       (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE));
+	return 0;
+}
+
 void sock_set_keepalive(struct sock *sk)
 {
 	lock_sock(sk);
@@ -1012,43 +1046,10 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 	case SO_TIMESTAMPNS_NEW:
 		sock_set_timestamp(sk, valbool, optname);
 		break;
+
 	case SO_TIMESTAMPING_NEW:
 	case SO_TIMESTAMPING_OLD:
-		if (val & ~SOF_TIMESTAMPING_MASK) {
-			ret = -EINVAL;
-			break;
-		}
-
-		if (val & SOF_TIMESTAMPING_OPT_ID &&
-		    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
-			if (sk->sk_protocol == IPPROTO_TCP &&
-			    sk->sk_type == SOCK_STREAM) {
-				if ((1 << sk->sk_state) &
-				    (TCPF_CLOSE | TCPF_LISTEN)) {
-					ret = -EINVAL;
-					break;
-				}
-				sk->sk_tskey = tcp_sk(sk)->snd_una;
-			} else {
-				sk->sk_tskey = 0;
-			}
-		}
-
-		if (val & SOF_TIMESTAMPING_OPT_STATS &&
-		    !(val & SOF_TIMESTAMPING_OPT_TSONLY)) {
-			ret = -EINVAL;
-			break;
-		}
-
-		sk->sk_tsflags = val;
-		sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname == SO_TIMESTAMPING_NEW);
-
-		if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
-			sock_enable_timestamp(sk,
-					      SOCK_TIMESTAMPING_RX_SOFTWARE);
-		else
-			sock_disable_timestamp(sk,
-					       (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE));
+		ret = sock_set_timestamping(sk, optname, val);
 		break;
 
 	case SO_RCVLOWAT:
-- 
2.26.3

