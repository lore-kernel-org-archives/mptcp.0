Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246210F6
	for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 00:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645750388; x=1677286388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oKM2fvwOsoxNYiRY2TPnQn4Ts4UIqfnrnhTuR2TshaM=;
  b=Q3f9EfPSZXmeoP+GjSqLyjXJl0mgbx6K3p33fVGrhSucwUEefLRfM4PQ
   AD9uG8/hXL+tw71w3QXZ4AWYuvVqCfvhm2iHt9bXmAE2uimm4m+sEYAOT
   VvoVag4LP6L1d0iQpsC7WNQg2Bfrh2XhoYp6xaA2m8rKF8AArfiJkon+N
   uFGgS6AyMYpkzMBXIk5CIeadhGJltyvM/u67W8IiqudQNUeB8w+8ZLi0n
   cRV+TRa7ZkSvx/2lHk6531BZ+RHf7fRy4PUTxxEm50cwXrk7GTP3oNefI
   rSgKxOLmO04jCIA22TKxR96YIh3cr8v53Mq4sJOEFlgtoEQWaDDT9qGSC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252117839"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="252117839"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:53:05 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="638050200"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.28.67])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:53:05 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 2/3] selftests: mptcp: do complete cleanup at exit
Date: Thu, 24 Feb 2022 16:52:58 -0800
Message-Id: <20220225005259.318898-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225005259.318898-1-mathew.j.martineau@linux.intel.com>
References: <20220225005259.318898-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

After commit 05be5e273c84 ("selftests: mptcp: add disconnect tests")
the mptcp selftests leave behind a couple of tmp files after
each run. run_tests_disconnect() misnames a few variables used to
track them. Address the issue setting the appropriate global variables

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index cb5809b89081..f0f4ab96b8f3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -763,8 +763,8 @@ run_tests_disconnect()
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-I 3 -i $old_cin"
 
 	# restore previous status
-	cout=$old_cout
-	cout_disconnect="$cout".disconnect
+	sin=$old_sin
+	sin_disconnect="$cout".disconnect
 	cin=$old_cin
 	cin_disconnect="$cin".disconnect
 	connect_per_transfer=1
-- 
2.35.1

