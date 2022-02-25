Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3310EF
	for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 00:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645750387; x=1677286387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Omi3XQHIC7kCcULuYJcgiYxsXqqdpxDfRMdsvBKd/jM=;
  b=n2CKVu1Ru/dWgg2Tkzmbobr60j7nyCj8KUmTHxil0AlEiefvyHBPGDkt
   pwAmvXkFBURNoYySLXUCmPNJEoRLRE1Zs+841LPp0w0S+Ydw8+Fy98btC
   6LU3VZurjyLb10wE/WagLVaK4rA5nzK5ogz/bkpw3K5CV4XpIQL3g8AvI
   51+a707+VO61qWG52ojjP1DwSJJWe+iY1THJkJokz2eFjU8+GDpcWKQA/
   TxFXSPHoa4VBsOsLQs2HKvqbQDQLYzLYGbWpZTdZWRiSrM2nJZyOaNDAp
   //KTLb7Tt/tFKWycD/3Rx0Bd63nto7ikB+qwHQq8okf38fvvz6PiOyIQv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252117834"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="252117834"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:53:04 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="638050197"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.28.67])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:53:04 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/3] mptcp: Fixes for 5.17
Date: Thu, 24 Feb 2022 16:52:56 -0800
Message-Id: <20220225005259.318898-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes an issue with the SIOCOUTQ ioctl in MPTCP sockets that
have performed a fallback to TCP.

Patch 2 is a selftest fix to correctly remove temp files.

Patch 3 fixes a shift-out-of-bounds issue found by syzkaller.

Mat Martineau (1):
  mptcp: Correctly set DATA_FIN timeout when number of retransmits is
    large

Paolo Abeni (2):
  mptcp: accurate SIOCOUTQ for fallback socket
  selftests: mptcp: do complete cleanup at exit

 net/mptcp/protocol.c                           | 18 ++++++++++++++++--
 .../selftests/net/mptcp/mptcp_connect.sh       |  4 ++--
 2 files changed, 18 insertions(+), 4 deletions(-)


base-commit: d8152cfe2f21d6930c680311b03b169899c8d2a0
-- 
2.35.1

