Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2538FE
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646685887; x=1678221887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lmWvw4D5PKVHts20BdUYWt5NY1uF+i3noijxyyVdqiU=;
  b=Ddm6+xKpezNLgPDTG1OTOvmlsVpjWw/vODFP2MpfSZGJ3ZRbefrZkDtq
   sBFzmS1JM7A5eTZCftrHine443awNCZTSQ8wIrYPQCckItoej1I0XJrKn
   u48hChPw7DTr18viZdlF7+DAR7ALpgE0udp9EGZfxCdepOaxTPrkVVmYV
   xraPZ2+cmZqhx9hHMQhdzi475aTKOrqlmsMuabYv6BH/KCl2q0M60dSzA
   VhbTmHdgIbkKMKb3GnHypf3KXW8sNsOXneUUChTjutsr3ZfGWj8rNkSYo
   MM3adfh/jCo8p0ry6KpZOCwPNWJIWzuyfXjGGZb3Bwoj2QRbtXfAlNv8/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="317731786"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="317731786"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:44:45 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="553320486"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.192.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:44:44 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/9] selftests: mptcp: Rename wait function
Date: Mon,  7 Mar 2022 12:44:34 -0800
Message-Id: <20220307204439.65164-5-mathew.j.martineau@linux.intel.com>
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

The "selftests: mptcp: improve 'fair usage on close' stability" commit
changed that self test to check the TcpAttemptFails MIB instead of
looking for TW sockets. The associated bash function wasn't renamed in
that commit because of the merge conflicts it would cause, so this
commit updates the function name as Paolo originally intended.

Cc: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 309d06781ae7..d4769bc0d842 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1242,7 +1242,7 @@ chk_link_usage()
 	fi
 }
 
-wait_for_tw()
+wait_attempt_fail()
 {
 	local timeout_ms=$((timeout_poll * 1000))
 	local time=0
@@ -1361,7 +1361,7 @@ subflows_error_tests()
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	# mpj subflow will be in TW after the reset
-	wait_for_tw $ns2
+	wait_attempt_fail $ns2
 	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	wait
 
-- 
2.35.1

