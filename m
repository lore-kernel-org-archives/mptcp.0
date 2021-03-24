Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79C6F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 08:51:43 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so838512pjb.0
        for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 01:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TLE63/cvWu2yjmwz8tDmkePM2ofbH+hRIBHUyYqXCV4=;
        b=pblQVxuV1Brun4vzkvAN58JVhl77H0f9D+DdFAaOWjlpjXZQXdi7BqIjswzSoLIZ3Z
         DBvSuakc+6E4ydlGQCdkaqgzZ9OtWr9HEjVyLk6OGngofO4XEChj4Jkiw7lW0ZMmoBT+
         ju+4nZqrdOo6/Dr+tFvQijIFa/r1xdyciw0YODPRFbepS5eb1sUkQc/Zx2tsVmNdm+rq
         AmnCs+lopzKOV6+YHtiC/MgYrMEPaP/MeidBoy0HpjwS0fH84siNwLxpZ5sxQYpTcBWl
         Ax5J86kuXViy35N2LqzL/58izI4m0AO+qcwhQEVZoOg+PH5a2g7B2p6iQjRhGgDIwCDM
         +g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TLE63/cvWu2yjmwz8tDmkePM2ofbH+hRIBHUyYqXCV4=;
        b=BZuWtBeoZZ9mAaBXOpscBG9qa13vDsQ+EX5r16VxjYZmW0W3Eedqx7MX61MgJ9dEvo
         18pLbW70IFmpWsrOlg/dCGEeTBHzBYvo9mbsvMUUdFqz8wjBGqcn40C7vuqfYNktduC+
         +Mt5fQNWO5hbeTjjPeWfiUeslLKYPwyS24IppCzALK36AKlwznAye0nceagRcjLH/SPU
         Qx+v/aehpxGHw+Lgmkwvu/0oN+tmUOCVgX2EaNMDcv4rsBWg1Y5DBI7qew4Jupzwg+IK
         p2QO/GDewT6tdK150+VrdsvUHY7ScsrwGBfzWcwoH8uoMRTTD/MXE+2kT3N+oDgyHiOb
         pdPw==
X-Gm-Message-State: AOAM532AsALyZj6gEc/GdfPqMzSXe5gsI+TRY2BvVdWNlfZ7SgpxercE
	U0dphroYr2wlYLWrWELbEVI=
X-Google-Smtp-Source: ABdhPJzGfAdmkA4lKP4H2AAqTiSITCeKXx6llY1dzVIrL5AwbZ8b6fFUjqiHDf3fIzfsHLE3C+KAlg==
X-Received: by 2002:a17:90b:a0d:: with SMTP id gg13mr2303401pjb.29.1616575903407;
        Wed, 24 Mar 2021 01:51:43 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id ch15sm1609988pjb.46.2021.03.24.01.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 01:51:42 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org,
	mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 0/5] add tracepoints
Date: Wed, 24 Mar 2021 16:51:34 +0800
Message-Id: <cover.1616575602.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - add two new patches.
 - update the patch set as Paolo suggested.

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

 include/trace/events/mptcp.h | 151 +++++++++++++++++++++++++++++++++++
 net/mptcp/options.c          |   3 +
 net/mptcp/protocol.c         |   6 +-
 net/mptcp/protocol.h         |   1 +
 net/mptcp/subflow.c          |  10 +--
 5 files changed, 164 insertions(+), 7 deletions(-)
 create mode 100644 include/trace/events/mptcp.h

-- 
2.30.2

