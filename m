Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC07194
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 18:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668797174; x=1700333174;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NLcIs5XItOiEJ9H5WtVJylx2BC7kGSi6m5yYiqOJlQc=;
  b=lPbuHDeCp8kl46U6mR8rYLIddMQZYumruQqwwqQDYhdgtrGyvBWa+LRr
   U56o468nHmuE4NJtEXn38Y7CywvR1w1sO2b1y/CAzwSz0Y7/FJORtJ87b
   rn4tsdjuDp2Pj4kvOzpJBa/QCvlkxmGBZbPzQx9jkrp3VlQZ9W1CBBEcm
   xPX0xBfZOIkzW7Cso1XngGecb7dG/MxMsZvlLNbSqFfwtoJFV/888kPy3
   117WAjnRHYyCeJRK67EwbH/c49ahoUI36nTL8tu93s8cdMupORlopnPCD
   fPpInvbtv07MnM/Q45Evca4N8Vwfaxs0zblU4iTXcfdE88qV9IPdxuXdw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="314356548"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="314356548"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:46:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="746102224"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="746102224"
Received: from mjenkins-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.47.242])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:46:13 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/2] mptcp: More specific netlink command errors
Date: Fri, 18 Nov 2022 10:46:06 -0800
Message-Id: <20221118184608.187932-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series makes the error reporting for the MPTCP_PM_CMD_ADD_ADDR netlink
command more specific, since there are multiple reasons the command could
fail.

Note that patch 2 adds a GENL_SET_ERR_MSG_FMT() macro to genetlink.h,
which is outside the MPTCP subsystem.


Patch 1 refactors in-kernel listening socket and endpoint creation to
simplify the second patch.

Patch 2 updates the error values returned by the in-kernel path manager
when it fails to create a local endpoint.


Paolo Abeni (2):
  mptcp: deduplicate error paths on endpoint creation
  mptcp: more detailed error reporting on endpoint creation

 include/net/genetlink.h |  3 +++
 net/mptcp/pm_netlink.c  | 59 ++++++++++++++++++-----------------------
 2 files changed, 29 insertions(+), 33 deletions(-)


base-commit: ab0377803dafc58f1e22296708c1c28e309414d6
-- 
2.38.1

