Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0E1FF7A1
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487046; cv=none; b=P1IS+KNxkUVdlDfnlOJLBtUOYTfMOGjesVOW7Zcyg65zd+Hnb9Nd9MiDVuA9XXmHnElA+7leo+pn/L+Eai4AOPGFYw0qOdAdsByfigRhPLuyxGw8sLpM8yN41zMVARavzdtae7bhwXsr/320I76btD5zhZhjz8XMeK8xUoO8hMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487046; c=relaxed/simple;
	bh=nh0JS+9Fb1CZPzBhYUtvUU3O+CP21dHcWnWjQCZq1iI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TCEpCnfQUicS3arttj9icb2XrfY6RVCP6Yvg8KAyvakqQjvYb+Fbzv1dmCXotkDKin0UlbQnuUK/ghtZSAFxFKXh4AmwRPUZn+0w5GsfoiYOjDfa9UEKxxxfUvZfpAmc/iaihJilDAWeO09l5p6tetMS3xQqWn6zaFvPyPgr/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwjReOVz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwjReOVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733487043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIziDAgzhno3pF7TeaMOb+Tqv9Hx8iYCJIuWwtOGo6g=;
	b=RwjReOVz7jIdVQqYyTTGyfXidmTneprw8ERUjsUUn3cVImvqSZQeU/bVk3IdoK5AYSx8Lo
	LvVZEWUgFxJ+9cgyJgUhUmUCAYfFt+Cynu0tGUg8p0jOcotCs+gumHAAtn59mmlUrGKUyF
	QoMO1Wf32tDloUrSShEf/bcLGfGfC9g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-04d2w_tzNDie22N2yM2bEA-1; Fri,
 06 Dec 2024 07:10:41 -0500
X-MC-Unique: 04d2w_tzNDie22N2yM2bEA-1
X-Mimecast-MFC-AGG-ID: 04d2w_tzNDie22N2yM2bEA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 501D1195423C
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.243])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A0BD1956095
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 1/7] mptcp: prevent excessive coalescing on receive
Date: Fri,  6 Dec 2024 13:10:34 +0100
Message-ID: <9c5947ad3b55695cb6000900acad5471b7314195.1733486870.git.pabeni@redhat.com>
In-Reply-To: <cover.1733486870.git.pabeni@redhat.com>
References: <cover.1733486870.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VOZ2moFR3Qcaad15UcJwYcGN6BxlIKXjWVVg_VuyKbs_1733487041
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently the skb size after coalescing is only limited by the skb
layout (the skb must not carry frag_list). A single coalesced skb
covering several MSS can potentially fill completely the receive
buffer. In such a case, the snd win will zero until the receive buffer
will be empty again, affecting tput badly.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
No fixes tag because the problem is not very visible in practice
currently, but will be apparent after the rx refactor.
Still I hope this could affect positively the simlut flows self-tests
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f768aa4473fb..fd9593f85a98 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -136,6 +136,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int delta;
 
 	if (MPTCP_SKB_CB(from)->offset ||
+	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 
-- 
2.45.2

