Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA488F5C
	for <mptcp@lists.linux.dev>; Sat, 22 Oct 2022 00:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666399551; x=1697935551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ert+uCzj8lEVkCVt2SylFgKBcnqr6mCJxyZDd/56H+o=;
  b=eG1WdIeC17r5PhvgL2j4uPQMbqfhc/xtUHOD5ApPl/WHeyQIhNcN632u
   RvpJKhLQ+uFO8WCK/VroofSlKRoLvmi47OuHhOEKq18t2Xc9CSYfe+tsl
   SWdw3lHrS6poFsdb5ieIviuOHgPHeQUyWShzuYdnbv0CsUys6fs4kEvNn
   QxbTGAcC8TI6Rzs9ZKG7aydIw65HFtw46gfEsEMoe9KaGYxRtUfWhSvR1
   SmznvLKnL2XnvFV/nyeDQemJBidYEwj2pp1HmBCihMWveHAqJF1mpKvoa
   OZ85xi0J63hfOrjviGD77DRJOfopCf9hLSIYbEUPbj4am1Z7u1oNjIhOA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308822188"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="308822188"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 17:45:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="581795617"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="581795617"
Received: from tremple-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.81])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 17:45:50 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/3] mptcp: Socket option updates
Date: Fri, 21 Oct 2022 17:45:02 -0700
Message-Id: <20221022004505.160988-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1 and 3 refactor a recent socket option helper function for more
generic use, and make use of it in a couple of places.

Patch 2 adds TCP_FASTOPEN_NO_COOKIE functionality to MPTCP sockets,
similar to TCP_FASTOPEN_CONNECT support recently added in v6.1


Matthieu Baerts (3):
  mptcp: sockopt: make 'tcp_fastopen_connect' generic
  mptcp: add TCP_FASTOPEN_NO_COOKIE support
  mptcp: sockopt: use new helper for TCP_DEFER_ACCEPT

 net/mptcp/sockopt.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)


base-commit: 3bd5549bd479d4451cf20be077fa7646f9ffc56f
-- 
2.38.1

