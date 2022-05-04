Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6C233E0
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 21:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651701262; x=1683237262;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KdM3lp/DhazZUn4xm4CRFy23Msgw+tObg/KorAQfreg=;
  b=doDBFFiju/V0wpHmcwunYAWpx8mUC9ahxRyGVkAwdH2UZUCPuRK1RgQX
   k6CT8FojvMBSA0Gx6xVoPOekgg/DAYbvooypl/Cm84Sh8hZHY7pEiqd4W
   jE2CEGUbP3BcK71TyrFXYWxq6kGOmjWIvZOUtKkbV/eDLrttJCATYVN5/
   eAMPRZMQ/yJuBSbQLOyHeH39jLTS+aZXDnUz7o1odQKL9QCfQlQGiYCB8
   a2k9bB/vTowHEDe9xccoO+7LqfZH6IZbDZB1yutnyGrzKSMsiRaWWGhFl
   eC66RgHVC1C1ISDYZU3NWvQR25eg2gFpnAkspGw6fRoCZldLcWiuteCi9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="249892479"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="249892479"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:54:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="621000348"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.251.111])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:54:14 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/5] mptcp: Improve MPTCP-level window tracking
Date: Wed,  4 May 2022 14:54:03 -0700
Message-Id: <20220504215408.349318-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves MPTCP receive window compliance with RFC 8684 and
helps increase throughput on high-speed links. Note that patch 3 makes a
change in tcp_output.c

For the details, Paolo says:

I've been chasing bad/unstable performance with multiple subflows
on very high speed links.

It looks like the root cause is due to the current mptcp-level
congestion window handling. There are apparently a few different
sub-issues:

- the rcv_wnd is not effectively shared on the tx side, as each
  subflow takes in account only the value received by the underlaying
  TCP connection. This is addressed in patch 1/4

- The mptcp-level offered wnd right edge is currently allowed to shrink.
  Reading section 3.3.4.:

"""
   The receive window is relative to the DATA_ACK.  As in TCP, a
   receiver MUST NOT shrink the right edge of the receive window (i.e.,
   DATA_ACK + receive window).  The receiver will use the data sequence
   number to tell if a packet should be accepted at the connection
   level.
"""

I read the above as we need to reflect window right-edge tracking
on the wire, see patch 4/5.

- The offered window right edge tracking can happen concurrently on
  multiple subflows, but there is no mutex protection. We need an
  additional atomic operation - still patch 3/4

This series additionally bumps a few new MIBs to track all the above
(ensure/observe that the suspected races actually take place).

I could not access again the host where the issue was so
noticeable, still in the current setup the tput changes from
[6-18] Gbps to 19Gbps very stable.


Paolo Abeni (5):
  mptcp: really share subflow snd_wnd
  mptcp: add mib for xmit window sharing
  tcp: allow MPTCP to update the announced window
  mptcp: never shrink offered window
  mptcp: add more offered MIBs counter

 include/net/mptcp.h   |  2 +-
 net/ipv4/tcp_output.c | 14 ++++++-----
 net/mptcp/mib.c       |  4 +++
 net/mptcp/mib.h       |  6 +++++
 net/mptcp/options.c   | 58 +++++++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.c  | 32 +++++++++++++++---------
 net/mptcp/protocol.h  |  2 +-
 7 files changed, 90 insertions(+), 28 deletions(-)


base-commit: a37f37a2e7f5ea3ae2a1278f552aa21a8e32c221
-- 
2.36.0

