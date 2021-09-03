Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905A2FAE
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 08:15:21 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id t1so4834856pgv.3
        for <mptcp@lists.linux.dev>; Fri, 03 Sep 2021 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lFqpmkSn3/NPzzg/QjXKw8E0JwnOHqba8tpaTQqiD8Q=;
        b=YLTRnMuV/aMtlh8aKB4fg83INQl/BXPt2Eb5FiOyzvCxTxqBT97w9s1gK3Jsp4KlP5
         LmQtkbXqGQzDjpm1epRAMiTtU+mSF1a9X5gosE4oCnOgxFC9+NKMTG9lLyiFfVp/81R/
         KMiooobz87i5yD0+oG3PsVPbzlRxO/Uft8fuvY9rQpu+NexNKXuLtN5DmvzgpHPulAHo
         brbEKP9Zlt1feVdhGqR86pLavEro+RH8vzDYYhZj8kc5QHKOF7Nc/TP6hDvASEAAVQyf
         CfgUHmbduc4tEehoUo0gyFEPtB2JP6RqUPPVOoBMtLVzag0kA2+1c5GsL8OLXbfMXLkZ
         FAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lFqpmkSn3/NPzzg/QjXKw8E0JwnOHqba8tpaTQqiD8Q=;
        b=ZIpw/KS5qBW2tS8xCADqx0urs4kV58VUUYxi5UudpOEhZJ1HqJpgeJN7qh3I1unJUr
         FsbH9HdHeJuj5JK8BeHQUAYjRE9cQ81NrcqwH8ahedwwCKhtis/s7puK2BNIXwamwcrH
         +eBIOpD3EqQg5+hFb0irHztJbBJeLwOhUi/w7g0E5e7oN4wDv5iJBj0v3nI5KIqsvJnw
         WSfumemAU331wntoOkIHus4kugja8VDIOUP5GpPjhvI40y1ng2ewRr0nAj7QqrxpFbYa
         XyGpXhEaK50SfvXA0kbMGpPrjsVkOIkggsHXLcIyJJl5MM4WY5SQ/R0o0OqJZhfwuwp+
         bkzg==
X-Gm-Message-State: AOAM531Msgr9ZJfIFeAqdWTSnQhgPGUyQd6VRERzRKZaUW3vfDJrlYwS
	kTMLv0J2Uh+YR6ib/2KvWzS3uHQ9yi4=
X-Google-Smtp-Source: ABdhPJyYtgp5AWEt0eBB1jYsRkTxA/VHWUsT9ViAY45CtjWwCV5kX8/e9f0zNutwJKUtdUtxhHgD6g==
X-Received: by 2002:a63:b950:: with SMTP id v16mr2553141pgo.328.1630656920710;
        Fri, 03 Sep 2021 01:15:20 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id j6sm5254452pgq.0.2021.09.03.01.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 01:15:20 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH RFC 0/5] The infinite mapping support
Date: Fri,  3 Sep 2021 16:15:08 +0800
Message-Id: <cover.1630656206.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patchset doesn't work yet. I sent this RFC version for some
suggestions and help.

tag: export/20210901T094059

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/216

Geliang Tang (5):
  mptcp: don't send RST for single subflow
  mptcp: infinite mapping sending
  mptcp: infinite mapping receiving
  mptcp: add a mib for the infinite mapping sending
  DO-NOT-MERGE: mptcp: mp_fail test

 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  1 +
 net/mptcp/options.c                           | 13 ++++++++
 net/mptcp/pm.c                                |  6 ++++
 net/mptcp/protocol.c                          | 32 +++++++++++++++++++
 net/mptcp/protocol.h                          |  3 ++
 net/mptcp/subflow.c                           | 27 +++++++++++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 18 +++++++++++
 8 files changed, 96 insertions(+), 5 deletions(-)

-- 
2.31.1

