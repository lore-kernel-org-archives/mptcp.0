Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E7346791
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293127; cv=none; b=WK4ldw2Jo5dXrZdAX8K0QGXhM8+lRHZ/29bYBfVxypSayS9uMuWrhhf5NLTzOWnqMz9Z0OeahPaRZaPCQ1Zyg1IQ8gN+ZIXVbWcSA6jqVq4X981HnFByf9PYZiW6+fDATDhYKb5xmLpCWKWEMs20gAz2gW2cTb5ebkYkKSJEBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293127; c=relaxed/simple;
	bh=iAQlvwi+CPiFalAX6WJ9QZdeCHLSgVQWp5znRSJTDa8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dcRjHVaHQkQxHnrYFOZhQAF8YwtDBm93WKr50564jiJdUfL17xwNgb4VG9A7MNOoXGpTUbUw2uHSRWwrJbAz2RCQoZ5z1PomMWwtJ4vMePK2FRQhReAaJuIjhMNohSdHf4ZNN6YND7PtQgOU2983Ku7ytM9qPO5Fi8qgkLWeiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKNeg7DW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKNeg7DW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762293125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Me4rreWp/5HU/SJCEgJeFmFZCRm90DkRo4EntxdLNtA=;
	b=dKNeg7DWIGTCycpYQKC3/dRvOA8YjFBNeSwmIgs7wcYKGjWqI32VoQN3/hqdowL8WMwvXS
	n5A6cEYdil3EKiiXElKYeG+vgiJUhebUaJZtk2tVbtfq1U98zNRIz83TWu2aN2ocLj5A6q
	TKvH41Xmv2GzDDIL7WDPv+3N1MJGiGo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-m7P6K8vRNP-9L_k6JoC4OQ-1; Tue,
 04 Nov 2025 16:52:03 -0500
X-MC-Unique: m7P6K8vRNP-9L_k6JoC4OQ-1
X-Mimecast-MFC-AGG-ID: m7P6K8vRNP-9L_k6JoC4OQ_1762293123
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4B5E1800345
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:52:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8EED19560A2
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:52:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 3/7] mptcp: fix receive space timestamp initialization.
Date: Tue,  4 Nov 2025 22:51:37 +0100
Message-ID: <1f53b9ab2809061f293d327d1d71cc89a8f6822f.1762292476.git.pabeni@redhat.com>
In-Reply-To: <cover.1762292476.git.pabeni@redhat.com>
References: <cover.1762292476.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yQJNSl5antXJcqOwxWMxhb8JC6wwRkyATmvgecE1E54_1762293123
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP initialize the receive buffer stamp in mptcp_rcv_space_init(),
using the provided subflow stamp. Such helper is invoked in several
places; for passive sockets, space init happened at clone time.

In such scenario, MPTCP ends-up accesses the subflow stamp before
its initialization, leading to quite randomic timing for the first
receive buffer auto-tune event, as the timestamp for newly created
subflow is not refreshed there.

Fix the issue moving the stamp initialization of the mentioned helper, as
soon at the data transfer start, and always using a fresh timestamp.

This will also make the next patch cleaner.

Fixes: 013e3179dbd2 ("mptcp: fix rcv space initialization")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 -- factor out only the tstamp change for better reviewability
---
 net/mptcp/protocol.c | 7 ++++---
 net/mptcp/protocol.h | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 443406bc4a54..fd10565d9287 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2072,8 +2072,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
 	msk->rcvq_space.copied += copied;
 
-	mstamp = div_u64(tcp_clock_ns(), NSEC_PER_USEC);
-	time = tcp_stamp_us_delta(mstamp, msk->rcvq_space.time);
+	mstamp = mptcp_stamp();
+	time = tcp_stamp_us_delta(mstamp, READ_ONCE(msk->rcvq_space.time));
 
 	rtt_us = msk->rcvq_space.rtt_us;
 	if (rtt_us && time < (rtt_us >> 3))
@@ -3491,7 +3491,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	mptcp_copy_inaddrs(nsk, ssk);
 	__mptcp_propagate_sndbuf(nsk, ssk);
 
-	mptcp_rcv_space_init(msk, ssk);
+	msk->rcvq_space.time = mptcp_stamp();
 
 	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
 		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
@@ -3706,6 +3706,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	 * accessing the field below
 	 */
 	WRITE_ONCE(msk->local_key, subflow->local_key);
+	WRITE_ONCE(msk->rcvq_space.time, mptcp_stamp());
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f14eeb4fd884..49f211e427bf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -913,6 +913,11 @@ static inline bool mptcp_is_fully_established(struct sock *sk)
 	       READ_ONCE(mptcp_sk(sk)->fully_established);
 }
 
+static inline u64 mptcp_stamp(void)
+{
+	return div_u64(tcp_clock_ns(), NSEC_PER_USEC);
+}
+
 void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 bool mptcp_finish_join(struct sock *sk);
-- 
2.51.0

