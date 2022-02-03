Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803462F2C
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 01:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643850231; x=1675386231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z9FXdFRTATWnPkR8TDxvMrnTWTylwxTAHt4sB0od7FY=;
  b=EEkcRTPC2m3JyArm/dhIfbmA+tlT4HHxtU6tsxn/z1bNoQlauzKYePB/
   mDvpKTPFhda9y8/vuta1i/PnaUoIouBMAunBz54pgCX2nHKMmp1nAKG2Y
   zrCVKX1EQy/nC98YSfnuEwYQRqMJdzmeAyzMd0uekSDpju7pNNRnuw6cQ
   CH6lZbbT+lmxoZFqPAAD7d+1TFukhFKTslumDGyeY3o1vlSyTNjJBy8/l
   d4N4jinmF3ajoBQ4FdLY8UrwsAimBgH+SJH3mPpTY7wcOb9PsIzs9KRlJ
   h+vEMwkCdMH4t9drgRd6xzTmTwEV0wjNTgaM00LoD4/HH5DG+0COBIr/o
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228023383"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="228023383"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 17:03:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="483070829"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.1.6])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 17:03:48 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/7] mptcp: reduce branching when writing MP_FAIL option
Date: Wed,  2 Feb 2022 17:03:38 -0800
Message-Id: <20220203010343.113421-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203010343.113421-1-mathew.j.martineau@linux.intel.com>
References: <20220203010343.113421-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

MP_FAIL should be use in very rare cases, either when the TCP RST flag
is set -- with or without an MP_RST -- or with a DSS, see
mptcp_established_options().

Here, we do the same in mptcp_write_options().

Co-developed-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5d0b3c3e4655..ab054c389a5f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1267,17 +1267,6 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 	const struct sock *ssk = (const struct sock *)tp;
 	struct mptcp_subflow_context *subflow;
 
-	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
-		subflow = mptcp_subflow_ctx(ssk);
-		subflow->send_mp_fail = 0;
-
-		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
-				      TCPOLEN_MPTCP_FAIL,
-				      0, 0);
-		put_unaligned_be64(opts->fail_seq, ptr);
-		ptr += 2;
-	}
-
 	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
 	 * see mptcp_established_options*()
 	 */
@@ -1336,6 +1325,10 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			}
 			ptr += 1;
 		}
+
+		/* We might need to add MP_FAIL options in rare cases */
+		if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
+			goto mp_fail;
 	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
@@ -1476,6 +1469,21 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		put_unaligned_be64(opts->rcvr_key, ptr);
 		ptr += 2;
 
+		if (OPTION_MPTCP_RST & opts->suboptions)
+			goto mp_rst;
+		return;
+	} else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
+mp_fail:
+		/* MP_FAIL is mutually exclusive with others except RST */
+		subflow = mptcp_subflow_ctx(ssk);
+		subflow->send_mp_fail = 0;
+
+		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
+				      TCPOLEN_MPTCP_FAIL,
+				      0, 0);
+		put_unaligned_be64(opts->fail_seq, ptr);
+		ptr += 2;
+
 		if (OPTION_MPTCP_RST & opts->suboptions)
 			goto mp_rst;
 		return;
-- 
2.35.1

