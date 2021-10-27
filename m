Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820EC72
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 14:53:42 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mfjx1-0005Yg-Fn; Wed, 27 Oct 2021 16:30:47 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 0/2] mptcp: add freebind & transparent sockopt
Date: Wed, 27 Oct 2021 16:30:39 +0200
Message-Id: <20211027143041.28449-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This depends on IP_TOS patches that got posted recently.

First patch adds ipv4/ipv6 TRANSPARENT and FREEBIND, second
patch adds a selftest to mptcp_connect.sh.

Florian Westphal (2):
  mptcp: sockopt: add SOL_IP freebind & transparent options
  selftests: mptcp: add tproxy test case

 net/mptcp/sockopt.c                           | 66 ++++++++++++++-
 net/mptcp/subflow.c                           |  3 +-
 .../selftests/net/mptcp/mptcp_connect.c       | 51 +++++++++++-
 .../selftests/net/mptcp/mptcp_connect.sh      | 80 +++++++++++++++++++
 4 files changed, 197 insertions(+), 3 deletions(-)

-- 
2.32.0

