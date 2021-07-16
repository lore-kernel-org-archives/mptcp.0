Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CCC70
	for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 03:12:38 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id y17so8598556pgf.12
        for <mptcp@lists.linux.dev>; Thu, 15 Jul 2021 20:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJBVTOs7RdLp8t7IInvkiv7Djlj4Aux1tWyvL1guTA0=;
        b=Ca7Mhl+dVOBBGER5ZhL6e2efqsBYMjU0h41IuEcg2tBR6uuKohhgRMmDhTeKF7plut
         p89uRpPlul8oVAZrDtTwbx7MJkKbF3RmEW384/jEu8fsDINs2g25KaRynRzL3jIENmLW
         hN+NrI1G3lB31NRA+FTiZG8/fsFJ1lRfGYFs1iCBU6yc7nFn4AS8vaDery+BaaKPoBAx
         4LkWmJ3YXOB75TN6QCAdG9QscKOJTl1HAurjz8lfprzLQpeA/KxZiYnAcMdi5k4zRIpN
         Aa7c0TuC62V81H8pSxlvHixiMlpZxEMtL3SHibPBPkxNhsGysBkGOoMN0Mi/XyolQD5r
         YnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJBVTOs7RdLp8t7IInvkiv7Djlj4Aux1tWyvL1guTA0=;
        b=Piy4RzcDpsb/zGT3ph284y3zCBpyVq79MV3142HALbn5hgmi5b6cjRfBIUxm3oucAD
         tqM07/p6b0rCjQSSOlEjhOp9Sz8bwDLEBO9ZtUFS7yBa9cffZUmfgl6n/Tb6D9Asq45O
         C0N1kjQ8qOEA4DLmm13XylBg+eieeItZ2qJnc7VED4AKIPVlWJStorBwyUFZxPVkcJUG
         mp1WwKOjALY8N1Dx3HTPVjeO8Pc3UIBR2x5IxgRZ7wItzDdaj9YEEtY5zmO2OtiEZ8v4
         g8whUpbOCjkN9bLTfUVyXhAwIcd7VhXQKP9GyvumE+wUz/4z453x5DD/UsjWw6Bfw2gT
         SlTA==
X-Gm-Message-State: AOAM533QWnnSMR+8FSBaUkeQayyns6uCb3GbwmOWERklOA12eL3AlOHf
	hNZNbzRVCMiFF6okzuoSEiKr70ANKfa3wQ==
X-Google-Smtp-Source: ABdhPJzfeBcz5J1YGLT3FSyWx/vIDEoXrWatQAJGJM9ZL8W+xpu2IxqRI4KRFaCRsF4byvSfQjsRGg==
X-Received: by 2002:aa7:8d5a:0:b029:302:e2cb:6d79 with SMTP id s26-20020aa78d5a0000b0290302e2cb6d79mr7911350pfe.71.1626405157635;
        Thu, 15 Jul 2021 20:12:37 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id c2sm8368585pgh.82.2021.07.15.20.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 20:12:37 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v9 mptcp-next 0/6] mptcp: fix conflicts when using pm.add_signal in ADD_ADDR/echo and RM_ADDR process
Date: Fri, 16 Jul 2021 11:12:28 +0800
Message-ID: <cover.1626404090.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20210716031228.l_l3GdgZQCCyAtZCRkvvJUOUv5_Jwhc4-c30rdVLFbo@z>

From: Yonglong Li <liyonglong@chinatelecom.cn>

fix issue: ADD_ADDR and RM_ADDR use pm.add_signal to mark event, so
in some case pm.add_signal will be flush when ADD_ADDR/RM_ADDR in
process.

fix issue: if ADD_ADDR and ADD_ADDR-echo process at the same time,
only one event can write pm.add_signal. so ADD_ADDR will process
after add_timer timeout or ADD_ADDR-echo will not be process.

Patch 1 fix ADD_ADDR and RM_ADDR maybe clear addr_signal each other.

Patch 2 and 3 deal ADD_ADDR and ADD_ADDR-echo with separately to fix
conflicts in using pm.addr_signal porcess.

Patch 4 MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT is not necessary.

v1->v2:
 - remove READ_ONCE under the pm spin lock.

v2->v3:
 - Patch 2: mptcp_pm_should_add_addr => mptcp_pm_should_add_signal_addr
 - Patch 3: avoid read-modify-write of msk->pm.addr_signal and change 
   mptcp_pm_add_addr_signal to return void.

v3->v4:
 - Patch 1: use ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO))
   instead of BIT(MPTCP_RM_ADDR_SIGNAL)
 - Patch 3: simple the code; init flags; fix wrong goto logic code;

v4->v5:
 - Patch 3: simple the code of 'mptcp_established_options_add_addr'

v5->v6:
 - Patch2: fix fails of 'mptcp_join.sh -t'. In mptcp_pm_add_addr_send_ack
   without MPTCP_ADD_ADDR_SIGNAL check so pure ack can not be sent for
   ADD_ADDR. That cause ADD_ADDR can not be sent in time.
 - Patch3: refactor some code according Geliang's suggestions.
 - Patch4: modify commit comment

v6->v7:
 - Patch1: use reverse xmas tree order for variables definition
 - Patch3: refactor some code according Geliang's suggestions.
 - add a Patch4: remove some double-check

v7->v8:
 - Patch1,2: exchange patch1 and patch2
 - Patch3: refactor some code according Geliang's suggestions.
 - remove patch "remove some double check", Geliang think it's unnecessary

v8->v9:
 - Keep mptcp_add_addr_len unchanged.
 - populate opts->local or opts->remote after the length check, don't
   populate both of them.
 - add back 'echo' and 'port' arguments of mptcp_pm_add_addr_signal().
 - add a new arguments drop_other_suboptions for
   mptcp_pm_add_addr_signal(), and do the drop_other_suboptions check in it.
 - drop other suboptions in mptcp_established_options_add_addr() after the
   length check.
 - split the drop_other_suboptions code into a new patch.
 - add a new selftest case.

Yonglong Li (6):
  mptcp: move drop_other_suboptions check under pm lock
  mptcp: make MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate
  mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
  mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
  mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
  selftests: mptcp: add_addr and echo race test

 include/net/mptcp.h                           |  3 +-
 net/mptcp/options.c                           | 54 +++++++++---------
 net/mptcp/pm.c                                | 57 +++++++++++++------
 net/mptcp/pm_netlink.c                        | 10 ++--
 net/mptcp/protocol.h                          | 24 ++++----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++
 6 files changed, 97 insertions(+), 66 deletions(-)

-- 
2.31.1

