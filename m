Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB62F80
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 15:34:21 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id c3so25218959pfo.3
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p1Dl0ueNjYevrmz3Gt1qtJun8jZZQzbaR4eu/ZyL604=;
        b=Nv+6TO3S54QRy7NhkBw9Vh/flmygrUl9d+61YWIo6ibuM7txzqJjF7ITRm1kzlF3q1
         trngnHQFUkdtS9rLtLnrM/MJDnIbcpnCgUAitpllZHGdwDwXqYLCdwRvDh1/V7C0EvbN
         hQxFNb7iTpYiBj5N6diHWdNBrm7ZpjOJcZSn2Q1tMiCRJM3ZrZuuP4pCSvG3NEEQHPhk
         FNPKi4ooy/Hb3eVbAveu5c9KazNH0NTKkAF57CwrBd6DdoQPKwzJ5Jng97Ir57Gr+Ybu
         +dwDwkvBlYHotGoPacDPxCsbQcWoFu+W3vFs9XwrEAtb7UFF3tU/0GjO3UsJXvCCS5Ex
         EL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p1Dl0ueNjYevrmz3Gt1qtJun8jZZQzbaR4eu/ZyL604=;
        b=iqgxCwBQyTb6q8KKiA0DJp22Fn0gZ1aCoWLqDpBtL56Zdn1TensZ7IEuUMa7Ff5DfA
         afh0uEIlhtwkiU8tgvdM4gv6S5R52XSFBqkifODixI5sXAd9gNSw93x5HVHWvJ7yyy9h
         AVD9/rlX89nH/MsS7XEwAuusVY0ZXlvdD12KGK1PLTkI19i8O3Zmumd2igLOW84w4ZEj
         s5KECIM7BstJsaWAUWWERuW+DHEiDGcMPo2xWvQZKRl6bpNWRPsmbIFkr88KA79HjQTf
         EygxoSrVURNui2c795+71cTEHD6cWgMp2f/IY34We2CvPysY+QzrsF+2b/rRdazrKXoP
         gnUQ==
X-Gm-Message-State: AOAM5308VJKMKBLieM910Zy7drr5rXZmUCZqYTvAUKLbznoTuq+7yUAp
	cN2Dgv9CryySNAKAmRvLaERE3m3cYz4=
X-Google-Smtp-Source: ABdhPJxksAOUER0BZCqXZWylK7TkSvf9NI6CVAw1je50mZeG4zWGfo03llbd/UX9oFdlfBdUZcw5dA==
X-Received: by 2002:a63:f715:: with SMTP id x21mr27164623pgh.399.1619624060543;
        Wed, 28 Apr 2021 08:34:20 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id f20sm104056pgb.47.2021.04.28.08.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 08:34:20 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v3 mptcp-next 0/4] add MP_CAPABLE 'C' flag
Date: Wed, 28 Apr 2021 23:34:13 +0800
Message-Id: <cover.1619623735.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Geliang Tang (4):
  mptcp: add sysctl allow_join_initial_addr_port
  mptcp: add allow_join_id0 in mptcp_out_options
  mptcp: add deny_join_id0 in mptcp_options_received
  selftests: mptcp: add deny_join_id0 testcases

 Documentation/networking/mptcp-sysctl.rst     | 13 +++++
 include/net/mptcp.h                           |  3 +-
 net/mptcp/ctrl.c                              | 16 ++++++
 net/mptcp/options.c                           | 16 +++++-
 net/mptcp/pm.c                                |  1 +
 net/mptcp/pm_netlink.c                        |  4 +-
 net/mptcp/protocol.h                          | 11 +++-
 net/mptcp/subflow.c                           |  3 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 55 ++++++++++++++++++-
 9 files changed, 114 insertions(+), 8 deletions(-)

-- 
2.30.2

