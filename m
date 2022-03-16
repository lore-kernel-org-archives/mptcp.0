Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9038F5
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 19:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647457679; x=1678993679;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SiMwQJtvXSS5lABJn8EVbgy6f48SRC8ArN8F40IcG54=;
  b=ZIv8BXCJ1YomIZzQeA16aE+AWfT0bqFyQDAvkp5wqroYnAGnXsbsWj8W
   dmDiO97wA13zsy36zw/5pb9gIurn/aBbGyjOqoYb/IhNXTf9VDkzvetVN
   oe72165c1L1Gz34NoB1FMPSFdvJ8oisgOJnuW9VJGXkDBruJoUw4mse02
   7RhDUxwECActYkp42f0XSXuuUzjQ6NlLH5XB8GManp3zzABpJT7O2U+9G
   SAHDfXPooRfSIaDVSGfW6ht8T4LBJl1jfiMbxMTHZRUvOPKP5zTbzKUs8
   aFNQ0tP5NH8i8laLUgvSAAZQRtKo4OhUR85ARycq/TfxuafCw/QwYQeQb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="255521706"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="255521706"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:07:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="644799801"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:07:57 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/5] mptcp: fixes and enhancements related to path management
Date: Wed, 16 Mar 2022 15:07:42 -0400
Message-Id: <20220316190747.634325-1-kishen.maloor@intel.com>
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

Kishen Maloor (5):
  mptcp: bypass in-kernel PM restrictions for non-kernel PMs
  mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
  mptcp: reflect remote port (not 0) in ANNOUNCED events
  mptcp: establish subflows from either end of connection
  mptcp: expose server_side attribute in MPTCP netlink events

 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/options.c        |  4 ++--
 net/mptcp/pm.c             | 21 ++++++++++++++++-----
 net/mptcp/pm_netlink.c     | 22 +++++++++++++++++++---
 net/mptcp/protocol.c       |  5 +----
 net/mptcp/protocol.h       | 22 ++++++++++++++++------
 net/mptcp/subflow.c        |  5 ++++-
 7 files changed, 59 insertions(+), 21 deletions(-)


base-commit: 2a9f09777d24fc18cc62762b398054d3961ad8bf
--
2.31.1
