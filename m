Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0650D2F36
	for <mptcp@lists.linux.dev>; Wed,  8 Jun 2022 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654715970; x=1686251970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NgCAFu644p+mL9pknZJLYxOx2NlTb8UgHMuWs+dGx4U=;
  b=l4yuSyQzH6wfKuOFApN8OXtAE9n02TXw57f4Z43s38+gDR2T2ZDt5HQD
   J1Fu3+6+0PkurUWqvGqb9pfW/E9Skrm+vEnqidaZ00y1k9I8RvLf9rtBc
   cV1XaswzJok1XrGEsgeCY1Pw0M9dMQD5s0Zz+LBmkbKcnbniFZVQptGoL
   DmfUhUWt/HDo7wXEDpWrO28bwzFlJ9IKyxzW2e3JUHrug3avoHeYjzBrY
   vF14DigdgFH1e0a4rxmLv5p0mqQBjaa0gBl+UGDGboQdUW+J2AdQY8RLt
   c8jBaJ5H8HBIMJs7nh/S6RfSyGU4jkRxeC0S2cjyrhTWaLEMLHj0zJa/3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="278178188"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="278178188"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 12:19:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="580206806"
Received: from pperi-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.252.138.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 12:19:29 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/2] mptcp: Header fixups
Date: Wed,  8 Jun 2022 12:19:17 -0700
Message-Id: <20220608191919.327705-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 makes the linux/mptcp.h header easier to use in userspace.

Patch 2 cleans up a magic number.


Geliang Tang (1):
  mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h

Ossama Othman (1):
  mptcp: fix conflict with <netinet/in.h>

 include/net/mptcp.h        | 3 ++-
 include/uapi/linux/mptcp.h | 9 +++++----
 net/mptcp/protocol.h       | 1 -
 3 files changed, 7 insertions(+), 6 deletions(-)


base-commit: a84a434baf9427a1c49782fb1f0973d1308016df
-- 
2.36.1

