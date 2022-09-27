Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD614A18
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 19:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664307326; x=1695843326;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TNynad7WHchlnr6dBc498lQX/b1g9UiDwQW5y223KoE=;
  b=e1ZSewcQS1EJn99Q4USD+lYK5rCNy08rLtvo+JVkUdw5IfR3R88tbfMA
   eY798j75A4gkebNBYTNELJEXXpVAHEFLckuIHwVJUkedA+SmzNfDuyELV
   B8HW2P+78j6q6+7ajC0ey8B1f440d7SS+qtFsweHECWF/eKrG3wEyX3+W
   Yv46AzJz4XmUpplvBvFs0LMs0Z7WwNF4c2jYrf2SZ/XP922zlrbLwb4H5
   VcfZ4nB9jyZVhpTa6KR8dGeN1fTGB6gaFnnnU+XLf2BdkM0HcY+pXkKLp
   EWy1Qi5eryHYmegfefn7K+ZP4DQfVishTWCuRzzqUO7Y9h5NiFyOs/JUo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281782523"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="281782523"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:32:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="652399446"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="652399446"
Received: from soumiban-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.81.98])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:32:03 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/2] mptcp: Properly clean up unaccepted subflows
Date: Tue, 27 Sep 2022 12:31:56 -0700
Message-Id: <20220927193158.195729-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 factors out part of the mptcp_close() function for use by a caller
that already owns the socket lock. This is a prerequisite for patch 2.

Patch 2 is the fix that fully cleans up the unaccepted subflow sockets.

Menglong Dong (2):
  mptcp: factor out __mptcp_close() without socket lock
  mptcp: fix unreleased socket in accept queue

 net/mptcp/protocol.c | 16 +++++++++++++---
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 33 +++++++--------------------------
 3 files changed, 22 insertions(+), 29 deletions(-)


base-commit: 797666cd5af041ffb66642fff62f7389f08566a2
-- 
2.37.3

