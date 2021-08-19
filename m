Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1388173
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629386192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4cvZ2IEVyFgUPE66xYLtVyVauGBuAZYvSogkTOtgmM=;
	b=XGoVzquTADgN2GGUWB9FZZ3P7vqEz4eJAauY0BTSktMBxNY44bAbYTBmnzjdN8tSkmAROC
	BKVsWb/phD8dpxYYgYueNS13nHMoQNfSInJHFWBceolN+AqxvN4mJydPV3GmgBuCqq6yPh
	PHYPX8ZY/lvedI8CS9ddX/UBkBbo94A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-wRnxRD8COCaHyWIib-Pq0w-1; Thu, 19 Aug 2021 11:16:31 -0400
X-MC-Unique: wRnxRD8COCaHyWIib-Pq0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 888E2107ACF5
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 15:16:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 020726F97F
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 15:16:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 1/4] mptcp: do not set unconditionally csum_reqd on incoming opt
Date: Thu, 19 Aug 2021 17:16:14 +0200
Message-Id: <791bbd0419a8b4f1d2e00b3f6858375d5e33a2b5.1629386016.git.pabeni@redhat.com>
In-Reply-To: <cover.1629386016.git.pabeni@redhat.com>
References: <cover.1629386016.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Should be set only if the ingress packets present it, otherwise
we can confuse csum validation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bec3ed82e253..f012a71dd996 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -355,8 +355,6 @@ void mptcp_get_options(const struct sock *sk,
 		       const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	const struct tcphdr *th = tcp_hdr(skb);
 	const unsigned char *ptr;
 	int length;
@@ -372,7 +370,7 @@ void mptcp_get_options(const struct sock *sk,
 	mp_opt->dss = 0;
 	mp_opt->mp_prio = 0;
 	mp_opt->reset = 0;
-	mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
+	mp_opt->csum_reqd = 0;
 	mp_opt->deny_join_id0 = 0;
 	mp_opt->mp_fail = 0;
 
-- 
2.26.3

