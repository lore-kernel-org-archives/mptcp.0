Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9207F4ABB
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 23:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647558296; x=1679094296;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qXDnCOOeXlgntrQl4fVszU/j6k30TtQ8TurmELRRKJE=;
  b=ZQh8Oak+aJCXM883EYQ+nbSnmIz/X8Bz5Kwm/W1vgB710Z+2zkUFMzto
   7LGOk98O1ra1MJHPdhszi8VE5yiFYsR8vL/EH46N0kmXo2ZjtM+lx7cwr
   kr5YROYdAkewW8CDHlNnbL7Jt6VLkWGRrYFDioP0f5lcAMACuWMUMiMeK
   iI/fhmhdsMYEUSlDFmY5vnOdf7/rkQAoSZNxphSY1L7jhlJSDGME7Npjz
   P0bEQXX3NXQ2s8zP3q/sweh6Jg+ccF0r8SUffZXmZaH17RZ5zcjRohIgj
   l+uZxvUG4YKb8THoKGY/ATdm+gj8qCNn7R55ECwkZiOhAy3h+VybLEjzJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257189948"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="257189948"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 16:04:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="499015048"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 16:04:55 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 0/6] mptcp: fixes and enhancements related to path management
Date: Thu, 17 Mar 2022 19:04:43 -0400
Message-Id: <20220317230449.763778-1-kishen.maloor@intel.com>
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

v8:
-Fixed logic to achieve the desired outcome of not responding to
address advertisements when a userspace PM is offline.
-Factored out minor changes to mptcp_pm_is_userspace() to be
squashed into an earlier commit.

Kishen Maloor (6):
  Squash-to: mptcp: Bypass kernel PM when userspace PM is enabled
  mptcp: bypass in-kernel PM restrictions for non-kernel PMs
  mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
  mptcp: reflect remote port (not 0) in ANNOUNCED events
  mptcp: establish subflows from either end of connection
  mptcp: expose server_side attribute in MPTCP netlink events

 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/options.c        |  4 ++--
 net/mptcp/pm.c             | 21 +++++++++++++++++----
 net/mptcp/pm_netlink.c     | 24 +++++++++++++++++++++---
 net/mptcp/protocol.c       |  5 +----
 net/mptcp/protocol.h       | 22 ++++++++++++++++------
 net/mptcp/subflow.c        |  5 ++++-
 7 files changed, 62 insertions(+), 20 deletions(-)


base-commit: 2a9f09777d24fc18cc62762b398054d3961ad8bf
--
2.31.1
