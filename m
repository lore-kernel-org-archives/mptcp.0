Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01947173
	for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 07:35:12 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id k26so1215771pfi.5
        for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 00:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FV4VBygAKqfce6atRfm7MM7VKRPKrhvvjxIwES2bKMs=;
        b=JmlM15e4eIKHxjL03S2CRF3vfcrE6s92mfNIercW78daeHOdYwLdKxeq/XQAq2jjqc
         I1MrgSYFT7CdYRrC+ocDgQV3LB+kaZBtbojWr4jeC8LyVtnCMYdVSuQTDVoTjVVQhO1v
         elNJ/T7xqkQ+YOboiOjibqFUqxcSbSIfM+soDMk8QNFSfoTHDqkx8GH1IDZUI6CAVXlA
         CHEOdN9FGWyFvTVogCJDFEhB7nUhRyhpN0szQ1HTqoMyl1tKMtat7z6GoKttKarfwK4m
         qpcwgON+BKOaEDmYExO5aP7UpjZBIRWuUlOIA43kgVHOz/YAtD9Hu2EcPf53Lb+DJiD8
         yYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FV4VBygAKqfce6atRfm7MM7VKRPKrhvvjxIwES2bKMs=;
        b=WE1kcPEh0LvPUjF3LuOMbeh09kmYuvqyFktlNejULODUuPqo2TAOjnttujETZ9Ql1Z
         U3mAmvzJX/7yLhqkG9xZwnBXPcQ7a94z7pI7bUtT2CoSgpxhKaJJK3aFwc55lYwrbuqW
         BKmfAg0QLo0PL0FH4Hgp6ZKndhvQAgJOQilhZWCuolireAMcyBzSL2gP2vNycTJTsMZE
         e95OOlsNc/e2IEvIuBkQt/vGvhe+KLNcQLy2r2vS2l7DxMfPGcsWQvz9BJOnxXnnp4+r
         I1utcFTbDkeiRw4cXdqDMVsbSihPsN7oaX19GnApUDf9sS7I4Xsr6Lqdk5VRAFWJrjut
         Fm7g==
X-Gm-Message-State: AOAM530GTpneMAUid1wm58dGFCnES9fg1k5psGypTVRvVgQByKIzuTq2
	5K3DUgWsB7VDmIQUWByDlIHATUkyRUl4zQ==
X-Google-Smtp-Source: ABdhPJzDolYtf4LVNUPAz7zUSQo9XfoaVJ/DaKNHQtfRhUrzGc/RHioMXuAOKJvS1NMrbGlqduXHaA==
X-Received: by 2002:a63:da54:: with SMTP id l20mr8410014pgj.341.1632900912280;
        Wed, 29 Sep 2021 00:35:12 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id gn11sm937853pjb.36.2021.09.29.00.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 00:35:11 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v6 0/9] The infinite mapping support
Date: Wed, 29 Sep 2021 15:34:58 +0800
Message-Id: <cover.1632900306.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v6:
 - use allow_infinite_fallback instead of last_retrans_seq.
 - rename mptcp_is_data_contiguous to mptcp_allow_infinite_fallback.
 - rename last_fully_acked_dss_start_seq to last_ack_dss_start.

v5:
 - move last_retrans_seq from msk to mptcp_subflow_context

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

Geliang Tang (9):
  mptcp: don't send RST for single subflow
  mptcp: add the fallback check
  mptcp: track and update contiguous data status
  mptcp: add last_ack_dss_start in the msk
  mptcp: infinite mapping sending
  mptcp: infinite mapping receiving
  mptcp: add mib for infinite map sending
  selftests: mptcp: add infinite map mibs check
  DO-NOT-MERGE: mptcp: mp_fail test

 include/net/mptcp.h                           |  3 +-
 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  1 +
 net/mptcp/options.c                           |  2 +-
 net/mptcp/pm.c                                |  5 ++
 net/mptcp/protocol.c                          | 34 +++++++++++
 net/mptcp/protocol.h                          | 23 +++++++-
 net/mptcp/subflow.c                           | 54 +++++++++---------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 56 +++++++++++++++++++
 9 files changed, 149 insertions(+), 30 deletions(-)

-- 
2.31.1

