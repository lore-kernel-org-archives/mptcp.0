Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33832CB2
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 23:16:12 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="219119106"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="219119106"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 15:16:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="518491437"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.180.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 15:16:09 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 2/4] mptcp: clear 'kern' flag from fallback sockets
Date: Tue, 14 Dec 2021 15:16:02 -0800
Message-Id: <20211214231604.211016-3-mathew.j.martineau@linux.intel.com>
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

The mptcp ULP extension relies on sk->sk_sock_kern being set correctly:
It prevents setsockopt(fd, IPPROTO_TCP, TCP_ULP, "mptcp", 6); from
working for plain tcp sockets (any userspace-exposed socket).

But in case of fallback, accept() can return a plain tcp sk.
In such case, sk is still tagged as 'kernel' and setsockopt will work.

This will crash the kernel, The subflow extension has a NULL ctx->conn
mptcp socket:

BUG: KASAN: null-ptr-deref in subflow_data_ready+0x181/0x2b0
Call Trace:
 tcp_data_ready+0xf8/0x370
 [..]

Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming connections")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

Note: The original author of cf7da0d66cc1 is not cc'd because the email
address is no longer valid.

---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c82a76d2d0bf..6dc1ff07994c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2879,7 +2879,7 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 		 */
 		if (WARN_ON_ONCE(!new_mptcp_sock)) {
 			tcp_sk(newsk)->is_mptcp = 0;
-			return newsk;
+			goto out;
 		}
 
 		/* acquire the 2nd reference for the owning socket */
@@ -2891,6 +2891,8 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	}
 
+out:
+	newsk->sk_kern_sock = kern;
 	return newsk;
 }
 
-- 
2.34.1

