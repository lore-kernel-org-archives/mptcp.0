Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7DE11CA9
	for <mptcp@lists.linux.dev>; Sat,  6 Apr 2024 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712368147; cv=none; b=JzGfIFc7V//Nnsymy8/ur/ZG0rdl9f3mdGDEHxh+HTFx2tWE1etHJNJcnUw0cRyiTkgFGGiOo6aNZY/ifsbjOuxDVMET7R6trztmtOxltOQkuOrw5RAtyBfzZ24S0rk5Kwr5/YlnEwXt2A2u05oHLERQTYrMhzrmkQGIH+a5anY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712368147; c=relaxed/simple;
	bh=l825sw8ynG4lR2su7izmRLMTBPsxEofiIOdnzLywsnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F1S3IhpPDIvm/agwd6xcpVal6GBGCVynAwXsXoEuQ54PL3xB4flYklehQiwNr9/lS8vgDRujBLpuYclqYvWZs4QNotGc75mj8eDlHpk/50xwUescLDaz2h17WfVs/DbdSLhU7fHmxXRGLfQGmo3IgUrrIKbmXY5+s7H+ELL578Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzuyWA0u; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzuyWA0u"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e24c889618so24217385ad.2
        for <mptcp@lists.linux.dev>; Fri, 05 Apr 2024 18:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712368145; x=1712972945; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHpmksB/cpcKRYpeYHWK9D8wSWzvbKo+X+QX5tAxBEU=;
        b=TzuyWA0uK6D8s/edmV0Zo6F/YmheV3ctSZw5vbww+0oIBNNFLKJjsShp3LCzAygNzU
         Sz7G3mbH083G6kftDJwJbTp/9EkYEImjFNLPd/r/5dvYokAeyXhFmHnibRePbYH/+bXc
         myalnyAkTPRUD9UN2h4I3RuhrZr33p+JSebCYQBdyuvOyHlQ4ar/8yfpS82CBe7EGTec
         PkB/VQ3DXHrQ3TfUXLQi48CdKZxrdVzpbEqCM0PNUKjnkdQwQrFdSbTHHg0fAwdgYsMg
         53D8srZ9li0ypOffGBIjsbq+LdCwl2hCMqsS9cnFDyBg30Mpdis10P0pp2xw29JLFr6P
         c9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712368145; x=1712972945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHpmksB/cpcKRYpeYHWK9D8wSWzvbKo+X+QX5tAxBEU=;
        b=lmF5WNI1RZ2Qqsflr4+km0v8P52Y6lxNIwmYllr8lmj4Kxf7aObKjcRhWutAJk3qMg
         7wlz3hfCqOnrnEnpztkv6jmxSVRYnyad8VwCejDC5uAfffuKCPfjc1mcrUV+fWs1Nh6a
         qGKSOdVvHXA2i08GNF8NUuUaNOt1K6eDleEtMjENKKbMEsUsshWIapxpLvYUU+zXrvGO
         nXS46wPteUotqXSXW4sls3EWrZryJB8HtkGPP7g8iKAnTnZSWyJQyKdc6+0V/KKRyeIU
         GEGrcNsP5W3faRb9h49WAGxvFTbwmz5qsWnn9RxM6QTdd4kQ8TcKHnnJv+9n53V4OAPS
         58Kw==
X-Gm-Message-State: AOJu0YxK2A1FpWmAmf6KPnMiMsRlwNXVwRlcVjYI2bk692bXrZgnH1z7
	PJ/pico/5iPL+8yqUvLZNMPr+4EqOHSBVXuqMPt8d6zyJfA4wvuz
X-Google-Smtp-Source: AGHT+IEaKSQcXPmMfK9yeyGxm0hiJOl2DO/8v67vlGnpg38UtgcstdgBDRfHXT95j/2CAsF0dqq9HA==
X-Received: by 2002:a17:903:ca:b0:1de:f569:cf41 with SMTP id x10-20020a17090300ca00b001def569cf41mr2654923plc.26.1712368145277;
        Fri, 05 Apr 2024 18:49:05 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b001e0b60e26f5sm2287139plg.62.2024.04.05.18.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 18:49:04 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2] mptcp: add reset reason options in some places
Date: Sat,  6 Apr 2024 09:48:48 +0800
Message-Id: <20240406014848.71739-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The reason codes are handled in two ways nowadays (quoting Mat Martineau):
1. Sending in the MPTCP option on RST packets when there is no subflow
context available (these use subflow_add_reset_reason() and directly call
a TCP-level send_reset function)
2. The "normal" way via subflow->reset_reason. This will propagate to both
the outgoing reset packet and to a local path manager process via netlink
in mptcp_event_sub_closed()

RFC 8684 defines the skb reset reason behaviour which is not required
even though in some places:

    A host sends a TCP RST in order to close a subflow or reject
    an attempt to open a subflow (MP_JOIN). In order to let the
    receiving host know why a subflow is being closed or rejected,
    the TCP RST packet MAY include the MP_TCPRST option (Figure 15).
    The host MAY use this information to decide, for example, whether
    it tries to re-establish the subflow immediately, later, or never.

Since the commit dc87efdb1a5cd ("mptcp: add mptcp reset option support")
introduced this feature about three years ago, we can fully use it.
There remains some places where we could insert reason into skb as
we can see in this patch.

Many thanks to Mat and Paolo for help:)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/5046e1867c65f39e07822beb0a19a22743b1064b.camel@redhat.com/
1. complete all the possible reset reasons in the subflow_check_req() (Paolo)
---
 net/mptcp/subflow.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1626dd20c68f..b7ce2ca1782c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -150,8 +150,10 @@ static int subflow_check_req(struct request_sock *req,
 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
 	 * TCP option space.
 	 */
-	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info))
+	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info)) {
+		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
 		return -EINVAL;
+	}
 #endif
 
 	mptcp_get_options(skb, &mp_opt);
@@ -219,6 +221,7 @@ static int subflow_check_req(struct request_sock *req,
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
 			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				return -EPERM;
 			}
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTSYNRX);
@@ -227,10 +230,12 @@ static int subflow_check_req(struct request_sock *req,
 		subflow_req_create_thmac(subflow_req);
 
 		if (unlikely(req->syncookie)) {
-			if (mptcp_can_accept_new_subflow(subflow_req->msk))
-				subflow_init_req_cookie_join_save(subflow_req, skb);
-			else
+			if (!mptcp_can_accept_new_subflow(subflow_req->msk)) {
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				return -EPERM;
+			}
+
+			subflow_init_req_cookie_join_save(subflow_req, skb);
 		}
 
 		pr_debug("token=%u, remote_nonce=%u msk=%p", subflow_req->token,
@@ -873,13 +878,18 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
+					subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 					goto dispose_child;
 				}
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTACKRX);
 			}
 
-			if (!mptcp_finish_join(child))
+			if (!mptcp_finish_join(child)) {
+				struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(child);
+
+				subflow_add_reset_reason(skb, subflow->reset_reason);
 				goto dispose_child;
+			}
 
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
 			tcp_rsk(req)->drop_req = true;
-- 
2.37.3

