Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0A1E832A
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751700309; cv=none; b=HqkhrhQ4CiGM4KuP1hAtHiHdhybr/SosiEjxnm1CTZg0Ui6Cee9EWZRjSYk32C75cjyIiffusS3kLuYa/riqwkOqsPgrT3I0uzrvAOXehptsxrsvKseb8M94VhcQb9r66BOstValYzFs/JaB4tyDOqSaPNMzNVKGxG9O7SxT+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751700309; c=relaxed/simple;
	bh=0kTjdVT7h1dR+gvoMYEwcLAWTm9TbvARWAqnUMl+9Tw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Ls3qwvd4o3ivXABgDL+rdlupLM8JbeAknQA6ZBr5UdnlpnR+pXGW81Rw4uWZ5g2pr5Z3j7mN+a78rmm2y1BaBDUyTF7f3Ok5nTPVVH7agKl002zU1Td7LRh3F+M36fDqacaUDHJgt+vwswFb9WhPn887inJxJbbUuro7nxr/iVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSqKOGdE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSqKOGdE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751700306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrOw1Efc+XtHk0VTw8vzTwX5pSE7zkELVwBgzoL1j2Q=;
	b=CSqKOGdEaAbe9bEifD7F0k+5btpV+y+RjaQC9GV2lOfXVbp0WUYYQDphEzwHC/0qMMaVgY
	YJN8PlL9S49YF3S08pnwfYU5xCDfQ1J5oezBIIP9gRB1ZVD1L3erXooAYPQ0syPd2QzoJ2
	mMkeQFD0LrdFjKZjIz4yYnZMi8gR/QM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-oGRVkQ8MMtyEnkMoPlsHdQ-1; Sat,
 05 Jul 2025 03:25:04 -0400
X-MC-Unique: oGRVkQ8MMtyEnkMoPlsHdQ-1
X-Mimecast-MFC-AGG-ID: oGRVkQ8MMtyEnkMoPlsHdQ_1751700304
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BF981978F61
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:25:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 16F6A195608F
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:25:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 5/5] mptcp: remove pr_fallback()
Date: Sat,  5 Jul 2025 09:24:49 +0200
Message-ID: <189eef71d3406ce2931e6d9442c0c5bba1df42fa.1751700000.git.pabeni@redhat.com>
In-Reply-To: <cover.1751699999.git.pabeni@redhat.com>
References: <cover.1751699999.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yf8jop5Ez-wwKs-W95blLXdnepN9s9ML5p_DLJG9Sbw_1751700304
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We can now track fully the fallback status of a given connection
via the relevant mibs, the mentioned helper is redundant. Remove
it completely.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  | 1 -
 net/mptcp/protocol.c | 1 -
 net/mptcp/protocol.h | 3 ---
 net/mptcp/subflow.c  | 2 --
 4 files changed, 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c9e1f3ec3772..878bb147409c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -980,7 +980,6 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		subflow->mp_capable = 0;
 		if (mptcp_do_fallback(ssk, MPTCP_MIB_DATA_FALLBACK))
 			goto reset;
-		pr_fallback(msk);
 		return false;
 	}
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5f99f02c827c..397a135cb811 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1166,7 +1166,6 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
-	pr_fallback(msk);
 }
 
 #define MPTCP_MAX_GSO_SIZE (GSO_LEGACY_MAX_SIZE - (MAX_TCP_HEADER + 1))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ceb2f2ba2cc7..d39991c90582 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1254,13 +1254,10 @@ static inline bool mptcp_do_fallback(struct sock *ssk, int fb_mib)
 	return true;
 }
 
-#define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
-
 static inline void mptcp_early_fallback(struct mptcp_sock *msk,
 					struct mptcp_subflow_context *subflow,
 					int fb_mib)
 {
-	pr_fallback(msk);
 	subflow->request_mptcp = 0;
 	__mptcp_do_fallback(msk, fb_mib);
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e140d032eb3e..af9f09b8736a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -548,7 +548,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 					    MPTCP_MIB_MPCAPABLEACTIVEFALLBACK))
 				goto do_reset;
 
-			pr_fallback(msk);
 			goto fallback;
 		}
 
@@ -1859,7 +1858,6 @@ static void subflow_state_change(struct sock *sk)
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
 		mptcp_do_fallback(sk, MPTCP_MIB_SIMULT_FALLBACK);
-		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_propagate_state(parent, sk, subflow, NULL);
 	}
-- 
2.49.0

