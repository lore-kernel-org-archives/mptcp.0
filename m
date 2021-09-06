Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF672
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 06:06:35 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mN7lz-0008QZ-Lz; Mon, 06 Sep 2021 08:06:27 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [mptcp-next 0/2] Fix mptcp connection hangs after link failover
Date: Mon,  6 Sep 2021 08:06:12 +0200
Message-Id: <20210906060614.25217-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First patch is preparation work: tx_pending_data counter is unreliable.
Second patch fixes premature stop of the retransmit timer.

Florian Westphal (2):
  mptcp: remove tx_pending_data
  mptcp: re-set push-pending bit on retransmit failure

 net/mptcp/protocol.c | 32 +++++++++++++++++++++++++-------
 net/mptcp/protocol.h |  1 -
 2 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.32.0

