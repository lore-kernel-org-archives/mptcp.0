Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB0A357A32
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763554392; cv=none; b=ZUjXxPpH1HhJbiLQ2lNi57s6jvX/KLhe+5VO2ciRa2bfBlO/QkBpgoGthmmWecc2xwOrqQABmVdBDd4ZgfR9JuGzpJS23/Lb8W1MvL3bpTIeU3AEXj28uUV0+ZniXNpHMGUvJ5ImqdSdPrrFKcSYG7Na5CsragmqYfXRUrU8vm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763554392; c=relaxed/simple;
	bh=5RBPt6YSmJMCMi6vgcWNU1NqFPuJ/HtHROADFPjZVd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JBqIdNaYp1I2lVZuk/bSCv0KZyjIjVTLlV+Bf8XfRNggbnUhWyu8tBpAzX5FdIpxsy8ux9z8plEec6G/e9MSNB04njpb0se9mTZRTCgTxr5EqbuvIZscspxK5udY2ORKylZA9k5hH8omrqk1W9/fbT0MJw4z/uRg1oYRqNC2pq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMWUjwkg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMWUjwkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763554388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0KItWhDxxaIFHIFSvZCOY/XWLEcM1aTO5QNapZUrfEQ=;
	b=XMWUjwkgwozymGIMwpqfxsPdjP7UaFtjkAGUdXne0ovYz/ri9/aXVMbSvkNSJ+6uR5027R
	dePJZFoJGATuSL/natJgG1VwkBg6u+CE0hYrt71GmXUVZlflhnyu7Jg4PVjKIA6gWmBbTN
	vlbJnJ5eNQzJcCxNnfjr7zZEfx4Y4+k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-9InAmiTSO22GvmSDrSjPfQ-1; Wed,
 19 Nov 2025 07:13:07 -0500
X-MC-Unique: 9InAmiTSO22GvmSDrSjPfQ-1
X-Mimecast-MFC-AGG-ID: 9InAmiTSO22GvmSDrSjPfQ_1763554386
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F06318AB300;
	Wed, 19 Nov 2025 12:13:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E40F8195608E;
	Wed, 19 Nov 2025 12:13:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: martineau@kernel.org
Subject: [PATCH mptcp-next v5 2/5] mptcp: fix receive space timestamp initialization.
Date: Wed, 19 Nov 2025 13:12:55 +0100
Message-ID: <b5d273206e793ebeb9348eb6a7043f838358dd9b.1763553361.git.pabeni@redhat.com>
In-Reply-To: <cover.1763553361.git.pabeni@redhat.com>
References: <cover.1763553361.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ESQ-2Lxcf_SaE8Q9VY4RRYhUImr1Hco2o1b4LrAfcEg_1763554386
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
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 -- factor out only the tstamp change for better reviewability
---
 net/mptcp/protocol.c | 7 ++++---
 net/mptcp/protocol.h | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 64f592a7897c..8b2824834b10 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2089,8 +2089,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
 	msk->rcvq_space.copied += copied;
 
-	mstamp = div_u64(tcp_clock_ns(), NSEC_PER_USEC);
-	time = tcp_stamp_us_delta(mstamp, msk->rcvq_space.time);
+	mstamp = mptcp_stamp();
+	time = tcp_stamp_us_delta(mstamp, READ_ONCE(msk->rcvq_space.time));
 
 	rtt_us = msk->rcvq_space.rtt_us;
 	if (rtt_us && time < (rtt_us >> 3))
@@ -3530,7 +3530,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	mptcp_copy_inaddrs(nsk, ssk);
 	__mptcp_propagate_sndbuf(nsk, ssk);
 
-	mptcp_rcv_space_init(msk, ssk);
+	msk->rcvq_space.time = mptcp_stamp();
 
 	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
 		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
@@ -3745,6 +3745,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	 * accessing the field below
 	 */
 	WRITE_ONCE(msk->local_key, subflow->local_key);
+	WRITE_ONCE(msk->rcvq_space.time, mptcp_stamp());
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 199f28f3dd5e..95c62f2ac705 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -917,6 +917,11 @@ static inline bool mptcp_is_fully_established(struct sock *sk)
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

