Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCED3FC1
	for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 23:26:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="214293408"
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="214293408"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 16:26:31 -0700
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="515847895"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.40.105])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 16:26:31 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	geliangtang@xiaomi.com
Subject: [PATCH net-next 0/7] mptcp: Optimize output options and add MP_FAIL
Date: Tue, 24 Aug 2021 16:26:12 -0700
Message-Id: <20210824232619.136912-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set contains two groups of changes that we've been testing in
the MPTCP tree.


The first optimizes the code path and data structure for populating
MPTCP option headers when transmitting.

Patch 1 reorganizes code to reduce the number of conditionals that need
to be evaluated in common cases.

Patch 2 rearranges struct mptcp_out_options to save 80 bytes (on x86_64).


The next five patches add partial support for the MP_FAIL option as
defined in RFC 8684. MP_FAIL is an option header used to cleanly handle
MPTCP checksum failures. When the MPTCP checksum detects an error in the
MPTCP DSS header or the data mapped by that header, the receiver uses a
TCP RST with MP_FAIL to close the subflow that experienced the error and
provide associated MPTCP sequence number information to the peer. RFC
8684 also describes how a single-subflow connection can discard corrupt
data and remain connected under certain conditions using MP_FAIL, but
that feature is not implemented here.

Patches 3-5 implement MP_FAIL transmit and receive, and integrates with
checksum validation.

Patches 6 & 7 add MP_FAIL selftests and the MIBs required for those
tests.


Geliang Tang (5):
  mptcp: MP_FAIL suboption sending
  mptcp: MP_FAIL suboption receiving
  mptcp: send out MP_FAIL when data checksum fails
  mptcp: add the mibs for MP_FAIL
  selftests: mptcp: add MP_FAIL mibs check

Paolo Abeni (2):
  mptcp: optimize out option generation
  mptcp: shrink mptcp_out_options struct

 include/net/mptcp.h                           |  29 +-
 net/mptcp/mib.c                               |   2 +
 net/mptcp/mib.h                               |   2 +
 net/mptcp/options.c                           | 305 +++++++++++-------
 net/mptcp/pm.c                                |   5 +
 net/mptcp/protocol.h                          |  20 ++
 net/mptcp/subflow.c                           |  16 +
 .../testing/selftests/net/mptcp/mptcp_join.sh |  38 +++
 8 files changed, 295 insertions(+), 122 deletions(-)


base-commit: 3a62c333497b164868fdcd241842a1dd4e331825
-- 
2.33.0

