Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0054BF0
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215297; cv=none; b=IinTGwcajrLuR/xVAT8cEMubdQqOjjRkHl4vxqO4sFz7xlceZvCJlkGS7FuWm3S5RdLVwL6bj1emHIFWBAXLzUW2aJvthuMp7uwShnMed2dCbpbUhfiqz7nPmtShoa4pT5Xe7r9cWsufsDUfHI5RpYdXeknhstKSoKxhjoYW+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215297; c=relaxed/simple;
	bh=YJHF94tDUSTWCiWPr7aQkKYgxgeg1GDBFAggrN+81Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6AM+jYaa6lHi30aQOqNABipEHWk3ocSMIGSHv1LiqXcvyuvbCtLsxoFBflKPoAfe8gUfHf+sMpnmyQ3c7AsX+iw07lyNqnuB5u2Zhxd4DaahdM8uNpYOOy0uId+o7VRgPRp+qqQXZYdBa5VIi2yadzQF45bANB8VmltCZTfe7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtHLbX36; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtHLbX36"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0edd0340fso5885105ad.2
        for <mptcp@lists.linux.dev>; Thu, 04 Apr 2024 00:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712215295; x=1712820095; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zCgjlonmz37DPEbA0Oytli/YhfsEeASyIn4O2vwvxk=;
        b=jtHLbX36G5bLxXGSdZftsv27xqFt8oHzq6CLRo5lE/yOB1m7/lHD1+0fgXp8UREUxu
         bJO/77E2hhUcxvM2q52crTeX2PjNZQhd7JIUA/bZOGZC18uOLMVWVHBvmIFWf9kKTplR
         IkCBUHEcRimtL2PicQLmPFZ4683xYOewidHbIrofKt8XlI5K5opp/JEY2BgpCK1geARl
         qONa7EwuGcS3l1DLZkZLCWC9N42YPx6W7a+K9qQ0myyTkiad0yrSGB3+LeF6BloEi2fH
         y+QUOlQZg5lhAccBDH0l3UslJe8K26MK3HyBshcyKpAEKCf8azQQIHr91DhqdehejZQv
         mJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215295; x=1712820095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zCgjlonmz37DPEbA0Oytli/YhfsEeASyIn4O2vwvxk=;
        b=AT2CBcnSIWNV5VMv29w5wWjnsMN4gUi1OFFXLC5gealYGPLUjYuk4QyY79qKIzdExL
         9ya3WXbo2WOF3sTD4sJSVno78iGKOQlS9yMQqk9OoYgiygxhfjeIu4Sj7ELOeoo6WXFd
         DiFv9AlnO+ASygztVy05p282RI/0MikS8zl7KUTxG1AzeW99RKVMMBYGdpydKV6zbP1X
         LI0b+3lmEeLDASMvMOg7FrF0NiaH0Wy+1WgGJRgLhOGyCR1dB6W7tb7AzQuQUcre/nMO
         JjGnvJwfovWUrKnWRyfgAqMDf9JzPF3Og2jjMYeQEm+y6ZmxkMdoLsHISPzLPCRdEhjl
         WOxw==
X-Gm-Message-State: AOJu0YyPbckDZwV2GXNe6s8fkK06kKlsqKjQ4x7vWQP++iRSgZsR2LS1
	RwO7hk78HeRVK2vhowrVmn3LpzHWuSn487GiAHlNX8rw87br0W6O
X-Google-Smtp-Source: AGHT+IEa5+T77JAdTma2XOgWwr9eA4re9vQQ278n8wGaPTDE+cp9slsp+aNVcEu07OClKPDzo6pJhA==
X-Received: by 2002:a17:902:ecd0:b0:1e0:e8b7:1fa2 with SMTP id a16-20020a170902ecd000b001e0e8b71fa2mr1782922plh.21.1712215294850;
        Thu, 04 Apr 2024 00:21:34 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709029a8200b001db5b39635dsm14606399plp.277.2024.04.04.00.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:21:34 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 5/6] mptcp: support rstreason for passive reset
Date: Thu,  4 Apr 2024 15:20:46 +0800
Message-Id: <20240404072047.11490-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240404072047.11490-1-kerneljasonxing@gmail.com>
References: <20240404072047.11490-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

It relys on what reset options in MPTCP does as rfc8684 says. Reusing
this logic can save us much energy. This patch replaces all the prior
NOT_SPECIFIED reasons.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/subflow.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a68d5d0f3e2a..24668d3020aa 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -304,7 +304,10 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 
 	dst_release(dst);
 	if (!req->syncookie)
-		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		/* According to RFC 8684, 3.2. Starting a New Subflow,
+		 * we should use an "MPTCP specific error" reason code.
+		 */
+		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_MPTCP_RST_EMPTCP);
 	return NULL;
 }
 
@@ -371,7 +374,10 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 
 	dst_release(dst);
 	if (!req->syncookie)
-		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+		/* According to RFC 8684, 3.2. Starting a New Subflow,
+		 * we should use an "MPTCP specific error" reason code.
+		 */
+		tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_MPTCP_RST_EMPTCP);
 	return NULL;
 }
 #endif
@@ -778,6 +784,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	bool fallback, fallback_is_fatal;
 	struct mptcp_sock *owner;
 	struct sock *child;
+	int reason;
 
 	pr_debug("listener=%p, req=%p, conn=%p", listener, req, listener->conn);
 
@@ -833,7 +840,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 */
 		if (!ctx || fallback) {
 			if (fallback_is_fatal) {
-				subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
+				reason = MPTCP_RST_EMPTCP;
+				subflow_add_reset_reason(skb, reason);
 				goto dispose_child;
 			}
 			goto fallback;
@@ -861,7 +869,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		} else if (ctx->mp_join) {
 			owner = subflow_req->msk;
 			if (!owner) {
-				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				reason = MPTCP_RST_EPROHIBIT;
+				subflow_add_reset_reason(skb, reason);
 				goto dispose_child;
 			}
 
@@ -875,13 +884,18 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
+					reason = MPTCP_RST_EUNSPEC;
 					goto dispose_child;
 				}
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTACKRX);
 			}
 
-			if (!mptcp_finish_join(child))
+			if (!mptcp_finish_join(child)) {
+				struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+
+				reason = subflow->reset_reason;
 				goto dispose_child;
+			}
 
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
 			tcp_rsk(req)->drop_req = true;
@@ -901,7 +915,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	req->rsk_ops->send_reset(sk, skb, convert_mptcp_reason(reason));
 
 	/* The last child reference will be released by the caller */
 	return child;
-- 
2.37.3

