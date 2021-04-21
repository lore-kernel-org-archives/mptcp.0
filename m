Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CBC2F83
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5u9JVLuIAyG57I/hEOQ65KgrmnLaavPZrvgg++c/p4g=;
	b=bI6N0YcAarhNi316im5jFpb1uxQ08EH0o2XYszwwqfnWKiuPL8orSUORRFR7XUdvVQus3d
	HGFLAEH+47PZHOfLBZtLVdhgSVJmgmRk/EKvt3GEZm75MdIM8pznVIMyeEtV/FS/Ff0JPz
	PtvdiH8pSuSwPBfkbIwMCjXdC0sLLfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-iJePxWpbOZa42gcJ6-AE4g-1; Wed, 21 Apr 2021 16:20:41 -0400
X-MC-Unique: iJePxWpbOZa42gcJ6-AE4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E141F108BD16;
	Wed, 21 Apr 2021 20:20:40 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F07FA6085A;
	Wed, 21 Apr 2021 20:20:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 08/21] Squash-to "mptcp: send out checksum for DSS"
Date: Wed, 21 Apr 2021 22:17:57 +0200
Message-Id: <dc70316d43c4344da0e78616d9a9f23640e22c78.1619035356.git.pabeni@redhat.com>
In-Reply-To: <cover.1619035356.git.pabeni@redhat.com>
References: <cover.1619035356.git.pabeni@redhat.com>
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

Account for csum len in mptcp_established_options_dss()

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
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

