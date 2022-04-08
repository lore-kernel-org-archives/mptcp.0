Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3128C2CA1
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 19:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649447171; x=1680983171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zdAkC0JYrW2Pdheuu2gZ1bu45Lzie2GfL/O91yGB45o=;
  b=GLLwRNX0/jfvLVptDdti4FshE0XGxNmdh+R7Lz0QuHPLwYqo7qD6Dr0b
   x4PogMkQo+AKi5LQdNAB9ICnDeF1kYy1L6vHxpKfwF2g+vKpn73WuSn/d
   WfgG80HbLihBTz+1/wGGPEsbEcwFGVxgL8IskNV+SjdOusMUxohoxE6jw
   rsuOiFNjJ5M2ztbAtJXcDQ1D4EW2/JqI5xyM+0NiJVP9MqR2SGEIkEiZT
   7bkEWHZM2CcqmAg90wZ/SsVAcDCar7FO+xqbkO3/vEiTJUvEM1Ky/Ldnb
   CxuxftDxzI73NV+QN/Y7kl0xI6GMhZKd4tEtJx4UsicMnFPT4ZT+ld+lC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="322365294"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322365294"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:46:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="659602147"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.134.75.99])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:46:07 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/8] mptcp: optimize release_cb for the common case
Date: Fri,  8 Apr 2022 12:45:54 -0700
Message-Id: <20220408194601.305969-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
References: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The mptcp release callback checks several flags in atomic
context, but only MPTCP_CLEAN_UNA can be up frequently.

Reorganize the code to avoid multiple conditionals in the
most common scenarios.

Additional clarify a related comment.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0cbea3b6d0a4..2a9335ce5df1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3092,15 +3092,17 @@ static void mptcp_release_cb(struct sock *sk)
 		spin_lock_bh(&sk->sk_lock.slock);
 	}
 
-	/* be sure to set the current sk state before tacking actions
-	 * depending on sk_state
-	 */
-	if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags))
-		__mptcp_set_connected(sk);
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
 		__mptcp_clean_una_wakeup(sk);
-	if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
-		__mptcp_error_report(sk);
+	if (unlikely(&msk->cb_flags)) {
+		/* be sure to set the current sk state before tacking actions
+		 * depending on sk_state, that is processing MPTCP_ERROR_REPORT
+		 */
+		if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags))
+			__mptcp_set_connected(sk);
+		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
+			__mptcp_error_report(sk);
+	}
 
 	__mptcp_update_rmem(sk);
 }
-- 
2.35.1

