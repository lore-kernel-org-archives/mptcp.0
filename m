Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201B2FAF
	for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 22:54:47 +0000 (UTC)
IronPort-SDR: 9SNSdUaeeV4eQ/46oozX4WIV3B+uoSBIrY+7IkWhxB5aGjDe6qtYQx/QGkx9FD0yzSKarVHMg1
 3JVn9u4pJFpA==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="203933126"
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="203933126"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 15:54:42 -0700
IronPort-SDR: JETIo+o+XHnaU103DvAb4XUSHtFklFsORi+3HR5U9Li7VRDX9P3WRDLS/syn810Pq6Tb0P22ts
 tczt537G6fyg==
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="486673971"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.74.136])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 15:54:42 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/6] mptcp: don't clear MPTCP_DATA_READY in sk_wait_event()
Date: Mon, 21 Jun 2021 15:54:35 -0700
Message-Id: <20210621225438.10777-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621225438.10777-1-mathew.j.martineau@linux.intel.com>
References: <20210621225438.10777-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

If we don't flush entirely the receive queue, we need set
again such bit later. We can simply avoid clearing it.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c47ce074737d..3e088e9d20fd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1715,7 +1715,7 @@ static void mptcp_wait_data(struct sock *sk, long *timeo)
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 
 	sk_wait_event(sk, timeo,
-		      test_and_clear_bit(MPTCP_DATA_READY, &msk->flags), &wait);
+		      test_bit(MPTCP_DATA_READY, &msk->flags), &wait);
 
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -2039,10 +2039,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		 */
 		if (unlikely(__mptcp_move_skbs(msk)))
 			set_bit(MPTCP_DATA_READY, &msk->flags);
-	} else if (unlikely(!test_bit(MPTCP_DATA_READY, &msk->flags))) {
-		/* data to read but mptcp_wait_data() cleared DATA_READY */
-		set_bit(MPTCP_DATA_READY, &msk->flags);
 	}
+
 out_err:
 	if (cmsg_flags && copied >= 0) {
 		if (cmsg_flags & MPTCP_CMSG_TS)
-- 
2.32.0

