Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D624C72
	for <mptcp@lists.linux.dev>; Fri,  8 Jul 2022 23:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657323382; x=1688859382;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EYM3dMFqjlVHn6LqIw1/xdSb4hfj52ET+Bxqsfzd0rM=;
  b=J0YCLDQgSiKlB/AT9tosoHbfj9VX8lvsver9zmsZTvKjq/w7R9jSWqyO
   HkwyUdcnB0J6Dq/sCD+IhonWPkY785r23l5DsX7klGvXmBgn+Wpx6S5s7
   9XR3IHIbe27yGVcvAERKoU1sUVHUt/9UpjFiBsb4v75VWtatzMfgiL4P0
   eqOPA0IcrN72QBjQGOLCQNKZrRQuQJ89qWsC7kL3mLPlBbqikOF6QoDYK
   fUPRPw/y5QInY6BnQnNr6P/58fhSJ32vp5f67tLK+g/ycCuG6pZ3nv3JN
   a5nbV7TQhC643OjueRfG9zwktGautZMafNdmKWbIcjMZ7tlf9rMB0MWOn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="348372257"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="348372257"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 16:36:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="770933076"
Received: from aroras-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.1.203])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 16:36:14 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kishen.maloor@intel.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/2] mptcp: Disconnect and selftest fixes
Date: Fri,  8 Jul 2022 16:36:08 -0700
Message-Id: <20220708233610.410786-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 switches to a safe list iterator in the MPTCP disconnect code.

Patch 2 adds the userspace_pm.sh selftest script to the MPTCP selftest
Makefile, resolving the netdev/check_selftest CI failure.

Matthieu Baerts (1):
  selftests: mptcp: validate userspace PM tests by default

Paolo Abeni (1):
  mptcp: fix subflow traversal at disconnect time

 net/mptcp/protocol.c                       | 4 ++--
 tools/testing/selftests/net/mptcp/Makefile | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)


base-commit: 32b3ad1418ea53184ab7d652f13b5d66414d1bba
-- 
2.37.0

