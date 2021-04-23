Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A629CA
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 18:17:16 +0000 (UTC)
IronPort-SDR: 9UfyxbhHrvqP/njuTCExuy5hoRcuJeHl37lb3TdHtRFfLUln2NyDYGYEGGKmlnpgnM9i1vlb20
 bNh5VyvLaX+w==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="183243832"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="183243832"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:17:14 -0700
IronPort-SDR: lVba1yMz4CBKhB/o4V6jwcz3ja7STkU14prABs2k9NLoEre+esdwmjKveN5f34hFI5sy62WyEB
 SNrqJgo5a3tw==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="402264968"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.254.72.13])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 11:17:14 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/5] mptcp: implement MSG_TRUNC support
Date: Fri, 23 Apr 2021 11:17:06 -0700
Message-Id: <20210423181709.330233-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423181709.330233-1-mathew.j.martineau@linux.intel.com>
References: <20210423181709.330233-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The mentioned flag is currently silenlty ignored. This
change implements the TCP-like behaviour, dropping the
pending data up to the specified length.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Sigend-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1d5f23bd640c..ae08c563c712 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1739,7 +1739,7 @@ static void mptcp_wait_data(struct sock *sk, long *timeo)
 
 static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 				struct msghdr *msg,
-				size_t len)
+				size_t len, int flags)
 {
 	struct sk_buff *skb;
 	int copied = 0;
@@ -1750,11 +1750,13 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 		u32 count = min_t(size_t, len - copied, data_len);
 		int err;
 
-		err = skb_copy_datagram_msg(skb, offset, msg, count);
-		if (unlikely(err < 0)) {
-			if (!copied)
-				return err;
-			break;
+		if (!(flags & MSG_TRUNC)) {
+			err = skb_copy_datagram_msg(skb, offset, msg, count);
+			if (unlikely(err < 0)) {
+				if (!copied)
+					return err;
+				break;
+			}
 		}
 
 		copied += count;
@@ -1966,7 +1968,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	while (copied < len) {
 		int bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied);
+		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
-- 
2.31.1

