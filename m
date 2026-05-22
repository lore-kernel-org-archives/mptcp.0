Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A825A359
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486256; cv=none; b=bP4+/dgeKxh3G0Nl8LcIp2ZCSDEwYkxytaJo8K245rHa2EqQQbYk72n5Ihs1ulA2WLo5Th0V3h/ZAoK8tE2GIk3f7nUXhX812i0gV0R4Rhkshu/H1/h713zbqpyzihAovsgkTZ7KMMVlTAqR9bXneX3iXv/e7Qo4FtOCSVEcTPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486256; c=relaxed/simple;
	bh=gwl+dZ1eUhiNdD/znifmDOOwuSf7gz8pXM0DfLd/q2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bDahetCzpfcEuuq/fU3hbHFrZRyhhzfVzW2/X8zFhUq0eHkbXE48SONYZhVKgUuINTe+uOwaJnn/t9je2QOuJ9HdwXukaU6Ugw8VvgQ5BMkAqy9v/VDx3Aw2F8/u4RQcuohclBn0wJVnikMepawjEWGEbl8osPCc+ndD8n/IC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUW+CwG3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUW+CwG3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779486254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZk5YZoZl8fxVnovYNsrtczwo00g6IVhtNt2pXPqs00=;
	b=ZUW+CwG3uNVMJMKJcir7CchXCebnfcrMwV9280YgAwXDcDPeN3kIT8R92l7KYv8Y24TgZt
	dsw5ocA+yXXdQPHUZ6ITSaUvB8vtsHB4LlfUq17dh0I1UA7CUyc7cNdwquqxil4bXh8CLz
	LMJ3elAwwukhRRFbaO4UCE+woWkb3z4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-gt94aD-oPhufZo5UbrfZEQ-1; Fri,
 22 May 2026 17:44:10 -0400
X-MC-Unique: gt94aD-oPhufZo5UbrfZEQ-1
X-Mimecast-MFC-AGG-ID: gt94aD-oPhufZo5UbrfZEQ_1779486249
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 851861956096;
	Fri, 22 May 2026 21:44:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.93])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0046318004A3;
	Fri, 22 May 2026 21:44:07 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	gang.yan@linux.dev
Subject: [PATCH v8 mptcp-next 2/9] mptcp: fix retransmission loop when csum is enabled
Date: Fri, 22 May 2026 23:43:43 +0200
Message-ID: <eb3104033a7831b126ad918b7f6e5c06ac74c407.1779485511.git.pabeni@redhat.com>
In-Reply-To: <cover.1779485511.git.pabeni@redhat.com>
References: <cover.1779485511.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wwvdONnJ_41nPvjDS65vOHbbJSOIoKVAOOvt8SaUJI8_1779486249
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Sashiko noted that retransmission with csum enabled can actually
transmit new data, but currently the relevant code does not update
accordingly snd_nxt.

The may cause incoming ack drop and an endless retransmission loop.

Address the issue incrementing snd_nxt as needed.

Fixes: 4e14867d5e91 ("mptcp: tune re-injections for csum enabled mode")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f14572fb1975..4f2b2868031a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2867,6 +2867,10 @@ static void __mptcp_retrans(struct sock *sk)
 	msk->bytes_retrans += len;
 	dfrag->already_sent = max(dfrag->already_sent, len);
 
+	/* With csum enabled retransmission can send new data. */
+	if (after64(dfrag->already_sent + dfrag->data_seq, msk->snd_nxt))
+		msk->snd_nxt = dfrag->already_sent + dfrag->data_seq;
+
 reset_timer:
 	mptcp_check_and_set_pending(sk);
 
-- 
2.54.0

