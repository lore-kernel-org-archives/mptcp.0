Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7E20E1
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 22:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666393142; x=1697929142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CHMtahEpEz5Zi5dx1eMAFpy1kqoG1TwtUkIb6zRQVQA=;
  b=XK0VaMFj8MRLUr1GPbdAlJKhP17mz1ZWULUOaDOopXdFayc6hfpxlhBB
   KqnwhfXrTIrpaHT0ShgXuqAV5dXFL928arKYyv2JyBeAagFWy17i19xtT
   CY6tx7mESUh3dJeNzbVuouDW3ONbaMyimDJ1XV17Dph7yc+zapNFO69FK
   qq55WnMSE143CuNaclBykbf9XtTT2WkXGt45Flcp8JiFGD0rVC4O8QjMu
   BFJuzQGy7wFjO1H6XGW/k/1WPctdSn20qy/xkm8epCG06TNmUbyncLe5S
   CAah+2FDF8kxeLmgjOwyfnDLOkUQIe5/mThLcNFpeNXMvjfqnHVG4NL14
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="333699090"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="333699090"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:59:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="663928729"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="663928729"
Received: from tremple-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.81])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:59:01 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dmytro@shytyi.net,
	benjamin.hesmans@tessares.net,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/3] mptcp: Fixes for 6.1
Date: Fri, 21 Oct 2022 15:58:53 -0700
Message-Id: <20221021225856.88119-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes an issue with assigning subflow IDs in cases where an
incoming MP_JOIN is processed before accept() completes on the MPTCP
socket.

Patches 2 and 3 fix a deadlock issue with fastopen code (new for 6.1) at
connection time.

Paolo Abeni (3):
  mptcp: set msk local address earlier
  mptcp: factor out mptcp_connect()
  mptcp: fix abba deadlock on fastopen

 net/mptcp/protocol.c | 182 ++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |   5 +-
 net/mptcp/subflow.c  |   7 ++
 3 files changed, 113 insertions(+), 81 deletions(-)


base-commit: 4d814b329a4d54cd10eee4bd2ce5a8175646cc16
-- 
2.38.1

