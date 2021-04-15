Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD92BC7
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 23:45:13 +0000 (UTC)
IronPort-SDR: +K7dQnv80r41TjBgeKtjzW9leR6TZcEdFUTWhPqojl29085Bn7ua/FCr3Tgcj3acgI7Wg13ct4
 VBXGOd0N5UlQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="258923284"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="258923284"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:45:08 -0700
IronPort-SDR: XtD91Er7uIJOZwsoKCMW6E5Y7dsXWDvDifHfNcEI1obxxDLXiaZE+LfsOdO6Y0Efbg6YWbO3Ow
 wp3s21ImOsEg==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="461793370"
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
Subject: [PATCH net-next 10/13] mptcp: setsockopt: add SO_INCOMING_CPU
Date: Thu, 15 Apr 2021 16:44:59 -0700
Message-Id: <20210415234502.224225-11-mathew.j.martineau@linux.intel.com>
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

Replicate to all subflows.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/sockopt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1ad6092811e5..7eb637488dc2 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -101,6 +101,9 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 				sk_dst_reset(ssk);
 			}
 			break;
+		case SO_INCOMING_CPU:
+			WRITE_ONCE(ssk->sk_incoming_cpu, val);
+			break;
 		}
 
 		subflow->setsockopt_seq = msk->setsockopt_seq;
@@ -125,6 +128,15 @@ static int mptcp_sol_socket_intval(struct mptcp_sock *msk, int optname, int val)
 	return 0;
 }
 
+static void mptcp_so_incoming_cpu(struct mptcp_sock *msk, int val)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	WRITE_ONCE(sk->sk_incoming_cpu, val);
+
+	mptcp_sol_socket_sync_intval(msk, SO_INCOMING_CPU, val);
+}
+
 static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 					   sockptr_t optval, unsigned int optlen)
 {
@@ -145,6 +157,9 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
 		return mptcp_sol_socket_intval(msk, optname, val);
+	case SO_INCOMING_CPU:
+		mptcp_so_incoming_cpu(msk, val);
+		return 0;
 	}
 
 	return -ENOPROTOOPT;
@@ -230,6 +245,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_RCVBUF:
 	case SO_RCVBUFFORCE:
 	case SO_MARK:
+	case SO_INCOMING_CPU:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval, optlen);
 	case SO_LINGER:
 		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
-- 
2.31.1

