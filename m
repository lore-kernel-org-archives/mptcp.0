Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E61173
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 19:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641583554; x=1673119554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C0th8gsROJI3GvC5mmzJikWkPE41uBmnF18Hw9VeCXc=;
  b=W4e3Mr1l3FqduDgQc5vwyreHzvJWaKPDZswjqUJ1h5jv4GXcoxTAJ9f+
   gWZpOPPZYWTLKFV70hhtZC4U3O0RqE4Ber8Fl44jReZptWrPxWlJYoKCf
   l0Zj9BboY9nRQKd8cEtmvext0jie0rGA4R9zYvW4w9L526Lcb/LpXgWEZ
   Ux/+127YMJX4X3zBzd7wol5Ex6Vlq7IFT0ZyKmuBj1eMoZv8jkx2SruV4
   9rRVjaQ7D3Uq+jjxwQsWLtMYsxU4Rhu0q8wvtQkB6o9aNEubFXIOV00At
   FWS61JqDwKjlb3Bs5G4HZ14UeJ0bkxWfVqRoZD0DTBaKp7h0HRPRxwuOI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="240478007"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="240478007"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:25:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="527478584"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.36.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:25:53 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/3] mptcp: Refactoring for one selftest and csum validation
Date: Fri,  7 Jan 2022 11:25:21 -0800
Message-Id: <20220107192524.445137-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few more patches from the MPTCP tree for 5.17, with some refactoring
changes.

Patch 1 changes the MPTCP join self tests to depend more on events
rather than delays, so the script runs faster and has more consistent
results.

Patches 2 and 3 get rid of some duplicate code in MPTCP's checksum
validation by modifying and leveraging an existing helper function.


Geliang Tang (2):
  mptcp: change the parameter of __mptcp_make_csum
  mptcp: reuse __mptcp_make_csum in validate_data_csum

Paolo Abeni (1):
  selftests: mptcp: more stable join tests-cases

 net/mptcp/options.c                           |   8 +-
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/subflow.c                           |  15 +--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 120 ++++++++++--------
 4 files changed, 79 insertions(+), 65 deletions(-)


base-commit: c25af830ab2608ef1dd5e4dada702ce1437ea8e7
-- 
2.34.1

