Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3E034CFC5
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143543; cv=none; b=FSsWmRuZ7VptQZSfs1n+SZm5Rveyj065L5nV//VMdgUlI8WXFaDAI+jnllMrtUNV8mJWzuHKxnYSEwa6SkCnQp7V6VNj5ScTaVAzz8AvnCUGmZpdMwu/n9AK+CQZz2FXg6KO3EKImi2neGOVEguwCxJXPvAXmfT9ggQV6Kvby6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143543; c=relaxed/simple;
	bh=eaMYQX+TvELGANQJQm4+Yp2fUQAnchWMwdgNqaPqnNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=sUkmEZwT85XNSNiBXUw7pNvlNJZoEP951W+R/rIi4WSobMifpgvNJStiw48HKmCGJhW9+Qpl+gmB61ocC+fd9jE2fJSf1YiAily2MzPDxcSdSfn6zcc/8qGcShAJoX/IdGzNfI2JA7jKZu9hJdSrJUMVD6LlGdnvFIw5scW3OQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cqo5CERp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cqo5CERp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761143539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heGPi6cAbBN2yxMkd2fBr/CJiKgfH467iIpJUwG6JWI=;
	b=Cqo5CERpMKWGEFTZu5qGHCp/8Vrmv3Q3oJrBvMu953tz4v6YaBY54UpLcjlvPxTWyJeJqT
	OrAAILc8BBHmDciNsvwlx2zH2RBWprH3H8sAWYbD69fuSBHvUHj3fWJg7rSM9ntb0M7xfY
	8bchqDouaz1xpU/WLXv2F4R2yJ6mR1k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-qSwwG9fnN6WQorgSBJbnRw-1; Wed,
 22 Oct 2025 10:32:16 -0400
X-MC-Unique: qSwwG9fnN6WQorgSBJbnRw-1
X-Mimecast-MFC-AGG-ID: qSwwG9fnN6WQorgSBJbnRw_1761143534
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D9B019560B5;
	Wed, 22 Oct 2025 14:32:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0726E1956056;
	Wed, 22 Oct 2025 14:32:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v6 mptcp-next 07/11] mptcp: do not miss early first subflow close event notification.
Date: Wed, 22 Oct 2025 16:31:50 +0200
Message-ID: <60e46264540b92e915a1464ad037b4a2a6066228.1761142784.git.pabeni@redhat.com>
In-Reply-To: <cover.1761142784.git.pabeni@redhat.com>
References: <cover.1761142784.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7xCORb3jMvaXRly7YPHNrjJFUbBWHkjQpxrkV89CwYE_1761143534
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP protocol is not currently emitting the NL event when the first
subflow is closed before msk accept() time.

By replacing the in use close helper is such scenario, implicitly introduce
the missing notification. Note that in such scenario we want to be sure
that mptcp_close_ssk() will not trigger any PM work, move the msk state
change update earlier, so that the previous patch will offer such
guarantee.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 200b657080eb3e..8c835ba5a437a2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3985,10 +3985,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		 * deal with bad peers not doing a complete shutdown.
 		 */
 		if (unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
-			__mptcp_close_ssk(newsk, msk->first,
-					  mptcp_subflow_ctx(msk->first), 0);
 			if (unlikely(list_is_singular(&msk->conn_list)))
 				mptcp_set_state(newsk, TCP_CLOSE);
+			mptcp_close_ssk(newsk, msk->first,
+					mptcp_subflow_ctx(msk->first));
 		}
 	} else {
 tcpfallback:
-- 
2.51.0

