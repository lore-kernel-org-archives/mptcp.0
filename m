Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8EA2CA4
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 23:16:12 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="219119105"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="219119105"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 15:16:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="518491435"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.180.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 15:16:09 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	syzbot+1fd9b69cde42967d1add@syzkaller.appspotmail.com,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 1/4] mptcp: remove tcp ulp setsockopt support
Date: Tue, 14 Dec 2021 15:16:01 -0800
Message-Id: <20211214231604.211016-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214231604.211016-1-mathew.j.martineau@linux.intel.com>
References: <20211214231604.211016-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

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

Fixes: d9e4c1291810 ("mptcp: only admit explicitly supported sockopt")
Reported-by: syzbot+1fd9b69cde42967d1add@syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/sockopt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 0f1e661c2032..f8efd478ac97 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -525,7 +525,6 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_NODELAY:
 		case TCP_THIN_LINEAR_TIMEOUTS:
 		case TCP_CONGESTION:
-		case TCP_ULP:
 		case TCP_CORK:
 		case TCP_KEEPIDLE:
 		case TCP_KEEPINTVL:
-- 
2.34.1

