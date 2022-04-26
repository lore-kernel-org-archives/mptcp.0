Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257C633C3
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 21:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651010246; x=1682546246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MhOYld/1XELXh4CJiXdT/E/wXr1i2B/WULJbFZ2W420=;
  b=O6dJ9Ap+Ig/eu/fCo4fxNPGQopKoLEFv7MUUaP/l8sIDxKueNJRl/gD1
   1rZKm8Z4BxkbP4oDt9VPRBqtapf1R+YuuTaeiG+/ukq86caScIQzGFzSf
   X4+1LqSueatw/xCcnH6TyTNXp+hfYqZyf1osanQZiOIdKza47rs2avaUy
   fZIUxFqxCi9kqT230VQ6PxOuTvFBd+wuJ7CPPGG336eS2zqPbt1qv+mfq
   7o0AucnrSEPSNsil5OKx5ggHbsQ3pz3c9slRmWDDb+CarJhqaQpR5YRrL
   sxlopHGNBj9QnLZkA4xGb+lBGlENOGyQX++X+8KoayydPMby2Jgrf7z4A
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326222713"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326222713"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="532878095"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.10.176])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:23 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/7] mptcp: use mptcp_stop_timer
Date: Tue, 26 Apr 2022 14:57:12 -0700
Message-Id: <20220426215717.129506-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426215717.129506-1-mathew.j.martineau@linux.intel.com>
References: <20220426215717.129506-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Use the helper mptcp_stop_timer() instead of using sk_stop_timer() to
stop icsk_retransmit_timer directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4581c570ef68..e3db319ce92e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2753,7 +2753,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	/* join list will be eventually flushed (with rst) at sock lock release time*/
 	list_splice_init(&msk->conn_list, &conn_list);
 
-	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
+	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
 
@@ -2861,7 +2861,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
 	}
 
-	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
+	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 
 	if (mptcp_sk(sk)->token)
-- 
2.36.0

