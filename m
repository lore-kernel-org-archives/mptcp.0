Received: from out-208.mta0.migadu.com (out-208.mta0.migadu.com [91.218.175.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38C7481
	for <mptcp@lists.linux.dev>; Tue, 17 Oct 2023 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j3WgxmrR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697511773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSIFXRsF8qRcq/a0S9tpNnUasQ+RgZz2oFDd1s4sWkY=;
	b=j3WgxmrR0nd6fkWFyeEZovpTh/ZvbSAIhkMDpB3Jl10pkOezFYi7219cBIcGPAxi3j8XB+
	QooeGhMlnbIV2Ex0O07IN4Wb4BEH7ZI6uxUzZGXGFFBaOW9n+nkXqVLarNW6fjkxJh8YRi
	TPymj677mGSzVDBZWm8TRFHWEa3y1RI=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 4/9] Squash to "mptcp: add mptcpi_subflows_total counter"
Date: Tue, 17 Oct 2023 11:00:23 +0800
Message-Id: <6aeaa1589a57314e65b92b8ebc349af5d2e099a6.1697511436.git.geliang.tang@suse.com>
In-Reply-To: <cover.1697511436.git.geliang.tang@suse.com>
References: <cover.1697511436.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Geliang Tang <geliang.tang@suse.com>

Update __mptcp_has_initial_subflow().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6508179e94a6..8529b3ae55e9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1081,7 +1081,9 @@ static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
 {
 	struct sock *ssk = READ_ONCE(msk->first);
 
-	return ssk && inet_sk_state_load(ssk) != TCP_CLOSE;
+	return ssk && ((1 << inet_sk_state_load(ssk)) &
+		       (TCPF_ESTABLISHED | TCPF_SYN_SENT |
+			TCPF_SYN_RECV | TCPF_LISTEN));
 }
 
 static inline void mptcp_do_fallback(struct sock *ssk)
-- 
2.35.3

