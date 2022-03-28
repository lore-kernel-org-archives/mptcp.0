Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B723202
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 12:49:22 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nYooC-00068i-0O; Mon, 28 Mar 2022 14:49:20 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v2 0/3] mptcp: inet diag listen dump support
Date: Mon, 28 Mar 2022 14:49:10 +0200
Message-Id: <20220328124913.29768-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2: drop patch 4 and prefer msk->first (Paolo Abeni)

Done in a not-very-elegant way:
Iterate over tcp listen hash, then pick out the tcp sockets
with mptcp-ctx structure attached, then take the conn->sk for dumping.

First patch is preparation/cleanup.
Second patch gets rid of locking to avoid a lockdep splat.
If the socket lock is really needed (I don't see where) I can workaround
this by dropping locks temporarily when iterating the listen hash table,
but its a bit more awkward.

Sample output:
ss -Mil
State        Recv-Q Send-Q Local Address:Port  Peer Address:Port
LISTEN       0      20     127.0.0.1:12000     0.0.0.0:*
         subflows_max:2

Florian Westphal (3):
  mptcp: diag: switch to context structure
  mptcp: remove locking in mptcp_diag_fill_info
  mptcp: listen diag dump support

 net/mptcp/mptcp_diag.c | 102 +++++++++++++++++++++++++++++++++++++++--
 net/mptcp/sockopt.c    |   6 ---
 2 files changed, 99 insertions(+), 9 deletions(-)

-- 
2.35.1

