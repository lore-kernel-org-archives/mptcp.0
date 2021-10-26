Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E42CAB
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 23:29:24 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="227493941"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="227493941"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 16:29:22 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="597124830"
Received: from jdweinst-mobl2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.54.246])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 16:29:21 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	pabeni@redhat.com,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 4/4] mptcp: drop unused sk in mptcp_push_release
Date: Tue, 26 Oct 2021 16:29:16 -0700
Message-Id: <20211026232916.179450-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211026232916.179450-1-mathew.j.martineau@linux.intel.com>
References: <20211026232916.179450-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Since mptcp_set_timeout() had removed from mptcp_push_release() in
commit 33d41c9cd74c5 ("mptcp: more accurate timeout"), the argument
sk in mptcp_push_release() became useless. Let's drop it.

Fixes: 33d41c9cd74c5 ("mptcp: more accurate timeout")
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 81ef592113a5..eb316bd578bb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1469,8 +1469,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	return NULL;
 }
 
-static void mptcp_push_release(struct sock *sk, struct sock *ssk,
-			       struct mptcp_sendmsg_info *info)
+static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
 {
 	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
 	release_sock(ssk);
@@ -1533,7 +1532,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			 * the last round, release prev_ssk
 			 */
 			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(sk, prev_ssk, &info);
+				mptcp_push_release(prev_ssk, &info);
 			if (!ssk)
 				goto out;
 
@@ -1546,7 +1545,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <= 0) {
-				mptcp_push_release(sk, ssk, &info);
+				mptcp_push_release(ssk, &info);
 				goto out;
 			}
 
@@ -1561,7 +1560,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 	/* at this point we held the socket lock for the last subflow we used */
 	if (ssk)
-		mptcp_push_release(sk, ssk, &info);
+		mptcp_push_release(ssk, &info);
 
 out:
 	/* ensure the rtx timer is running */
-- 
2.33.1

