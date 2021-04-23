Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A134C71
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 18:17:16 +0000 (UTC)
IronPort-SDR: C2+esQX4mmwYSXB46vKsMAi5b6o/fkACDXk0SVteQYyMDYxJURxsBUgvzsJ8rDKI6LYbxo/Qcq
 CbF/LF9Lz8BQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="183243830"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="183243830"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:17:14 -0700
IronPort-SDR: 3cJ9tlV6f8s9hb1Mw9evb6XTGcTSxqQjIevvDmtX21YwG6yCFb7frc1h/PgDxqvtu/puUpqNOM
 lTvpKPp94uhg==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="402264967"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.254.72.13])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:17:14 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/5] mptcp: implement dummy MSG_ERRQUEUE support
Date: Fri, 23 Apr 2021 11:17:05 -0700
Message-Id: <20210423181709.330233-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423181709.330233-1-mathew.j.martineau@linux.intel.com>
References: <20210423181709.330233-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

mptcp_recvmsg() currently silently ignores MSG_ERRQUEUE, returning
input data instead of error cmsg.

This change provides a dummy implementation for MSG_ERRQUEUE - always
returns no data. That is consistent with the current lack of a suitable
IP_RECVERR setsockopt() support.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c14ac2975736..1d5f23bd640c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1945,6 +1945,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
+	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return inet_recv_error(sk, msg, len, addr_len);
+
 	if (msg->msg_flags & ~(MSG_WAITALL | MSG_DONTWAIT))
 		return -EOPNOTSUPP;
 
-- 
2.31.1

