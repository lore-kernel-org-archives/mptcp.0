Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71FD12D758
	for <mptcp@lists.linux.dev>; Tue, 30 Apr 2024 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478819; cv=none; b=Su63Jkf3sBux4EtBehfWXAc5XaEbF4VV5qM24wR5z2NztwRp8TSbRkZUVOQAIMpPh9jOyxyyyewHgfL31bbnFJwgLYsBHS5BbKAMrqJ1Uk8WgBZo2sEHSRdl8Zg6eNVyaMevf9YtIHW6iU0Q6KnPrzIfvKeqi3terMKfb61YAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478819; c=relaxed/simple;
	bh=x23ZmUT013iUCLSXaUpi5LlryRrA3BD/ZAzMO8y10dM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JYPnWshKipWoBdAEibUzzSFYc/jP0UEP0x67uUHtDipXdm0RkO61cd8TqqZYKUKsqz4hV1Aqd9AZtkb3bc86DFl+lANUtjhYsk40YUFljERQif9+kfWdccbNjui+a18yFwm7FiwTzdNKSxSe2kYE9St1e9sNsLSp1TSDpzBRexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2ktX4dQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2ktX4dQ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a58eb9a42d9so393987566b.0
        for <mptcp@lists.linux.dev>; Tue, 30 Apr 2024 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478816; x=1715083616; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hZLwKbv9c5bAVLt3i8TXd1TJdk794rrVqCRO+gOArU=;
        b=l2ktX4dQjGbh+XrPk2mhLeQ+2Q5OjS20pDFDFat/3x+/XslmFdpvGnj+tARXZ1Asji
         qO61oSiUEKk5TAaSLpWJlXPvmjVR4DaW3S+e3Mbr38E04im5iVA8V3Z5EzGE+JkXHSxt
         rp3uzGsChBQnSloZu0NK+hzZH6UWbRfCe5RV32dpP6IJ+TMAgDMN2pTLU7WDxh8I8udh
         uGe9J7d7qtmB4+ApAwW1s7mCRHEECzfC7WleFC5o+xyHxMG/b0x9894DWWjlbdqeW1Ru
         qaWqHziri+E+whh1ubUhwJxzZ/NMxSFhna3GcSkbBUy4Vzo/Zw7JuRnXwdIbp3MQOtGB
         PGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478816; x=1715083616;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hZLwKbv9c5bAVLt3i8TXd1TJdk794rrVqCRO+gOArU=;
        b=FmGCdI1ocTCw1eaFPNmlzGc210+PvGmpcTyi+wbZkxCw0/SaUD8SzCCPZXepb05R87
         XmR6sa59PcqGIGmuBHYy/+X0YUsMvitQuDSxHYytkkGk5PAxgf64iOf3RDxP7od4kduK
         +Ep+a1BZjB0bqS71w8pgkK7kHagjXmMH39pwpEgiWbByfp8yG+Xghybx8fUy/cNQfvBA
         7N1G3CgpuND9iC0ZpwRjR5/4Jdc+o6tP776gG8EzNtinLQdpJWvJEb54wGHSA0dgK9L1
         wxky1S3AQV5quONdvx2P4lxQvWYCdgNTfUITR4/XicNxhtqtVN4tSxmdkJ8c8SdoVItW
         Ootw==
X-Gm-Message-State: AOJu0Yz4Mmyk8APJRTIcJqZhJ9S2nQ+hgkQukpLJptBOF4Xaecv+tJo8
	2gEugqQqO7s8bm/peXG72l2CxdH73urxYFDK76/I9WeypsuwsLfK3h80hIKt
X-Google-Smtp-Source: AGHT+IHrM1zlG0ZzAb29wtAufdWWuYY9vBDuGi+0rMj7OuflpBTLc2eR0B82HaLCSAR6mJR35f+UqQ==
X-Received: by 2002:a17:906:492:b0:a52:2772:b9cb with SMTP id f18-20020a170906049200b00a522772b9cbmr1826981eja.24.1714478815860;
        Tue, 30 Apr 2024 05:06:55 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:700:80a3::])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906bc5100b00a4660b63502sm15242626ejv.12.2024.04.30.05.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:06:55 -0700 (PDT)
From: Gregory Detal <gregory.detal@gmail.com>
Subject: [PATCH mptcp-next 0/2] mptcp: fix net.mptcp.scheduler behavior
Date: Tue, 30 Apr 2024 12:06:40 +0000
Message-Id: <20240430-sysctl_scheduler-v1-0-8187148850df@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANDeMGYC/x3M3QqEIBBA4VeJuV5Bsz96lWWJ0qkGysRxo4jeP
 enyuzjnAsZAyNBmFwTciWlzCeqTgZl7N6Egmwy5zAtZaCn4ZBOXjs2M9r9gEErrqrblMDaqh5T
 5gCMd7/ILq4/GC4dHhN99P5LeqnduAAAA
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Gregory Detal <gregory.detal@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714478815; l=893;
 i=gregory.detal@gmail.com; s=20240430; h=from:subject:message-id;
 bh=x23ZmUT013iUCLSXaUpi5LlryRrA3BD/ZAzMO8y10dM=;
 b=rJAN08seIQ1gKrOmhwiIS2SidZZhrCgYXKI62Za2xdl40iXSejBM8H2uENhoL5fTDSfBL5+4k
 SNU7CBRlO9rBKIeTJZLfq5XeYTtK55VG9rBT3jICTE069NfcuYAtcIN
X-Developer-Key: i=gregory.detal@gmail.com; a=ed25519;
 pk=TziJDop3YEG3Ywr6io7U9Iy2jaAY3l0hTh8KdwDKXQM=

The sysctl is accepting any input. This patchset ensures only
existing scheduler can be set.

Moreover, this adds an helper sysctl to list the available scheduler
similarly to tcp_available_congestion_control.

The first patch of the series is a fix for mptcp-net.

Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
---
Gregory Detal (2):
      mptcp: only allow set existing scheduler for net.mptcp.scheduler
      mptcp: add net.mptcp.available_schedulers

 include/net/mptcp.h  |  3 +++
 net/mptcp/ctrl.c     | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 22 +++++++++++++++++
 4 files changed, 91 insertions(+), 2 deletions(-)
---
base-commit: dd741144c1d1e3bd1fed5eb0ded1934c9230b4ef
change-id: 20240430-sysctl_scheduler-13367d5bf81a

Best regards,
-- 
Gregory Detal <gregory.detal@gmail.com>

