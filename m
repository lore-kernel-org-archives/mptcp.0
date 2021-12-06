Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908072C80
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 15:51:28 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1muGH0-0001qd-72; Mon, 06 Dec 2021 16:51:26 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp 0/2] mptcp: fix crash with mptcp-ulp on tcp sockets
Date: Mon,  6 Dec 2021 16:51:18 +0100
Message-Id: <20211206155120.26929-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on the tls-ULP syzbot report I found that its also
possible to set the "mptcp" ulp from userspace, iff the socket is a
tcp socket returned via accept() on an mptcp listen socket.

First patch fixes this, second patch adds a test case.

Florian Westphal (2):
  mptcp: clear 'kern' flag from fallback sockets
  selftests: mptcp: try to set mptcp ulp mode in different sk states

 net/mptcp/protocol.c                          |  1 +
 .../selftests/net/mptcp/mptcp_connect.c       | 97 ++++++++++---------
 .../selftests/net/mptcp/mptcp_connect.sh      | 20 ----
 3 files changed, 52 insertions(+), 66 deletions(-)

-- 
2.32.0

