Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253BA2C81
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 23:56:44 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="210826412"
X-IronPort-AV: E=Sophos;i="5.87,194,1631602800"; 
   d="scan'208";a="210826412"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 16:56:43 -0700
X-IronPort-AV: E=Sophos;i="5.87,194,1631602800"; 
   d="scan'208";a="487759729"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.3.7])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 16:56:43 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	pabeni@redhat.com,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/2] mptcp: Some selftest improvements
Date: Fri, 29 Oct 2021 16:55:57 -0700
Message-Id: <20211029235559.246858-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are a couple of selftest changes for MPTCP.

Patch 1 fixes a mistake where the wrong protocol (TCP vs MPTCP) could be
requested on the listening socket in some link failure tests.

Patch 2 refactors the simulataneous flow tests to improve timing
accuracy and give more consistent results.


Geliang Tang (1):
  selftests: mptcp: fix proto type in link_failure tests

Paolo Abeni (1):
  selftests: mptcp: more stable simult_flows tests

 .../selftests/net/mptcp/mptcp_connect.c       | 72 +++++++++++++++----
 .../testing/selftests/net/mptcp/mptcp_join.sh |  2 +-
 .../selftests/net/mptcp/simult_flows.sh       | 36 ++++------
 3 files changed, 73 insertions(+), 37 deletions(-)


base-commit: 28131d896d6d316bc1f6f305d1a9ed6d96c3f2a1
-- 
2.33.1

