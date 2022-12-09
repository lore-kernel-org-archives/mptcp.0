Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DF7E
	for <mptcp@lists.linux.dev>; Fri,  9 Dec 2022 00:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670546677; x=1702082677;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WpCZuEoj9S+cdDYyVkX372txxL33h20MU9oS7XPvEk0=;
  b=VwLvM0/lQNCnDQ8VXif8Ojqo0dqFBXoE/DFILX8zc8woCAgiOt8CuX4L
   So15UAGKrB0t4LgrjDTt1zPGup99EPzKEEC3Cpvz7VA8TjK+YXA2V2HnR
   pDiie8uaseBbz9h26Vtxn/hMFLtQhWS9VJE7ffXtgbgrX0ot4YHGVig9s
   BzC0XIwdw5V4SjKVDE34cqsGhJCiLduHTCRYbQ1erheM9G2gvuBj8GvcM
   bXuEeWWu6kcsXcG4G7B5xibqKAS7kIrB5LbniwWgwcpUBe08Ey3R5CfJn
   apVEXfujWtfbmHxMk1peTWAQZzQnYJYRa01mGF7duNHi3TuY6ndSEPxhL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="317367574"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="317367574"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 16:44:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="736027000"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="736027000"
Received: from mchombea-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.102.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 16:44:36 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/2] mptcp: Miscellaneous cleanup
Date: Thu,  8 Dec 2022 16:44:29 -0800
Message-Id: <20221209004431.143701-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two code cleanup patches for the 6.2 merge window that don't change
behavior:

Patch 1 makes proper use of nlmsg_free(), as suggested by Jakub while
reviewing f8c9dfbd875b ("mptcp: add pm listener events").

Patch 2 clarifies success status in a few mptcp functions, which
prevents some smatch false positives.

Geliang Tang (1):
  mptcp: use nlmsg_free instead of kfree_skb

Matthieu Baerts (1):
  mptcp: return 0 instead of 'err' var

 net/mptcp/pm_netlink.c | 12 ++++++------
 net/mptcp/sockopt.c    |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)


base-commit: ff36c447e2330625066d193a25a8f94c1408d9d9
-- 
2.38.1

