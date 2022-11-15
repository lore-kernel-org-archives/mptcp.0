Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED148AD0
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 22:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668550253; x=1700086253;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YhR6LLfPRwRi7J/KilLJ/w6vqBuEr/5KVeEOxzYOcuw=;
  b=VLcTPkt+iG7pShUVua0J2jb74frr7qUupSu8b3HGpw3Yq8sfPs16NdBZ
   T3T2WD22R+HFrlVFEIS3uHFplZOxFMfyAA8tpEtddq+6lTNUIrlZ6EkWJ
   8oc6mntiTk2yyIn+AXS2cmK0zKA/lbcdqqh/rjDoSpqmV5uh1R0NXNEMn
   +qovoz1dvmBn7ZyA9TxS3Cz1uVgG2S0lbnNp9F2bPOdwMzxgb/XQg3uJf
   SDQUizg/ndNqP3GcJR3UUMsEBNVKfoUQ0vyMwjGHV8Iu4YKwi74lL58Sh
   fz+CXML1VXmPNQ3zusB2oQ2DJcV1EymZ3Byjmbgzvli45FjMZAO9VtQUf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292089835"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292089835"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:10:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="616917986"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="616917986"
Received: from imunagan-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.21.103])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:10:51 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	geliang.tang@suse.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/3] mptcp: selftests: Fix timeouts and test isolation
Date: Tue, 15 Nov 2022 14:10:43 -0800
Message-Id: <20221115221046.20370-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1 and 3 adjust test timeouts to reduce false negatives on slow
machines.

Patch 2 improves test isolation by running the mptcp_sockopt test in its
own net namespace.

Matthieu Baerts (2):
  selftests: mptcp: run mptcp_sockopt from a new netns
  selftests: mptcp: fix mibit vs mbit mix up

Paolo Abeni (1):
  selftests: mptcp: gives slow test-case more time

 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 6 +++---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 9 +++++----
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 5 +++--
 3 files changed, 11 insertions(+), 9 deletions(-)


base-commit: 9d45921ee4cb364910097e7d1b7558559c2f9fd2
-- 
2.38.1

