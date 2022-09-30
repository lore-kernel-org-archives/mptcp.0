Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F25A66
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664553628; x=1696089628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dQ8gHgXfrlWUWr09xMTVaafO69+hUvU9xOkm3ErfMoQ=;
  b=dtLIby4bbKdB5qpksqj2+W7KIReDtuy0xZzXkoVVokimYd7pfGidfHm1
   VKjee4wcWoRR8X06Hb+uo7q1pgYNgmiaNxqjgSxCaBm9wrJs8R+f/4vF5
   xssgOFSrLxCv7MxsEm4d/JZXwdRE/Txams0twCOGrXbIqllsYprxZs2TH
   xVB0xPAWrue1SJsGWuy0WncQSYDtPQMEoN4i1ZqmAvnz1L59mF9PryAMy
   e8mf1ovuYaEd/Q3XdHYr6gWJNoGrWlo2DsILO5wHDlRPd11QoWaI/LQRo
   PpVmsSmE+una2aiRsUsURl7aK8abxsJKkbx/Tf+oVuv01MtubaP/gjGKG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="289383892"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="289383892"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 09:00:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="655996107"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="655996107"
Received: from cmforest-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.22.5])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 09:00:27 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/4] mptcp: Fastclose edge cases and error handling
Date: Fri, 30 Sep 2022 08:59:30 -0700
Message-Id: <20220930155934.404466-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPTCP has existing code to use the MP_FASTCLOSE option header, which
works like a RST for the MPTCP-level connection (regular RSTs only
affect specific subflows in MPTCP). This series has some improvements
for fastclose.

Patch 1 aligns fastclose socket error handling with TCP RST behavior on
TCP sockets.

Patch 2 adds use of MP_FASTCLOSE in some more edge cases, like file
descriptor close, FIN_WAIT timeout, and when the socket has unread data.

Patch 3 updates the fastclose self tests.

Patch 4 does not change any code, just fixes some outdated comments.

Paolo Abeni (4):
  mptcp: propagate fastclose error
  mptcp: use fastclose on more edge scenarios
  selftests: mptcp: update and extend fastclose test-cases
  mptcp: update misleading comments.

 net/mptcp/protocol.c                          | 124 ++++++++++++------
 .../selftests/net/mptcp/mptcp_connect.c       |  65 +++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh |  90 ++++++++++---
 3 files changed, 217 insertions(+), 62 deletions(-)


base-commit: 0f5ef005310d4820926c76bc1e94d4d2a0e49d97
-- 
2.37.3

