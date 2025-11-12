Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF782DC76C
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940479; cv=none; b=FynAIsgWV4+UTnQ3Px8QPUxtDNOmCGIPXbpyqL6lrS+hgkvn7usa2thxhMdOGNLsmh7nbqC2nICjdoMdrqZbLIYYU8ahiltvLVB1HAYBdJs4qIsMPEsLpJyflZVPo85JnledbBN5XhqhSW6rweCHkGQZrHNc+KaJbQJjUBAQv5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940479; c=relaxed/simple;
	bh=HXuSAo7CYUIfKUYDnCTsdRlarfpGPcJ+smgPvRxAZnc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=s7FDXQmlMsXggn8sPKnG+c6aEOIGFo/ySqP21bKw53uc2uQ+MOeuO/Lgri2YTSs0fTlUa8BTSwpDPDJzwwL1q2eQYNjHyLidJfQQAeOlf0u5ISEqy3gA4lRRB7BlW43BeVCP2y5kSJhr29Hhh4mxtnSB8fpERwUK2n1cgiR9gMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVAh9hOj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVAh9hOj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtT43FHSJ9+POsdbG3U5BaTw6ZMDe4fvQQpT68Pr13o=;
	b=PVAh9hOjQzHJm46FfBaHovhsR26TSjb6LuD7fJj2SVd1MCI0XGd1/w2mmcUm9ST8j+/ar0
	GVRmXdESmi5ZQ1lSEYnSfQp8WkVL7Ohl8oqy7EiALdwW5IH7Cb8dHOG0s0TaSd0GFBigDZ
	lNLLzztoRUor6Bg+AMLaFtcsIX0t25Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-RM_czQocOlGoLN3Vkxc-xg-1; Wed,
 12 Nov 2025 04:41:15 -0500
X-MC-Unique: RM_czQocOlGoLN3Vkxc-xg-1
X-Mimecast-MFC-AGG-ID: RM_czQocOlGoLN3Vkxc-xg_1762940475
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B23119560B2
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 259B01955F1A
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 2/6] mptcp: fix receive space timestamp initialization.
Date: Wed, 12 Nov 2025 10:41:02 +0100
Message-ID: <7152b5431a95b1b52251e7df3120590c28749a1a.1762940290.git.pabeni@redhat.com>
In-Reply-To: <cover.1762940290.git.pabeni@redhat.com>
References: <cover.1762940290.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4o0RgYrTaw2tMiRSOtyhM8dHscXgu-vVdpV4GTUD2m8_1762940475
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
index 7510bc634585..9bff316558b4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2074,8 +2074,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
 	msk->rcvq_space.copied += copied;
 
-	mstamp = div_u64(tcp_clock_ns(), NSEC_PER_USEC);
-	time = tcp_stamp_us_delta(mstamp, msk->rcvq_space.time);
+	mstamp = mptcp_stamp();
+	time = tcp_stamp_us_delta(mstamp, READ_ONCE(msk->rcvq_space.time));
 
 	rtt_us = msk->rcvq_space.rtt_us;
 	if (rtt_us && time < (rtt_us >> 3))
@@ -3508,7 +3508,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	mptcp_copy_inaddrs(nsk, ssk);
 	__mptcp_propagate_sndbuf(nsk, ssk);
 
-	mptcp_rcv_space_init(msk, ssk);
+	msk->rcvq_space.time = mptcp_stamp();
 
 	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
 		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
@@ -3723,6 +3723,7 @@ void mptcp_finish_connect(struct sock *ssk)
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
2.51.1

