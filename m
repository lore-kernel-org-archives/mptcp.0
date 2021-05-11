Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492670
	for <mptcp@lists.linux.dev>; Tue, 11 May 2021 13:37:22 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lgSZc-0000U9-TA; Tue, 11 May 2021 15:37:20 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 mptcp-next 4/8] mptcp: sockopt: propagate timestamp request to subflows
Date: Tue, 11 May 2021 15:36:55 +0200
Message-Id: <20210511133659.29982-5-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210511133659.29982-1-fw@strlen.de>
References: <20210511133659.29982-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for TIMESTAMP(NS) setsockopt.

This doesn't make things work yet, because the mptcp receive path
doesn't convert the skb timestamps to cmsgs for userspace consumption.

receive path cmsg support is added ina followup patch.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/sockopt.c | 50 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index ee55e4145d7e..0e0670553fb4 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -140,6 +140,43 @@ static void mptcp_so_incoming_cpu(struct mptcp_sock *msk, int val)
 	mptcp_sol_socket_sync_intval(msk, SO_INCOMING_CPU, val);
 }
 
+static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optname, int val)
+{
+	sockptr_t optval = KERNEL_SOCKPTR(&val);
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int ret;
+
+	ret = sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname,
+			      optval, sizeof(val));
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow = lock_sock_fast(ssk);
+
+		switch (optname) {
+		case SO_TIMESTAMP_OLD:
+		case SO_TIMESTAMP_NEW:
+		case SO_TIMESTAMPNS_OLD:
+		case SO_TIMESTAMPNS_NEW:
+			sock_set_timestamp(sk, optname, !!val);
+			break;
+		case SO_TIMESTAMPING_NEW:
+		case SO_TIMESTAMPING_OLD:
+			sock_set_timestamping(sk, optname, val);
+			break;
+		}
+
+		unlock_sock_fast(ssk, slow);
+	}
+
+	release_sock(sk);
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 					   sockptr_t optval, unsigned int optlen)
 {
@@ -164,6 +201,13 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_INCOMING_CPU:
 		mptcp_so_incoming_cpu(msk, val);
 		return 0;
+	case SO_TIMESTAMP_OLD:
+	case SO_TIMESTAMP_NEW:
+	case SO_TIMESTAMPNS_OLD:
+	case SO_TIMESTAMPNS_NEW:
+	case SO_TIMESTAMPING_OLD:
+	case SO_TIMESTAMPING_NEW:
+		return mptcp_setsockopt_sol_socket_tstamp(msk, optname, val);
 	}
 
 	return -ENOPROTOOPT;
@@ -251,6 +295,12 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_MARK:
 	case SO_INCOMING_CPU:
 	case SO_DEBUG:
+	case SO_TIMESTAMP_OLD:
+	case SO_TIMESTAMP_NEW:
+	case SO_TIMESTAMPNS_OLD:
+	case SO_TIMESTAMPNS_NEW:
+	case SO_TIMESTAMPING_OLD:
+	case SO_TIMESTAMPING_NEW:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
-- 
2.26.3

