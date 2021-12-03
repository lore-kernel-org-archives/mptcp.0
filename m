Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7512C9D
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 22:35:52 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="235802949"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="235802949"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 14:35:48 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="460185314"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.18.88])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 14:35:47 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Maxim Galaganov <max@internet.ru>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 09/10] mptcp: expose mptcp_check_and_set_pending
Date: Fri,  3 Dec 2021 14:35:40 -0800
Message-Id: <20211203223541.69364-10-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203223541.69364-1-mathew.j.martineau@linux.intel.com>
References: <20211203223541.69364-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Galaganov <max@internet.ru>

Expose the mptcp_check_and_set_pending() function for use inside MPTCP
sockopt code. The next patch will call it when TCP_CORK is cleared or
TCP_NODELAY is set on the MPTCP socket in order to push pending data
from mptcp_release_cb().

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Maxim Galaganov <max@internet.ru>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 943f74e804bd..f124cca125d2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1502,7 +1502,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 		msk->snd_nxt = snd_nxt_new;
 }
 
-static void mptcp_check_and_set_pending(struct sock *sk)
+void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk) &&
 	    !test_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bb51fa7f5566..147b22da41ca 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -555,6 +555,7 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
+void mptcp_check_and_set_pending(struct sock *sk);
 void __mptcp_push_pending(struct sock *sk, unsigned int flags);
 bool mptcp_subflow_data_available(struct sock *sk);
 void __init mptcp_subflow_init(void);
-- 
2.34.1

