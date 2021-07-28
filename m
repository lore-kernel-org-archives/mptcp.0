Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5572
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 09:35:19 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id j1so4233999pjv.3
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=212B+hMHtIZSfeMYFSEggMmAZ8RIovdSkbwAzZbz96o=;
        b=XuCKESfCnQKADrh1pALYYzPJHhu3OepkvnpbWSrdf2m5wmdXeo0hCUJmQY9iGV8Y3f
         O8bvie2P0B0248aRRcdX+WqsZYRUHwdidKCNuYvfULwtNJ1/32T3bYm23GBS4/OvV00i
         +eLU7IR41QUROEjuGf+EHLp291S37LcEl14ZSLRKvS13kpv/5zdkfIL+4nRpyXqmIqQG
         kTbLVCf1TES7cphRx2nW1V3rNDEHlf3vaWpy3c3HLJSFiYd8eWIp4fIz4seWiR1rtHDH
         yFH27OONEyY3Z3Gh01lcqF9R1p0CUbdrI6qmaAG930nIqujb2dUwH25muQ9R5lft4ziI
         JUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=212B+hMHtIZSfeMYFSEggMmAZ8RIovdSkbwAzZbz96o=;
        b=Tv0FEz/Utb5hf4bz7It32gA9jbqi14wM+IYhHrgAMjcydOtLaasuY4Lizbwt/E79dN
         Kb80diFrNy2w9ueel/mTRyTG0gpymXCRTTI9mfm7xuW9fGAeXAZNFYSJlW69P0uPIzdW
         fUKL/kC+GH/BO8ZPNrBAsUDfin73JsQNdGVgP+UPIRPdBvUGRz/NIf0kqbpIXm79yvtp
         GjKQ6SpuSbahbGe8NSgfQHwIsCUe5FgV0ToPAHdUibQxEidsmz6KeKt78Tsx75buYmhq
         CuKwW53UwHACbmTLW9xettpaZ17ud/EG1gcByxhXblRuFru67LbWXtGmrc7eiVFFsT1g
         xZWg==
X-Gm-Message-State: AOAM530FEZQelEhNl2cPLutLz4pMnR9WhsCl7B1fNL1/MfvpS3dCJruY
	K/qSeRISKm3AZV/YBt5zsRdkE8U1dQY=
X-Google-Smtp-Source: ABdhPJyHgN6l7G1f3idxtZuOBrm7K4XX02ACJv4EAr6zJLW4rXeIt68JxGNCZGXxs1K9RHNDxfpvUw==
X-Received: by 2002:a63:1e57:: with SMTP id p23mr27899502pgm.41.1627464919219;
        Wed, 28 Jul 2021 02:35:19 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id v10sm5312560pjd.29.2021.07.28.02.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:35:18 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v6 mptcp-next 0/5] MP_FAIL support
Date: Wed, 28 Jul 2021 17:35:07 +0800
Message-Id: <cover.1627464017.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

v6: only rebased patch 1
 - move the struct member 'fail_seq' behind 'ext_copy'.
 - define OPTION_MPTCP_FAIL to BIT(12), BIT(11) is used by DSS
 - move the MP_FAIL writing code at the beginning of mptcp_write_options,
   and add the 'unlikely' tag.
 - tag: export/20210728T080904

v5:
 - patch 1, change "ret = true;" to "return true;"
 - patch 3, in the single-subflow case, send MP_FAIL and receive the
   echo, then temporarily handled by reset.

v4:
 - just deal with the multiple subflows case, put the single subflow
   case into the new 'infinite mapping' part.

v3:
 - respond with MP_FAIL
 - add single subflow check
 - add infinite mapping sending and receiving
 - export/20210626T054902

v2:
 - MP_FAIL logic:
   * Peer B send a DSS to peer A, and the data has been modify by the
  middleboxes, then peer A detects the bad checksum.
   * In the multiple subflows case, peer A sends MP_FAIL+RST back to peer B,
  and peer A discards the data following the bad data sequence number. Peer
  B receives this MP_FAIL+RST, and close this subflow.
   * In the single subflow case, using the simple implementation, peer A
  sends MP_FAIL back to peer B, and peer A fallback to a regular TCP. Peer
  B receives this MP_FAIL, and fallback to a regular TCP.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/52

Geliang Tang (5):
  mptcp: MP_FAIL suboption sending
  mptcp: MP_FAIL suboption receiving
  mptcp: send out MP_FAIL when data checksum fails
  mptcp: add the mibs for MP_FAIL
  selftests: mptcp: add MP_FAIL mibs check

 include/net/mptcp.h                           |  5 +-
 net/mptcp/mib.c                               |  2 +
 net/mptcp/mib.h                               |  2 +
 net/mptcp/options.c                           | 78 ++++++++++++++++++-
 net/mptcp/pm.c                                | 20 +++++
 net/mptcp/protocol.h                          | 20 +++++
 net/mptcp/subflow.c                           | 18 +++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++
 8 files changed, 178 insertions(+), 5 deletions(-)

-- 
2.31.1

