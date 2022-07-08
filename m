Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C754C75
	for <mptcp@lists.linux.dev>; Fri,  8 Jul 2022 23:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657323383; x=1688859383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mLtbgDckIbKax2TRKG/sQfPD3NEQ0gRiAtYmyp8RjqY=;
  b=c4TpUCI1S3W9O/oT/hb/D1gLQufqJe1b9YYUgINHRQw/tjcJp53UtRoS
   z0Zep95FQ2jUDpGiuG0Z1reCerG8jKKTKlkSGBvC+zLxVbt+koBd0zTjm
   e2PUIXxXNLiuHz6a14d6XeBTX5HafFpC3XaFX9v/wgSUwM+ICYW3+X1xv
   HH9raJBzuCryKyWGM4cOZDkMCtdtIWWlh4Xr1UxCG6nl6qoqLSf7RuMU3
   MqZ9v96G7iiPMwmHfoeCRR+TvznKROIVAD6Z06Eb8UGNw1gyW9pILI+dz
   irSvIad/UdsXddn9tCh3Hj0LB30ofypHpTpqod256UN4SBzMlVX7EzjYV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="348372260"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="348372260"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 16:36:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="770933082"
Received: from aroras-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.1.203])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 16:36:14 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kishen.maloor@intel.com,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 2/2] selftests: mptcp: validate userspace PM tests by default
Date: Fri,  8 Jul 2022 16:36:10 -0700
Message-Id: <20220708233610.410786-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220708233610.410786-1-mathew.j.martineau@linux.intel.com>
References: <20220708233610.410786-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

The new script was not listed in the programs to test.

By consequence, some CIs running MPTCP selftests were not validating
these new tests. Note that MPTCP CI was validating it as it executes all
.sh scripts from 'tools/testing/selftests/net/mptcp' directory.

Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index f905d5358e68..48a99e1453e1 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -6,7 +6,7 @@ KSFT_KHDR_INSTALL := 1
 CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
-	      simult_flows.sh mptcp_sockopt.sh
+	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
 
-- 
2.37.0

