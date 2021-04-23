Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8FD70
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619189427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnWfBHjXSmHIlflkZFBf8X3K6/89AabtR4hdbRgcJ/M=;
	b=f7YhAkvGyCfqNZ5JfyMGW3z4Z83nW8JlEl+JfV1iQVd/5rOy9LAkG6LwdwNLT/1+oUKxGL
	DcL8tP9H1TwyZc/9Q8/9/KKRmQX1QMGXZS1f1P7FHmAiZfQIS61rTtQkcAwK254kEBEozR
	m2Fsph2D8Dza0Vq3WIchr+DkPVObwVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-Et1KNQSrPYqqGZRddxLOUw-1; Fri, 23 Apr 2021 10:50:24 -0400
X-MC-Unique: Et1KNQSrPYqqGZRddxLOUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E465C1008060;
	Fri, 23 Apr 2021 14:50:23 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-60.ams2.redhat.com [10.36.115.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2478119D9B;
	Fri, 23 Apr 2021 14:50:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v4 mptcp-next 08/22] Squash-to "mptcp: send out checksum for DSS"
Date: Fri, 23 Apr 2021 16:49:47 +0200
Message-Id: <fd487e2c0d5048de25adcfd08d25b677046b87f9.1619189145.git.pabeni@redhat.com>
In-Reply-To: <cover.1619189145.git.pabeni@redhat.com>
References: <cover.1619189145.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Account for csum len in mptcp_established_options_dss()

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4
 - use opts->csum_reqd (Geliang)
 - reoder remaining, dss_size update (Geliang)
---
 net/mptcp/options.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 01caff4cdd25..f8430415a954 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -553,15 +553,17 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
 
 	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
-		unsigned int map_size;
+		unsigned int map_size = TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
 
-		map_size = TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
+		if (mpext) {
+			if (READ_ONCE(msk->csum_enabled))
+				map_size += TCPOLEN_MPTCP_DSS_CHECKSUM;
 
-		remaining -= map_size;
-		dss_size = map_size;
-		if (mpext)
 			opts->ext_copy = *mpext;
+		}
 
+		dss_size = map_size;
+		remaining -= map_size;
 		if (skb && snd_data_fin_enable)
 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
 		ret = true;
-- 
2.26.2

