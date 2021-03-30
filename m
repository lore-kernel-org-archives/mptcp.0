Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD670
	for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 09:16:51 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id g15so11752856pfq.3
        for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 02:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+SKWUUt5qxbUqHGmuMlqpdr8erhPI6Ukp6lIZ6aTpw=;
        b=UI8BsESv6TNPR5WeboBzKUGw0pKvQ11AwdY/sL5n5kari6PN4Kl717/yG8g8E1aMUU
         ZGhQ5biWhEq2+dMJCme9sFcpi2BjdcZ1LQEKBv4FlwOzyTUeesj3kt7FU7ZSukriqecB
         fU1z+ERX1GWOKWPUjGAc4UspR91PLOyzI+5gZlEA1UZ6Eo55K0vPjJBw7OU7cZPEpVRz
         /ZVaW0PMW7yjif+aJlYc+1TCLQiq2j837g7QT+FabaTpc4KmNAIyyRDkT6heFENHG6eb
         yC8ddhmXjDEOZh+ZjXYZm1oY/aUYJZi1Pwcp0q3OfBv4uTVFXcMmBzykiBDki9UVqnDL
         uvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+SKWUUt5qxbUqHGmuMlqpdr8erhPI6Ukp6lIZ6aTpw=;
        b=IB1gry116KP8ZZXtkdYFUAfgi07HE/SS7hVihpyiC3rS5tzYGzr+jbUPWqOhM+kTTU
         AE34QKn+ivq4jhLlFtkJTQ6r8ky6EZWv6KCvm51M5iAv4aLeYbsDJI54y8nxU8a2WleH
         q0FuPLoUFDTAJRVvLi2iiTGOU4x8JPYIwdGx5OpptIhoDRvg9GqQI5q59ABWEBgFzusJ
         g8O/x5XgAJZagOOBus6TKUO37w0HlHZ75JLkmRVbOS/kj5ujFE3KFoL65J3jYnrk7TRG
         95Eqs0iNxmRNAm+kQ/LWEXeaBteG+KAfk+HacE6R09aS8XPfYhubUafG1nbHQW3rkhEy
         vvFg==
X-Gm-Message-State: AOAM532AXYXkyZ0kBgo1GXK/O6vW/ccrGU/KFxRm4gR/T7E9JbIQodWb
	uYc/8hv/zzIrAiTxSUv/j0VcEJwd2Dg=
X-Google-Smtp-Source: ABdhPJwqgSti3XGkUDYE4py05NQSCcJkqYxe9ah1PP91XuGPArbK2+jWk6+MITXaL8A4boZXjsFrkg==
X-Received: by 2002:a65:6a0e:: with SMTP id m14mr1658880pgu.448.1617095810321;
        Tue, 30 Mar 2021 02:16:50 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id c6sm20323696pfj.99.2021.03.30.02.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:16:49 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v3 mptcp-next 0/4] add tracepoints
Date: Tue, 30 Mar 2021 17:16:42 +0800
Message-Id: <cover.1617095554.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
 - update the patch set as Paolo suggested.
 - drop the patch "mptcp: export mptcp_subflow_active".

v2:
 - add two new patches.

This patchset addressed issues 131, replace some/most pr_debug with trace
events. As Paolo suggested, we should add the tracepoints at "the packet
scheduler and the mapping status" first.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/131

Geliang Tang (4):
  mptcp: add tracepoint in mptcp_subflow_get_send
  mptcp: add tracepoint in get_mapping_status
  mptcp: add tracepoint in ack_update_msk
  mptcp: add tracepoint in subflow_check_data_avail

 include/trace/events/mptcp.h | 158 +++++++++++++++++++++++++++++++++++
 net/mptcp/options.c          |   6 ++
 net/mptcp/protocol.c         |   7 ++
 net/mptcp/subflow.c          |  10 +--
 4 files changed, 175 insertions(+), 6 deletions(-)
 create mode 100644 include/trace/events/mptcp.h

-- 
2.30.2

