Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B4779B8E
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147086; cv=none; b=bS/xiNqdpgdTmVV9MiY8kDc8unughZV/ef3hwPPHET89tn+WAgozteYtYKlDUkHjaDietMguk9KCHjv7lcLQ7CN4c03SSR0RnHFVJ3VsBf/4Na8/2YtgBqCpcVW3sfYA8/H8vzb64EloUFdzVlO5ObGgN08eGIMqO83Q2whbJYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147086; c=relaxed/simple;
	bh=LxPSHGj+YqVPkDKGo+uORRwgqnKKiBsfU35zezrsazo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzfZtqvjt3jqb7op9IuNJiLPusyyuAJM31DqEsWNb0kYg/PTBFAQWFgmxKaLmOotuHIG53YNp0oQggbriHgJGwX/mKrsQP206XH0/eEF1JhW919WOHcThxA/oTEV6peWQ/3LS8YuyMwbosXAOcV6jvH6KBwYdPjCaIgm5YjlLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WI37NAxD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI37NAxD"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f44b4404dfso16048745ad.0
        for <mptcp@lists.linux.dev>; Fri, 31 May 2024 02:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717147084; x=1717751884; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyfPe9ztbEYNGGiUHWp+Lku7sfb+L/LbaE9KE47G5ug=;
        b=WI37NAxDeX1O91P6Bqo07VALScvSXwQLWf3OeX9SXCZ2aAoDGXTb7t3rqQHhFlcKnj
         nJQfENH+mL0Iqts+vn6iAsCten9Oeupq5M9wbNo0IEHStINjFakDyspW44hn5mIgjZT8
         PdVq57lx94btm4X9zm3eAlXZdrUQHY+mCFteBWb5IQ/s6OnEQpuQLrBnJhaemXBjYVmC
         cDdOziERazDQJSDB2LG2DJico6V5qWh1C/h7JW4hQg+T76i+uE08DYUZ1xZhYtJGinL+
         50/K/WohIJzb3NtL5GXGxsdS0PXoobUlncV19hvMSwISxaWLOWCxOCpOOD+NBUhAfU8m
         kTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717147084; x=1717751884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyfPe9ztbEYNGGiUHWp+Lku7sfb+L/LbaE9KE47G5ug=;
        b=MPenYA3BqKbkWGnlH0+obQbKer7TQK4nw2xcb60tt99BbcoMQDFCObvolCqkfxmzCb
         4oNs//rMZNCvkJUTEONkokWIW3wFqghgIzCACm5M2PbvxBXdzTFQaJX7oi3nVG6x5l1L
         dJfFjCs2/re8f/rEEZJDK66O2SejV5Mbviw59HsF7yYylcf8ofk0aMrNI3JWCp8b6FA7
         vaqdSi803DBvk5P8ICQyS8lGsqs0uPUWTyIdEAVhx5cggSMpxdG70mac5oy3eDw6r+0w
         7bDIQpoScIdhyfVIT4lzRQfsWUguKGN5DS9KBE3JL51WP0fzgIN0IIfATE3XZeb8upky
         VCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRcrQxcdUzKH8a4E/5ZvIEQPufUPTSq/LY+AvhJpJEtHbZMqY/d4fBHd1rOeklmWKgbpxI+gm+UGzRbJBCsGsIfhbBvPU=
X-Gm-Message-State: AOJu0YxNl2jA4VcjBEW11++peFMz3/PuejkKfm6YeeZNEV081DZatwcb
	b2XRhvpFgm3LFX1H3Hmvx/JuOtXRujR0NpDjkiouMW9+e5u/06na
X-Google-Smtp-Source: AGHT+IGDwC34IENpstbCQnwxx9+3Ns1eMnJa0OYx/FleLHZ0BHNJ3Qbo5Mn2nPMgwK/Pr2FQvqJQ2Q==
X-Received: by 2002:a17:903:22cf:b0:1f3:b0:f9ef with SMTP id d9443c01a7336-1f6370a0c4dmr15508015ad.43.1717147084160;
        Fri, 31 May 2024 02:18:04 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632356c84sm11950015ad.76.2024.05.31.02.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:18:03 -0700 (PDT)
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
Subject: [PATCH net v4 1/2] tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
Date: Fri, 31 May 2024 17:17:52 +0800
Message-Id: <20240531091753.75930-2-kerneljasonxing@gmail.com>
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

