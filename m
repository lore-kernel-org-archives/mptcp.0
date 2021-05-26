Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17E370
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622042763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AcWkiKSZ8yHV3kxJO5ZZkW5/1vqbxHCCKA4qfuymk1M=;
	b=I8ua/tlYcMZ8TAiP3fvgIaOdFJhF/cetJ7/iGVtpStCxzzTTpUAqFaV4p0up5CPxqsPLG1
	8Lf1vRIeO5kMN8kg2IX5TFYTJ0MgWO85M/tjWkvJ3zE7DZEaVhgN80Iu8CW4L+R7P7NtCY
	l3r18XcfEr9XSLU3rfWwvueOLp48Bn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-MRC9On8XMP-7D4wL-LY6yA-1; Wed, 26 May 2021 11:26:01 -0400
X-MC-Unique: MRC9On8XMP-7D4wL-LY6yA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79D6BC73A1;
	Wed, 26 May 2021 15:26:00 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-44.ams2.redhat.com [10.36.113.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7FF1060875;
	Wed, 26 May 2021 15:25:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: max@internet.ru
Subject: [PATCH mptcp-net] mptcp: let warn_bad_map report relevant values
Date: Wed, 26 May 2021 17:25:50 +0200
Message-Id: <e553550a010387f7ccfafa4010397413b032eef9.1622042688.git.pabeni@redhat.com>
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

When the right bound check fails, warn_bad_map() reports
the wrong ssn value, let's fix it.

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6b1cd4257edf..726bc3d083fa 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -821,7 +821,7 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
 	if (unlikely(!before(ssn, subflow->map_subflow_seq +
 				  subflow->map_data_len))) {
 		/* Mapping does covers past subflow data, invalid */
-		warn_bad_map(subflow, ssn + skb->len);
+		warn_bad_map(subflow, ssn);
 		return false;
 	}
 	return true;
-- 
2.26.3

