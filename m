Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FDF7A
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 01:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656378174; x=1687914174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EJvn72C9iNx1ZNK7vsLL/vNLnYeIv6S01w9Gf9NZz9M=;
  b=iwou9q2yYAME3zm1cHyA+i3f8OeHaOeJMd4fnyD8/dFeTO5VUBjVlK/Y
   L4H3y6wQvRtbfWN3PxfMaKGVvDR8htPLFxM1SeL2TvGphd5OcaI00RHgj
   Kfh7fempnCCdQX7p1mTPQLsjAf4MBC7lMxYCKROzw/2g5JEcIP3Ctw9cL
   q8FETus1Oe+2l/XjOAN5KEyT25VL1w3vnHOSZe3WJZtgK3T2PcbzH57xf
   5k79HpZP8dJLxjkhPNcpuZXC9GvrB0Ss1oV9EbHnWwioIJ8VqocU1YIjx
   Gwq/2w6h1ONPphaVMwBd6qjkCKO9xQgwtxRLc0c90GF0pLauWacbMjlSg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270347726"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270347726"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:02:52 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="692867420"
Received: from cgarner-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.0.217])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:02:51 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Ossama Othman <ossama.othman@intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	geliang.tang@suse.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 8/9] mptcp: fix conflict with <netinet/in.h>
Date: Mon, 27 Jun 2022 18:02:42 -0700
Message-Id: <20220628010243.166605-9-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220628010243.166605-1-mathew.j.martineau@linux.intel.com>
References: <20220628010243.166605-1-mathew.j.martineau@linux.intel.com>
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
2.37.0

