Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4222C85
	for <mptcp@lists.linux.dev>; Mon,  8 Nov 2021 11:23:40 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mk2L3-0006XQ-6F; Mon, 08 Nov 2021 11:57:21 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 0/3] support for setsockopt(TCP_INQ)
Date: Mon,  8 Nov 2021 11:57:08 +0100
Message-Id: <20211108105711.16200-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds TCP_INQ for mptcp and extends the selftest infra.
Last patch adds the (older) ioctls for this.

Florian Westphal (3):
  mptcp: add TCP_INQ cmsg support
  selftests: mptcp: add TCP_INQ support
  mptcp: add SIOCINQ, OUTQ and OUTQNSD ioctls

 net/mptcp/protocol.c                          | 85 +++++++++++++++++++
 net/mptcp/protocol.h                          |  1 +
 net/mptcp/sockopt.c                           | 37 ++++++++
 .../selftests/net/mptcp/mptcp_connect.c       | 56 +++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 10 +--
 5 files changed, 183 insertions(+), 6 deletions(-)

-- 
2.32.0

