Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19B70
	for <mptcp@lists.linux.dev>; Tue, 22 Jun 2021 00:33:15 +0000 (UTC)
IronPort-SDR: IIeNIudnEQfXYUJxUGVNAaYf8UjSWe7YQj5CMvPwnzdjvPtSVvUNz6gB0/aSgtOg6si4q/L0ss
 C1hWzQtx4ycQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="292587735"
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="292587735"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 17:33:14 -0700
IronPort-SDR: ifWrKQun0x/KqCSKstUD1fh4aB6zLHqi80f3XYqZpkK1Db6QNvDEKDqy2sazZeWxATB4MW4mnO
 IaFd0flXANXg==
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="417234897"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.74.136])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 17:33:14 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	fw@strlen.de,
	dcaratti@redhat.com
Subject: [PATCH net 0/2] mptcp: Fixes for v5.13
Date: Mon, 21 Jun 2021 17:33:07 -0700
Message-Id: <20210622003309.71224-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.32.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are two MPTCP fixes from Paolo.

Patch 1 fixes some possible connect-time race conditions with
MPTCP-level connection state changes.

Patch 2 deletes a duplicate function declaration.


Paolo Abeni (2):
  mptcp: avoid race on msk state changes
  mptcp: drop duplicate mptcp_setsockopt() declaration

 net/mptcp/protocol.c |  5 +++++
 net/mptcp/protocol.h |  5 ++---
 net/mptcp/subflow.c  | 30 ++++++++++++++++++++++--------
 3 files changed, 29 insertions(+), 11 deletions(-)


base-commit: 0cd58e5c53babb9237b741dbef711f0a9eb6d3fd
-- 
2.32.0

