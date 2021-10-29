Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599FD2C83
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 11:09:34 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mgPlM-00088r-Hh; Fri, 29 Oct 2021 13:09:32 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v3 0/2] mptcp: add freebind & transparent sockopt
Date: Fri, 29 Oct 2021 13:09:25 +0200
Message-Id: <20211029110927.12315-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First patch adds ipv4/ipv6 TRANSPARENT and FREEBIND, second
patch adds a selftest to mptcp_connect.sh.

Only change is in patch 2 which has more verbose SKIP messages
and an updated mptcp/config to account for IPV6_MULTIPLE_TABLES
and other toggles required for the tproxy test case.

Florian Westphal (2):
  mptcp: sockopt: add SOL_IP freebind & transparent options
  selftests: mptcp: add tproxy test case

 net/mptcp/sockopt.c                           | 66 ++++++++++++++-
 net/mptcp/subflow.c                           |  3 +-
 .../selftests/net/mptcp/config                |  7 ++-
 .../selftests/net/mptcp/mptcp_connect.c       | 51 +++++++++++-
 .../selftests/net/mptcp/mptcp_connect.sh      | 80 +++++++++++++++++++
 5 files changed, 202 insertions(+), 5 deletions(-)
-- 
2.32.0

