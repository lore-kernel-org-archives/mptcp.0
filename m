Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241412FB0B
	for <mptcp@lists.linux.dev>; Mon,  3 Jun 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434166; cv=none; b=Gn/XciPCTbqDPgUWOA+GjkBN4WrkWWhkB/fyYwCAp3fJF06AaGyNgaLxjxu/h1vDcy0Dw8FE9R+xs7+3es4wA9tkegm6ZvF8iHT73vMTDyvnspLqnqa5ptMK0I0BDGdTpK4HitwVabh3WptcAissVzy6/+5WIx13tKEYLA5Hg9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434166; c=relaxed/simple;
	bh=zISG6yHAh6L1orzXgPMlwLk4EZq0CiQ3ktK1OzoK1Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ufi3vgECFcn0XaZBQz9bji05F3PXEq0aSFN+fqSuX79hQJW0ty6i8qKha65fi5l03ew46Ks9HKsChnUuhzUj4IfKNWHQ9z5AS8riGzKZNFm5j7Rck70A/u2uK3lPepYAhne+0/Hlj2BsR4cxLC3eSuYD9qVhfd8dmAjoWzm51iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCPTz6VF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCPTz6VF"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c1e6eadb54so167297a91.3
        for <mptcp@lists.linux.dev>; Mon, 03 Jun 2024 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717434163; x=1718038963; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUOdVRnefN2TG2DgKbC6vXDKZD70/za0tG8Wz0BIq6A=;
        b=cCPTz6VFbnk/1NlGIqkcw83VbtamqTKMkKSUm5x091cfKc0PQ0TkEAuvdm1cCkTAKI
         YHeV80CNXaRau8b1JOqOacPqFrRYQ80Rfv/dP1dRqVsDNeyUlir8P15dkShPFXh4sv/u
         tk8xMYptLZWrFA2SDc4TxnvdzgHEeJf8m1wdkLgOU7A3Lm1T1cRpsrhgmF7Xl4Ouco3U
         +DdUujhr7EDxQryi6hUo9J97mOZOtynKsh9f+JRh/JqNioTZKk3ntEaq35Z9TRiUY4Ol
         oPz9K1PUIuUVQR0eZG1sVJ7aU9HJ0SStG8p6oUKW26SifpQS/6rkjPQkZJhZY2nMc4j4
         K3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717434163; x=1718038963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUOdVRnefN2TG2DgKbC6vXDKZD70/za0tG8Wz0BIq6A=;
        b=fa4y4lNmp8pwj1lCDfSgh4ZSz3Wt3QaoDciu6YkGp1suTSfV5xTb9ELYLhqq2nh2uQ
         o2YMEree9x/x9ZoByMRm8tjRTataH+gwKa0JZm1/JayA/+NKJVVlgQ074XrPRUgw5b0A
         zCLqLrzCSfrWRKEqmHVvrlxrLNBgJSee8HwTYkXJ5YYpo9jrirfRMRDTQbaLoN7aPLDT
         eSWbNnrwqq6PSDb7F5arIjTyEpzQz2Zt7ETAd0NBerLIJ+JXreHLzd95/tvSmIOichO6
         lvOdGp4TEgmL/stDqwFgGVZIXGjCoMLtBE44feQ/LObNj8xfJQxWTmbUI51NijwRC/jj
         g7OA==
X-Forwarded-Encrypted: i=1; AJvYcCX3cT2eOJJaT/XnaHwghfLKvUpNSOjriQtLyx0pXOfUdk6xmKnf61dAXljARmUbPnQFIWnGN0KiQv4tB8rEo+bu/TQKV10=
X-Gm-Message-State: AOJu0YwsKcL7GD68f7I5gN6yrugH+JP65EKRIl2y42WtMoEAARHGY99w
	D2+H/LUWaI3v+g8fDVo8J2Pt5A1v399HPLgDoXp8c1WmhRgPpF/O
X-Google-Smtp-Source: AGHT+IGoFO32AO0kxmqcKniiWCpHNyKylhFLcQXOZjP8QMHGyuhX0TJFSoxIbEpIvxl1zWJd63qh9g==
X-Received: by 2002:a17:90a:ad8b:b0:2c2:4107:1fc3 with SMTP id 98e67ed59e1d1-2c241073a8fmr2419113a91.38.1717434163398;
        Mon, 03 Jun 2024 10:02:43 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27e577fsm6460431a91.32.2024.06.03.10.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 10:02:42 -0700 (PDT)
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
Subject: [PATCH net v5 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
Date: Tue,  4 Jun 2024 01:02:17 +0800
Message-Id: <20240603170217.6243-3-kerneljasonxing@gmail.com>
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
 net/mptcp/protocol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d44196ec5b6..96b113854bd3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2916,9 +2916,14 @@ void mptcp_set_state(struct sock *sk, int state)
 		if (oldstate != TCP_ESTABLISHED)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
 		break;
-
+	case TCP_CLOSE_WAIT:
+		/* Unlike TCP, MPTCP sk would not have the TCP_SYN_RECV state:
+		 * MPTCP "accepted" sockets will be created later on. So no
+		 * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
+		 */
+		break;
 	default:
-		if (oldstate == TCP_ESTABLISHED)
+		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
 	}
 
-- 
2.37.3

