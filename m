Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E77762C
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082947; cv=none; b=Tgy7lzmicu5eHMbWTjkONpMzn4CQuHbebdX+C9aoGo/QorG/R6k5zLjP68qxAgY2YaDRpEB+LA59IuzjyitAcqk4DXdtlO65D1gjO51FDp+LK1bjA3822IH3CZ4wjc2FIMNEnYwEf2W/cR6szuG/DVXG9EiowIeqNDLy8NDxZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082947; c=relaxed/simple;
	bh=x+d6eSiGhT2Nlyf5X80Xa2HjBowEIhTNrTNaIs9pyBY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtw2C22neA/Dshr6B+wIXJ6Gt88MgYoSRFcfPIPUWjvLAiuXwM5sc2seRcY3cIRfFCZG6eU8xAgWZQGT9OaC4V7mX6mh9QuBI3LJ0OC2S5Wl2o864fi9ASpdkodRrrRlt5SFCyx/hl19gbB0HGhJJpWA9OY08GFLtVbx9BSRyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFzaKvlY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFzaKvlY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708082944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dBwYBZm8KULJpa+g8Lf6eL61n5tLMWELiidRcbUT0Y=;
	b=DFzaKvlYlnaYmPEhT05rdaFb7D0CM6+xyooGvmBdTjChtbhDKg4M5zb1XgIfKOaoY5es4t
	PfBk5a1IADPm7fOsX0ddKnYKeqzY8F3rfcWXqwMuocQGRsPdciWYk2umV4jPlWzhc3dxHh
	TCpZV6J9E5tBBalHo2kJjny7TXqL3Hg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-1k-VptpdPVGbUH470sLXXw-1; Fri, 16 Feb 2024 06:29:01 -0500
X-MC-Unique: 1k-VptpdPVGbUH470sLXXw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEF27884343
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3E5EF492BE2
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:29:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 net-next 5/7] mptcp: avoid some duplicate code in socket option handling
Date: Fri, 16 Feb 2024 12:28:16 +0100
Message-ID: <a0f895e48c9aee80c3700fdf6fe1b7424e98a096.1708082765.git.pabeni@redhat.com>
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

