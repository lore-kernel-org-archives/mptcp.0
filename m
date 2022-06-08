Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9933D3
	for <mptcp@lists.linux.dev>; Wed,  8 Jun 2022 19:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654715971; x=1686251971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BQQdLKEaLaTl/b8/Z9nSyx946gsulvh5RHu3JZjqrns=;
  b=IRE3XNYhWsYMr5niS9oA7kTAnBaJEIZOSuiojsqKaUl9RWGIooWGETcL
   DHfoLJsfhy0ph97xrEXc4nor6ngD4S7Xnskv5uQCjdJYi3BP6uthbC5xG
   VdeFTHHMtpJ6t8QORzkV4kzIpMsR/D2LFEKLMwpwLxTymLJS9y9mawuo6
   dtdam0nJjWAXV6wNqGhRN2t/fba/DZM6TaVi6f/7S8Kr5kRDeu0gDXTy1
   AvdIid0uc+3BJ+BDc0H8XoIXgPa1YElq6qitgEA8kxvNWoKfkikNKWNwy
   mg3/or725+ZdED2vPausLqM/5gh6SC6hdeohM940FkrEPDIbz4IfAapmx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="278178192"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="278178192"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 12:19:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="580206809"
Received: from pperi-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.252.138.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 12:19:29 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Ossama Othman <ossama.othman@intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/2] mptcp: fix conflict with <netinet/in.h>
Date: Wed,  8 Jun 2022 12:19:18 -0700
Message-Id: <20220608191919.327705-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220608191919.327705-1-mathew.j.martineau@linux.intel.com>
References: <20220608191919.327705-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ossama Othman <ossama.othman@intel.com>

Including <linux/mptcp.h> before the C library <netinet/in.h> header
causes symbol redefinition errors at compile-time due to duplicate
declarations and definitions in the <linux/in.h> header included by
<linux/mptcp.h>.

Explicitly include <netinet/in.h> before <linux/in.h> in
<linux/mptcp.h> when __KERNEL__ is not defined so that the C library
compatibility logic in <linux/libc-compat.h> is enabled when including
<linux/mptcp.h> in user space code.

Fixes: c11c5906bc0a ("mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support")
Signed-off-by: Ossama Othman <ossama.othman@intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/uapi/linux/mptcp.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 921963589904..dfe19bf13f4c 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -2,16 +2,17 @@
 #ifndef _UAPI_MPTCP_H
 #define _UAPI_MPTCP_H
 
+#ifndef __KERNEL__
+#include <netinet/in.h>		/* for sockaddr_in and sockaddr_in6	*/
+#include <sys/socket.h>		/* for struct sockaddr			*/
+#endif
+
 #include <linux/const.h>
 #include <linux/types.h>
 #include <linux/in.h>		/* for sockaddr_in			*/
 #include <linux/in6.h>		/* for sockaddr_in6			*/
 #include <linux/socket.h>	/* for sockaddr_storage and sa_family	*/
 
-#ifndef __KERNEL__
-#include <sys/socket.h>		/* for struct sockaddr			*/
-#endif
-
 #define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
 #define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
 #define MPTCP_SUBFLOW_FLAG_JOIN_REM		_BITUL(2)
-- 
2.36.1

