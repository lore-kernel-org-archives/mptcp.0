Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA392F84
	for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 22:38:19 +0000 (UTC)
IronPort-SDR: SqzI/Ec1rzNkBoPdbV6VOOgWa563X2O5V/HNosc8X5ehetvpNd9Z9whzX9Qe3BMHO6iu6x0GaQ
 K9eGjI5tAmiA==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="175231658"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="175231658"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 15:38:17 -0700
IronPort-SDR: ifONsZmzTldXPNUiFL7KWjFUS1d6Lg1jHrbMRfdpPxBIDJ4uC0KzHw4aczF5JeCe8a7E/WazNt
 tZhJfNsZ9PcA==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="462107388"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.43.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 15:38:17 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/8] mptcp: fix format specifiers for unsigned int
Date: Fri, 16 Apr 2021 15:38:02 -0700
Message-Id: <20210416223808.298842-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416223808.298842-1-mathew.j.martineau@linux.intel.com>
References: <20210416223808.298842-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@gmail.com>

Some of the sequence numbers are printed as the negative ones in the debug
log:

[   46.250932] MPTCP: DSS
[   46.250940] MPTCP: data_fin=0 dsn64=0 use_map=0 ack64=1 use_ack=1
[   46.250948] MPTCP: data_ack=2344892449471675613
[   46.251012] MPTCP: msk=000000006e157e3f status=10
[   46.251023] MPTCP: msk=000000006e157e3f snd_data_fin_enable=0 pending=0 snd_nxt=2344892449471700189 write_seq=2344892449471700189
[   46.251343] MPTCP: msk=00000000ec44a129 ssk=00000000f7abd481 sending dfrag at seq=-1658937016627538668 len=100 already sent=0
[   46.251360] MPTCP: data_seq=16787807057082012948 subflow_seq=1 data_len=100 dsn64=1

This patch used the format specifier %u instead of %d for the unsigned int
values to fix it.

Fixes: d9ca1de8c0cd ("mptcp: move page frag allocation in mptcp_sendmsg()")
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 073e20078ed0..9d0b9f76ab3c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1294,7 +1294,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	int avail_size;
 	size_t ret = 0;
 
-	pr_debug("msk=%p ssk=%p sending dfrag at seq=%lld len=%d already sent=%d",
+	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
 
 	/* compute send limit */
@@ -1712,7 +1712,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			if (!msk->first_pending)
 				WRITE_ONCE(msk->first_pending, dfrag);
 		}
-		pr_debug("msk=%p dfrag at seq=%lld len=%d sent=%d new=%d", msk,
+		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
 			 !dfrag_collapsed);
 
-- 
2.31.1

