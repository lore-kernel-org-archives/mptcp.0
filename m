Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2D5812E
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082949; cv=none; b=hq3ltOxd93lQVatfsyCnbDVKLIYogL2BvCU2gFmD1tgW6RqGsen+Jj+MR3KsAS8h+P6GMlTSGG1FRj8t/95wFyki8wj8rhPLu5PhVtRiVVNlGp2HCgPZNF+VPPjWD5kCV6GGj0HsC4y5thYrrHHVb9peCQR63ZHTTNYvr9Wit5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082949; c=relaxed/simple;
	bh=EzLZH6aFXRumUkGJpI3oeD+oymNoJs7Iq/Y89m+Rsdk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuZzSk7Ky4EbfCapSG4TZrsSns3LjBUoFtEFl0H573ZA0yVL16/9dCtSWF+OSnkBiDhfAiHPLlNTzJIJTmlJkKxo1/wnD9wfJKaKXR0MMBpZahUrC0iVmU1k+VFxnnKYd1RblnsMBNMUdony/VVgiJoL1k7zQvdNmTfiRXKcxww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGvcujot; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGvcujot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708082944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+akTRa9mFQqVNm211wS2m5ZkUgSgoHSuHL1fIi9cQyo=;
	b=eGvcujotuRU7Q4XF8jhAqvXerOXvTlHYxAjqxOAe0V7hUFW5Fa/OH8lQBXlUSx6xDwsWAx
	3GhdhCyt5w4pbExWrRNBTabfQf3+QRWvjH2+2PYjrhu50n5AgRV4IWgMOMNpgwLF0Uy9LP
	yiQbZZDNmj/J/L5hfnX344wJVxGMf3g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-PqGZ1yJOOpeGYKFa1MlOrA-1; Fri, 16 Feb 2024 06:29:03 -0500
X-MC-Unique: PqGZ1yJOOpeGYKFa1MlOrA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4047F828CE8
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C3AD9492BE4
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 net-next 7/7] mptcp: cleanup SOL_TCP handling
Date: Fri, 16 Feb 2024 12:28:18 +0100
Message-ID: <cd18123f3ed884b835f17e29b77511e5313b8b2d.1708082765.git.pabeni@redhat.com>
In-Reply-To: <cover.1708082765.git.pabeni@redhat.com>
References: <cover.1708082765.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Most TCP-level socket options get an integer from user space, and
set the corresponding field under the msk-level socket lock.

Reduce the code duplication moving such operations in the common code.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/sockopt.c | 75 ++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1b38dac70719..dcd1c76d2a3b 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -624,18 +624,11 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
-static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optval,
-					 unsigned int optlen)
+static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val, ret;
 
-	ret = mptcp_get_int_option(msk, optval, optlen, &val);
-	if (ret)
-		return ret;
-
-	lock_sock(sk);
 	sockopt_seq_inc(msk);
 	msk->cork = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -647,23 +640,15 @@ static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optva
 	}
 	if (!val)
 		mptcp_check_and_set_pending(sk);
-	release_sock(sk);
 
 	return 0;
 }
 
-static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t optval,
-					    unsigned int optlen)
+static int __mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val, ret;
 
-	ret = mptcp_get_int_option(msk, optval, optlen, &val);
-	if (ret)
-		return ret;
-
-	lock_sock(sk);
 	sockopt_seq_inc(msk);
 	msk->nodelay = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -675,8 +660,6 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t op
 	}
 	if (val)
 		mptcp_check_and_set_pending(sk);
-	release_sock(sk);
-
 	return 0;
 }
 
@@ -799,35 +782,10 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	int ret, val;
 
 	switch (optname) {
-	case TCP_INQ:
-		ret = mptcp_get_int_option(msk, optval, optlen, &val);
-		if (ret)
-			return ret;
-		if (val < 0 || val > 1)
-			return -EINVAL;
-
-		lock_sock(sk);
-		msk->recvmsg_inq = !!val;
-		release_sock(sk);
-		return 0;
 	case TCP_ULP:
 		return -EOPNOTSUPP;
-	case TCP_NOTSENT_LOWAT:
-		ret = mptcp_get_int_option(msk, optval, optlen, &val);
-		if (ret)
-			return ret;
-
-		lock_sock(sk);
-		WRITE_ONCE(msk->notsent_lowat, val);
-		mptcp_write_space(sk);
-		release_sock(sk);
-		return 0;
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
-	case TCP_CORK:
-		return mptcp_setsockopt_sol_tcp_cork(msk, optval, optlen);
-	case TCP_NODELAY:
-		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
 		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
 		mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen);
@@ -840,7 +798,34 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 						      optval, optlen);
 	}
 
-	return -EOPNOTSUPP;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	switch (optname) {
+	case TCP_INQ:
+		if (val < 0 || val > 1)
+			ret = -EINVAL;
+		else
+			msk->recvmsg_inq = !!val;
+		break;
+	case TCP_NOTSENT_LOWAT:
+		WRITE_ONCE(msk->notsent_lowat, val);
+		mptcp_write_space(sk);
+		break;
+	case TCP_CORK:
+		ret = __mptcp_setsockopt_sol_tcp_cork(msk, val);
+		break;
+	case TCP_NODELAY:
+		ret = __mptcp_setsockopt_sol_tcp_nodelay(msk, val);
+		break;
+	default:
+		ret = -ENOPROTOOPT;
+	}
+
+	release_sock(sk);
+	return ret;
 }
 
 int mptcp_setsockopt(struct sock *sk, int level, int optname,
-- 
2.43.0

