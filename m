Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FF51845
	for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 23:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650409427; x=1681945427;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cUlps6v/lnh5V6hLWijS7y2rQGeWmz8vX1zAPJAoSOU=;
  b=RecKvNFSdE7/qwvtCRrAyOjs65djRw71rjCMIxHsPnNfr+dvx68Dbq+m
   TDSwwFdZskgnEwrTbbZKUkpKS9DUmo6y2fQEWd2gDS+jL9s4GYoo1dj4K
   9CCLuYcKCDpg659bU64wTV8xteqkUZpRU1o+Kzo/7hEFi2dKMPd+puUGh
   lmQr/m5hQNu902NWQKoKLgIg52BWHXms4AtJ9plhAron4dZvn3qaXHBu5
   hB9HKgpHec30MWRSo9B0lbNG5pdVy/iCFu8/dr6cOQJ9T+mI6ILvpBg+h
   /4JriKuqWZWInUpKijzJ0EIHMvxGPS8dq5VZfTaZQk4+RZpgwrMXEt0kZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263654607"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263654607"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:03:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="625832510"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:03:46 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/3] mptcp: fix bug in userspace PM APIs
Date: Tue, 19 Apr 2022 19:03:37 -0400
Message-Id: <20220419230340.2263545-1-kishen.maloor@intel.com>
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
