Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C719B72
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 07:21:00 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id t21so5861321plr.13
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 00:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UfPXdmi2f8V6Bs4iEPMkD2hzApkUAbFUQ75lB3I5X/Q=;
        b=TQdzKualBwx6fbqwTP3gKgA0Tv7GTqHULaXUavg/1Q5itOiRfmYFofWNsc7NM1ZE+5
         1iS5JwL+EG9BvB701MmOlFwUl2s2YuRgHMWaLuxxtz+pZtdU04/cpOWIewuvSpFB4m9a
         lSi4h5HfyjCgfNuqgsHjEsiT/wFtSGnv4s6oblhN36Ho6UuehXi5BDNbdBqf4oJ/17NY
         5sOF43UiML9o9ny6/8TRJmkJ+T2Z32EcjJ1AHDNh3/t20om3AHXfR2ebNZohNJxLsbp8
         wbZ+aqma9Uw7K37MAWlJ5TCwPOfJ6ZBOCDvgvbPlNs3mH/Rd8F5M4miUnqmG+AK7C099
         vfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UfPXdmi2f8V6Bs4iEPMkD2hzApkUAbFUQ75lB3I5X/Q=;
        b=iiCIjWnknu9LFKiWYueg0EUqM2quO9eUBNY9vJn4qJiColBK3MmzXVh0F3+fj9lPPD
         tMPinw5HfhbZas8tl66o7poLraEjwF+tLSioXDZt/w83BS33u78U4PzwSZ4FnQZ6vUIJ
         JeyjJPOhErrsFNJOAiREYpMHjAOb45Yt34LBWtxYb4Bs8KjhXnjfKwXBGOtcTqbd7Vur
         4EJDShxsUtpgAHx7tQQJxorVpv2bhkEwiqOpbzF6gpwQa1V7DPQnXT/HDaRm7fRdUfM8
         Slb2BAYEJdh856AoODjZTU0KVf1nbVpgNPXfQ1+gQT9YmIrBoZKZLfl/Kxa9eKregpuG
         zQPQ==
X-Gm-Message-State: AOAM533R6zSoaLE8i34Mmu1u3ZG+YZbEpcVMaZlBQzyY7WJhv6jYTUcx
	8RtATMl/+A97SgLm5hxW2t6KKQs9ApI=
X-Google-Smtp-Source: ABdhPJwl3rqTlD/jFxn/r9ODr+6qHOoYFGyoaVeENVMbJxL3KdTC9wuzffI8J1LWoSwPsOwVzyJWeg==
X-Received: by 2002:a63:2c01:: with SMTP id s1mr2638657pgs.357.1627543260122;
        Thu, 29 Jul 2021 00:21:00 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id p17sm2211550pfh.33.2021.07.29.00.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:20:59 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v7 mptcp-next 0/6] fullmesh path manager support
Date: Thu, 29 Jul 2021 15:20:49 +0800
Message-Id: <cover.1627543032.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

v7:
 - add a new patch to drop flags and ifindex arguments of
   __mptcp_subflow_connect().
 - add more comments for the testcase.

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

Geliang Tang (6):
  mptcp: drop flags and ifindex arguments
  mptcp: remote addresses fullmesh
  mptcp: local addresses fullmesh
  selftests: mptcp: set and print the fullmesh flag
  selftests: mptcp: add fullmesh testcases
  selftests: mptcp: delete uncontinuous removing ids

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/pm_netlink.c                        | 155 ++++++++++++++++--
 net/mptcp/protocol.h                          |   5 +-
 net/mptcp/subflow.c                           |   7 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  76 ++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  16 +-
 6 files changed, 233 insertions(+), 27 deletions(-)

-- 
2.31.1

