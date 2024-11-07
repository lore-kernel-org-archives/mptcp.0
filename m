Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B141EC01E
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975825; cv=none; b=Be48b9BWDDi62c9/HWQosWrrfDW3g37aBvorOVjRrobt2oQttloklPWsrEuHCYij7e3jgfTfvv0jgy5Oc0Yz/juenO4ESMjv8jkC+h1HbX4i41gjoLuj4b4P2+MsCVc66doENe5yXaFbdSRPCWq6GvVSvWLbg0uFR2sdlxEfPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975825; c=relaxed/simple;
	bh=WODWf4kizp6Gb43EtRkQfRAQmJvFlX5SfA19hWLvooo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vzy5tRRewkq6nOHCKiDiFuWtUQ/esmEe6Mw9iPfCzTZSFM5qLTGh6wc8uG4n8eMUx8T3FocJFjUFJuZEP1NoKx2eK1ZJb18DF9AyiXn3sgC/alZfSZQ258hrsUfJPGxmxbPUYiUQXOicvR+EXbkbvvT8xhJ7fEUo7OZLvaQbY5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNGZ3WWw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNGZ3WWw"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e690479cso630473e87.3
        for <mptcp@lists.linux.dev>; Thu, 07 Nov 2024 02:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730975822; x=1731580622; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfZVIGt8Rmy75o208RSK4hSdJkPI/4dSjeFGxBLdUh8=;
        b=QNGZ3WWwp/LbzLOP6mOqo5VSQIDOfJjt12vTISgrJiUn9eH8l74FkI23p2IHCn9y7/
         iLlrikFNCAxuZDKb3C0aD0anTLhBnv0msaOsWHix4AT4S/GZPgtTXWXVLlXV99TgFl08
         mo4yuGBCBQe4MQDlqwK2UggiNonC0b7HTBJEGyLFXkco3ux8S1KSeD786zko0KEjJvKl
         X801KTGB8jFvF5EM5zqX4bkcC9MgQiVTHImhGQbAoCagqJIgwdIiZQShSXyqcDqB+gPD
         Vf5q3nnPc0SWoKK0Jre/vwnvASyUnFHVP/eCNCG3AVjSMnn/b1otGX/8uaTVpC4MLGYF
         ZTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975822; x=1731580622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfZVIGt8Rmy75o208RSK4hSdJkPI/4dSjeFGxBLdUh8=;
        b=qBdFTjAKc2gFYj4DQ5QQ4xxQoRf+DUlIYUddbZ01Dohgl8HNJ4f224u+KgvPOhhX2O
         X5CamoD1xDHyq7t6o5/Jyg69PI+tHm+aSig/IX1SMxivwP/4gZvi13KdaRc1NcbEBDbQ
         zNTumq4liOQZ9IfvV/5OrmbJqfIfG/b2yImR5t2/xc0epJ9ifmEvcDW9Dk85s5jdlWUu
         tQN4/9zMG9R8IFLrtlJvsP3O3glnMhu242mUSkxptXADg6AhQsro8VhGXSmiyR95Dx6y
         NvyXaDlLrvtJhlL7u3rB75ltQvBxNtig77qkVBvAwameV6+CtBn+kE4x2Gh8+rw+tYqm
         XS9A==
X-Gm-Message-State: AOJu0Yzx8ia59/Op9jRJegUXX/iaGeAS+y1K9dlZdkfGo/EXLDjWP4w7
	AHooKt9i3wvp8yR3mxC5nn/kLzc9U3ieLT+W4/LCBNXVAWVOhC2u
X-Google-Smtp-Source: AGHT+IHxkKwKzxkqB/vK0lp80N/+iOYb02NNcmbAQEHv3G4+1z49VyK7rPqMqOkEMoLHx00Q9mNkPQ==
X-Received: by 2002:ac2:4e13:0:b0:539:9867:eed7 with SMTP id 2adb3069b0e04-53d65de94b5mr12747124e87.24.1730975821693;
        Thu, 07 Nov 2024 02:37:01 -0800 (PST)
Received: from localhost.localdomain ([178.219.168.100])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a9e4fsm160025e87.221.2024.11.07.02.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:37:00 -0800 (PST)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Dmitry Kandybka <d.kandybka@gmail.com>
Subject: [PATCH] mptcp: fix possible integer overflow in mptcp_reset_tout_timer
Date: Thu,  7 Nov 2024 13:36:57 +0300
Message-ID: <20241107103657.1560536-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'mptcp_reset_tout_timer', promote 'probe_timestamp' to unsigned long
to avoid possible integer overflow. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e978e05ec8d1..ff2b8a2bfe18 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2722,8 +2722,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
 		return;
 
-	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
-			mptcp_close_timeout(sk);
+	close_timeout = (unsigned long)inet_csk(sk)->icsk_mtup.probe_timestamp -
+			tcp_jiffies32 + jiffies + mptcp_close_timeout(sk);
 
 	/* the close timeout takes precedence on the fail one, and here at least one of
 	 * them is active
-- 
2.43.5

