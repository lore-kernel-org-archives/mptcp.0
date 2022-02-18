Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154074373
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 03:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645153410; x=1676689410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rJcUjjhStw1S/M4Ov0UOD4j8IEQ/i/HzgPMq0VdQJRk=;
  b=L5iXO7N34UQ8/SU40YCBhlKC8amFleVZ9ecK0WgPHcIUCuBAK3bhRB3l
   seqe9iW9wvu6P9qVzBI+19bCp0dFNz+vG555rqpraU7wEs/O/7wjyBWTL
   mUa+x/g7S/LAo32e0WT1XCp6jDVrNVMnGN5ovV1xn9ABOlix1KHMVJvL/
   Yrh7klYjy4qyjy4sBx/LjySJor5j8T5+F3AD+GQd2BDh5CDATZWIfzgdZ
   uAqIm6N/7rggn3aCHzaozuV1Yd+L5kn+zaVjfm6Mt2EF5L+NpD2p11JvK
   VMdRH1+uc4AMpOADHKVEh6NJ1CGi+7F2k2Kt39PhbURyLybcsCf0fPSO+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231021635"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="231021635"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="635431891"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.101.109])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:17 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/7] selftests: mptcp: increase timeout to 20 minutes
Date: Thu, 17 Feb 2022 19:03:05 -0800
Message-Id: <20220218030311.367536-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218030311.367536-1-mathew.j.martineau@linux.intel.com>
References: <20220218030311.367536-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

With the increase number of tests, one CI instance, using a debug kernel
config and not recent hardware, takes around 10 minutes to execute the
slowest MPTCP test: mptcp_join.sh.

Even if most CIs don't take that long to execute these tests --
typically max 10 minutes to run all selftests -- it will help some of
them if the timeout is increased.

The timeout could be disabled but it is always good to have an extra
safeguard, just in case.

Please note that on slow public CIs with kernel debug settings, it has
been observed it can easily take up to 45 minutes to execute all tests
in this very slow environment with other jobs running in parallel.
The slowest test, mptcp_join.sh takes ~30 minutes in this case.

In such environments, the selftests timeout set in the 'settings' file
is disabled because this environment is known as being exceptionnally
slow. It has been decided not to take such exceptional environments into
account and set the timeout to 20min.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/settings b/tools/testing/selftests/net/mptcp/settings
index a62d2fa1275c..79b65bdf05db 100644
--- a/tools/testing/selftests/net/mptcp/settings
+++ b/tools/testing/selftests/net/mptcp/settings
@@ -1 +1 @@
-timeout=600
+timeout=1200
-- 
2.35.1

