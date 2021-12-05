Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD02C9D
	for <mptcp@lists.linux.dev>; Sun,  5 Dec 2021 19:27:47 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mtxAg-0004BD-L7; Sun, 05 Dec 2021 20:27:38 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: syzkaller-bugs@googlegroups.com,
	<netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	syzbot+1fd9b69cde42967d1add@syzkaller.appspotmail.com
Subject: [PATCH mptcp] mptcp: remove tcp ulp setsockopt support
Date: Sun,  5 Dec 2021 20:27:00 +0100
Message-Id: <20211205192700.25396-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <00000000000040972505d24e88e3@google.com>
References: <00000000000040972505d24e88e3@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP_ULP setsockopt cannot be used for mptcp because its already
used internally to plumb subflow (tcp) sockets to the mptcp layer.

syzbot managed to trigger a crash for mptcp connections that are
in fallback mode:

KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 1 PID: 1083 Comm: syz-executor.3 Not tainted 5.16.0-rc2-syzkaller #0
RIP: 0010:tls_build_proto net/tls/tls_main.c:776 [inline]
[..]
 __tcp_set_ulp net/ipv4/tcp_ulp.c:139 [inline]
 tcp_set_ulp+0x428/0x4c0 net/ipv4/tcp_ulp.c:160
 do_tcp_setsockopt+0x455/0x37c0 net/ipv4/tcp.c:3391
 mptcp_setsockopt+0x1b47/0x2400 net/mptcp/sockopt.c:638

Remove support for TCP_ULP setsockopt.

Reported-by: syzbot+1fd9b69cde42967d1add@syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw@strlen.de>
---
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 3c3db22fd36a..aa3fcd86dbe2 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -543,7 +543,6 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_NODELAY:
 		case TCP_THIN_LINEAR_TIMEOUTS:
 		case TCP_CONGESTION:
-		case TCP_ULP:
 		case TCP_CORK:
 		case TCP_KEEPIDLE:
 		case TCP_KEEPINTVL:
-- 
2.32.0

