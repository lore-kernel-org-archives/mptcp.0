Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06603FC1
	for <mptcp@lists.linux.dev>; Tue,  7 Sep 2021 10:42:05 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so1790178pjq.1
        for <mptcp@lists.linux.dev>; Tue, 07 Sep 2021 03:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0lo8hnmYD4eGLyw+n7SGzxVXQdANGcg2+Qxie8+ObbQ=;
        b=nS19Kib0PJeVajDkOGj9kyQRf1+DJjTcjXx8GNKlZ7b5P58MjOZm2byQGFTIIK4r1o
         ZaRoDun25pVd044Bh3/7gSjaooSwGdoeem4E7f0dPv4UdGvEJqrfVY578MUBz6Q4nZPR
         gUwlRuUlSknMquDOyF2ZDs0S7A0M28j1SqTfbPCdy7jXPmIToUS4E8cK2Nvv5nVtkE9O
         So2FSJI2ktJPnP/+gYtcXYo0wStunhBYOQSShbDv3Fe25cRXYwI2ZVkSM+1QLIp0bqC6
         XPaw0I0wtC8kuxXdPL+P/J5FvABUJ+pJLndV2qwyPxNzE4RCqfsVEoPNc/yk7K7Xfcmm
         9FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0lo8hnmYD4eGLyw+n7SGzxVXQdANGcg2+Qxie8+ObbQ=;
        b=XO/wbJxvGYCHRo+L4yd9xGmDu5fDnoyAFkVxJBg/WuggngKwpMXf2+JsfoHqb0ZWmM
         p8V6fg85NZ7GcKQVfwXw4Q34AxvLOTFSOlt5HUh9nTs/IyK3sBmXehRfzJtrN7RBSvrS
         wk/X6xdmRvC/SqjEBVpqibwIGmIMVNG6nqK7ZbuRpS4AdBd4nXBvW1/xeIdMvUDY9oVu
         IdLDf+3QHP7J+uacNlxZxpcu5jROsJEyJHVffBad8FAmbpl3+CcZmACcNywdEb+3AdU7
         6Pz2dzq8uXiyKJC3K2iAzRUyGw2Bitu5VruLPHRLuogV5GAtWJgynYIL5RwYfmbzC7fC
         yUQQ==
X-Gm-Message-State: AOAM5316Ibko/Ymh5WG4KrAi6Qm6YHxRGsgqAZQHC7p5rJX6D7BVD5EV
	AqvGVNz1OUwfbd+ESgIAmrYkEUQKtRU=
X-Google-Smtp-Source: ABdhPJzyZl20dChvNlShxgAlJlcduZ88Fn8qO3vD23Jvqbv/P8FDj/1A3XCJTHZaQSvFyGHsFCXTug==
X-Received: by 2002:a17:90a:5d95:: with SMTP id t21mr3808531pji.77.1631011324949;
        Tue, 07 Sep 2021 03:42:04 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x189sm10571885pfc.52.2021.09.07.03.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:42:04 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH RFC mptcp-next 0/4] round-robin packet scheduler support
Date: Tue,  7 Sep 2021 18:41:55 +0800
Message-Id: <cover.1631011068.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

Implement the round-robin packet scheduler, ported from the mptcp.org kernel.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/194

Geliang Tang (4):
  mptcp: add a new sysctl scheduler
  mptcp: add struct mptcp_sched_ops
  mptcp: round-robin packet scheduler support
  selftests: mptcp: add round-robin testcase

 Documentation/networking/mptcp-sysctl.rst     |  8 ++
 net/mptcp/Kconfig                             |  7 ++
 net/mptcp/ctrl.c                              | 14 +++
 net/mptcp/protocol.c                          | 86 ++++++++++++++++++-
 net/mptcp/protocol.h                          | 11 +++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 11 ++-
 6 files changed, 132 insertions(+), 5 deletions(-)

-- 
2.31.1

