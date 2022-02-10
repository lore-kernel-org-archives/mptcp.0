Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979ED2F24
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 01:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644456315; x=1675992315;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3rrsnoKd1ZR12c0sFe1pA9AOATsBnXmwt4Bb94WhWLQ=;
  b=DTkzyuuw34VYWI6JBcYGkwP4nm6JxpVQFl+rwF5PhPgaSonliqM0AtPh
   Fi8sNhBkgJyqJRJHTQ/zedVZv2l88b5kZR4LrheT9VpHYclDhT00zv5H4
   zSLJTvBYN0pEq8mSklQQRfeSiGmRfaCI1hnQqXt6hPjO5SvEACj52J9bi
   fAxcd3FElNaEb7kX/H2uOWOMTBeWDDSEGunJHaWB7o+HVDiitIOttZMcF
   Ee/sIcnus108FtIQc8+bXd6lFxesOfjvTYRnsVyWajBwL9T3/DWGmV3Gk
   8OLBcYgi0mVIa2s6ymVm1u8bChumIKBtPfHEAGkhUEg7I7qWCdX+zl1/3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249136290"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="249136290"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 17:25:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="526263243"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.22.101])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 17:25:14 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/2] mptcp: Fixes for 5.17
Date: Wed,  9 Feb 2022 17:25:06 -0800
Message-Id: <20220210012508.226880-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes a MPTCP selftest bug that combined the results of two
separate tests in the test output.

Patch 2 fixes a problem where advertised IPv6 addresses were not actually
available for incoming MP_JOIN requests.

Kishen Maloor (1):
  mptcp: netlink: process IPv6 addrs in creating listening sockets

Matthieu Baerts (1):
  selftests: mptcp: add missing join check

 net/mptcp/pm_netlink.c                          | 8 ++++++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)


base-commit: 3bed06e36994661a75bae6a289926e566b9b3c1a
-- 
2.35.1

