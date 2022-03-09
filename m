Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F795107
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 19:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646853407; x=1678389407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/Ran1JNyW3eEs7d6BBS1NjHx1jcG0pHnNMJVrGsWSWI=;
  b=c9LNPaE+hLQRh19mNG/I3oB4lZT5J8QqtuOG36dPLVQvGhjjDhd1SZ1S
   mUmTKf/ocb0+v2+PBk9QlQhvzs3DcZcQf9j/GgOipXOKj4gHUEO3+beqi
   a99MYAhCPJPfmDq4hgYfPoGHI9wHU+jGqaLvOfP4syPm/re+WEJL58meK
   HoudBSb285tOSbwBj4uW+2kFI4DVwbuBfjN78OqCe3n1IMj0M9zyILtgh
   lnFYXZje8VYuimtAl6jvlWxIIg3r1stccuh7bwSbczz4fN/KNxzJ7A/r4
   zcBW2WBEO4pOKHtm7L36hX4Plnoq/2Zh58HBrSE0PSuJMGtNOydEwGpLo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255011970"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="255011970"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:16:46 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="495957051"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.194.198])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:16:45 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 00/10] mptcp: selftests: Refactor join tests
Date: Wed,  9 Mar 2022 11:16:26 -0800
Message-Id: <20220309191636.258232-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mptcp_join.sh selftest is the largest and most complex self test for
MPTCP, and it is frequently used by MPTCP developers to reproduce bugs
and verify fixes. As it grew in size and execution time, it became more
cumbersome to use.

These changes do some much-needed cleanup, and add developer-friendly
features to make it easier to see failures and run a subset of the tests
when verifying fixes.


Geliang Tang (1):
  selftests: mptcp: drop msg argument of chk_csum_nr

Matthieu Baerts (9):
  selftests: mptcp: join: define tests groups once
  selftests: mptcp: join: reset failing links
  selftests: mptcp: join: option to execute specific tests
  selftests: mptcp: join: alt. to exec specific tests
  selftests: mptcp: join: list failure at the end
  selftests: mptcp: join: helper to filter TCP
  selftests: mptcp: join: clarify local/global vars
  selftests: mptcp: join: avoid backquotes
  selftests: mptcp: join: make it shellcheck compliant

 .../testing/selftests/net/mptcp/mptcp_join.sh | 2249 +++++++++--------
 1 file changed, 1210 insertions(+), 1039 deletions(-)


base-commit: 24055bb87977e0c687b54ebf7bac8715f3636bc3
-- 
2.35.1

