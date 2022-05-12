Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950A2F28
	for <mptcp@lists.linux.dev>; Thu, 12 May 2022 23:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652398025; x=1683934025;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GNV+LO1ybpOWHmQ4r6igGS0ARXXbp9yywJBUY7nXGHI=;
  b=TqSV0TnH0GBoq8VSRnlUaZAugV8c1BgXszeeecSVPOcmHArhTbCv1QOP
   aZrD72nIGnfw4zkd7LTXMIOnAzUu7Tb+EldLAxn+oSS5JSh+xRvuTGyGj
   dz8UykmjHKmRJGZf1DnwBXwUrn9TELszMnS0i2eD69xpmnsrqXQ7KCDra
   wXN1obequoMuQZ1jo3IdAQTRmwZB4Siw1PpZLj1AVAS4U7iL3SYuXSJZ/
   0SYsIaVKfQiXZlc87JILyDXdNlJrNUDpV6moMxlCUVBHvaCccpeDV96eo
   1D9bqI6+5aaMA2qGgUJ0CbJKMt9G0S1/Hzvb0yK0OvErDpoQwUXk0yydv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="356590478"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="356590478"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 16:26:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="739919553"
Received: from cmokhtar-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.36.250])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 16:26:47 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/2] mptcp: Subflow accounting fix
Date: Thu, 12 May 2022 16:26:40 -0700
Message-Id: <20220512232642.541301-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains a bug fix affecting the in-kernel path manager
(patch 1), where closing subflows would sometimes not adjust the PM's
count of active subflows. Patch 2 updates the selftests to exercise the
new code.

Paolo Abeni (2):
  mptcp: fix subflow accounting on close
  selftests: mptcp: add subflow limits test-cases

 net/mptcp/pm.c                                |  5 +-
 net/mptcp/protocol.h                          | 14 ++++++
 net/mptcp/subflow.c                           | 12 +++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 48 ++++++++++++++++++-
 4 files changed, 71 insertions(+), 8 deletions(-)


base-commit: f3f19f939c11925dadd3f4776f99f8c278a7017b
-- 
2.36.1

