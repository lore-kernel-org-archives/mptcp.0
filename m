Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1303472
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 13:24:38 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso4821770pjo.1
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RjEK/lCGBzh23B7sYRkYIkKgZC98yeV1+QcCygw8oLc=;
        b=lRh6huaMtaE4xEEKcsTBQbNYDs2JeXcEm7UM+9EshdLXXq1O/8dJPB2YW7+XuKwBI+
         3RoojLThY+caZE+7Q6TxlZdtTcxDFtKQaa7dJad3Slmpj+ocZasKMlgcwCCy9H/TLvfH
         073Hq3FPBTz2wpZ/O3gul1zZAGRqLS4lFeztAj5rfQTeuzL3RNBMEIdmtBIkaD0F0jD0
         e2GjBFbVr+6MEris2DMg3WtCN5e3mjzGg0Hi3ax0SLcxCB4Qe03MYauE/DHma6jZUjjD
         kaHo0eiOhHAhnV+AaQOF04yfEwC4QNtdEIgsK6VQi7I+IV0r1UT2Ob9uXTMAqABPoMKX
         2t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RjEK/lCGBzh23B7sYRkYIkKgZC98yeV1+QcCygw8oLc=;
        b=LVX/+AwUsyg8+z6OP2q9Rp0EuwYUPkaIEMc8TXqAMhoRiPb6viAE/hnFzU21UuioWv
         hFs8rOdAnI8fyP3h3x7VNTnWZLBlVmrsNlMYQVwwTnfDTLqbmeklE/tEmHy91hBMu+h3
         zQJlqqINUihAlkLpLJz96aNiUnu4/egLIytGcCHgNqeSsZghBCZVezaYV6dIMJpDgI3g
         zpK5assehR7RdVIXZNi6BAgfiyAojEIcxpcgGTxRLvxJiNOB8jNgBchx8M5O+WwR3VpX
         oxBxiopcafHNu8P0sXZ1MkVizqhJ5sv2ZveptULKhV9IW39s+bkF9IeFvsXptLhU1VAP
         h/dA==
X-Gm-Message-State: AOAM530iwp1NQIxq5OQ/Rm9s/uvtzKznZeuVrSOTHPmLLoczE+GhenBZ
	xDF9g4rKzc3uScyd1Mx87arAAG7n7Ow=
X-Google-Smtp-Source: ABdhPJwD/9J8HSqW+lF+i5roGIXX63nPifdRqjtVy21u9/XaXnzwDVnGxXKSI10Fzk2TrhjmMd5gug==
X-Received: by 2002:a17:902:6903:b029:12b:ab66:1248 with SMTP id j3-20020a1709026903b029012bab661248mr18358530plk.69.1627392278481;
        Tue, 27 Jul 2021 06:24:38 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id j13sm3511066pjl.1.2021.07.27.06.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:24:38 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v6 mptcp-next 0/5] fullmesh path manager support
Date: Tue, 27 Jul 2021 21:24:28 +0800
Message-Id: <cover.1627391588.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

v6:
 - drop lookup_subflow_by_addrs()
 - pass three arrays instead of 'entries' in fill_local_adresses_vec()
 - drop the 'remote' argument of fill_local_addresses_vec
 - drop the 'local' argument of fill_remote_addresses_vec
 - fix the pm.subflows.
 - add limit testcase.

v5:
 - patch 1, add a new helper lookup_address_in_vec.
 - patch 2, update pm.subflows in the non-fullmesh case.
 - patch 4, add more tests.
 - tag: export/20210727T054640

v4:
 - add new helpers, fill_local/remote_addresses_vec
 - add max_subflows checks
 - add 'local' into the local addresses array only when no fullmesh
   entry found.
 - add signal,fullmesh check

v3:
 - the in-kernel fullmesh path manager has been dropped from this
   patchset, only keep the fullmesh flag support code.

v2:
 - Implement the fullmesh mode as an extension to the netlink PM, not a
   standalone PM as Paolo suggested.
 - drop duplicate code.
 - add a new per endpoint flag MPTCP_PM_ADDR_FLAG_FULLMESH.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/193

Geliang Tang (5):
  mptcp: remote addresses fullmesh
  mptcp: local addresses fullmesh
  selftests: mptcp: set and print the fullmesh flag
  selftests: mptcp: add fullmesh testcases
  selftests: mptcp: delete uncontinuous removing ids

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/pm_netlink.c                        | 145 ++++++++++++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh |  67 +++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  16 +-
 4 files changed, 206 insertions(+), 23 deletions(-)

-- 
2.31.1

