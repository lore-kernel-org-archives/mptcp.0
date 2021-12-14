Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8E92CA4
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 23:16:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="219119103"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="219119103"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 15:16:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="518491434"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.180.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 15:16:09 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/4] mptcp: Fixes for ULP, a deadlock, and netlink docs
Date: Tue, 14 Dec 2021 15:16:00 -0800
Message-Id: <20211214231604.211016-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two of the MPTCP fixes in this set are related to the TCP_ULP socket
option with MPTCP sockets operating in "fallback" mode (the connection
has reverted to regular TCP). The other issues are an observed deadlock
and missing parameter documentation in the MPTCP netlink API.


Patch 1 marks TCP_ULP as unsupported earlier in MPTCP setsockopt code,
so the fallback code path in the MPTCP layer does not pass the TCP_ULP
option down to the subflow TCP socket.

Patch 2 makes sure a TCP fallback socket returned to userspace by
accept()ing on a MPTCP listening socket does not allow use of the
"mptcp" TCP_ULP type. That ULP is intended only for use by in-kernel
MPTCP subflows.

Patch 3 fixes the possible deadlock when sending data and there are
socket option changes to sync to the subflows.

Patch 4 makes sure all MPTCP netlink event parameters are documented
in the MPTCP uapi header.


Florian Westphal (2):
  mptcp: remove tcp ulp setsockopt support
  mptcp: clear 'kern' flag from fallback sockets

Matthieu Baerts (1):
  mptcp: add missing documented NL params

Maxim Galaganov (1):
  mptcp: fix deadlock in __mptcp_push_pending()

 include/uapi/linux/mptcp.h | 18 ++++++++++--------
 net/mptcp/protocol.c       |  6 ++++--
 net/mptcp/sockopt.c        |  1 -
 3 files changed, 14 insertions(+), 11 deletions(-)


base-commit: 3dd7d40b43663f58d11ee7a3d3798813b26a48f1
-- 
2.34.1

