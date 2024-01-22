Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC97CF06
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936138; cv=none; b=fdvXdnfET0eOnTYszGXml7Lx3fSzJNfb8M5uIffMSCDZHZaSW3F02N74Plct4JW6Cr7Kji+FYpjhzFV5EyMeDjNMo3zFZTAQUDsAOwxFxIDm+GAadLkLmsKd3OImfqWIw0D2h0U3n433QzBL5MK1zb3/fpzzo9t0y2YkkYKPnH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936138; c=relaxed/simple;
	bh=x+d6eSiGhT2Nlyf5X80Xa2HjBowEIhTNrTNaIs9pyBY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/s8ztWxinRKlYXUIz3iBodtWx4BS4WsvynZGVpNGwDKvg04kYQkDaeOT63wLjut0kKH6ZMf9jaoWwPcfJ9MuDhYnkciXF8ZyxKsA41bTadH93bqT8yPSW2k6EwgF7HvUJzLFryfL9TZEBxd7dWWkL0rBaIo+heCSRWBnm2BEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FXtaPwQ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXtaPwQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705936135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dBwYBZm8KULJpa+g8Lf6eL61n5tLMWELiidRcbUT0Y=;
	b=FXtaPwQ810LS/Iu5nlSL622zO5wSAol1mNLyjD/IaJkI6RTpvLb0n6GJ474RuRO5dmFoX/
	KTYG9A7qtK5Lk4rGdK8OHYFlpRGbECOK0DcIkYFgvR1Q0H4LCPYjpX82E9ICkCh8KDuoUc
	FVJxcC/4LnRjgYk5dHvYo456YvaZfEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-n_0_BYLmNaWWKdmhmqy0UQ-1; Mon, 22 Jan 2024 10:08:54 -0500
X-MC-Unique: n_0_BYLmNaWWKdmhmqy0UQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 351B2185A788
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B98E41C060AF
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 15:08:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 5/7] mptcp: avoid some duplicate code in socket option handling
Date: Mon, 22 Jan 2024 16:08:42 +0100
Message-ID: <ddb32799cd83b4536dcce71b0d614c083df42549.1705836321.git.pabeni@redhat.com>
In-Reply-To: <cover.1705836321.git.pabeni@redhat.com>
References: <cover.1705836321.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

