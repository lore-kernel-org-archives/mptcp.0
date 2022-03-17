Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01344378
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647531302; x=1679067302;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gMTv+B7KdtzmYc8KxHvx924nI4PTSAad8qCDAGYvjLY=;
  b=QZ8C3ZlOd8d27bMVnFy7MlVbIylR4/smPO0+pcGy/IZKZvfcr4fXjgRK
   sp58iRN84zGTp2Dz+O3RAmQ3+NtgVkK6kzdXEoaQAJ84Wo/y2Ch7cuthE
   QipTsCF2A9RjYgIDuWO2L4BaL+2b5Kra/Uw3mX1gsFdIcSwdhxmybmHE0
   Ipn/8FZxf17OhVY27bewcjLHppw41WPdXNFThrBKHWD7DRwvyVfwkuM4A
   UsuYDRlw3JnR2v7bRt1m7rZWI+eVKDfZ4fb5HMufTBl6mXqMMWeasw/Qm
   esJDG0hTTVXN2tEMTeM5GqAnLDb/sd4pPRF22+E33TyAQceCU+usOCyuJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237504876"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="237504876"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 08:35:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516804196"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 08:35:01 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v7 0/5] mptcp: fixes and enhancements related to path management
Date: Thu, 17 Mar 2022 11:34:48 -0400
Message-Id: <20220317153453.665359-1-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series incorporates fixes and enhancements related to
path management over MPTCP connections, particularly in support of
userspace PMs. The changes ensure that the required bits of
information are conveyed through MPTCP netlink events which
would be consumed by the path manager in making its decisions.
Further it adds flexibility in establishing paths and from
both ends of MPTCP connections.

v6:
-Dropped framework and functionality around the use of kernel
listening sockets for receiving MPJs.

v7:
-Fixed bug caught by the CI build.

Kishen Maloor (5):
  mptcp: bypass in-kernel PM restrictions for non-kernel PMs
  mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
  mptcp: reflect remote port (not 0) in ANNOUNCED events
  mptcp: establish subflows from either end of connection
  mptcp: expose server_side attribute in MPTCP netlink events

 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/options.c        |  4 ++--
 net/mptcp/pm.c             | 19 +++++++++++++++----
 net/mptcp/pm_netlink.c     | 22 +++++++++++++++++++---
 net/mptcp/protocol.c       |  5 +----
 net/mptcp/protocol.h       | 22 ++++++++++++++++------
 net/mptcp/subflow.c        |  5 ++++-
 7 files changed, 58 insertions(+), 20 deletions(-)


base-commit: 2a9f09777d24fc18cc62762b398054d3961ad8bf
--
2.31.1
