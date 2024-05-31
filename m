Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EEF4D8DB
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147089; cv=none; b=XtBd1xnkxOVvXZuFCvffHIU0OsJhhBJ90Y3K+J0bjA2Mt5jqk5Vtl1Y8MM5OYItfNUnqA3yIcUgDAQIkAIFev9UtDa9M/UHhAhvZn2UJQ0ULKDaAM89YE0/JnXKm6ZbCbgwOrbg+EIxi9kr1bPIxT1IQZC+FWun8wXoB8Ow9RBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147089; c=relaxed/simple;
	bh=eyQnC/rEPBwn0E5uHpSpwaoEXey2aSvRknwYF2ugYQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UBSx9myjNRND3Db90tuPWBTwMLFyi2aE30grmJBnV4oKsljeRQ7S5HXIlJUu91t2MRelACUjA4ryBPKwHR3+/vTwWIMUBWlFmj426wQw3TtDHWSl0BVAyMqTkR9C8eft9UO+uxD8YEchLDBOZk34DrOpbyF7apixTVnyrC7PxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+F6f4bX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+F6f4bX"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-702442afa7dso548003b3a.2
        for <mptcp@lists.linux.dev>; Fri, 31 May 2024 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717147088; x=1717751888; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFtIipB+8uh1h/WWuJkWeXFWlpOYxcgwM8qEpCuPaOw=;
        b=b+F6f4bXv68QUG6zOcUlXVru7dCwdYvpcpQ31PGe2ROlT+FV4tXjfeKEYTrpVs9DAD
         RUd2bpUkz5VQbBrbwelUE/E0Vw4Ff3pUaWEO42P3nRQDnsr2hSAegLURAylsLzHK8xax
         Igv1rPrwDuwqqNc8aj+YJRHqoQyQwOg+eOh9WgMfP1dQsxB3lkk8/kYx9WKQxMpOcBpL
         z0KAeUNYqfbQsK4DO8fSehGKLO8iwIzWa95zGT0dTjyWHhhsqO3O4tsLxpDMZl2lAAHk
         Npq/nZl9Av2GS/nZkwYLhcZ0Kxj59qg1aZWaVrMM7RouGXiyGp/+R5EqZGTO9m3gq5F8
         e6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717147088; x=1717751888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFtIipB+8uh1h/WWuJkWeXFWlpOYxcgwM8qEpCuPaOw=;
        b=F3EvBoj0jLPyJxlwqiA/xvMMonbKBopKuij6pxfMsfufkVZfeqUYR9P9KYUjNZFYnG
         NX6aWQrp0RUMU6sxkPjNRNVlr0Q7JXW+3Zv0X0BQg/u97oEFpDbIt48uAa//td/+sdhI
         CSeCg1IZA+ZYEV7yXN3VwTZyhACKN/P3BJiGY5gxO9qc3GeAq/M6nCMVljeAyc+Pry+y
         oAq2WlrwdkOgbyoevUmklyhPUMnR4uX6973Y09NUgO8rwO7SgQgXc2SMnMVw8Q6OAV+w
         wILsXUXI6CDax6rS9vVGUTStrvC+6dDyLChOvo6sOGA2q4/DSeTOnqQuTiJ4OS+FLWh4
         ii1A==
X-Forwarded-Encrypted: i=1; AJvYcCX1FzlLLL2L01bt3nzbF5l/S67pg8wWu/ixxQVxBT5MnTKDd9DAG5rAgDOUL5RaEYCpAAefwKjvOAi4hH3BgxFDssa+THo=
X-Gm-Message-State: AOJu0Yzjf9zoBpajpn4QWDC8KYghJZCGyb3loPNJfc9z84ihw2ihuzdq
	xfDNVWEkX3nohvmrtEMugX6HLO1iDZBveVedZ8hRIXY0hfsMK6F/
X-Google-Smtp-Source: AGHT+IFBxUg00mUC2sLff/ELtuqbYhpyZ1togUMePSm+KrTfgqA4KJ/wHfhDbl6L7h//L7Hjr1srpA==
X-Received: by 2002:a05:6a20:8403:b0:1a9:6c18:7e96 with SMTP id adf61e73a8af0-1b26f1c4f38mr1384696637.19.1717147087777;
        Fri, 31 May 2024 02:18:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632356c84sm11950015ad.76.2024.05.31.02.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:18:07 -0700 (PDT)
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
Subject: [PATCH net v4 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
Date: Fri, 31 May 2024 17:17:53 +0800
Message-Id: <20240531091753.75930-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240531091753.75930-1-kerneljasonxing@gmail.com>
References: <20240531091753.75930-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Like previous patch does in TCP, we need to adhere to RFC 1213:

  "tcpCurrEstab OBJECT-TYPE
   ...
   The number of TCP connections for which the current state
   is either ESTABLISHED or CLOSE- WAIT."

So let's consider CLOSE-WAIT sockets.

The logic of counting
When we increment the counter?
a) Only if we change the state to ESTABLISHED.

When we decrement the counter?
a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
from CLOSE-WAIT to LAST-ACK.

Fixes: d9cd27b8cd19 ("mptcp: add CurrEstab MIB counter support")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d44196ec5b6..6d59c1c4baba 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2916,9 +2916,10 @@ void mptcp_set_state(struct sock *sk, int state)
 		if (oldstate != TCP_ESTABLISHED)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
 		break;
-
+	case TCP_CLOSE_WAIT:
+		break;
 	default:
-		if (oldstate == TCP_ESTABLISHED)
+		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
 	}
 
-- 
2.37.3

