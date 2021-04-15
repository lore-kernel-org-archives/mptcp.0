Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2052BC0
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 23:45:14 +0000 (UTC)
IronPort-SDR: qPs+EnmvRbUQZZas8i3+4BWcTnnIwGK3pqVlBjpUT5cweRoSgdvvI+Mu+stYEYX2pE+w+XkDOW
 4FoBaRe0tnUA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="258923288"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="258923288"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:45:09 -0700
IronPort-SDR: eIbrRUOAN3WVpfshcuyvUBqVG6jPIvdtXo51BqurG/xyONEOKClESmXd7mnXM2QMFmokSeiw/L
 QGkhKTaopJkw==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="461793371"
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
Subject: [PATCH net-next 11/13] mptcp: setsockopt: SO_DEBUG and no-op options
Date: Thu, 15 Apr 2021 16:45:00 -0700
Message-Id: <20210415234502.224225-12-mathew.j.martineau@linux.intel.com>
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

Handle SO_DEBUG and set it on all subflows.
Ignore those values not implemented on TCP sockets.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/sockopt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 7eb637488dc2..390433b7f324 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -77,6 +77,9 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 		bool slow = lock_sock_fast(ssk);
 
 		switch (optname) {
+		case SO_DEBUG:
+			sock_valbool_flag(ssk, SOCK_DBG, !!val);
+			break;
 		case SO_KEEPALIVE:
 			if (ssk->sk_prot->keepalive)
 				ssk->sk_prot->keepalive(ssk, !!val);
@@ -150,6 +153,7 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_KEEPALIVE:
 		mptcp_sol_socket_sync_intval(msk, optname, val);
 		return 0;
+	case SO_DEBUG:
 	case SO_MARK:
 	case SO_PRIORITY:
 	case SO_SNDBUF:
@@ -246,9 +250,21 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_RCVBUFFORCE:
 	case SO_MARK:
 	case SO_INCOMING_CPU:
+	case SO_DEBUG:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
+	case SO_NO_CHECK:
+	case SO_DONTROUTE:
+	case SO_BROADCAST:
+	case SO_BSDCOMPAT:
+	case SO_PASSCRED:
+	case SO_PASSSEC:
+	case SO_RXQ_OVFL:
+	case SO_WIFI_STATUS:
+	case SO_NOFCS:
+	case SO_SELECT_ERR_QUEUE:
+		return 0;
 	}
 
 	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
-- 
2.31.1

