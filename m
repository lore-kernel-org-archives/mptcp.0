Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7882C80
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 22:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641506804; x=1673042804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3lN9yvtAafUPvnEzs7lrByK8xJf6zwrWM3K7chapWrE=;
  b=ADGx5yigQaBbuy0GenC/1rVO6Z6cYcfaHtV8TY8fkyQ1ZJSSrkTQ5h0I
   YRkdLQ1OnlPqDDwHJv1eTX1zrtn23oObFVEmSL9WMy+2pI2sBuhSprM3J
   nwn9akqutrd9DM+DzT3I23Qzjn1BZMpEqLA9YYjce0emJCNow0X1vRtl5
   ECrNF+OiEcqtkwkyioVnW5VOCjSHB8l257yNUH50NijITrr15foPah9KH
   x7JF96gwa03/mvWGLV/1djBSf/TTBbRs0NCPwVmV6xKWPm23JYA+HCFaw
   MWaUuVDPdLtwDm33/QTuGGwjHWY/eDJoWtBY9SzFvhGYX8S0MtQM8uh+8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240303704"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="240303704"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 14:06:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="618479812"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.94.200])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 14:06:43 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	geliang.tang@suse.com
Subject: [PATCH net 0/3] mptcp: Fixes for buffer reclaim and option writing
Date: Thu,  6 Jan 2022 14:06:35 -0800
Message-Id: <20220106220638.305287-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are three fixes dealing with a syzkaller crash MPTCP triggers in
the memory manager in 5.16-rc8, and some option writing problems.

Patches 1 and 2 fix some corner cases in MPTCP option writing.

Patch 3 addresses a crash that syzkaller found a way to trigger in the mm
subsystem by passing an invalid value to __sk_mem_reduce_allocated().


Geliang Tang (1):
  mptcp: fix a DSS option writing error

Mat Martineau (1):
  mptcp: Check reclaim amount before reducing allocation

Matthieu Baerts (1):
  mptcp: fix opt size when sending DSS + MP_FAIL

 net/mptcp/options.c  | 10 +++++++---
 net/mptcp/protocol.c |  4 +++-
 2 files changed, 10 insertions(+), 4 deletions(-)


base-commit: 36595d8ad46d9e4c41cc7c48c4405b7c3322deac
-- 
2.34.1

