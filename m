Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27C1F3B85
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226211; cv=none; b=HTNvxf+gPPr9NmSIAZ6AieOOPQkqWJs3vJQOT+0AImBO/AN7+XrjRVvmES3Y0oe8IczfXGIxtZW0RqAtTYPCHFxbzJzNFQ5Nvzn2jN581jCQUhld92HBtRCEPbqAMrywk2zu4+bjP76VCknTADkAL6Md4cbAm0qyyZDW/I+ucQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226211; c=relaxed/simple;
	bh=pDULvE0RKlOZG3DamYApZm18zHkD2DYpQr/nK1LsS3g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dgrrLxAgPo77lq/96SBSrEWmEli7VdEGKpiKdWp3cVkb+YQrhKOkKgO3fMTKaAE033KCx5x2oxzfHDtm1VR3iNPZ1avT98k9pmHIPrGUVpiUjRWr7mJgk48s3qTtOLJF5iLNwU5mUi/v+aKU1Vzk6065KhNtOOZyCtFly9oSbY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQGnTcHa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQGnTcHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752226208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXXPEph5Cdo2wybBzPRhFmolXpbd4Rtj+ghIoZPzDIo=;
	b=QQGnTcHa7FsR3vAN+xSQqWD/JObmAq72YmTQTH8oYQTpovVWAOBFNGUKLfVC8vdN8xvdOp
	i3azK4K+F3RNGqNsmge7fkn6EpNUABHjgiK5qn9G4OWdbkMRdnfzoDBZroQZVca4fj/oUD
	tlYqdtpvqkPyW+qTVkUdmA32pJZOnYw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-5GD_1D8kOySzxOk6T4N-3A-1; Fri,
 11 Jul 2025 05:30:06 -0400
X-MC-Unique: 5GD_1D8kOySzxOk6T4N-3A-1
X-Mimecast-MFC-AGG-ID: 5GD_1D8kOySzxOk6T4N-3A_1752226206
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C76AE1955F2E
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:30:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.145])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E98271800285
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:29:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-net 5/5] mptcp: remove pr_fallback()
Date: Fri, 11 Jul 2025 11:29:45 +0200
Message-ID: <c66130f43bde6d98090a65fb899d3d90d86f806c.1752221786.git.pabeni@redhat.com>
In-Reply-To: <cover.1752221786.git.pabeni@redhat.com>
References: <cover.1752221786.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BSyXcJqkSzRVp6AtwkeCxpaK9UNpjP6tVUG0fv0TeqY_1752226206
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We can now track fully the fallback status of a given connection
via the relevant mibs, the mentioned helper is redundant. Remove
it completely.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - dropped unused variable in subflow_state_change()
---
 net/mptcp/options.c  | 1 -
 net/mptcp/protocol.c | 1 -
 net/mptcp/protocol.h | 3 ---
 net/mptcp/subflow.c  | 4 ----
 4 files changed, 9 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b49a8b3ffe00..3c08beffbfea 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -982,7 +982,6 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
 			goto reset;
 		}
-		pr_fallback(msk);
 		return false;
 	}
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d4e17d99cbc9..9f9dea72757d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1166,7 +1166,6 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
-	pr_fallback(msk);
 }
 
 #define MPTCP_MAX_GSO_SIZE (GSO_LEGACY_MAX_SIZE - (MAX_TCP_HEADER + 1))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 74579743264f..db50b216143a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1254,13 +1254,10 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
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
 	WARN_ON_ONCE(!__mptcp_try_fallback(msk, fb_mib));
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 600e59bba363..3f1b62a9fe88 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -551,7 +551,6 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 				goto do_reset;
 			}
 
-			pr_fallback(msk);
 			goto fallback;
 		}
 
@@ -1855,14 +1854,11 @@ static void subflow_state_change(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct sock *parent = subflow->conn;
-	struct mptcp_sock *msk;
 
 	__subflow_state_change(sk);
 
-	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
 		WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));
-		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_propagate_state(parent, sk, subflow, NULL);
 	}
-- 
2.50.0

