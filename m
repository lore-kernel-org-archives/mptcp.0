Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88032596
	for <mptcp@lists.linux.dev>; Mon, 24 Apr 2023 14:09:20 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-2fa36231b1cso2680758f8f.2
        for <mptcp@lists.linux.dev>; Mon, 24 Apr 2023 07:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682345359; x=1684937359;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+e6Liem8K70XXf0wfZkdfebMBxwD1YskEbNt6re7ILo=;
        b=oHd+l+mOls4aa6N57uHf5Xxpq5x5rluyb24AfDOtSaeZ5fKKQS6F48jmq+p2HHRsbX
         Plc7iq4v5xT6C9c59C7ZJbsHLC4SRgTHRu1bGNpbGFUClj7RMwCEKzprE4H1WNYtPuyk
         dGeiI4JQndwEWAjCcRGw/0MdPA8TxIjlOptWlKxNOGvNKfOTP6T+CrUXj7A978rFicHx
         EE2eWJbDzwwQf9VuX46KDXTHI/bKTIGPkzgE0VrDMWZlKs2Fw1OV65iT1Mb02MbYMint
         6EmGrK53XOm4MXe3Mfh58TLbUmEXqeQ1qGwvsTFRDkpXJl615O8UFFv+cW1Q05Wq0LyQ
         u8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682345359; x=1684937359;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+e6Liem8K70XXf0wfZkdfebMBxwD1YskEbNt6re7ILo=;
        b=Y/2AzTixKlWLGJnCdZb6JI5AAFfeCXpTR5YV8hwl598Oqa2q4x8J5ASi3niq664xh6
         x/6XROYWd1Ic8JQH4AV5Hznek2GoBLhjCUDckxt25GabQcWFZtiZON9x+Prji0ggvC2g
         hvJIP80mo8M69mIU8OGy/XQfDX/QaDrK1LN6WEGHUcPOjSt8cFboRKVKZ9rwtURdM1Hi
         pTjAUZqBIN47QMkKTC7TFIpNZbRH+vJ044JFD46ALJIlgHHdLHDJYzTu5EemwoqhVjR2
         J43e9Y6dxumSCfcPGZKrlaeHa/ggpRMTJceyHw506h7xg6ibIQFJLvAaAxzuQjsb17JQ
         jqgw==
X-Gm-Message-State: AC+VfDyG0HVz7ZETwMZYdKYw/o+yj8+XFzCHUd9BkY5k2EBJ6lQOWbrI
	UvH9gKDyKDdlZAh117MW8XVEaw==
X-Google-Smtp-Source: ACHHUZ6Sk/a6imDY/42Ob7uZkQeRm8HDtlOUdBWVPskn5eD4GHhjv3MyeCWkZa1HSJRHiyQisCuzDQ==
X-Received: by 2002:a5d:48ca:0:b0:304:7ff3:9b2 with SMTP id p10-20020a5d48ca000000b003047ff309b2mr1297160wrs.39.1682345358761;
        Mon, 24 Apr 2023 07:09:18 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003ee5fa61f45sm15729235wmq.3.2023.04.24.07.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:09:18 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH 6.1 0/2] mptcp: Stable backports for v6.1.26
Date: Mon, 24 Apr 2023 16:09:07 +0200
Message-Id: <20230424-upstream-stable-20230424-conflicts-6-1-v1-0-b054457d3646@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIONRmQC/z2NQQrCMBBFr1Jm7UiaphG8irhI4sQOtGnIRBFK7
 27qwuV7H97fQKgwCVy7DQq9WXhNDfpTB2Fy6UnIj8aglR6U0QZfWWoht6BU52fC/xDWFGcOVdB
 ij3HQY6SLDaNR0GLeCaEvLoXpyNUlHzYXivz53d/Annu47/sX1D52g5MAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
 mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Christoph Paasch <cpaasch@apple.com>, 
 "David S. Miller" <davem@davemloft.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=wwy461Gwfpcpa0cZnYPEfeHm78stYVLC5xvQOo8KG88=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkRo2Nf0YGcxa0eCStciXodepJljVP9g6kBTma7
 CEO79FsFtaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZEaNjQAKCRD2t4JPQmmg
 c4H4D/9gCiQqqb60CKjNTF36wi+DEWgTDxzCRGcWTlut9aTJfsdFhxmpPpZcXLlZDiHzyVtyBT0
 ThyJeBiM5Z25BOChTyJOe9Q+2TkdXH7C9pw/GuumLrfsGQu0EtjVVjYqBWbqiiwNqwJNJnwQvTI
 9eAP9lZzv0yHBoOIdNV8jG1tcyTb+NMMQzZtZJ571QDbU6VdjZUorKNj4YU+Xyg2sv2p6Emqq9U
 iJTfWkJZqgzk7juGZDiGeTltQpj4E0oIdYajBtyfQ2/h2ciEoRoHf7GDhiGigaFTp/Hq/Gf8XRW
 ug2VQciqS5QRQaV+cuSEwlEvXH+pOgDupxSP1USxOoari3DtIpZBCWUHGJYy7ofnwSMNgQxPfYc
 kbqCExlK5SgcAP7+hhKvPHFJlc0hc4MbpYwaHjovhQD1i6hHohk6wx6uZQ8LUirGUdw/3xnFWYR
 71q9RVss6M43voZDUz3cPnGIuDwUKTdFpI4TZKDUM8oq0lj9UCEpFW/ldHp4FU/WJ1FpB4X1RZq
 frmhBl4IDMI2o1z1+Y9gFPqLwSaYe0Ixf6avghB16HQJvC2VLFmBu7feG3z2cIMyGD1aEeAgVqq
 nnoTryIAgn61q1P4WeL9KjaOk3VQxggVUjxhEKLHchSp5gTvrU4P1CeSqeKr9jYSqzTa0KwyyzR
 ngmRcMLkdCVoKcw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Hi Greg, Sasha,

Recently, 2 patches related to MPTCP have not been backported to v6.1
tree due to conflicts:

 - 2a6a870e44dd ("mptcp: stops worker on unaccepted sockets at listener close") [1]
 - 63740448a32e ("mptcp: fix accept vs worker race") [2]

I then here resolved the conflicts, documented what I did in each patch
and ran our tests suite. Everything seems OK.

These patches are based on top of the latest linux-stable-rc/linux-6.1.y
version.

Do you mind adding these two patches to v6.1 queue please?

[1] https://lore.kernel.org/r/2023042259-gravity-hate-a9a3@gregkh
[2] https://lore.kernel.org/r/2023042215-chastise-scuba-8478@gregkh

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Paolo Abeni (2):
      mptcp: stops worker on unaccepted sockets at listener close
      mptcp: fix accept vs worker race

 net/mptcp/protocol.c | 74 +++++++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 130 insertions(+), 26 deletions(-)
---
base-commit: e4ff6ff54dea67f94036a357201b0f9807405cc6
change-id: 20230424-upstream-stable-20230424-conflicts-6-1-f325fe76c540

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

