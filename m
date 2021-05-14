Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF671
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 14:32:23 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id c17so24743569pfn.6
        for <mptcp@lists.linux.dev>; Fri, 14 May 2021 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZCBzNrT7HIpbeEprQTXwFMo3yKkeOSxih+Y7f1gCOkY=;
        b=rRQcJ08jFlCRj1V+iUDckFWfWV/lGMb6MV5zq7TQu7BJfyecU1PXB1yKavCiZ8jk+x
         ILDAXoNMgr41bs3Jmc1NOzBSlGO+C/EYdMXNFzumFaqM1C2YF9yUh+iNlGXTTZqPWDzs
         mpK2tChLrczigeCvkOO8/EgeNDTVcQfp8zZF6GxmOtKB4aIdfqq0wKKsws+GKM9spd5j
         3bQUsgyrsSTC3Uq050lUI/UDdmYl33Bu0bHVDPYok1GhBCqR/NgKE69bN0J2Anw/qvgP
         RxCzWBSZjTPJR2VCjGXtV/NKAEQnQwt9EpFEwlTrwoNnbJpQ9QUvfdBhKI74dJ2B5AAe
         x9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZCBzNrT7HIpbeEprQTXwFMo3yKkeOSxih+Y7f1gCOkY=;
        b=DX77YmAgpaQJXccE6DI4y/SpMfAFxshc4MT6ZgunTIfVs1DNUaV6y6iVJD74Umrw0k
         4rkqDLdmFxCKNNvb3xvrHEiELsYblMWXx2kljuuSCW9ZlZ4fZY3fhkqI+p8y9C8DJofj
         Zq5rQgjBpH2dEPS/gHjYaDmes3uOvoDfkpw8SjhY3UV56/r/y3wLI7IXJGwknXzUWAkh
         Irwjqz2/PUVsYp96SD3OittJy7qO/w3g7tNLRDp5Dk7fnEjmJM6EwICeGNPCryNiwZMC
         TRoV1XANrAupPF6wh1l3Ug4RFF3YrEWhE9f3nJoWUu6G/exyH7/YWOazzftqFPHsPH7U
         zUIQ==
X-Gm-Message-State: AOAM533tTeXjKyJpofpctWcca/7i0R1dFUViR7gzUztz/WQJIFNBKwpH
	s/RjkM4sXq1giCqAoQ6uS/V/+vATdRI=
X-Google-Smtp-Source: ABdhPJzLtMCzFpin2hA6vT5LTTvQko0kxQrUudugFY8Kw20IfunVVdB/pxkGxpMmY8m/KN8kn0H0Xg==
X-Received: by 2002:a62:1b50:0:b029:2c6:bf99:5f41 with SMTP id b77-20020a621b500000b02902c6bf995f41mr21709747pfb.33.1621002742768;
        Fri, 14 May 2021 07:32:22 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id lj13sm9224913pjb.3.2021.05.14.07.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:32:22 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v6 mptcp-next 0/6] add MP_CAPABLE 'C' flag
Date: Fri, 14 May 2021 22:32:13 +0800
Message-Id: <cover.1621002341.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Geliang Tang (6):
  mptcp: add sysctl allow_join_initial_addr_port
  mptcp: add allow_join_id0 in mptcp_out_options
  mptcp: rename mptcp_pm_add_entry to mptcp_pm_anno_entry
  mptcp: add add_list in mptcp_pm_data
  mptcp: add deny_join_id0 in mptcp_options_received
  selftests: mptcp: add deny_join_id0 testcases

 Documentation/networking/mptcp-sysctl.rst     |  13 ++
 include/net/mptcp.h                           |   3 +-
 net/mptcp/ctrl.c                              |  16 ++
 net/mptcp/options.c                           |  14 +-
 net/mptcp/pm.c                                |   2 +
 net/mptcp/pm_netlink.c                        | 151 ++++++++++++++----
 net/mptcp/protocol.c                          |   1 +
 net/mptcp/protocol.h                          |  21 ++-
 net/mptcp/subflow.c                           |   3 +
 .../testing/selftests/net/mptcp/mptcp_join.sh |  56 ++++++-
 10 files changed, 238 insertions(+), 42 deletions(-)

-- 
2.31.1

