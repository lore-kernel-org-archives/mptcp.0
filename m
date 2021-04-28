Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D219C2F80
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 07:01:10 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id m12so3325151pgr.9
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0bCZnUPxlDjlDQetGgddOg37ZkVBXFOWrY/SRTGTfPc=;
        b=gwcWo6S1iSIs6SuGF7KhH6QCRtadeWMVWyhl/83YIZEdicLHUwhE8gHrkzHGxAEnC4
         d0Et/6djGhfAjrGcL2my4/8d6UR1cKAJCnAyR/AkkCVb1V02ce5vTYbkgISRuSIhoku2
         Pyg7bhxjBxQqNUikve4lz3S+mdNvtd3bw3v1YUNMdxB7T3cbKCvMaQ1IYrNe64barCJK
         RgOoId38KurR7Po7TufoDb/jE14jjZIWuQXUDlWHIugcNSWDUjzH/ewcpUBeW6rCc0Gi
         yeDk04H8hptKIdD0A4rav4h/noRV/GtxT5jqepaRL9bXzZNHSQuAC5ZYlNlL7tRu7qLZ
         jv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0bCZnUPxlDjlDQetGgddOg37ZkVBXFOWrY/SRTGTfPc=;
        b=W++TZop/PSqkQZY0XW3hMBDjIVaZfJ8xp1sXamaLa9Z6+WgtroPQl8tSqr/smPWixY
         QqKrYMzi3WxUugao22FyeavRwvJfs1SXYpdsIpZbXF4h5fiWKdzfT5jj6I0CnuEQJytF
         F+MC+rkVTxTHwU5VndkZoT+kiIFeegx9iEsUfXJgtpVZONHGArpC72L/DDYQL6MrN48W
         1DArnfWC0lHPmn90vwwcJ/gEwmfq2siaBC6ElDOo24BPxXwwsANH+SeMubvuAZg7Mkvq
         UybN9iTiThNVBIvN8xnPZWezUUbpTBOGxyVZYTIJQDALVm6467Rlrms8LCWyeaDo4iIf
         Hnfg==
X-Gm-Message-State: AOAM53214BtZNQ1WbZMYRlpsu1M77Bzc94wTNSvKDC0vtT9MaT2C4z73
	O5WvjT+m2HpBOfuv+4CHQHH3KxEcq98=
X-Google-Smtp-Source: ABdhPJye+ZtSzDjQUQ8mD2rks0aqV2MqSpucLFnH7BnVq+iFYFO3K1p1aTW4IjXl0O2wjaKN462h4Q==
X-Received: by 2002:a65:618c:: with SMTP id c12mr25928146pgv.296.1619593270214;
        Wed, 28 Apr 2021 00:01:10 -0700 (PDT)
Received: from localhost ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id p10sm4102079pfo.210.2021.04.28.00.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 00:01:09 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 0/4] add MP_CAPABLE 'C' flag
Date: Wed, 28 Apr 2021 15:01:02 +0800
Message-Id: <cover.1619592361.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - rename join_denied to allow_join_id0 in mptcp_out_options
 - rename join_denied to deny_join_id0 in mptcp_options_received
 - add a new function mptcp_pm_deny_join_id0_received
 - move deny_join_id0 flag from mptcp_sock to mptcp_pm_data
 - check deny_join_id0 flag in mptcp_pm_create_subflow_or_signal_addr
instead of in mptcp_syn_options.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/183

Geliang Tang (4):
  mptcp: add sysctl allow_join_initial_addr_port
  mptcp: add allow_join_id0 in mptcp_out_options
  mptcp: add deny_join_id0 in mptcp_options_received
  selftests: mptcp: add deny_join_id0 testcases

 Documentation/networking/mptcp-sysctl.rst     | 13 +++++
 include/net/mptcp.h                           |  3 +-
 net/mptcp/ctrl.c                              | 14 +++++
 net/mptcp/options.c                           | 16 +++++-
 net/mptcp/pm.c                                | 10 ++++
 net/mptcp/pm_netlink.c                        |  4 +-
 net/mptcp/protocol.h                          | 12 +++-
 net/mptcp/subflow.c                           |  3 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 55 ++++++++++++++++++-
 9 files changed, 122 insertions(+), 8 deletions(-)

-- 
2.30.2

