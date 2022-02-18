Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02964C92
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 21:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645220152; x=1676756152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Uud2yottizEiH9vgn0GKtF6C9QDDmBYtoR12teTdeM=;
  b=cRgo0qPEyZ7GumwOcnmFq112qLk2gg2f8F9hFwTS9U/hsD/7tPy6unU+
   PEcFgb5qw9IXPQFB12Z1lC8u/MylY6e8rS00te4fpksXXzGI+Gzdi6Jd+
   WFWerboVDkTSvNW4iqcFBcEI57reblaiYgA07SLGJP7BZrUgk4aRrOHhj
   yVNhjkSaf5gCzrWi4a+emxzdUmp4PtVnG+1ZJPY0cF773Z4DMHZysrVJF
   ODp1ngrwEfMqD6pywcjtU7xTNjAAOT8VO7djMH3VY6D9fmSaLhfXuD241
   l0uuvsKeyuVfHtGv762ohPDjNaqM3v92Ma87T1XdaGOKa/R98N46tnLbm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="238639219"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="238639219"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:35:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="605664069"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.65.242])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:35:51 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	geliang.tang@suse.com,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 2/7] selftests: mptcp: improve 'fair usage on close' stability
Date: Fri, 18 Feb 2022 13:35:39 -0800
Message-Id: <20220218213544.70285-3-mathew.j.martineau@linux.intel.com>
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

The mentioned test has to wait for a subflow creation failure.
The current code looks for TCP sockets in TW state and sometimes
misses the relevant event. Switch to a more stable check, looking
for the associated mib counter.

Fixes: 46e967d187ed ("selftests: mptcp: add tests for subflow creation failure")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/257
Reported-and-tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c0801df15f54..10b3bd805ac6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -961,7 +961,7 @@ wait_for_tw()
 	local ns=$1
 
 	while [ $time -lt $timeout_ms ]; do
-		local cnt=$(ip netns exec $ns ss -t state time-wait |wc -l)
+		local cnt=$(ip netns exec $ns nstat -as TcpAttemptFails | grep TcpAttemptFails | awk '{print $2}')
 
 		[ "$cnt" = 1 ] && return 1
 		time=$((time + 100))
-- 
2.35.1

