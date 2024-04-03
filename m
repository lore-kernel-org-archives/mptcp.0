Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F05B053
	for <mptcp@lists.linux.dev>; Wed,  3 Apr 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129543; cv=none; b=PFRf69ip2VtbSDPFQaGwjDfWGEMYOzrVjV96b2sZqCbjt7mNacJSdN4c1auHrUCkBHWgj7U2iRcSa/3LswMa00Cz52k0VCgFvbDw9pJ9P5SahT+hvTkGj1clG5Sr/2vVioYAdPiFhkXQ75seN/bBspbb07ltXotrdzNM2ahOIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129543; c=relaxed/simple;
	bh=YJHF94tDUSTWCiWPr7aQkKYgxgeg1GDBFAggrN+81Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sD4UrIeFifl/1LSPTVX8TIu5gxWW2GV6uvCJSY8nQPFWFJcrqj5r7g7t8TPUl2Yx0CbevcSBctHoU4/13xKQrK85j7x5G2e/qBEAf6rIqXMOm3o4HqELGb5L+KZLL4zonhQpe6INkUji9BDylChEy1bo3s3f8DmHmp4I/zMC2kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFftXuWb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFftXuWb"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0025ef1efso41559975ad.1
        for <mptcp@lists.linux.dev>; Wed, 03 Apr 2024 00:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712129541; x=1712734341; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zCgjlonmz37DPEbA0Oytli/YhfsEeASyIn4O2vwvxk=;
        b=cFftXuWbDqqIOo/jhzYhZjabzvKz0oLS+nxSVo+y3SAXSGTsrmKryQ6hd7C+h0rVu7
         GL5FdUs10O/YjZWBSeGaz4lsrnRv8fvBNZO0n6HspMoMCYWfXqA+Mq5sOdoCWMhXP6wb
         7HJ3k60QtCQSS4zwlyGuWBLH6CXMGszTVALBWLrCBTGW1/OczQO3hTpvY+CBSQRGh+lt
         tdhW4MmOJ7i7iBCnBQOM7LpgraVRalfh7WTJuNnwTwpVK2dKZeNZdl/iZrCmk3DLdA4L
         VFHf9UvanJzrDUA16uef+608imSA/2GmAk3ZI3bQ5JaZGDTZuRBZX8u867eAKedSH/GR
         1fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129541; x=1712734341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zCgjlonmz37DPEbA0Oytli/YhfsEeASyIn4O2vwvxk=;
        b=LJ6773StJ+UKjnAjJdN7BndOfIQz+suob/vv+ykXHrp/tWq4xsthCtNrNgikeLGCeb
         yxPK9rIID0yDATBEdgOgDYmrTYNGnJPYJy7VtAJOVzPb7nGRK6JdeDHuirEZGN6SC5dx
         l+GbdoGJPJZg8Iz1wRBCtYytNtGejQrNXE3vuvD/Ksed6nocGFxPcQntr/oRqxlQUIr1
         fAH7KET0cFq3D9uP1/g6c+O2xfsbfhauebRcuygaIOhg6/6oHxUKNvYIROGI+YzDzUIX
         mBSojsApRzjt459YlGNjY0LWgJLGuJsGomVyJBDTdRPaeFS2/7lkZBExqNQH9x5q/0+4
         M2nw==
X-Gm-Message-State: AOJu0Yx8Tfk31UBwI9U5kVYB/G/FEmHAidnQx9IdFL9I+bgAVI6I/qwp
	qqJ0qhvYvAnYJGiKEZ1iA4BVsB8SF7eZUlCcGabFeEPzsBUAvkwNNgdiHv39
X-Google-Smtp-Source: AGHT+IGQjU3jEmF0zn6HJ43TC+8/OqIPRh3EVeutbaaMEY/geLwKt4KxdUvOo/y5b7ARumXYuHjDzw==
X-Received: by 2002:a17:902:f606:b0:1e2:88fd:c220 with SMTP id n6-20020a170902f60600b001e288fdc220mr2055084plg.44.1712129541416;
        Wed, 03 Apr 2024 00:32:21 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b001e03b2f7ab1sm12563067plg.92.2024.04.03.00.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:32:20 -0700 (PDT)
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
Subject: [PATCH net-next 5/6] mptcp: support rstreason for passive reset
Date: Wed,  3 Apr 2024 15:31:43 +0800
Message-Id: <20240403073144.35036-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240403073144.35036-1-kerneljasonxing@gmail.com>
References: <20240403073144.35036-1-kerneljasonxing@gmail.com>
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

