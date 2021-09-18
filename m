Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48372
	for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 07:22:31 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id c1so8401608pfp.10
        for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 00:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tX1QZrSUT0S8/MMkPPauSMAtryTe1QF8XRqzwOBeC58=;
        b=cMej6w1w5W1z6xNSnIiganCXeXCCvwUXOIG/VjqSIKGfL1Ib7ZxOcXIcgudW6tqdv/
         IMltyFl0e0LJeF8rhhnNlu1NzMWmuqsCYeVS7ft2JB8KhbwoKesgxlRKBVBV63MSPU49
         DttG7now4YiNpexESElZgvytnT6WswHjgGpztGaarPet5j8CG+UFiDjX0FFGvgfkRufz
         N0yGfyhWfpcGo8CKzIIeK/PpZvxp+qrT/ZKar1TlCEuaY4UXtUszLzPyQiGiOHJRjJoj
         Q7XX12i/eQRkW+AHiK5dtmKlEtJSL3tX+lNZAd+rnwIlJ7YB0nbybwIJbotnm+udvgod
         buWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tX1QZrSUT0S8/MMkPPauSMAtryTe1QF8XRqzwOBeC58=;
        b=3YWGhuyPSmdm77lLyg3IQqdU3YRijuelLCbpl70zo7HzVs932VIyKwEbPCRVXUgXso
         QWnaQG7rPFxgEWHlE76BUf0nH8PUWzTnMey0H5evTzMsThAjrw9t8IZFOOPJCJ1mQVa0
         Acd20xE1emh2jfR5Euv5c4Bs5Nk+6QIFVxIPggVkNFHV8TW4zW20vumSpdlG4/5U09C/
         z0Obv7thJce7BLn3FqyU/JY6po9pW+s2UNtA8T14IL0F2hJiK/kqOP5gYPPjl7Fdi6PC
         JQcQ4dB1LFEW0MumyqC7QGVMClG6+xHy9Qk9p3XOLsLRYf7NvswOKKSz6+3dgRo5V8xk
         sPuw==
X-Gm-Message-State: AOAM530yzeAJYH9EVR2YxojXohYpV/TBhIqhTEU9YZzYWBJzR/qxYOD+
	21sDF76Kgqv04mmjR3UEABFcx6sxd+8=
X-Google-Smtp-Source: ABdhPJxVOy3U/iBNZkCJnLg1WztfXa7bmhoLzwSlywSktiWc2vtBd9RD5agmideD3RcsGXdgewC/2A==
X-Received: by 2002:a63:401:: with SMTP id 1mr13598995pge.166.1631949750863;
        Sat, 18 Sep 2021 00:22:30 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 77sm8040214pfu.219.2021.09.18.00.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:22:29 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v4 0/8] The infinite mapping support
Date: Sat, 18 Sep 2021 15:22:15 +0800
Message-Id: <cover.1631949480.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
 - update patch 1 and patch 2

v3:
 - drop MPTCP_INFINITE_DONE flag
 - drop MAPPING_INFINITE
 - add mptcp_is_data_contiguous helper
 - add the fallback check
 - The u32 target testcase has not been completed yet.

v2:
 - add MPTCP_INFINITE_DONE flag
 - add MAPPING_INFINITE mapping status
 - add start_seq in the msk

v1:
 - add noncontiguous flag
 - add the mibs check
 - tag: export/20210904T080009

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/216

Geliang Tang (8):
  mptcp: track and update contiguous data status
  mptcp: add last_fully_acked_dss_start_seq in the msk
  mptcp: infinite mapping sending
  mptcp: add the fallback check
  mptcp: infinite mapping receiving
  mptcp: add mib for infinite map sending
  selftests: mptcp: add infinite map mibs check
  DO-NOT-MERGE: mptcp: mp_fail test

 include/net/mptcp.h                           |  3 +-
 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  1 +
 net/mptcp/options.c                           |  6 +-
 net/mptcp/pm.c                                |  6 ++
 net/mptcp/protocol.c                          | 47 +++++++++++++++-
 net/mptcp/protocol.h                          | 19 +++++++
 net/mptcp/subflow.c                           | 55 +++++++++---------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 56 +++++++++++++++++++
 9 files changed, 163 insertions(+), 31 deletions(-)

-- 
2.31.1

