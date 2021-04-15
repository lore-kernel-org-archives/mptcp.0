Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D62BC5
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 23:45:13 +0000 (UTC)
IronPort-SDR: 7qyb++4AXvzgRqqITqPFRDm8RtbUTlmQ/aRND2iqAJixgRbr66wqF/IyjndtIadjLEkrY9p74T
 cAYKKVBkJXfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="258923282"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="258923282"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:45:08 -0700
IronPort-SDR: +Jn7oxUku11ggSUDa4/e7WlP+TbEcRUF5a8nVyRFHf59krtqE+FccluiGfuTE3AA56czPV7Xtr
 BS+DlgC/t0Ow==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="461793366"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.243.150])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:45:08 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 09/13] mptcp: setsockopt: add SO_MARK support
Date: Thu, 15 Apr 2021 16:44:58 -0700
Message-Id: <20210415234502.224225-10-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415234502.224225-1-mathew.j.martineau@linux.intel.com>
References: <20210415234502.224225-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Value is synced to all subflows.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/sockopt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index ee5d58747ce7..1ad6092811e5 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -95,6 +95,12 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 			ssk->sk_userlocks |= SOCK_RCVBUF_LOCK;
 			WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
 			break;
+		case SO_MARK:
+			if (READ_ONCE(ssk->sk_mark) != sk->sk_mark) {
+				ssk->sk_mark = sk->sk_mark;
+				sk_dst_reset(ssk);
+			}
+			break;
 		}
 
 		subflow->setsockopt_seq = msk->setsockopt_seq;
@@ -132,6 +138,7 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_KEEPALIVE:
 		mptcp_sol_socket_sync_intval(msk, optname, val);
 		return 0;
+	case SO_MARK:
 	case SO_PRIORITY:
 	case SO_SNDBUF:
 	case SO_SNDBUFFORCE:
@@ -222,6 +229,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_SNDBUFFORCE:
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
+	case SO_MARK:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
-- 
2.31.1

