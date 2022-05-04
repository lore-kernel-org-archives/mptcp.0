Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BFD33E0
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 21:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651701264; x=1683237264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qnJzb3wltAIT3SqGTtEHEESmhK0f8+gNhdxlDAAqu2E=;
  b=ctWDLAptBo0wJKo9QjewxOk6QBKEovi8Gdqr4puKkNQ5reP9fqpnSjng
   1xUgt1YKSe1qIwgiVsGGwHFcZXUwkzUxPBR/BtKsvj1QlCvJverpcBStc
   A1FAXvlEGpVewCBmzooy0RBVT5fTJtTOhVSvFeNtwj5MdIjRciNn9V31c
   twjZca46PJBirqvTC72QFmNU3zsKp9jIjw1bRzlR2v3gr+9wfiGoN9NLu
   ON03wHOuW+zKeQkhsQqiF1xRFplhvgkCRx/+LgdeYxxWv8w5wyCof8GCd
   sCWNq8z3eWwGuIJLy8CmCt601qUWCtKylTJ6LpRbnaIbNL09TKz2/gY00
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="249892480"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="249892480"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:54:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="621000359"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.251.111])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:54:16 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/5] mptcp: really share subflow snd_wnd
Date: Wed,  4 May 2022 14:54:04 -0700
Message-Id: <20220504215408.349318-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504215408.349318-1-mathew.j.martineau@linux.intel.com>
References: <20220504215408.349318-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

As per RFC, mptcp subflows use a "shared" snd_wnd: the effective
window is the maximum among the current values received on all
subflows. Without such feature a data transfer using multiple
subflows could block.

Window sharing is currently implemented in the RX side:
__tcp_select_window uses the mptcp-level receive buffer to compute
the announced window.

That is not enough: the TCP stack will stick to the window size
received on the given subflow; we need to propagate the msk window
value on each subflow at xmit time.

Change the packet scheduler to ignore the subflow level window
and use instead the msk level one

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 52ed2c0ac901..97a375eabd34 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1141,19 +1141,20 @@ struct mptcp_sendmsg_info {
 	bool data_lock_held;
 };
 
-static int mptcp_check_allowed_size(struct mptcp_sock *msk, u64 data_seq,
-				    int avail_size)
+static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
+				    u64 data_seq, int avail_size)
 {
 	u64 window_end = mptcp_wnd_end(msk);
+	u64 mptcp_snd_wnd;
 
 	if (__mptcp_check_fallback(msk))
 		return avail_size;
 
-	if (!before64(data_seq + avail_size, window_end)) {
-		u64 allowed_size = window_end - data_seq;
+	mptcp_snd_wnd = window_end - data_seq;
+	avail_size = min_t(unsigned int, mptcp_snd_wnd, avail_size);
 
-		return min_t(unsigned int, allowed_size, avail_size);
-	}
+	if (unlikely(tcp_sk(ssk)->snd_wnd < mptcp_snd_wnd))
+		tcp_sk(ssk)->snd_wnd = min_t(u64, U32_MAX, mptcp_snd_wnd);
 
 	return avail_size;
 }
@@ -1305,7 +1306,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	}
 
 	/* Zero window and all data acked? Probe. */
-	copy = mptcp_check_allowed_size(msk, data_seq, copy);
+	copy = mptcp_check_allowed_size(msk, ssk, data_seq, copy);
 	if (copy == 0) {
 		u64 snd_una = READ_ONCE(msk->snd_una);
 
@@ -1498,11 +1499,16 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	 * to check that subflow has a non empty cwin.
 	 */
 	ssk = send_info[SSK_MODE_ACTIVE].ssk;
-	if (!ssk || !sk_stream_memory_free(ssk) || !tcp_sk(ssk)->snd_wnd)
+	if (!ssk || !sk_stream_memory_free(ssk))
 		return NULL;
 
-	burst = min_t(int, MPTCP_SEND_BURST_SIZE, tcp_sk(ssk)->snd_wnd);
+	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
+	if (!burst) {
+		msk->last_snd = NULL;
+		return ssk;
+	}
+
 	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
-- 
2.36.0

