Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C691108
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650428731; x=1681964731;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LG9jFrkp4duj3xsNBkQOp4aNUvWr+6GbtffN8VaIBlc=;
  b=NmoUvFg5RxB4Ka5WyS6qzyNhW0gN/WTcoug1gRhmMcTzFrFUyicEhC/4
   RQx6Jwj0gj++TGptAgsRo+QfKb2SBNe12ZHerw/xrq6fmBPyNTbcKvnqD
   0mhdOp3mrfrVJV4vIYuD+xtTd+TTnSBbZp/RoZq/Naw2sxVkwOB4j0y3k
   aQysoCD+o24lzLEMlMgxmgrtjPdDYTFYB98bzpknt69D5zIK+kiKSiyNE
   Dy6yJpfopbMM4jVzTHB8k5NrkHm/k47M4mkBVecGX41h2fZqphZervkNA
   hgBwtnYtF4Fltb2H0/ANwzet7OTqWVKrquoEmvo26dFDu9cWs8giDZ027
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="251242269"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="251242269"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 21:25:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="529584144"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 21:25:28 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 0/3] mptcp: fix bug in userspace PM APIs
Date: Wed, 20 Apr 2022 00:25:21 -0400
Message-Id: <20220420042524.2268380-1-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes issue #267:
https://github.com/multipath-tcp/mptcp_net-next/issues/267

Specifically, calls to mptcp_token_get_sock() from userspace PM APIs
hold a reference to the msk which needs to be freed before leaving those
functions. This was causing a memory leak which was caught in
the CI debug build.

v2:
-Fixed code style.

Kishen Maloor (3):
  Squash-to: mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
  Squash-to: mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
  Squash-to: mptcp: netlink: allow userspace-driven subflow
    establishment

 net/mptcp/pm_userspace.c | 93 +++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 40 deletions(-)


base-commit: e561667a821b0ecccba582520829f38da50567a3
--
2.31.1
