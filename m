Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55CF6E
	for <mptcp@lists.linux.dev>; Fri, 19 Mar 2021 18:33:11 +0000 (UTC)
IronPort-SDR: gNSU1OarxKFRBDLDalIrFDmm2p+dTqMeY/oizvWc3BLwdllwNev5+LT5LBqKdZRITL26CrD9v2
 mqS+6fBuu6Bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="253947314"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="253947314"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:33:11 -0700
IronPort-SDR: S+RcAbZkdeBj49InRuqX0h8mJj0AF8mD2ivOcPb8a/RHF55gLEB3Re4NkDsfiOCVEqX0vV3xBR
 pD+qPSjBK6TQ==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="406900676"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.255.228.188])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:33:10 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.01.org,
	mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net] mptcp: Change mailing list address
Date: Fri, 19 Mar 2021 11:33:02 -0700
Message-Id: <20210319183302.137063-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mailing list for MPTCP maintenance has moved to the
kernel.org-supported mptcp@lists.linux.dev address.

Complete, combined archives for both lists are now hosted at
https://lore.kernel.org/mptcp

Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d80d3dda3d0..8e43e0417335 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12539,7 +12539,7 @@ NETWORKING [MPTCP]
 M:	Mat Martineau <mathew.j.martineau@linux.intel.com>
 M:	Matthieu Baerts <matthieu.baerts@tessares.net>
 L:	netdev@vger.kernel.org
-L:	mptcp@lists.01.org
+L:	mptcp@lists.linux.dev
 S:	Maintained
 W:	https://github.com/multipath-tcp/mptcp_net-next/wiki
 B:	https://github.com/multipath-tcp/mptcp_net-next/issues

base-commit: c79a707072fe3fea0e3c92edee6ca85c1e53c29f
-- 
2.31.0

