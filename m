Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB84173
	for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 22:02:28 +0000 (UTC)
IronPort-SDR: sIwVuKNZyBcGZbEr580zw5xVTkhoSW7VGGYbPF4Jhr77EWRnYk+Z5b4R5Tk494QoU0Uwc78Q4m
 xwapyaD+LllQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="187004134"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="187004134"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:02:27 -0700
IronPort-SDR: 4WFkcJdwGK6DVtjWfn6+gT/9T+4jLO4fPp8ADa2xti5f7NMN2jvYukKtJz6w/V09kDG2vDFspZ
 NdtWrga65mBA==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="443703681"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.26.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:02:27 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	fw@strlen.de
Subject: [PATCH net 0/2] mptcp: 32-bit sequence number improvements
Date: Fri, 18 Jun 2021 15:02:19 -0700
Message-Id: <20210618220221.99172-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.32.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPTCP-level sequence numbers are 64 bits, but RFC 8684 allows use of
32-bit sequence numbers in the DSS option to save header space. Those
32-bit numbers are the least significant bits of the full 64-bit
sequence number, so the receiver must infer the correct upper 32 bits.

These two patches improve the logic for determining the full 64-bit
sequence numbers when the 32-bit truncated version has wrapped around.

Paolo Abeni (2):
  mptcp: fix bad handling of 32 bit ack wrap-around
  mptcp: fix 32 bit DSN expansion

 net/mptcp/options.c  | 29 +++++++++++++++--------------
 net/mptcp/protocol.h |  8 ++++++++
 net/mptcp/subflow.c  | 17 +----------------
 3 files changed, 24 insertions(+), 30 deletions(-)


base-commit: 9cca0c2d70149160407bda9a9446ce0c29b6e6c6
-- 
2.32.0

