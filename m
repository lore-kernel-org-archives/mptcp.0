Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E64871
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 04:48:13 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id m37so3866724pgb.8
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 21:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gZHGdOGTVrc35Tm4+kjXid0cVPKAPzCtFBodBnaPatE=;
        b=njONUYYSgwx/uksIWyxypDWa9H8O10NKFDtHfhCW91rS+FJg6Wu8Tr6MvovZG9ZzDq
         94GB+kogpfmrnunFtaxUb38C4h72qWkOD8poAazMmdBiq6EdgROEMW1ZTer0gUhK1Z5I
         4hnG8HLz6F0f2NmXYcNHb+jOEKmHSpYdT8dujz/tkytvbt67TvHp39lQTnKaW8w01duY
         mu5s1/gfllCxFHEHGpucjOY6IzfbkI2SDzGpDwYxtyY1+itON79QPR2raX1G3WnVBnfS
         U9KU3MHmO2m5toDpoFeI20rKC0f0IWjw+yW1h54DNj/kpAXnpMaiaHpTL/szh9Z2XDeg
         tGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gZHGdOGTVrc35Tm4+kjXid0cVPKAPzCtFBodBnaPatE=;
        b=CScQd8zFHzxiM/Tx/WWor4IoN3v2s97xZb3HS2QRbhIgd/uCRm2bzDchvuZKnftOix
         /FRtczXh+vBH7Q63Y+8gwYiwVRSJ0WWMic0LOqeAn3UxPy/WoL5o20Y/nwj7uBmJx+mR
         Y5aKTxhD5vZE2SUhLN/i0e0Yc2Eztwift9EH8RU+V9OyPCpo/XZmjFEAqmiibUp3dDwz
         t/Plj3BsSAiPbZU1NASGo2Eq8Y+b9i+CnmSkhN2vG5kAvH5w38AO4BxCNqrl4WfHCobK
         aQpyM43nMkpxZcs5aXCUv6NMHoOF67j1gCaTWJMoaQyNxujvXTRGEynGXDOJc8Gpxe2p
         Ah/A==
X-Gm-Message-State: AOAM531N0Q40kQj9GlC1NXF5C9t1pHoESXRG7L2XqLHGbXCo8C/kQ59o
	dV+cJR+dyrt+noEh031yo+wGcJEMjSo=
X-Google-Smtp-Source: ABdhPJwvEdeMfwfWPMd0FF6L0jYO01UEKpoKr0B2Hd3YVejnOjx4boIJzFBkh8+Cq3kOi8rXITS8YQ==
X-Received: by 2002:a65:40c7:: with SMTP id u7mr2354374pgp.29.1620276492963;
        Wed, 05 May 2021 21:48:12 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id c6sm751318pfo.192.2021.05.05.21.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:48:12 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v4 mptcp-next 0/4] add MP_CAPABLE 'C' flag
Date: Thu,  6 May 2021 12:48:04 +0800
Message-Id: <cover.1620275759.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Geliang Tang (4):
  mptcp: add sysctl allow_join_initial_addr_port
  mptcp: add allow_join_id0 in mptcp_out_options
  mptcp: add deny_join_id0 in mptcp_options_received
  selftests: mptcp: add deny_join_id0 testcases

 Documentation/networking/mptcp-sysctl.rst     | 13 +++++
 include/net/mptcp.h                           |  3 +-
 net/mptcp/ctrl.c                              | 16 ++++++
 net/mptcp/options.c                           | 12 ++++
 net/mptcp/pm.c                                |  1 +
 net/mptcp/pm_netlink.c                        |  4 +-
 net/mptcp/protocol.h                          | 11 +++-
 net/mptcp/subflow.c                           |  3 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 57 ++++++++++++++++++-
 9 files changed, 114 insertions(+), 6 deletions(-)

-- 
2.31.1

