Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3B4C94
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 21:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645220154; x=1676756154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XkVHPDIyBkaH3q1Z9MjQ0riJxIyyJNcm/+ZtjZLixX0=;
  b=gxRt0AKdFjveeQki0WN0CDgcsV4Ce9nyxjSWwLTlb+4hM6ycDq6ETUae
   aKk1XK/CXRbzKN8DC33vso//K9lIGpSZH6sZxCepU2t0FoQJLaKZ4en3b
   TGygGJSxquBnwjiwtwBPq6JZZpQVjkRVo+B45NXMLIaauZ9I/yFyv34QN
   DBOWsQgpoclW1r5HnCwCnlRwxRfd1s0zcgBa7Kxt3kr9TpBQpyfNcvJdt
   uJtKyG6rYFfkgTtgCa23PuzxK7Bc2W7k5San20ILo3HZawCa4q07c/x4H
   AbxhHVW2zCiGtZ0NKtBeDI4eeXeCLx8/v3uAsB1BpvrMlWPFpdbsMICVm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="238639223"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="238639223"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:35:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="605664080"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.65.242])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:35:52 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	geliang.tang@suse.com,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 5/7] mptcp: add mibs counter for ignored incoming options
Date: Fri, 18 Feb 2022 13:35:42 -0800
Message-Id: <20220218213544.70285-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218213544.70285-1-mathew.j.martineau@linux.intel.com>
References: <20220218213544.70285-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP in kernel path manager has some constraints on incoming
addresses announce processing, so that in edge scenarios it can
end-up dropping (ignoring) some of such announces.

The above is not very limiting in practice since such scenarios are
very uncommon and MPTCP will recover due to ADD_ADDR retransmissions.

This patch adds a few MIB counters to account for such drop events
to allow easier introspection of the critical scenarios.

Fixes: f7efc7771eac ("mptcp: drop argument port from mptcp_pm_announce_addr")
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/mib.c | 2 ++
 net/mptcp/mib.h | 2 ++
 net/mptcp/pm.c  | 8 ++++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 3240b72271a7..7558802a1435 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -35,12 +35,14 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
 	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
 	SNMP_MIB_ITEM("PortAdd", MPTCP_MIB_PORTADD),
+	SNMP_MIB_ITEM("AddAddrDrop", MPTCP_MIB_ADDADDRDROP),
 	SNMP_MIB_ITEM("MPJoinPortSynRx", MPTCP_MIB_JOINPORTSYNRX),
 	SNMP_MIB_ITEM("MPJoinPortSynAckRx", MPTCP_MIB_JOINPORTSYNACKRX),
 	SNMP_MIB_ITEM("MPJoinPortAckRx", MPTCP_MIB_JOINPORTACKRX),
 	SNMP_MIB_ITEM("MismatchPortSynRx", MPTCP_MIB_MISMATCHPORTSYNRX),
 	SNMP_MIB_ITEM("MismatchPortAckRx", MPTCP_MIB_MISMATCHPORTACKRX),
 	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
+	SNMP_MIB_ITEM("RmAddrDrop", MPTCP_MIB_RMADDRDROP),
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index ecd3d8b117e0..2966fcb6548b 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -28,12 +28,14 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=0 */
 	MPTCP_MIB_ECHOADD,		/* Received ADD_ADDR with echo-flag=1 */
 	MPTCP_MIB_PORTADD,		/* Received ADD_ADDR with a port-number */
+	MPTCP_MIB_ADDADDRDROP,		/* Dropped incoming ADD_ADDR */
 	MPTCP_MIB_JOINPORTSYNRX,	/* Received a SYN MP_JOIN with a different port-number */
 	MPTCP_MIB_JOINPORTSYNACKRX,	/* Received a SYNACK MP_JOIN with a different port-number */
 	MPTCP_MIB_JOINPORTACKRX,	/* Received an ACK MP_JOIN with a different port-number */
 	MPTCP_MIB_MISMATCHPORTSYNRX,	/* Received a SYN MP_JOIN with a mismatched port-number */
 	MPTCP_MIB_MISMATCHPORTACKRX,	/* Received an ACK MP_JOIN with a mismatched port-number */
 	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
+	MPTCP_MIB_RMADDRDROP,		/* Dropped incoming RM_ADDR */
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 696b2c4613a7..7bea318ac5f2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -213,6 +213,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->remote = *addr;
+	} else {
+		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 	}
 
 	spin_unlock_bh(&pm->lock);
@@ -253,8 +255,10 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 		mptcp_event_addr_removed(msk, rm_list->ids[i]);
 
 	spin_lock_bh(&pm->lock);
-	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_list_rx = *rm_list;
+	if (mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED))
+		pm->rm_list_rx = *rm_list;
+	else
+		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_RMADDRDROP);
 	spin_unlock_bh(&pm->lock);
 }
 
-- 
2.35.1

