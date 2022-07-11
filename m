Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7A4695
	for <mptcp@lists.linux.dev>; Mon, 11 Jul 2022 19:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657567002; x=1689103002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sX26Sc/Ae3nAyNsrp8P8AJWuFq/C3wjAC5FxQqFb5uw=;
  b=Rp0VCN43zKyanxJZ9QIjzsvRCPMuXjgkdKbjW0qMQLHq6mIJtNB4O2G3
   EJj8Rqceid1VSau7rj0ejAkmp9vghJLsOmBm8pzLt4fnRLx4RDqKM4xba
   Wsh6PWluViU0Dg1wk2Kw53IhqaxyJPg72dgDnKxr08sMywLt2W5pFDozl
   MgKapoYiGyNOD15unnBoHSqi3PvbJVwNp1sdCURj1dBHAkvbKwTpYCkkJ
   DyawKjVnF1rnDeB1Orf3uDSEsfb6QRozSLC4+3E0ZzjGnrWWqI0qOaYXs
   j/OCCnPaWRZhkG7VtgP+Q3R3XUvd51za0+Ig6Az1NP3cUkik35txFlhIW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284775362"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="284775362"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 12:16:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="697742717"
Received: from eedeets-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.2.111])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 12:16:39 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/5] selftests: mptcp: add MPC backup tests
Date: Mon, 11 Jul 2022 12:16:33 -0700
Message-Id: <20220711191633.80826-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711191633.80826-1-mathew.j.martineau@linux.intel.com>
References: <20220711191633.80826-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Add a couple of test-cases covering the newly introduced
features - priority update for the MPC subflow.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 55efe2aafb84..ff83ef426df5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2428,6 +2428,36 @@ backup_tests()
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
 	fi
+
+	if reset "mpc backup"; then
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		chk_join_nr 0 0 0
+		chk_prio_nr 0 1
+	fi
+
+	if reset "mpc backup both sides"; then
+		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		chk_join_nr 0 0 0
+		chk_prio_nr 1 1
+	fi
+
+	if reset "mpc switch to backup"; then
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		chk_join_nr 0 0 0
+		chk_prio_nr 0 1
+	fi
+
+	if reset "mpc switch to backup both sides"; then
+		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		chk_join_nr 0 0 0
+		chk_prio_nr 1 1
+	fi
 }
 
 add_addr_ports_tests()
-- 
2.37.0

