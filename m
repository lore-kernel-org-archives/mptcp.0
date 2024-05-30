Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C7183070
	for <mptcp@lists.linux.dev>; Thu, 30 May 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074806; cv=none; b=qtPJlrzG+si+soISmgHMqHq2ACbr31BxiKP4krifD8o9Riw6M6CS3vE2mfAeGVKOgUylTlIghRLR9HeLXT0KCvYdWW4pu4VGl1JFA9RyOHlpGPYTShqdDz7sjGwiTnGdhisKIQUfafxujuHVzHK8LdF/Ynns6rjEHZPIxFX65mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074806; c=relaxed/simple;
	bh=Wpgs9oUIypF+YvMnNy17mKtpyzQ9DGF0AjFAPIa2cog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j2m3+8cTjLUdbDcS2iXi0YmbVhND+LHJLsdlwADEmqMT92W19WRvOVPRE8dOBBRM+PdkCsunXqba+5SCgHbVUqaB0DPRh1RPsBv5/awL8MdBVOJhNZEQHFrBQlzscO6of8B8Wk/KDQ9jLPnZN/WhGtG2GmByNKwGMCgHjF6pQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhzV8Hls; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhzV8Hls"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f612d7b0f5so5533625ad.0
        for <mptcp@lists.linux.dev>; Thu, 30 May 2024 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717074804; x=1717679604; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSri7aw0KgXxxDOvTqU37iQnlBCCkk3J7IFK321nd4M=;
        b=mhzV8HlsIvRfpWjkwblPrFdZlHMW2kgA/PtQFf506oozU89G0NHOQc5YlycUpPUwCj
         g/AfE+aK+LsTmUCCr7XPvyiuSLmUvBBJsJbmxt3U+QmDR99B4v2XSBRAaW5PtIV9qeLv
         GxCNdd8+abYJnF2guEg04K/WVOg3WulB3giS6SGiwPWgxoVwoJsTgR9FXZWqW5D/snij
         WBzYyyFt+nDjPFy7nuen3jwFJ+PTZoIezolBFyniLJ8/zuoGbEghB2s5vQA6VxKkb28a
         TCU9FFVUJ/KRnkN+cnRxBkCVPt5OvhcwKM1Vyew6uumoatKFKwe69g3CZgQLC3m2jT5A
         lX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074804; x=1717679604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSri7aw0KgXxxDOvTqU37iQnlBCCkk3J7IFK321nd4M=;
        b=ElA8LJMCV4EZFP2BZSzzGpzplE9U6hJPBGqQY2sk2XMleeVkH1SkJ+OKeDyQMdKNBc
         IBytIzaY2/x5tx/Q5ZDqwpkIWYhHFHFS4nWOj0yy0WOubJRiN+jUE1d24YkPkSXcIe5f
         6l7GHO8VMCz/xVdPOMm2rtYsv0xKQH4WBplgNGVEf12BLzeVPeennfLHKk3uY3crkZNE
         xX21Ly2sjpPDSPqrM2NlhQsgE3TticLA46pz5kU6Pv9DeyszAWSaYR1eaIAJkUpSHNNv
         X0P4Us635onV0kLQ8WWtVsll/lMz3g2oIAriPQoQPmPEogY2+1R7TYO68LJvElFeD6tN
         DZxg==
X-Forwarded-Encrypted: i=1; AJvYcCWeWJn/f6DpBb5nO2fppUU1kTffwaR60aVlowPQ9dk/1CLQjTVQpImTyvGByEJWxU/3sBMVXhF4CWkZFvS+MLmZvrUSgGA=
X-Gm-Message-State: AOJu0Yxcbi+BGVw93in7ZRnpTJ2PPW0Uo7n72jkU9ta5M9PWj0He4zno
	3og8PBtTFt5cueGiX6FnwJMth2MQ9JRaNLRiN84CDkZSNkEOpPrP
X-Google-Smtp-Source: AGHT+IEP4j6FTfV2AFI6IKK+thft4SO9J3LKn/pKJmSe6Qnkac4vMuZU4u3BFjtyj6bO6qpmGWETTw==
X-Received: by 2002:a17:902:d4ca:b0:1f3:4f58:2037 with SMTP id d9443c01a7336-1f61be7749bmr25529205ad.18.1717074803969;
        Thu, 30 May 2024 06:13:23 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75de6dsm117814885ad.6.2024.05.30.06.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:13:23 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 1/2] tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
Date: Thu, 30 May 2024 21:13:07 +0800
Message-Id: <20240530131308.59737-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240530131308.59737-1-kerneljasonxing@gmail.com>
References: <20240530131308.59737-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

According to RFC 1213, we should also take CLOSE-WAIT sockets into
consideration:

  "tcpCurrEstab OBJECT-TYPE
   ...
   The number of TCP connections for which the current state
   is either ESTABLISHED or CLOSE- WAIT."

After this, CurrEstab counter will display the total number of
ESTABLISHED and CLOSE-WAIT sockets.

The logic of counting
When we increment the counter?
a) if we change the state to ESTABLISHED.
b) if we change the state from SYN-RECEIVED to CLOSE-WAIT.

When we decrement the counter?
a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
from CLOSE-WAIT to LAST-ACK.

Please note: there are two chances that old state of socket can be changed
to CLOSE-WAIT in tcp_fin(). One is SYN-RECV, the other is ESTABLISHED.
So we have to take care of the former case.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
previous discussion
Link: https://lore.kernel.org/all/20240529033104.33882-1-kerneljasonxing@gmail.com/
1. Chose to fix CurrEstab instead of introduing a new counter (Eric, Neal)
---
 net/ipv4/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5fa68e7f6ddb..902266146d0e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2646,6 +2646,10 @@ void tcp_set_state(struct sock *sk, int state)
 		if (oldstate != TCP_ESTABLISHED)
 			TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
 		break;
+	case TCP_CLOSE_WAIT:
+		if (oldstate == TCP_SYN_RECV)
+			TCP_INC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
+		break;
 
 	case TCP_CLOSE:
 		if (oldstate == TCP_CLOSE_WAIT || oldstate == TCP_ESTABLISHED)
@@ -2657,7 +2661,7 @@ void tcp_set_state(struct sock *sk, int state)
 			inet_put_port(sk);
 		fallthrough;
 	default:
-		if (oldstate == TCP_ESTABLISHED)
+		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			TCP_DEC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
 	}
 
-- 
2.37.3

