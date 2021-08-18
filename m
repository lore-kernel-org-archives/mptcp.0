Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D83173
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 23:42:48 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="213329550"
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; 
   d="scan'208";a="213329550"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 16:42:47 -0700
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; 
   d="scan'208";a="449944706"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.117.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 16:42:47 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	geliangtang@gmail.com
Subject: [PATCH net 0/2] mptcp: Bug fixes
Date: Wed, 18 Aug 2021 16:42:35 -0700
Message-Id: <20210818234237.242266-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are two bug fixes for the net tree:

Patch 1 fixes a memory leak that could be encountered when clearing the
list of advertised MPTCP addresses.

Patch 2 fixes a protocol issue early in an MPTCP connection, to ensure
both peers correctly understand that the full MPTCP connection handshake
has completed even when the server side quickly sends an ADD_ADDR
option.


Matthieu Baerts (1):
  mptcp: full fully established support after ADD_ADDR

Paolo Abeni (1):
  mptcp: fix memory leak on address flush

 net/mptcp/options.c    | 10 +++-------
 net/mptcp/pm_netlink.c | 44 ++++++++++++------------------------------
 2 files changed, 15 insertions(+), 39 deletions(-)


base-commit: fb4b1373dcab086d0619c29310f0466a0b2ceb8a
-- 
2.33.0

