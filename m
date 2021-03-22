Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467A6E
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 11:37:35 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso8358383pjb.3
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vr0480u7dXTjWK8VNKMWPgRc7SD42QuTjCUlSviI0fY=;
        b=XoP9MsGyIs6iMeHOf1PK+XsxOZCHg6fRMlQpJIsWBSE7LgJvrQFJaoT2u/EOGhCvaa
         JteI0uFGM0Pdu8neaoaeFC+djUWHF5XPerf5gI8YoVbwuiJbj6JpRfLVke2Z9M0dHjQ7
         TxomREpB/cvdtlQzQIBVbgAHXO63rGbkG5JsXLSxgTbqNzKGV2Fej/NA8HmqZNlcGMDu
         qcy+AV2QT38/tRkZ8nXXKIx/3ZDInAy3ZcY1ul2jCNU7TPtc8j4D6JUZudCz9/JRC/rh
         T0u7J0o4YWTuONrizOXBT8nZJbM5IcBC2gXY07O9EpGNQHGCMT5G4TK9nGaU7qpEhx+G
         ylaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vr0480u7dXTjWK8VNKMWPgRc7SD42QuTjCUlSviI0fY=;
        b=Q1xdwmUDx0jhYT7pyQh0qL4h6nEV7wb6rEz6mVLtTl17TAStXeUxjQIXdsOAM+f11e
         LsTeTGWcagIfPX2hwx/VjgwK471orEVJRvNEa7WvDJSEGr8munLKAO0HEamhhw4smkls
         L5KLGNSnD7I/v5xLaGVESyTvnFsTpGWwQcTPTN0ySyb9Idv3tRBGSCh3N/9qgeYU46yU
         l5OxZzJN5Ue+kNysvzmJixRjjcuGy6ps17Bh9okxrNp2FEb3l7cyW3b6YTZF3MfhmbCA
         j9CjFNb4cY/ONUg+OkI7+yetp95c0GpC6/haTEA3vVP8ToZN+EvBEhEbFLQ29s1ULg09
         MJHw==
X-Gm-Message-State: AOAM533HHsG7hSjLNhC5OGEyalc68lY8Ppv+IttagPprWvKRB4Qd7hpQ
	uVt11i4OkWmRYnRy2sUWEFE=
X-Google-Smtp-Source: ABdhPJyLi9fa7xGRiPOeIqJyOIPkyq8iKtTU6/DV25fT891QZq1KoWEk7XFfihjTRd8flV1IYxQeRg==
X-Received: by 2002:a17:90b:4008:: with SMTP id ie8mr13359874pjb.231.1616413055396;
        Mon, 22 Mar 2021 04:37:35 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id k17sm13177854pfa.68.2021.03.22.04.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:37:34 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org,
	mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 0/6] DSS checksum support
Date: Mon, 22 Mar 2021 19:37:24 +0800
Message-Id: <cover.1616412490.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apply: export/20210320T065116 + "refactor mptcp_addr_info and cleanups"

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/134

Geliang Tang (6):
  mptcp: add a new sysctl checksum_enabled
  mptcp: add csum_enabled in mptcp_out_options
  mptcp: add the csum_reqd fields
  mptcp: add the DSS checksum sending
  mptcp: add the DSS checksum receiving
  mptcp: add trace event for DSS checksum

 Documentation/networking/mptcp-sysctl.rst |  8 +++
 include/net/mptcp.h                       |  4 +-
 include/trace/events/mptcp.h              | 51 +++++++++++++++
 net/mptcp/ctrl.c                          | 14 +++++
 net/mptcp/options.c                       | 76 ++++++++++++++++++++---
 net/mptcp/protocol.c                      |  4 ++
 net/mptcp/protocol.h                      | 14 ++++-
 net/mptcp/subflow.c                       | 46 ++++++++++++++
 8 files changed, 205 insertions(+), 12 deletions(-)
 create mode 100644 include/trace/events/mptcp.h

-- 
2.30.2

