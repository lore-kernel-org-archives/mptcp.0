Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443ED4C9A
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 22:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645222704; x=1676758704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qF8XU1D4MxIposN0eSHBiLKfhamU+44NYZuTsiWj4Yk=;
  b=XOmXbKBx21dOQxplt8IBWvnLK71uelllZ4+2qzD/psZ9R34bpkNVV8Uc
   aKh5gcV1Soy0goH2etksT1XeunR5zKRenetbr6Y01sLxMZweqEIScKWKJ
   AUPvpCvlt+US5Z/sdHMIxjM30KwUC/TvwULmy7Xmbh0dds1Wxrjamo8g+
   AlbHzdx/0D35sUccE/bfz+MHJNK/fuJ2lwOjaeEy4h0WNR++upV5HpX6R
   S1WA6g65qdPS7hxBZdG88vrDqTgGzcrNWrmQQk96RPK7dvUWiEM1P0EGC
   X6KJ8moFBZZgEF/EXkkqkFjCkxM9MSeoSHyNEvWy6Zlp99GbLLrC2Xc1S
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231857987"
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="231857987"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 14:18:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="542032035"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.65.242])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 14:18:22 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 1/3] Squash to "selftests: mptcp: improve 'fair usage on close' stability"
Date: Fri, 18 Feb 2022 14:18:12 -0800
Message-Id: <20220218221814.72026-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
References: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I modified the patch sent to -net upstream to remove this function
rename, to avoid a net/net-next merge conflict. Rename is restored in a
later patch.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b48b11714817..788aab602d8f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1152,7 +1152,7 @@ chk_link_usage()
 	fi
 }
 
-wait_attempt_fail()
+wait_for_tw()
 {
 	local timeout_ms=$((timeout_poll * 1000))
 	local time=0
@@ -1271,7 +1271,7 @@ subflows_error_tests()
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	# mpj subflow will be in TW after the reset
-	wait_attempt_fail $ns2
+	wait_for_tw $ns2
 	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	wait
 
-- 
2.35.1

