Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8C4C68
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 21:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645220151; x=1676756151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uyPc/EBgzWTl0ZgbPCImCzWB00l72z32DRJocdmpAs8=;
  b=YirxUeFvONBNemusauTkycQwX0/rMrQ3qNQDNiBeL4eH7obKV3HUUj36
   3F83y4ETHhAdzoXSl5OYPDiPde2FL7GYp32tbPT9+iPnAUB/15UU7I6p1
   Ma3TwG0yFTK9YaymNZklI1apZNDMJq3P1Zwc2UqLwvAk2GmoZiy68n7xp
   InCKwSWu1dnls5MvV0m17zb6kjzQ+fanNADrl8cRqnleJPZyeiNN4TosN
   KPij4sYa7a98f/f4xkUa8+k+nSXB89fhxbnDCp4t6LbuM7aBRzHWX1viz
   HuigupfTsp0ogFuO2rbUl4rTo99nYpi98Xz6i1NLQAUNtb+b5rjS2Q88U
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="238639215"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="238639215"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:35:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="605664067"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.65.242])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:35:50 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	pabeni@redhat.com,
	geliang.tang@suse.com,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/7] mptcp: Fix address advertisement races and stabilize tests
Date: Fri, 18 Feb 2022 13:35:37 -0800
Message-Id: <20220218213544.70285-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1, 2, and 7 modify two self tests to give consistent, accurate
results by fixing timing issues and accounting for syncookie behavior.

Paches 3-6 fix two races in overlapping address advertisement send and
receive. Associated self tests are updated, including addition of two
MIBs to enable testing and tracking dropped address events.


Paolo Abeni (7):
  selftests: mptcp: fix diag instability
  selftests: mptcp: improve 'fair usage on close' stability
  mptcp: fix race in overlapping signal events
  mptcp: fix race in incoming ADD_ADDR option processing
  mptcp: add mibs counter for ignored incoming options
  selftests: mptcp: more robust signal race test
  selftests: mptcp: be more conservative with cookie MPJ limits

 net/mptcp/mib.c                               |  2 +
 net/mptcp/mib.h                               |  2 +
 net/mptcp/pm.c                                |  8 +++-
 net/mptcp/pm_netlink.c                        | 29 +++++++++---
 tools/testing/selftests/net/mptcp/diag.sh     | 44 ++++++++++++++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 32 +++++++++++---
 6 files changed, 96 insertions(+), 21 deletions(-)


base-commit: b352c3465bb808ab700d03f5bac2f7a6f37c5350
-- 
2.35.1

