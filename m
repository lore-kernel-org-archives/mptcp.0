Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C79A2FB1
	for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 22:54:47 +0000 (UTC)
IronPort-SDR: zkZf5zlwlHwbHPWxzufCObzLjlytKmn6v0irjuBwQh8ugSd233yew7XqdADKyRxWvOGfLSrtMH
 UhBILJGYiu+A==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="203933127"
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="203933127"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 15:54:43 -0700
IronPort-SDR: vh6VkRll+EEvDaoq/BV8IyDWVvvmtWb61/eEhojz5txu0RhzkaOmRCv0wZtERcG7bylqTLRKhK
 rues0IfIp6dg==
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="486673972"
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
Subject: [PATCH net-next 4/6] mptcp: drop redundant test in move_skbs_to_msk()
Date: Mon, 21 Jun 2021 15:54:36 -0700
Message-Id: <20210621225438.10777-5-mathew.j.martineau@linux.intel.com>
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

Currently we check the msk state to avoid enqueuing new
skbs at msk shutdown time.

Such test is racy - as we can't acquire the msk socket lock -
and useless, as the caller already checked the subflow
field 'disposable', covering the same scenario in a race
free manner - read and updated under the ssk socket lock.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3e088e9d20fd..cf75be02eb00 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -686,9 +686,6 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	struct sock *sk = (struct sock *)msk;
 	unsigned int moved = 0;
 
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return false;
-
 	__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
 	__mptcp_ofo_queue(msk);
 	if (unlikely(ssk->sk_err)) {
-- 
2.32.0

