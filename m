Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E3C2FB0
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 09:17:09 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id a7so7351233plh.3
        for <mptcp@lists.linux.dev>; Tue, 25 May 2021 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/+RBMxRD4DnE/EFkVaO5QqVKi7qK46p6FY38dRBVhw=;
        b=pIN5cZIXjI6PUXSSfXgFsJwQE1HTlZ0/ox5/O6NEz8z0iXJERbGnNAk6YiyP0RhqCY
         jMMavFrffxhfx9rawRkAWQkhp3yfXeg656c4+PVbwzdXIRHbSDyU86vRWoIqF104q3Ad
         MuEh5SqVHzMQSjwCp+VwuqJiMvuRPOzB/jaZA47HfvpHqtuDmHYvXQOltS44DvIKnVRK
         j06BZzFu23rXwoRVK/ndrJiu7NePv8+8kkD3JOj8O2BojjafuVoQqRMuFHdsc+MY5JfP
         EqRHKOqBGFkRfLWWSC+11GUXoBnZUJZJIATtDRzrfIa7/nMRVxDyDsgmZyJryDt84N1f
         DW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/+RBMxRD4DnE/EFkVaO5QqVKi7qK46p6FY38dRBVhw=;
        b=CaVe74LsK1dxS4ivomQjqpfDe+/0NZJqTjnv2vs6KdkfVRDAtYpBgD4Sye6xR0Aoi2
         //E/csJdV+LYF93wJysc1Sm3UA0QmbGFPfm+QTVF2/urqZf1EOj7q3wYp0Cplig2SIrZ
         f9sILj9aiGd9bCTI6K5LaaDmOqHB0HUO8iosm7MKE2e6EPV8AzfMXK0Tc3EZFCdIT4HP
         NYZ5IRFCLOilSyRSTRFOvfw8PbfB+Dl5fFqQPzMAq5pHP92zOV56yJvqImJqBryf8P87
         wvWPxbQZ8YsJZ7WA6T3APOMb5/HfidonE3dADda3qnUYRCkpobXVchZcwijQVTWuja7Z
         KZ4Q==
X-Gm-Message-State: AOAM531BjFr7LC+E40paKulwaEoXVcR29nGesO0QfhXC7ZPxA12P3AuK
	2NJvsKfunYuiBfbWrnoldp0uHWLepZJl1A==
X-Google-Smtp-Source: ABdhPJzolsBmNrJlhongVtXtR55PuGswpER/uGwouZG+MNicNfLvSUn+Gtufzk/3RwBbXtbUedkI9w==
X-Received: by 2002:a17:90a:1d0c:: with SMTP id c12mr10578268pjd.122.1621934229228;
        Tue, 25 May 2021 02:17:09 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id w125sm13028387pfw.214.2021.05.25.02.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:17:08 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v8 mptcp-next 0/4] add MP_CAPABLE 'C' flag
Date: Tue, 25 May 2021 17:17:02 +0800
Message-Id: <cover.1621933974.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v8:
 - drop add_cached in v7
 - tag: export/20210525T061510

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

Geliang Tang (4):
  mptcp: add sysctl allow_join_initial_addr_port
  mptcp: add allow_join_id0 in mptcp_out_options
  mptcp: add deny_join_id0 in mptcp_options_received
  selftests: mptcp: add deny_join_id0 testcases

 Documentation/networking/mptcp-sysctl.rst     | 13 ++++
 include/net/mptcp.h                           |  3 +-
 net/mptcp/ctrl.c                              | 16 ++++
 net/mptcp/options.c                           | 12 +++
 net/mptcp/pm.c                                |  1 +
 net/mptcp/pm_netlink.c                        |  3 +-
 net/mptcp/protocol.h                          | 11 ++-
 net/mptcp/subflow.c                           |  3 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 75 ++++++++++++++++++-
 9 files changed, 131 insertions(+), 6 deletions(-)

-- 
2.31.1

