Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38651CD23
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428990; cv=none; b=WWoHZB/uwfpb7oFgpR/h5Mlo+Y1K9PdvEWUAKQALVwVzF7XOaU8aKd8m3HxZL4lZ4p7XgYxFG2grRLtpj3VO4hGYqJxRuCENlNTegmuZib5iXtiO12awzMhjG3sx+tKwIn9YMJF8K5l6vYdhH9WmG7iqRrJOTwy4mdLVi78ZjXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428990; c=relaxed/simple;
	bh=MTLFm9hy0u18Giy81s2uUgwMftTeGx8gRb8NLHOghcg=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 X-Scanned-By:X-Mimecast-Spam-Score:X-Mimecast-Originator:
	 Content-Transfer-Encoding:Content-Type; b=hkTO4RHoUsf5fBmbdUGetPTt5nytauKbNgriC4ofD/0NDKBRH6UYQbdeRkVzHP2TjuRbB/hFpeex8lKR/GUb0uvZjLtePE8zkZTHVcf9wTvIPdP+X2fhMk/IJYUH0AKOA8KRnkr5FwuYXuE37yKTRf42uqB11nMlmBY9eQdfnmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bePRVRp6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bePRVRp6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705428987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeH3i+LMQzJ6zLjyH4dQUtoqKhfiePEKF2Etnvrjzw0=;
	b=bePRVRp6tig95F+TkP/A5W6YDnRQW2KsPMcQ049zI+itACBR3wJ1nsMbunqJE7kVLbppP6
	7f+J37HOEP2FCp9oDXIJJriKj9fayb7u4X20UjfRAo8wQAM+zK4W+xMffBj5J3oEzKA+Ch
	bPjVGpVj832Thh7oMcohbp15QYIf/u4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-54X1yzK6MqOvF7g-5sbXbg-1; Tue,
 16 Jan 2024 13:16:25 -0500
X-MC-Unique: 54X1yzK6MqOvF7g-5sbXbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D8C23C0F19A
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1D30E1121306
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 4/5] mptcp: annotate lockless access for token
Date: Tue, 16 Jan 2024 19:16:13 +0100
Message-ID: <a587c9fe6bed80dd14126d212230554109f3d929.1705427537.git.pabeni@redhat.com>
In-Reply-To: <cover.1705427537.git.pabeni@redhat.com>
References: <cover.1705427537.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The token field is manipulated under the msk socket lock
and accessed lockless in a few spots, add proper ONCE annotation

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 10 +++++-----
 net/mptcp/protocol.c   |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ae19113b8eb..53e0b08b1123 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -77,7 +77,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
-	pr_debug("msk=%p, token=%u side=%d", msk, msk->token, server_side);
+	pr_debug("msk=%p, token=%u side=%d", msk, READ_ONCE(msk->token), server_side);
 
 	WRITE_ONCE(pm->server_side, server_side);
 	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 287a60381eae..d9ad45959219 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1997,7 +1997,7 @@ static int mptcp_event_put_token_and_ssk(struct sk_buff *skb,
 	const struct mptcp_subflow_context *sf;
 	u8 sk_err;
 
-	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token))
+	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token)))
 		return -EMSGSIZE;
 
 	if (mptcp_event_add_subflow(skb, ssk))
@@ -2055,7 +2055,7 @@ static int mptcp_event_created(struct sk_buff *skb,
 			       const struct mptcp_sock *msk,
 			       const struct sock *ssk)
 {
-	int err = nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token);
+	int err = nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token));
 
 	if (err)
 		return err;
@@ -2083,7 +2083,7 @@ void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
 	if (!nlh)
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token))
+	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, id))
@@ -2118,7 +2118,7 @@ void mptcp_event_addr_announced(const struct sock *ssk,
 	if (!nlh)
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token))
+	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token)))
 		goto nla_put_failure;
 
 	if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, info->id))
@@ -2234,7 +2234,7 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 			goto nla_put_failure;
 		break;
 	case MPTCP_EVENT_CLOSED:
-		if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token) < 0)
+		if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token)) < 0)
 			goto nla_put_failure;
 		break;
 	case MPTCP_EVENT_ANNOUNCED:
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 35a5a2f54362..bc472f1294e1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3208,7 +3208,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 
 	msk = mptcp_sk(nsk);
 	WRITE_ONCE(msk->local_key, subflow_req->local_key);
-	msk->token = subflow_req->token;
+	WRITE_ONCE(msk->token, subflow_req->token);
 	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
-- 
2.43.0

