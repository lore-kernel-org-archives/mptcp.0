Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CC30F803
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513631; cv=none; b=IbzY9IK+5TjvOoUoEw3yZwrc6jTAOBSMT0WWi6PP5wGWDR9EE0kJz5KFxRKp2/qO68mK4POTuwsDu8dg6ACVRBsOihCX3vGZWrZoTxQGncva826u+SwtULyfMYYKoQ+dKKhiSjvin+UrZpRu/cUqE70jpL1kFyVAK20AprbWwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513631; c=relaxed/simple;
	bh=8L75x0wxoF6PsXlc3efRcNEijBk7AQTXODsEPhG910c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzuXOX5nfTEAkRG7lkbb0fEeQbApsz8wdAIyWeRM3bL9CSJkmEGZArLRNMdIGOuFsmhU5gNcGNLmdn/tOfGNi42Lr0EcJku9tkRTCfVZ2xJ5nhnLYiIsh1YooOkMlGpTjEE5nq66vTjyJIpXt3fwFsLwny1VOrYD2nF9kZH2oUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qVZZ4vUm; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qVZZ4vUm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786513627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mfpmizRnTWMR7M2xKNaR4gjr/3qGmyzhzv6APnPoOo=;
	b=qVZZ4vUmP4g8PK6G5L1KZLPN2ERkNT/065tokgyAQUHwNAFFlK5C9U5nJfKwxjnUQLYrrN
	JG3KxlJgb3Ru3gXpQdOLq10dJMZ3uYNU8/sN39RDGpEi26/NElDGEn8jW2Ac+luJkfE+Xu
	uWdl1IK5uHwjwpcURNmBwffD6FvCAQ0=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH export v3 3/4] mptcp: reset subflow on MP_FAIL when OoO queue is non-empty
Date: Wed, 12 Aug 2026 13:46:52 +0800
Message-Id: <20260812054653.43799-4-chenguang.zhao@linux.dev>
In-Reply-To: <20260812054653.43799-1-chenguang.zhao@linux.dev>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Infinite mapping needs contiguous data. If the MPTCP OoO queue is not
empty, reset the subflow instead of falling back.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/mptcp/pm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ba7c6f80a183..8c263084db7b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -882,6 +882,16 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 		spin_unlock_bh(&msk->fallback_lock);
 		return;
 	}
+
+	/* RFC8684 §3.7: Infinite mapping requires contiguous data */
+	if (!subflow->fail_tout &&
+	    !RB_EMPTY_ROOT(&msk->out_of_order_queue)) {
+		spin_unlock_bh(&msk->fallback_lock);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
+		mptcp_subflow_reset(sk);
+		return;
+	}
+
 	msk->allow_subflows = false;
 	spin_unlock_bh(&msk->fallback_lock);
 
-- 
2.25.1

