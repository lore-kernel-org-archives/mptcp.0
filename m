Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27752168
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 00:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641514848; x=1673050848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wc56x3z89MoqMhqYjlsOIeQJY/RWfoCH4DjPm2rYDaM=;
  b=WsMIzPyzxgfZ9Jkzm2RqCwsnZmpXfl1YDdcV+/7qRNukq6nGiJgRxMDP
   ao+Ku1AqlPyXISd4vvHZ0ItqxrBEUUkzVDapU2yStK5LA5j9ey7gLb+YU
   mcGWQ92jqV9ALUqnQy/7P2aI8+zGX5wb/ic54KkSFlnWIdtwXmrL9g+Me
   jQa5sWg8JM81DyaiLqNEtawktt9CdbOpFwBlJRYo0aKv8lYxS31Vla+L0
   1PU1dO/Qokhq3QEVMGMQooEtMORDk4RB1n/OT01U7cmKMuqFvsqXwzGf6
   1FZVDN2CVs+nrsetSwK8NiNJ521O88hhOFkqGe68/j3EBBguSNVlCWoox
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="329111019"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="329111019"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:20:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="618508492"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.94.200])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:20:33 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 01/13] mptcp: keep snd_una updated for fallback socket
Date: Thu,  6 Jan 2022 16:20:14 -0800
Message-Id: <20220107002026.375427-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107002026.375427-1-mathew.j.martineau@linux.intel.com>
References: <20220107002026.375427-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

After shutdown, for fallback MPTCP sockets, we always have

write_seq == snd_una+1

The above will foul OUTQ ioctl(). Keep snd_una in sync with
write_seq even after shutdown.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index df5a0cf431c1..f6fc0f0f66f0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2666,6 +2666,7 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
 	 * state now
 	 */
 	if (__mptcp_check_fallback(msk)) {
+		WRITE_ONCE(msk->snd_una, msk->write_seq);
 		if ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
 			inet_sk_state_store(sk, TCP_CLOSE);
 			mptcp_close_wake_up(sk);
-- 
2.34.1

