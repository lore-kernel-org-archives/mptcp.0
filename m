Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DAD5F
	for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 07:23:41 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso699391pji.3
        for <mptcp@lists.linux.dev>; Wed, 31 Mar 2021 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=taRiDKGRLi66CRy5jaeAm81l/9XEns+tYQv9t4Q5E5w=;
        b=EDM/j2qYWWMatnozoqC+oyYSgsVykcvuVPKDx4irZEqCYvAjPn1PAowO2SIh0CYZOP
         D3Y2zD2NvJSWliukMCMeym4JVBsJVQJbN9hEf8j6KUNK5hETT8fffNEhdpk2r1ooIBBU
         m+M3QJVFidjen68i2OGBMBH1biJtPzdD7aVwwA3I5STEmkSxc757wkIaHDM8j5AaSZGp
         lBYlmK2w/yiDKTKc7M4Bb3MNFRINPE0dYFT0a1iPyjy1UGU13kQXA4VkQgNvbrIpg7+E
         YI+DV01ZlmHaHwPMNw4oRFuX/zgVAoWxBMQbw3MIJ7TGkMY43xsoqhbKG6qnssgj73c1
         k4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=taRiDKGRLi66CRy5jaeAm81l/9XEns+tYQv9t4Q5E5w=;
        b=rp/bG8vOpEckz4tEVqNWth3uvtZaqSsT7UaH5X6+X59vc4fStHpsyuWw06z7MKFWeK
         x9YsmQosBQ5EtCWv+q/e6T//ZST+jTg5UgQCCvs5pvGmbOBmMFT+Edk5fc33Rz/IbIpi
         KEE/V5e7o1gr5sDMGtlDRW2HGXdIzN7u5kXevMmPNNU6MgwO1qZv+Boz2SsqmwouA3ve
         c4X8L3zZ9NtjQGTnHHkl4ITOsieE3237KkMPqnRDpAYJVWNtWdi/2s75nvuCIUoN2FmJ
         Wx8yVxkQsOeIAYm1XzQk9nu2b0SNPq2sjdKbn9nDY6ou8vDC4UcnVZuv6OXeybTlu+VQ
         nq9Q==
X-Gm-Message-State: AOAM5321wpQ8IMGzedCt7lcdAJHouy9UCzuX79jnYn1qaWkfoLXtNrB2
	RjA5JLg5co37sUAQGvXcSaCrCkYY0Nw=
X-Google-Smtp-Source: ABdhPJxL/XpBldJmVA1qCrc3anRgKNikkVW/FFHLod9phZ2cZzze4HoCYswyosThxK1RnnWfGkIo0A==
X-Received: by 2002:a17:90b:10a:: with SMTP id p10mr2196770pjz.148.1617175420438;
        Wed, 31 Mar 2021 00:23:40 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id o3sm1119580pjm.30.2021.03.31.00.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 00:23:39 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v4 mptcp-next 0/5] add tracepoints
Date: Wed, 31 Mar 2021 15:23:31 +0800
Message-Id: <cover.1617175133.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
 - add back patch 1.
 - use sk_fullsock in patch 2.

v3:
 - update the patch set as Paolo suggested.
 - drop the patch "mptcp: export mptcp_subflow_active".

v2:
 - add two new patches.

This patchset addressed issues 131, replace some/most pr_debug with trace
events. As Paolo suggested, we should add the tracepoints at "the packet
scheduler and the mapping status" first.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/131

Geliang Tang (5):
  mptcp: export mptcp_subflow_active
  mptcp: add tracepoint in mptcp_subflow_get_send
  mptcp: add tracepoint in get_mapping_status
  mptcp: add tracepoint in ack_update_msk
  mptcp: add tracepoint in subflow_check_data_avail

 include/trace/events/mptcp.h | 166 +++++++++++++++++++++++++++++++++++
 net/mptcp/options.c          |   6 ++
 net/mptcp/protocol.c         |  20 +----
 net/mptcp/protocol.h         |  12 +++
 net/mptcp/subflow.c          |  10 +--
 5 files changed, 192 insertions(+), 22 deletions(-)
 create mode 100644 include/trace/events/mptcp.h

-- 
2.30.2

