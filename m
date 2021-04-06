Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DE229DE
	for <mptcp@lists.linux.dev>; Tue,  6 Apr 2021 10:03:51 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so9392764pjb.0
        for <mptcp@lists.linux.dev>; Tue, 06 Apr 2021 03:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7sjPCpIYfjpQ9NPOfg4EQ8oW3eRbu3jjjHVyD8bAi2w=;
        b=decHLpmKX8RxdmFVYnSnKtMtfVjgyDMZH6NT2dRpkezJVUGCTFe9EEqbitFd3LFzRm
         AIabijwuQ3NpJJb5O3rwga558utCkhIMVALEY7yP5yOWjXvLwAWGgndqERQ6cjVqiOmg
         WDsnGMWWl5dxmJLDl7i624+YSr+58aziCagPOE+Fa4EnT/0/cCw1m3V5iE6w6lwSyQiu
         W+4FEfkGTz15hi9aMvMzHsInUe1m7vWhOQ1cqU+Me4nLqmsGLsYdh/MpbxViYXHlFMUz
         zaZPYzQbKBgJA5wO5EKlkOfL3nscNi9lSBDhBFOxgT8ySl9JVDgnLG5zYp+04tmlSvFH
         hT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7sjPCpIYfjpQ9NPOfg4EQ8oW3eRbu3jjjHVyD8bAi2w=;
        b=qXWyWkRZGZrtbGCf+0xVsTo5Tb35JfDl2/X+8JfXfo5M6rLtsW4wxv00ZpnPq8ApSD
         ckS9rXti75X28WA604fTbuYEXf5JhEDkAA0vMRiJrhBol2Iu7j6wLlNLHLRrG098otr+
         cmDhYs0q9oWfmHjGjcxK/JMC4FSOY/SRscU2dN00tVBaa2Qozocxry6QVrzk77VT2eX+
         PuaOEXbjmprBnYnm9LI9s6aBLSBGoPSnjTkhL9hwzjNggr9GIoqVVlmNUQoh/sOSCxL7
         knCak+cEnX9xu78Aan20a9aOUBizxXtwQZtB2ggQ35ocnkGYEQE+i7XwopJxib+GcApe
         Sr+w==
X-Gm-Message-State: AOAM532tzvT1d0jzbYx4Yeoh+tsN3qacGIYrhUMDoY8t+JXi+igvX84E
	HJkDyqsBZ2yLDCWvoX6LizPbG+Xms3ez0w==
X-Google-Smtp-Source: ABdhPJy8lMROM/TDdOzv6sfISQho/TrQ5KzL7hk7Q1DcLmscV+mLSHpJUgoSNqM6epl5SGhTuhRKDA==
X-Received: by 2002:a17:90b:1c0e:: with SMTP id oc14mr3589274pjb.188.1617703430203;
        Tue, 06 Apr 2021 03:03:50 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id h1sm18591601pfq.137.2021.04.06.03.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 03:03:49 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 0/2] mptcp_for_each_* cleanups
Date: Tue,  6 Apr 2021 18:03:42 +0800
Message-Id: <cover.1617703144.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small cleanups using the macro helpers mptcp_for_each_*.

Geliang Tang (2):
  mptcp: add mptcp_for_each_msk helper
  mptcp: use mptcp_for_each_subflow in mptcp_close

 net/mptcp/pm_netlink.c | 39 +++++++++++++++++----------------------
 net/mptcp/protocol.c   |  2 +-
 2 files changed, 18 insertions(+), 23 deletions(-)

-- 
2.30.2

