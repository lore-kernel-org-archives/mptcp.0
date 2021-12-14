Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D42CA4
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 23:16:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="219119109"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="219119109"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 15:16:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="518491441"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.180.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 15:16:10 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	fw@strlen.de,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 4/4] mptcp: add missing documented NL params
Date: Tue, 14 Dec 2021 15:16:04 -0800
Message-Id: <20211214231604.211016-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214231604.211016-1-mathew.j.martineau@linux.intel.com>
References: <20211214231604.211016-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

'loc_id' and 'rem_id' are set in all events linked to subflows but those
were missing in the events description in the comments.

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/uapi/linux/mptcp.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index c8cc46f80a16..f106a3941cdf 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -136,19 +136,21 @@ struct mptcp_info {
  * MPTCP_EVENT_REMOVED: token, rem_id
  * An address has been lost by the peer.
  *
- * MPTCP_EVENT_SUB_ESTABLISHED: token, family, saddr4 | saddr6,
- *                              daddr4 | daddr6, sport, dport, backup,
- *                              if_idx [, error]
+ * MPTCP_EVENT_SUB_ESTABLISHED: token, family, loc_id, rem_id,
+ *                              saddr4 | saddr6, daddr4 | daddr6, sport,
+ *                              dport, backup, if_idx [, error]
  * A new subflow has been established. 'error' should not be set.
  *
- * MPTCP_EVENT_SUB_CLOSED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *                         sport, dport, backup, if_idx [, error]
+ * MPTCP_EVENT_SUB_CLOSED: token, family, loc_id, rem_id, saddr4 | saddr6,
+ *                         daddr4 | daddr6, sport, dport, backup, if_idx
+ *                         [, error]
  * A subflow has been closed. An error (copy of sk_err) could be set if an
  * error has been detected for this subflow.
  *
- * MPTCP_EVENT_SUB_PRIORITY: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *                           sport, dport, backup, if_idx [, error]
- *       The priority of a subflow has changed. 'error' should not be set.
+ * MPTCP_EVENT_SUB_PRIORITY: token, family, loc_id, rem_id, saddr4 | saddr6,
+ *                           daddr4 | daddr6, sport, dport, backup, if_idx
+ *                           [, error]
+ * The priority of a subflow has changed. 'error' should not be set.
  */
 enum mptcp_event_type {
 	MPTCP_EVENT_UNSPEC = 0,
-- 
2.34.1

