Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAAC72
	for <mptcp@lists.linux.dev>; Sat,  8 May 2021 10:33:32 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so6955998pjb.3
        for <mptcp@lists.linux.dev>; Sat, 08 May 2021 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3+lBTQBNsOmaQF23L/h0gr46o4WRTdq6/wZoLcz/WZ8=;
        b=Kx+tY37luJsz4bJSeAN2JE5WNv9JIgOFMWsNAq+87h/yVQnLwZkFdPYMWnqaJSUiWv
         o4saIHEYPc4sR8mM6RwIXVEg0DdFMfh7AvP3mPL+xuxZvzT0DFQKTxnwY05NqnQEMiLm
         vpDSItGiX3o/BzkdIgOE0nPu6wpmY6NIS3esb0SvCqJZYy8LG1UzZL3/sA3hA06MAzJB
         8/bLG2RfeH4D3av0Oi9x2xwVOfQBFsUwMNWJDPgqBJUKLpBz8yUfbLmKvN+5qX+Ujme0
         U9AvsZ+xxc8Y+fftNIZ0a03MpEHfAPE2JFOAF6ruMnIRg8Y3eIWqYdoG5CeBHyfMTe0y
         a8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3+lBTQBNsOmaQF23L/h0gr46o4WRTdq6/wZoLcz/WZ8=;
        b=De2c+XEvQsMFp4LMehhZH1y2dUZE3r7RRcwQP+B1+DYWmxLeItHDZzu9jck7kiCn0e
         rYHAEWvFHsC155IfP46VW3Eul0XH8p+X5AD66mp7GLb2/JzUFQGIyih0S6znJDnyPmhQ
         teC/3izF7RaPDFAybnlXwc8eh084P6FzOR/oB3uIhNC8N2nCLZFoKPFNr+HmmXw3Erpq
         vD+R7RCOQUwWZZ8N9rmwrTikn4zs1aKuFjFa7+etLKxiD1AJW/rBagb8ZbjTPMG9bOv4
         oN9ZxAJ+v92zAJZpaTCiWTHNTraV0IY+VbzzUTWorvG4RZtkc4Hwb/epXz6Sp0pkAiUG
         WyJg==
X-Gm-Message-State: AOAM530zPBtK+egP4+NyyvqQTZNgH+/872Z4Sxk4pw0Y2Ojtzx7cHQi8
	cHIwX8tTdWvxKfJ4m3kZBzCiQA3WDoY=
X-Google-Smtp-Source: ABdhPJxnCVgEZkjIyChBbQEx+2bEG7+oY34Qj1AuSKzgBad+G+Ly6QRgImLwWJllarDowM1kZExUEQ==
X-Received: by 2002:a17:90b:e95:: with SMTP id fv21mr15621648pjb.107.1620470012013;
        Sat, 08 May 2021 03:33:32 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id j3sm6848259pfr.30.2021.05.08.03.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 03:33:31 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v5 mptcp-next 0/5] add MP_CAPABLE 'C' flag
Date: Sat,  8 May 2021 18:33:23 +0800
Message-Id: <cover.1620469774.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5:
 - add a new patch "mptcp: add add_list in mptcp_pm_data"
 - fix !CONFIG_SYSCTL case
 - tag: export/20210507T174457

v4:
 - rename mptcp_is_allow_join_id0 to mptcp_allow_join_id0
 - rename deny_join_id0 in mptcp_pm_data to remote_deny_join_id0
 - add comments for self test cases
 - apply: export/20210504T064955 +
          "data checksum support" +
          "data checksum support cleanups"

v3:
 - use 'u8 allow_join_initial_addr_port'
 - drop the spinlock in patch 3

v2:
 - rename join_denied to allow_join_id0 in mptcp_out_options
 - rename join_denied to deny_join_id0 in mptcp_options_received
 - add a new function mptcp_pm_deny_join_id0_received
 - move deny_join_id0 flag from mptcp_sock to mptcp_pm_data
 - check deny_join_id0 flag in mptcp_pm_create_subflow_or_signal_addr
instead of in mptcp_syn_options.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/183

Geliang Tang (5):
  mptcp: add sysctl allow_join_initial_addr_port
  mptcp: add allow_join_id0 in mptcp_out_options
  mptcp: add add_list in mptcp_pm_data
  mptcp: add deny_join_id0 in mptcp_options_received
  selftests: mptcp: add deny_join_id0 testcases

 Documentation/networking/mptcp-sysctl.rst     | 13 +++
 include/net/mptcp.h                           |  3 +-
 net/mptcp/ctrl.c                              | 16 ++++
 net/mptcp/options.c                           | 12 +++
 net/mptcp/pm.c                                |  2 +
 net/mptcp/pm_netlink.c                        | 86 ++++++++++++++++++-
 net/mptcp/protocol.c                          |  1 +
 net/mptcp/protocol.h                          | 13 ++-
 net/mptcp/subflow.c                           |  3 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 56 +++++++++++-
 10 files changed, 199 insertions(+), 6 deletions(-)

-- 
2.31.1

