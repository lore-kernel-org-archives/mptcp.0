Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B367C
	for <mptcp@lists.linux.dev>; Fri,  4 Mar 2022 19:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646422603; x=1677958603;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7y/BxYMS9tI6XR3NRSpOEvF3gtB7W3YhNNHW2z4bOH4=;
  b=YdTgb5uUhMBBspmvVNhSAHnWRx1i4ept8kxtpTIsi2tXwf+5jyTUYb0M
   dVlBl8zfu8JUEjp6f0QqFCDUt1PXBiyMzc7kLDg1XkOPXFcCDSO/JQrJ+
   viNqrwUJeHED4NRNl5NQNAa3700ToXwgaRbByGVKowB6dhfJM+klxQw2A
   um+pMJamUI+l9DXLjphYt6LSJekeIMw5tBjdTZofavtLBM7N3WK8RZvNq
   KFhuZ83YGe02g9+mCZ9rNcViyKPNKayfY8kulx41/Oa0EHrOJsV01ojYh
   z7LEudv2QvhZdCJn5MpLysPZVXh4iLjid+eSbKO9vfP5f6p4qE+qjtLpB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="278739500"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="278739500"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:36:42 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552340774"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.225.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:36:42 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 00/11] mptcp: Selftest refinements and a new test
Date: Fri,  4 Mar 2022 11:36:25 -0800
Message-Id: <20220304193636.219315-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1 and 11 improve the printed output of the mptcp_join.sh
selftest.

Patches 2-8 add a test for the MP_FASTCLOSE option, including
prerequisite changes like additional MPTCP MIBs.

Patches 9-10 add some groundwork for upcoming tests.


Geliang Tang (11):
  selftests: mptcp: adjust output alignment for more tests
  mptcp: add the mibs for MP_FASTCLOSE
  selftests: mptcp: add the MP_FASTCLOSE mibs check
  mptcp: add the mibs for MP_RST
  selftests: mptcp: add the MP_RST mibs check
  selftests: mptcp: add extra_args in do_transfer
  selftests: mptcp: reuse linkfail to make given size files
  selftests: mptcp: add fastclose testcase
  selftests: mptcp: add invert check in check_transfer
  selftests: mptcp: add more arguments for chk_join_nr
  selftests: mptcp: update output info of chk_rm_nr

 net/mptcp/mib.c                               |   4 +
 net/mptcp/mib.h                               |   4 +
 net/mptcp/options.c                           |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 271 ++++++++++++++----
 4 files changed, 223 insertions(+), 61 deletions(-)


base-commit: 1039135aedfc5021b4827eb87276d7b4272024ac
-- 
2.35.1

