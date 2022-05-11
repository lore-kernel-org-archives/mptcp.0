Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3DA28F9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 13:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1652275423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6S2w0/50GdrBpJkkutTW0xko0umxmLnFBJfJW9sJDGQ=;
	b=HhZX3O5nQeZ0h+FEm4hDCGg+HlUXpldLcz2whVgUH/t4Ud6mBAqrGozbzkfcjU6dFDPLmz
	pNv1TmX68rAZpUQLDxgfzCjmyW9PKIP0BBWU8sNal+3JhKsw5Zjq6nn2z6vmCmMWMYwBPW
	gjmKxoHa5LddH/K0SuijvXMaPyQ5P9I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-3yQypZZzNRmhuUnFPK_4nw-1; Wed, 11 May 2022 09:23:35 -0400
X-MC-Unique: 3yQypZZzNRmhuUnFPK_4nw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D878F800882
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 13:23:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5D0ED43F705
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 13:23:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: stop using the mptcp_has_another_subflow() helper
Date: Wed, 11 May 2022 15:23:30 +0200
Message-Id: <5e05ab9275671ea3018eaa02028197817715de65.1652275377.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mentioned helper requires the msk socket lock, and the
current callers don't own it nor can't acquire it, so the
access is racy.

All the current callers are really checking for infinite mapping
fallback, and the latter condition is explicitly tracked by
the relevant msk variable: we can safely remove the caller usage
- and the caller itself.

The issue is present since MP_FAIL implementation, but the
fix only applies since the infinite fallback support, ence the
somewhat unexpected fixes tag.

Fixes: 0530020a7c8f ("mptcp: track and update contiguous data status")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm.c       |  2 +-
 net/mptcp/protocol.h | 13 -------------
 net/mptcp/subflow.c  |  3 +--
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 59fdab2d0c27..8ba51120f35b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -303,7 +303,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
 	pr_debug("fail_seq=%llu", fail_seq);
 
-	if (mptcp_has_another_subflow(sk) || !READ_ONCE(msk->allow_infinite_fallback))
+	if (!READ_ONCE(msk->allow_infinite_fallback))
 		return;
 
 	if (!READ_ONCE(subflow->mp_fail_response_expect)) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f98c27300e60..dbb914def5cc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -661,19 +661,6 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
 }
 
-static inline bool mptcp_has_another_subflow(struct sock *ssk)
-{
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk), *tmp;
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-
-	mptcp_for_each_subflow(msk, tmp) {
-		if (tmp != subflow)
-			return true;
-	}
-
-	return false;
-}
-
 void __init mptcp_proto_init(void);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int __init mptcp_proto_v6_init(void);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b38a02db924b..550c8fbec54d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1218,8 +1218,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	if (!__mptcp_check_fallback(msk)) {
 		/* RFC 8684 section 3.7. */
 		if (subflow->send_mp_fail) {
-			if (mptcp_has_another_subflow(ssk) ||
-			    !READ_ONCE(msk->allow_infinite_fallback)) {
+			if (!READ_ONCE(msk->allow_infinite_fallback)) {
 				ssk->sk_err = EBADMSG;
 				tcp_set_state(ssk, TCP_CLOSE);
 				subflow->reset_transient = 0;
-- 
2.35.3

