Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4BD186B
	for <mptcp@lists.linux.dev>; Thu, 27 Oct 2022 10:42:48 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so1049216wma.3
        for <mptcp@lists.linux.dev>; Thu, 27 Oct 2022 03:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H6WsQ3KWGpdVyKHLBQa8AnduLOWItG0cpSHWHSxL/Jc=;
        b=WVKvOEa3utPLJjD1Twfm5OizR8E1ucWsRHQjTBxLCCuFA0vf5geCxXBJ4opiJiH8Rq
         d+mIHQaVKt6O0dPX1Yn7OufQTV4i9HBAg/uyLPE/LUhgIFs9qfGPnjdZTn9rke8s/Z1P
         NktIW022GwCJKhXC6RHgOy+Mei07kS20RmeFqCJAarc2uOFoOQ1ESZladD/I/eJwBfQw
         zoAB+7g4f5qYNbla3m1s0jqY7fjDp8j4pQbr2FYrz5pG407g6qZpxnonwgw5y9gAIKBO
         NOc1/sYuloKShC2isZPSW3n+whq0xJfWyEDzVG+K6yVpDGjxhZkAuYFp1/o56RC4zrhO
         A4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6WsQ3KWGpdVyKHLBQa8AnduLOWItG0cpSHWHSxL/Jc=;
        b=s6mycTpObeApeHEbw+0wcffPNzYFaoGBKGbJ2cO1A6VmY6/uZetxe62aKL9I8Q0VvU
         KyvSaCgHOGOTUEyJYIFYYQqYBYnbPLlk3vwca8/N+rRfxrEYGywqP4fi9u55/S3JZR/o
         j6lrX3L93EvAdC2o+ZRDhe8xvknKsQNEKchjlf1klWaUECR/rO/am67JSCXRjLUlIcJC
         gahJwZbIyz+zJtYrCOSfCIVNOdoCCtz0LdLLXvzO9ZwoeZ3KOJ5mbg97eLPFeRKfIey6
         UUgL/CT9MUSQMOPjcb0QhFrx57fRk+LytiqCQRVL5o3Ki/25x0Y3pOlBGGGmOL8Sni/F
         7I7g==
X-Gm-Message-State: ACrzQf3bH9CbA7y4iY3F/lRtVOkqybxMEFJpDeuKFb43S2SYD8MOs7aA
	dtLvFK0zpMWpxEMSdI0K/djBrSKLpsGsnA==
X-Google-Smtp-Source: AMsMyM5gOL1DVYA0pEzDUj92zmccC9KUylqjv0+UN48btEDYnqJ+rN7kFFVHdWIXY3lJnwfZqr3ydQ==
X-Received: by 2002:a05:600c:4fcb:b0:3cc:2858:5e24 with SMTP id o11-20020a05600c4fcb00b003cc28585e24mr5594799wmq.160.1666867366548;
        Thu, 27 Oct 2022 03:42:46 -0700 (PDT)
Received: from [127.0.0.1] ([194.110.115.71])
        by smtp.gmail.com with ESMTPSA id bn8-20020a056000060800b002365921c9aesm918145wrb.77.2022.10.27.03.42.45
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 03:42:45 -0700 (PDT)
Date: Thu, 27 Oct 2022 12:42:44 +0200 (GMT+02:00)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Message-ID: <eede4b08-7224-4d0a-92e1-f2c85d26b83f@tessares.net>
Subject: No meeting today
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <eede4b08-7224-4d0a-92e1-f2c85d26b83f@tessares.net>

Hello,

Don't forget that there is no meeting today at the usual time. I will talk to you all next week!

PS: pay attention to daylight savings: next week the meeting will be at 4pm UTC, 5 might be one hour later if you are *not* in Europe.

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
