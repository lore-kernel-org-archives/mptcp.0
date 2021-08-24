Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC53FC1
	for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 23:26:35 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="214293420"
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="214293420"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 16:26:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="515847905"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.40.105])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 16:26:33 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 6/7] mptcp: add the mibs for MP_FAIL
Date: Tue, 24 Aug 2021 16:26:18 -0700
Message-Id: <20210824232619.136912-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824232619.136912-1-mathew.j.martineau@linux.intel.com>
References: <20210824232619.136912-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added the mibs for MP_FAIL: MPTCP_MIB_MPFAILTX and
MPTCP_MIB_MPFAILRX.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 1 +
 net/mptcp/subflow.c | 1 +
 4 files changed, 6 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 3a7c4e7b2d79..b21ff9be04c6 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -44,6 +44,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
+	SNMP_MIB_ITEM("MPFailTx", MPTCP_MIB_MPFAILTX),
+	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 8ec16c991aac..ecd3d8b117e0 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -37,6 +37,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
+	MPTCP_MIB_MPFAILTX,		/* Transmit a MP_FAIL */
+	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index fa287a49dc84..bec3ed82e253 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1158,6 +1158,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	if (mp_opt.mp_fail) {
 		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
 		mp_opt.mp_fail = 0;
 	}
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index dba8ad700fb8..54b7ffc21861 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -911,6 +911,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	if (unlikely(csum_fold(csum))) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
 		subflow->send_mp_fail = 1;
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
-- 
2.33.0

