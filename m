Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241AF12FB0B
	for <mptcp@lists.linux.dev>; Mon,  3 Jun 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434159; cv=none; b=US5s21HoARC/BwHhK8TKNcMtlcsJLharhIsmh8nKNckWFSN24kyKiCqd7Uoyy6Z5UKyAx0cpOohsNBsARU2kG42KlZS1eNeDaevV96tXccllWGYYlAO+y2PLWe2axedSP7FJwksZMnbUJRXje3rzVz8BTS+nbaQiRH97T4Kw4z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434159; c=relaxed/simple;
	bh=LxPSHGj+YqVPkDKGo+uORRwgqnKKiBsfU35zezrsazo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SlpZx9tLBBrLl8clyP4Eo9l+Nga66wQZvRyAKTwXAQ6UKPzoIQh4S/1F34hWjWu0wDiSj5li3aBlSAJUUgpsulog5l/7DbOQW1aoszEO2KhFr4VUwZXy6KlgAQ+AguP8zaecoYSSDAnftpQDzYV4swltu2slGdtJJbfZfoaPp44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq/RPWKA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq/RPWKA"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7024cd9dd3dso2373223b3a.3
        for <mptcp@lists.linux.dev>; Mon, 03 Jun 2024 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717434157; x=1718038957; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyfPe9ztbEYNGGiUHWp+Lku7sfb+L/LbaE9KE47G5ug=;
        b=aq/RPWKANct6xaUyniN6ITP5QPq1YV046H0t0K7JcTNtfMsc/r2K8+FlmM/u6XeSeq
         Y1Epq3EBrykjBGjFwQktmQXvXG8qzdSI8I5rJOxC4tTbqsMccPivsrTx77hj4/DEeMmE
         KIzFyWAW07+XHmYPwXHNhHBhqByCfXv8YSwZijfR5McWqxBO2uBucNfkXMfw/6NTYyO3
         YTcujrBH3Yyo+FQKG9g9HcbAM3QeFrRyW1oMUH1xn6Q1L3AURka+GSiVwtX464FdDtUk
         KvtWpno4p+gN3s1EUbptGh90Y+gUJCjp36CMkW9ZkacmmaZEWsE80i1KtuSgLQmjtZ6G
         /WfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717434157; x=1718038957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyfPe9ztbEYNGGiUHWp+Lku7sfb+L/LbaE9KE47G5ug=;
        b=LjPcqb4m1eq0ykZ6Dei+7nKKgBa7Nuap+RplzV+UgD+/DOdxXrUEzccJGBLe+nGIj2
         ialnoOT6bsXeENAj+J0p2jKhoZ0mHuNf1jgUcnHGtVLoXud9+6avKXtRPpJMloNLYcxB
         2wu/aXmfWbkMF2m5kUscRWCa5bTYNoMLDmssQwAj/GFSFVV5iM7elFeUKa0MRSUOcPbA
         T47KodL2Enoq7J+5oA1AF1VVGFxxlPvupSePHj3aKXaWaJzc64X3Sb5Z/K+sYhkDhI/e
         hK2ST+hSEjXx8Be+x24cFdwUVes6u2QIYLYdnfVgIt7Pr9Ajem1PjS46v5XM+7BplnHk
         /Icw==
X-Forwarded-Encrypted: i=1; AJvYcCXAlJjQjPlbkAHCFhYAWNYLBSwd7LfKytacArQxjPzOu2NNI4D7gX5sNET0fQ7eyvAwad7GlgUjZ1X34F5+XSJgHK6ON5M=
X-Gm-Message-State: AOJu0YwmBbWFUej42OyN68qOBQ5GKyRq4p0GkBkBbawn5diRXXOibjYF
	I22fLtOpjn5hz7mrhj2mFl5erKFpDIo29Ah3c+HsXuipb9t5tedb
X-Google-Smtp-Source: AGHT+IGpi5Tpv3DJ3j3s3qdDjRqX28Ju2V7VqI8lPxnOSQaD1fyMdZjvXAzIKkzNPgfyWGcBGoToGw==
X-Received: by 2002:a17:90a:4b06:b0:2be:af:3637 with SMTP id 98e67ed59e1d1-2c1dc5c8ffamr8276778a91.37.1717434157359;
        Mon, 03 Jun 2024 10:02:37 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27e577fsm6460431a91.32.2024.06.03.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 10:02:36 -0700 (PDT)
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
Subject: [PATCH net v5 1/2] tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
Date: Tue,  4 Jun 2024 01:02:16 +0800
Message-Id: <20240603170217.6243-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240603170217.6243-1-kerneljasonxing@gmail.com>
References: <20240603170217.6243-1-kerneljasonxing@gmail.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
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

