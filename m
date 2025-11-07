Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A52D73B6
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504350; cv=none; b=rpAubZ/m4sbmXiBO0/88efl5RJ/Lw5cbiGmH3W/oVmYhxfBNezw0Sq3tFumqY7n7AXIn7uqrMZpXMRcMpcs7MMK6SCp2H84/+ZxmKs5zxW1U02kVu/zh4dJLr58r6oxszUwzvFHfakOBNvdzo+NrzIhOvRvlW5QAH366hM+lKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504350; c=relaxed/simple;
	bh=9GgvoNJAko9m/bAY2RU5JPF7twA5GR8qde2GD/FiiI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=oQJTWsRKm6I220JovKdOTMCR6+9ZImF58iiUA/P0zRJcDAaCh3DsLmrGSvK0eITlEGkg7DlCHyqTBFpnwvhflfpV56BxrED9rIPN89l5uXzs28drEMSqlsVnSSQXVu5FwHKjyLBuNd9B/z8S1pN2D3e+g3GvYsCkrx48wQtlfRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MM3LoiZE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MM3LoiZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762504348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5NEjoAU12ZmrZhsw0hzA7Ve9AZaP0CQ+SAYHceHQ7M=;
	b=MM3LoiZEPjZVCvrQ7Sv8IQqRbKvnNig6pwVPbo3XrP0ggn2lv52zk7RaIH/Xd3owCvuyrJ
	hXE/ialUHOrb6WYnaJuGbSG3NGzfTNU/YOgyFYow4sK2bpzBVQm1WROqjFhDmOzPzVYNKL
	wN0vSxunrp9CyjARkZEkrL2GI+QfZYo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-NswogssvP-yYWWVhHBjONQ-1; Fri,
 07 Nov 2025 03:32:26 -0500
X-MC-Unique: NswogssvP-yYWWVhHBjONQ-1
X-Mimecast-MFC-AGG-ID: NswogssvP-yYWWVhHBjONQ_1762504345
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6A5C1956088;
	Fri,  7 Nov 2025 08:32:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.157])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CAEE1800361;
	Fri,  7 Nov 2025 08:32:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
Subject: [PATCH v3 mptcp-next 3/7] mptcp: fix receive space timestamp initialization.
Date: Fri,  7 Nov 2025 09:32:07 +0100
Message-ID: <9840629a42a01472c2a9d41d03bae15d4dc506c3.1762504059.git.pabeni@redhat.com>
In-Reply-To: <cover.1762504059.git.pabeni@redhat.com>
References: <cover.1762504059.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7nFJXjeLjobIaNaKP59Kxo1zPAc3Vulym5M08WS5qkU_1762504345
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
index 31154e2df5ee..9dfec22694cc 100644
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
@@ -3505,7 +3505,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	mptcp_copy_inaddrs(nsk, ssk);
 	__mptcp_propagate_sndbuf(nsk, ssk);
 
-	mptcp_rcv_space_init(msk, ssk);
+	msk->rcvq_space.time = mptcp_stamp();
 
 	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
 		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
@@ -3720,6 +3720,7 @@ void mptcp_finish_connect(struct sock *ssk)
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

