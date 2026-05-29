Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE21391E7F
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076738; cv=none; b=f4natur8lLc4gE2RRjjGp+iyQpxIsjSIkqNZfitOLukTb+0Nbm7iw+EI5pltbEQsEYAnIVZnqNMhMFIszBH1D7YItamQ+6EtejrZ7OwUVwvi3CTxGk0MkF+RO1LPBrCazS4Xp5o62BZGplh5TpiZNPSAZBmi0jNLtgoa1zDJEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076738; c=relaxed/simple;
	bh=QcNVzrHJDmzDhVBtHzMTu8HUGMD/QTYlMSpRK5EIoOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIxVlSvT9SiJkndh1dI+KLT/R26WarztWZC9AoPeZvLoPZLMmlZUz3jfUrUNoQ9YKFfPvImSVV3OweffoZkeNtf5OB7hB+xM/3nDnru9AuxFbZh4OCux7Z1fkX9gsUzyEkAuxhsy2ByMZCE+ok/pfThruLBuTYljJw2MKBGUsc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dehapMrE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dehapMrE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48fde648a71so93949545e9.0
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780076736; x=1780681536; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=dehapMrEod4yQPedwi6wkMsO5R4UCxNPK0QUSNvmErNk/yPXXzP5zIA06qHUAr6DdE
         ZZz9LRHa1+LWm2CUl3sCl8paWQyhD82qdYaW9Sm05esWUQaf8Zfv3k5p4DYCfTSO76Eb
         YNHcIASJ9H70JtwD6w+w5ozNXVzljwnYIP3Nm2efGgZwVwtJC/EAxWPJ31ECyH3vePmK
         SE9Ka+cmMg5P2zGoVKQwEPnXDBY6cEe4QVh4iHSF31j8llx87+hDqh4rPJNSMZteW3zQ
         D4SMy3NT5xIHvDE/RVfNrn7sdWGpX/70f1MDmiC7gKkxv/RrSMrCCsqs/GaTIiTAVF0+
         zeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076736; x=1780681536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lXcg061bbhFrI0v23H2NQAB6iGsZBPcokYpsEnhLcE=;
        b=o7XD+CZMhLhF9UwJrjOkYmUEP8c48dLBFRN1IsWkoIgv9u611ub+upjJ8DEWyWbnxn
         uhSOOKns2g/f90xgfOTwRT5ZTCdA9uzGaqkthgLz0w0RT1rWr0tTrASAgDqBAiB6HF7o
         eh9JxFv0Gne00e8mpWHmdOV9Ig3b0uBCZkBnxM4Vc//josJ2wMY+05HA+5LSBUzlKOCr
         lY5YLqfhIhcOIsQ2UpXYZ8kf734+Mk+j0VDSjANkZu0IxywAug06miRaS5jwn+SBTAhD
         ffKh+0qncxdYN+Ie5NbqJ3fN0cU3MuzQ991LbuO0qP8kzF5QOj6iwlvYNZaZ89xFOX+T
         Nacg==
X-Gm-Message-State: AOJu0YygfRcvA68rITTUzPSb9EofyR3jpkYecD9taAbDbNz9twdpGr6H
	eACCLzZqGGAPpJxsieloxx8dSxl8htKxsIzpZmYSFU2xFu8jQBTon/B0FR5vBw==
X-Gm-Gg: Acq92OGXFAmyUDlbIifIImCKoBuDXA/NVUeSYbUTE97wmaVzip5U/nc7GZDFCIomcV2
	aF3B+WuZ1VSk3cEch+xbrbnjyCo0LuOXWRVZLpYpKlsk6kf8iSioqRgUVJeM5jKdmMW+N5Q3o57
	QEMOnH6fVcZLGkrzn/woA0E7Gujgcs7UjIF/EJ3lbAMmrZ620yqle3Bg3CAIha+Lyv6Pn/NqoZu
	DR7QwcJyDzjOy0KE5GcEdpHxyRdKY1WYd+E5JQH/V2nHswURXVfF/tuaQYyZTxjoXZSfzFngLW4
	d6XJnClVV7YcAAOnR4Ym40EIJrzichwiyFZOyPKV4SBw3hT2sskBoODwqfJB7oAu6w40e/ZHtbq
	39bvX9NsTgj9DTR+G75TgE/+9vFL5l/pf7Jqt5BnKZhMluYxxaMpf0FnoGf6405CPyfFeuFICR+
	4PeVbqXn/PSqboIrPrCMO3V5fXCYrSn8zcJPgBnkmfJ3ayCyBLeHWH1LUenJ2HNz2KOUnvlZGgj
	0cZopAPS3lEKJrqxgGqnakXhzQgXbEV
X-Received: by 2002:a05:600c:4753:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-490a2a79df1mr5349135e9.16.1780076735668;
        Fri, 29 May 2026 10:45:35 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09ab75sm18738075e9.6.2026.05.29.10.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:45:34 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v10 4/4] selftests: mptcp: cover IP_RECVERR sockopt propagation
Date: Fri, 29 May 2026 18:45:22 +0100
Message-ID: <20260529174524.260199-5-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529174524.260199-1-devnexen@gmail.com>
References: <20260529174524.260199-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise setsockopt/getsockopt of IP_RECVERR and IPV6_RECVERR on the
MPTCP parent socket, including the empty-errqueue EAGAIN contract on
MSG_ERRQUEUE|MSG_DONTWAIT.

End-to-end errqueue delivery (ICMP, TX timestamps, zerocopy) depends on
subflow-side producers that are out of scope for this series and will be
covered by follow-up work.

Assisted-by: Codex:gpt-5
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..95bb2cc8e2ff 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -769,6 +769,60 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
+static void test_ip_recverr_sockopt(int fd)
+{
+	struct iovec iov = {
+		.iov_base = &(char){ 0 },
+		.iov_len = 1,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	int one = 1, zero = 0, val = -1;
+	socklen_t s = sizeof(val);
+	int level, optname, r;
+
+	switch (pf) {
+	case AF_INET:
+		level = SOL_IP;
+		optname = IP_RECVERR;
+		break;
+	case AF_INET6:
+		level = SOL_IPV6;
+		optname = IPV6_RECVERR;
+		break;
+	default:
+		xerror("Unknown pf %d\n", pf);
+	}
+
+	r = setsockopt(fd, level, optname, &one, sizeof(one));
+	if (r)
+		die_perror("setsockopt recverr on");
+
+	r = getsockopt(fd, level, optname, &val, &s);
+	if (r)
+		die_perror("getsockopt recverr on");
+	if (s != sizeof(val) || val != one)
+		xerror("recverr on mismatch val=%d len=%u", val, s);
+
+	r = recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
+	if (r != -1 || errno != EAGAIN)
+		xerror("expected empty errqueue to return EAGAIN, ret=%d errno=%d", r, errno);
+
+	r = setsockopt(fd, level, optname, &zero, sizeof(zero));
+	if (r)
+		die_perror("setsockopt recverr off");
+
+	val = -1;
+	s = sizeof(val);
+	r = getsockopt(fd, level, optname, &val, &s);
+	if (r)
+		die_perror("getsockopt recverr off");
+	if (s != sizeof(val) || val != zero)
+		xerror("recverr off mismatch val=%d len=%u", val, s);
+}
+
 static int client(int pipefd)
 {
 	int fd = -1;
@@ -787,6 +841,7 @@ static int client(int pipefd)
 	}
 
 	test_ip_tos_sockopt(fd);
+	test_ip_recverr_sockopt(fd);
 
 	connect_one_server(fd, pipefd);
 
-- 
2.53.0

