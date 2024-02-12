Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B1C3BB47
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751162; cv=none; b=lAy76FKbz3oM65D5FYnS3gDTNOk0X/vGZp7mDaWrLLDv0RZSVnzTPnvaSZfkY6G2vk9z41+m3l0tqC7woy9Kvvcp7jh/f9KQMxRDRbpcTJ9mU4CYUnw+vE9WGd+jgc5LljxG+iR3/oO+6cEFAWInwO4JNXNvA6RuBY1QUUgAxR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751162; c=relaxed/simple;
	bh=x+d6eSiGhT2Nlyf5X80Xa2HjBowEIhTNrTNaIs9pyBY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwU74/34OnSy/ScFY7eOTlVSjy3rmILHADEuG83YEL/DoBdxKbq73wgBudLwVZrDSecTt2vzfPQ2goynvpEpy88EcEHyZ6RzFwnCt3c8VLfffAD3aV2dwDszAAmSBnwIoV3Jo7453OHD03xs9xOkcTCObd9D6lmMFkAwUiUCUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDCuRKzj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDCuRKzj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707751159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dBwYBZm8KULJpa+g8Lf6eL61n5tLMWELiidRcbUT0Y=;
	b=aDCuRKzj4N3OdMsl2cCz20XduZq1LTalhaphob7NyhezftB9cOMZoYVkFJNEO6V46G7++8
	CPsYX0p2toYxbAqXtuh0lF6qdzuTqPzE/q8OyUdWzXqVGm++aofpyzkdaVnd5bQ55kqEtQ
	ruQP6u/md4VBB+TenWF73iFck8DSHL8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-gF83pU22Ok-6njeRUwxj_g-1; Mon,
 12 Feb 2024 10:19:18 -0500
X-MC-Unique: gF83pU22Ok-6njeRUwxj_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEAAA1C08BA1
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D8E1492BC6
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 15:19:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [mptcp-next v2 5/7] mptcp: avoid some duplicate code in socket option handling
Date: Mon, 12 Feb 2024 16:19:00 +0100
Message-ID: <4293d2f7cc0edc84a228ab9b04ddaa7d5626f539.1707739536.git.pabeni@redhat.com>
In-Reply-To: <cover.1707739536.git.pabeni@redhat.com>
References: <cover.1707739536.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mptcp_get_int_option() helper is needless open-coded in a
couple of places, replace the duplicate code with the helper
call.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/sockopt.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index da37e4541a5d..ac37f6c5e2ed 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -629,13 +629,11 @@ static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optva
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val;
-
-	if (optlen < sizeof(int))
-		return -EINVAL;
+	int val, ret;
 
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
 
 	lock_sock(sk);
 	sockopt_seq_inc(msk);
@@ -659,13 +657,11 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t op
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val;
-
-	if (optlen < sizeof(int))
-		return -EINVAL;
+	int val, ret;
 
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
 
 	lock_sock(sk);
 	sockopt_seq_inc(msk);
-- 
2.43.0

