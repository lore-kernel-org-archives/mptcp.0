Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568B1E888
	for <mptcp@lists.linux.dev>; Mon, 29 Apr 2024 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431094; cv=none; b=JO/YLd2rn/NAva2GcF4kEw5b2pIkg2Ht3trsvlWSkf/OcvCJwvHutrrznocbXZRpQAt/nRzCoUhZOUKJ22ep4gpXZ0f6QKsunSuYlOMnfI5A8yk4tDKdjsB2OxL8f1IUev8cHD2GGevg9qmXQJUlIeJP2MKoNCvNWMoD9hBq2J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431094; c=relaxed/simple;
	bh=0VKKG+/MRHxZ5zvfz7WQUGj8U1xV2HSSeJPTsaTJWTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=udqY9iGkDTuHgbFBX8hyVNLVbh4bjdMtW6Zy8wMSz1jzOLGXPSfs31J6HXAZPJKtLfP3i4IA+LRTE2fdVtmFYrxhFS6dnYaJBbyP7G5jnueJM2EyAp5DdKa0aPl3PcA7SqPnBIFkhZE1yEQLixIFzCeimmUUDsAMLOA7GkZz6PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsNdKY7s; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsNdKY7s"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f3e3d789cdso3075719b3a.1
        for <mptcp@lists.linux.dev>; Mon, 29 Apr 2024 15:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714431093; x=1715035893; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0GQybxBCQIzUHs6cWJR+BEq7BKv8ohBRppC+jb7zUHo=;
        b=UsNdKY7sFHm2r0jnsAP2u6IVfmGMla3CTumMUE5iuku5b5gmatK3Y8jg79tDQkxS23
         CDjDe7dl7FXvj6MmkZAPMBUtDJ5TXWUUlzuwKZ3oG0M1axubFy+6kLD5vo73Pju7rbuL
         HnhpRWk9+HGYkCYelve8QDS2v0+g9iuP4TkgSysHxiXeGOZnx47/HXvo8zsb4gMobG0g
         syp0g9ovTurvVxldwrqEwQCO4qo0JDWrGKHJpnwSDw8OrUMgbmr+bn8a4QkhJYaYZ1xP
         dLK2FrYSNw9fH3SXfCP8X5X2DOQ36lR89p3mEYYKwKmOdYb2sabyY0X5eBWGnGKNIzKa
         xrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714431093; x=1715035893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GQybxBCQIzUHs6cWJR+BEq7BKv8ohBRppC+jb7zUHo=;
        b=k1f9g0ftLVq0/xS1w8kxFHFH4i+2cV+oRT1/mWwsoY6t4AMWs3fJcQWSQZIkqF712P
         yZHHJdEiTSR5n9VmpcJ7rcnjcozI/aKxawske5flmlgHMXCQT+n9nCG1a8K/iH8qRR/k
         4eGhI49S4hvDgAs9hq/f9bSX7iBusdLNVV5K9r+DpoB4nG+yVU1duSa5BZWvGJwmVllN
         NxkJP/mmGEr6s/LfOicnizeEDX3YraV//60ebAGmyqxwyLLbWRMw88xKOv37NLoN3WZ7
         /dmG6Q0HQxpt5EEBMJLnWiVmLm11+8bJsO+vKqEkYsq6xo1qFqOgyQw0j8yx0zbAz+hn
         gnrA==
X-Forwarded-Encrypted: i=1; AJvYcCWD1zPQvvkIGjkrPJWvKoSrjI1FQYayjJRnkbuo/KIheyF5AF3KLBvpaJqFa32Ews7/gd4wHjj/SWD/GwfsVQZtUwJgbrE=
X-Gm-Message-State: AOJu0Yzgdq+kJrTr1FDWyZqNceqsloOGhJf0Yxg4h4LyvsEs5ljdGe5r
	RnzJu1Lpcbt1IY+sVjQTKpHLERSw5159Z77I88idAhEILWwzwdA3
X-Google-Smtp-Source: AGHT+IEuVcuq6ujat2QJAa27PDqEgKnECV5cPO7TC0iv2mewdglY0NN93dnMKUP8D2/hbQ8g4hZ96Q==
X-Received: by 2002:a05:6a00:7114:b0:6ed:d8d2:5040 with SMTP id lh20-20020a056a00711400b006edd8d25040mr10823106pfb.21.1714431092773;
        Mon, 29 Apr 2024 15:51:32 -0700 (PDT)
Received: from fourcolor-Home.. ([203.121.254.74])
        by smtp.gmail.com with ESMTPSA id fm8-20020a056a002f8800b006ed059cdf02sm19841235pfb.116.2024.04.29.15.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:51:32 -0700 (PDT)
From: Shi-Sheng Yang <fourcolor4c@gmail.com>
X-Google-Original-From: Shi-Sheng Yang <james1qaz2wsx12qw@gmail.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: geliang@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shi-Sheng Yang <james1qaz2wsx12qw@gmail.com>
Subject: [PATCH] mptcp: subflow.c: fix typo
Date: Tue, 30 Apr 2024 06:50:33 +0800
Message-Id: <20240429225033.3920874-1-james1qaz2wsx12qw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 'greceful' with 'graceful'.

Signed-off-by: Shi-Sheng Yang <james1qaz2wsx12qw@gmail.com>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6042a47da61b..c794288f6224 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1234,7 +1234,7 @@ static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	unsigned long fail_tout;
 
-	/* greceful failure can happen only on the MPC subflow */
+	/* graceful failure can happen only on the MPC subflow */
 	if (WARN_ON_ONCE(ssk != READ_ONCE(msk->first)))
 		return;
 
-- 
2.34.1

