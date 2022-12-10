Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1E7E0
	for <mptcp@lists.linux.dev>; Sat, 10 Dec 2022 00:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670632098; x=1702168098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bWlb++TKa7RKfkQ/h17sXifOmIthPO3UjV4NJDbeOrQ=;
  b=EVpfSwU6J5G1fTXJYZktowxJiFRgnsWsGk931yHkhxyt2fR9W2UeKgrQ
   xrWccny+vQLYiPnh7iqUCJqGpeQiSfsu3W4CbyAvvmjdbT4uRRg5CUvJl
   K1VebHc88Cl1DHwR4IikSLSfzLxb0pvezpZjfyVknB66JlhFTKGG12+q5
   dFdr/iqT2UU1iVH66wGY14Gz+BoJ/r038aAvyg9sqVsm1Y75eAfgyXXUX
   8NXUFZ5Vslmv5yXzZSIV/i31OhXNpjvfKTTILrYWV2TMjFro5C4/4wRNx
   JfWWN1H4+kfxrJv9HHst38o+j4RzSC/ILygctxKoKnvri3Mln9KZM0OK0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="381879108"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="381879108"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 16:28:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="649728868"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="649728868"
Received: from hthiagar-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.231.121])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 16:28:16 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	kishen.maloor@intel.com,
	dcaratti@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net 0/4] mptcp: Fix IPv6 reqsk ops and some netlink error codes
Date: Fri,  9 Dec 2022 16:28:06 -0800
Message-Id: <20221210002810.289674-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 adds some missing error status values for MPTCP path management
netlink commands with invalid attributes.

Patches 2-4 make IPv6 subflows use the correct request_sock_ops
structure and IPv6-specific destructor. The first patch in this group is
a prerequisite change that simplifies the last two patches.


Matthieu Baerts (3):
  mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
  mptcp: dedicated request sock for subflow in v6
  mptcp: use proper req destructor for IPv6

Wei Yongjun (1):
  mptcp: netlink: fix some error return code

 include/net/mptcp.h      | 12 ++++++--
 net/ipv4/syncookies.c    |  7 ++---
 net/mptcp/pm_userspace.c |  4 +++
 net/mptcp/subflow.c      | 61 +++++++++++++++++++++++++++++++++-------
 4 files changed, 68 insertions(+), 16 deletions(-)


base-commit: 01de1123322e4fe1bbd0fcdf0982511b55519c03
-- 
2.38.1

