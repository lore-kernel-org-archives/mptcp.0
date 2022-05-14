Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE88362
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 00:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652487681; x=1684023681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v1FFDOLl/1CoYQYN6VQ020lcKIZK0JmY0EcIXIIcmg8=;
  b=HEW/BppdHHj/UhmISBiTq07BYkHiFl7oMqfIB36c5/nIYOkkIIl/H2uf
   JBJA6zVzQ0HX2ZF+MUmb8LiSj0lgbahEyundzrVl3HjrQboV6aS337ZuQ
   EiiEZ132TGLNET7Afh0WrE79i/zbzQc8TnctpqFzFJ09CbqwpbIRIsk3e
   ra05oH+1BdOAH1b2z64XSaeJ1y6o0Q2qCqDF025I+1IzX5d6m53oE5i+S
   6gYbTam48CHOBLAUOyVHZx+OVvSItI+C/vZLxScf98r7kQEvqXqrej7pM
   CsR0fwQ1oXxUD/8TCVvCHJ2GphOGAtT5qPpR4HEIJAGuHShsapy6WSqt3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="250349592"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="250349592"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 17:21:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="625102781"
Received: from clakshma-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.160.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 17:21:20 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/3] mptcp: Updates for net-next
Date: Fri, 13 May 2022 17:21:12 -0700
Message-Id: <20220514002115.725976-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three independent fixes/features from the MPTCP tree:

Patch 1 is a selftest workaround for older iproute2 packages.

Patch 2 removes superfluous locks that were added with recent MP_FAIL
patches.

Patch 3 adds support for the TCP_DEFER_ACCEPT sockopt.


Florian Westphal (1):
  mptcp: sockopt: add TCP_DEFER_ACCEPT support

Geliang Tang (1):
  selftests: mptcp: fix a mp_fail test warning

Paolo Abeni (1):
  Revert "mptcp: add data lock for sk timers"

 net/mptcp/protocol.c                            | 12 ------------
 net/mptcp/sockopt.c                             | 15 +++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  1 +
 3 files changed, 16 insertions(+), 12 deletions(-)


base-commit: 2c5f1536473b7530adefd09a25cf3fef2cfe01f2
-- 
2.36.1

