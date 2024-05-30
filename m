Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B717CA1C
	for <mptcp@lists.linux.dev>; Thu, 30 May 2024 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074809; cv=none; b=MbTt5sW4rmPkgtmXDUHJ3hSSA0+dSzPSKH1Ta+yAW6TcpPy51mVf9WBpCJVQF6Wykzy+6IwaLVucz7QHtDAGPe69H8le7LSkcz0diTlBdffmPeOFHVxiWOLdQZsaOfjhdnlM/tsFhjAD2YsvXuBU3UztxJ4jBk3vdNipzS+9UOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074809; c=relaxed/simple;
	bh=LidcF8t23URacHF1pQU5vSKTvOluPtJzGS+Vnc5xckQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GH43uuhTU271Jag9Iq3rsWTRUd09qSJiwgXGBOnQkent4NZP2xHtdfQIPSKFmxRs9CCBmc+6DHRtYL1mxYcDYAfpljPnbgUfMCGneuxhi2jI4m3syuzrECRvwC7bZR2eD//+qzrZma7l/iy3/7cP1H5JCvW+yy3fGV0oRxsaI40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5Awblux; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5Awblux"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f47728fa4cso5856085ad.3
        for <mptcp@lists.linux.dev>; Thu, 30 May 2024 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717074807; x=1717679607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJygBmIY79fvAAP7C8AynPmuHSE1Ops4q9w/nT6BOSk=;
        b=R5AwbluxvmsmMfImu9LaWyJYs6Gb0uxN4PVJvIdc14490ek3Jz5DbrcYNiz7+m1N60
         gY40DeB4Wbvb+JwEM/+1OZR2HerFVtCc42ECVCw31ugl1ZtPzQw70yZPIWylGR1Fs2Os
         v85LsFvnmM2mMBroDYvaPf6v7rQHi33KwW13r3tx+GVN97VGCPwZWAvob/oiLc+lrlsW
         6VtUb1LcunP/kYfuYBD6+N0A2pU8ddaJmTZpPdvVfihr1G4WkZSoE4cl10m92msencgc
         gP20LQW6OlYlnunsVXAHVgL1VcmH3dTwvb13yB0alRKocX+fPiZG1FXkEIO4hXFFxnVw
         bJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074807; x=1717679607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJygBmIY79fvAAP7C8AynPmuHSE1Ops4q9w/nT6BOSk=;
        b=tKte9tqz4Ri2qrp5oXWlHBL2NuEJOodPMQoelhndZIgj23DOYUe+dtJJJLbkAbbPig
         hlzagnXv87jv+PXm1lvjOJNK0kf0528NiknR46Vf1+9Rj5otsLdfkcg4bBmtmBTPsq26
         7AmsSkJSifdSpxu3Xg+Dy3iUoC+EWgOTpxvmC71+JP93ucyU4fJRt1TgmfZXFj314wZ9
         1mO9D8UBZ4XW+FQKYkCsI9mZmMcnFPPMSDUBkQDbuRvcJOUVAYdlLWQ5Nxixxbuh/3/j
         W6MQr4lLZED3WCbBbttB4UYF3h5tfGI4fOpAQ+G4Y1ksBKJwjVV0hwtXVxmcDKQUI5FM
         zPZA==
X-Forwarded-Encrypted: i=1; AJvYcCXvCQLKJaxy5AedAnfRCxYvRyBlYBX2H02fpTztC6fF3rYsB6CvwLozHrWQdX9FyxbDfm8bsoxwkdXGKEPkslcuZqLOp40=
X-Gm-Message-State: AOJu0YxfKn4NOICzcyJjtfUnjuOOTaSu5AKf72QBoDTCk6qS7rP8dD4v
	AqW36iYemjZRCjmCoq4n0AMGnLsxheuXY90yTfG3x2FVEgRoS51W
X-Google-Smtp-Source: AGHT+IF8nAXNCvLE9crt3PfaxaIFi+g17LgND85Olc9PfykOagHx5MHvCbDNWyRXyhTcUeNv7yzCMA==
X-Received: by 2002:a17:902:d2c9:b0:1f4:7d8b:cd87 with SMTP id d9443c01a7336-1f61a4d5390mr22175345ad.67.1717074807565;
        Thu, 30 May 2024 06:13:27 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75de6dsm117814885ad.6.2024.05.30.06.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:13:26 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
Date: Thu, 30 May 2024 21:13:08 +0800
Message-Id: <20240530131308.59737-3-kerneljasonxing@gmail.com>
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
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

