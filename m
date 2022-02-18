Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D36838DA
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 03:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645153406; x=1676689406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/+fdgO+cd1J3Z+MrI8XeZw3LC+mXZz3iq8eO6M0LvQ4=;
  b=DUh6Jhflf8o2uJtdEVBsu+oGy4liFWgIA9GbxZvUOuy5oaH7Kn3VIESK
   wpkpncKn6mKOMFE0TL+OxjTZkGWfR6etuoeCWifUZT/KNWKKbR/R54RLP
   O5bQ8CNKrHhDAnQLClHD10VJMWbkZfwe0cCAio3i6Hm+21JOD4R9nICuU
   TQOndDB7eTP7lf0mpudBMxXig2kA4SJiRIF4PzTAellBvk0gGwklH+4uP
   OCUSge9VjkOrH+xktRiLrm1H30eg13bkPAG30096RYDjMdDRxCxHRZzDD
   j2gZhzIfpLTX2BksyTjDn8aT2WzGcmBgURntvX7WbDkMVTKBNqvoSf1qH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231021633"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="231021633"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="635431885"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.101.109])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:17 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/7] mptcp: Selftest fine-tuning and cleanup
Date: Thu, 17 Feb 2022 19:03:04 -0800
Message-Id: <20220218030311.367536-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 adjusts the mptcp selftest timeout to account for slow machines
running debug builds.

Patch 2 simplifies one test function.

Patches 3-6 do some cleanup, like deleting unused variables and avoiding
extra work when only printing usage information.

Patch 7 improves the checksum tests by utilizing existing checksum MIBs.

Geliang Tang (2):
  selftests: mptcp: simplify pm_nl_change_endpoint
  selftests: mptcp: add csum mib check for mptcp_connect

Matthieu Baerts (5):
  selftests: mptcp: increase timeout to 20 minutes
  selftests: mptcp: join: exit after usage()
  selftests: mptcp: join: remove unused vars
  selftests: mptcp: join: create tmp files only if needed
  selftests: mptcp: join: check for tools only if needed

 .../selftests/net/mptcp/mptcp_connect.sh      |  19 +++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 130 +++++++++---------
 tools/testing/selftests/net/mptcp/settings    |   2 +-
 3 files changed, 85 insertions(+), 66 deletions(-)


base-commit: 2aed49da6c080cbb8e35a39886f513ff97e954b4
-- 
2.35.1

