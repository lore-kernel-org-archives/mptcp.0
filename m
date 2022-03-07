Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865E24349
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 20:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646685886; x=1678221886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ucCVEbG2r6tv8BhrEAQxcmNxQ5DVG9ZS+1eowHh6Zk=;
  b=faBRPrsRW97i9s1AVOoQb5G1zEatk5PmF9WpdIfryLQbUmZyGVWeRgwD
   HykcxV4Z4ICXEZnEz1UQ5+jbvKegADS+Eq+g/CUNi/CiACWvwurfaZQR7
   JHR6PidSRp4IpjKmPvgBbQEjDx/5eT7RqdJo7MHnl6w1j0hpNdIbBAXB0
   Guq4PGRwzlU6S1Xwmp4k98X37IKcGbHivlGh242o3MWgMrkpV46VlkGZ+
   Psx2grUyBe4WsQGQNe1UiZQjMqcbuIDa7h98eTdQoxghQIG//qk2eL+tJ
   T6uAG7zJjuw4NiuD3mYUv3MExzgMGjJoTk1j5d6xlJb5HPIXFWknz/iDo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="317731783"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="317731783"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:44:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="553320480"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.192.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:44:44 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/9] mptcp: add tracepoint in mptcp_sendmsg_frag
Date: Mon,  7 Mar 2022 12:44:31 -0800
Message-Id: <20220307204439.65164-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307204439.65164-1-mathew.j.martineau@linux.intel.com>
References: <20220307204439.65164-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

The tracepoint in get_mapping_status() only dumped the incoming mpext
fields. This patch added a new tracepoint in mptcp_sendmsg_frag() to dump
the outgoing mpext too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/trace/events/mptcp.h | 4 ++++
 net/mptcp/protocol.c         | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 6bf43176f14c..f8e28e686c65 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -115,6 +115,10 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		  __entry->csum_reqd)
 );
 
+DEFINE_EVENT(mptcp_dump_mpext, mptcp_sendmsg_frag,
+	TP_PROTO(struct mptcp_ext *mpext),
+	TP_ARGS(mpext));
+
 DEFINE_EVENT(mptcp_dump_mpext, get_mapping_status,
 	TP_PROTO(struct mptcp_ext *mpext),
 	TP_ARGS(mpext));
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1c72f25f083e..36a7d33f670a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1356,6 +1356,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 out:
 	if (READ_ONCE(msk->csum_enabled))
 		mptcp_update_data_checksum(skb, copy);
+	trace_mptcp_sendmsg_frag(mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 	return copy;
 }
-- 
2.35.1

