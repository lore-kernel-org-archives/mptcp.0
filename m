Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928717F
	for <mptcp@lists.linux.dev>; Mon, 24 May 2021 07:07:24 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso9856161pjx.1
        for <mptcp@lists.linux.dev>; Mon, 24 May 2021 00:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xey/i7O8wWP66GwC7P5ffRtlbMLEh4wuK6ule0d4ddM=;
        b=AFkGM3EMkZRqoesIFz2RrhxK8mTsCzYiZUM2xgw47d75IWZ8PctwsG5wibn4dt8a5E
         CtlTT+YwskaERUIN9FTP4kCvYL75XGHNC/hrkuRjh9+n1DsaB4nM8d/iF2CmWpAGC7nM
         lL82mTuH1+NdBgvFl4tRBWKK+qq28wRMTKkDbcOTT3Du3faun88GG6HJg11pxcekVCQ7
         ZkaEe2kp+9pNN2U/c4G/JJfoawunrPwuygDEDp6kRc02GVROvVrnEKJu/WxiObay4bVy
         QjjaxXknQIkoqb6fJdsSB9WLmJ64dePG4HJ+beGJFi49nfVxAO++OHBobc8YUzTkJ1f6
         Sa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xey/i7O8wWP66GwC7P5ffRtlbMLEh4wuK6ule0d4ddM=;
        b=Kig+T4DWTFde9tlhTc3muRkX+dnl48PfKhCLlLWarIfDU+o9MyhjOnmuFiYaUbkIgn
         huMeEtVpt7XMQ3IflSp+XQ2AJUZTTl/YA2i0/dtD1K7plU8o1+R8BEj38fRKlYbbe3no
         4C9WroULASuuVWIJhPmMFE1ENZIo2Bps4t9PxZFmz1RyQNS9pUn/lO5cZ6+aH6N3l3Gb
         1buckfAxkYEDzwKdRFxn4vn+YQDlahS+GjlHjEpPiwOpNiMPGRrgoD6xhlz+QMS6l1YW
         1kvCwUkkClGDX+X+JeMmjaiwEQFsyK7a+A9NkWzuUgDe7XQFiP0ls4lk/p9KU4pjsiwj
         Lldg==
X-Gm-Message-State: AOAM531LqgzJrcjYMrROJVfSmf/fzGwSmyi3g/pBgKES5+etJLeycsx7
	O/V1awu8+wpECRdI6u5zrgw3r4uGWRImHA==
X-Google-Smtp-Source: ABdhPJxjvU57J0+0Qiwyl8FKKQysLbzhbR6h5Pr+8vyhDnewTROaWJqVm+QKsVqIWhi44M1w1i3QLA==
X-Received: by 2002:a17:90a:2a89:: with SMTP id j9mr14552147pjd.141.1621840043941;
        Mon, 24 May 2021 00:07:23 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id x14sm7118480pjq.30.2021.05.24.00.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:07:23 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v7 mptcp-next 0/5] add MP_CAPABLE 'C' flag
Date: Mon, 24 May 2021 15:07:14 +0800
Message-Id: <cover.1621839764.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v7:
 - use add_cached instead of add_list
 - tag: export/20210524T060340

v6:
 - rename mptcp_pm_add_entry to mptcp_pm_anno_entry
 - update mptcp_pm_free_add_list
 - update code in mptcp_pm_nl_add_addr_received
 - tag: export/20210514T055902

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
  mptcp: add add_cached in mptcp_pm_data
  mptcp: add deny_join_id0 in mptcp_options_received
  selftests: mptcp: add deny_join_id0 testcases

 Documentation/networking/mptcp-sysctl.rst     | 13 ++++
 include/net/mptcp.h                           |  3 +-
 net/mptcp/ctrl.c                              | 16 ++++
 net/mptcp/options.c                           | 12 +++
 net/mptcp/pm.c                                |  2 +
 net/mptcp/pm_netlink.c                        | 11 ++-
 net/mptcp/protocol.h                          | 12 ++-
 net/mptcp/subflow.c                           |  3 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 73 ++++++++++++++++++-
 9 files changed, 139 insertions(+), 6 deletions(-)

-- 
2.31.1

