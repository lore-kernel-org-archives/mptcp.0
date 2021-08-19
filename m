Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763E6D38
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 13:40:53 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id b15so12972053ejg.10
        for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ensNw/H0Wnz0bHHK4Bvl9UvZrHCtYOJjXNkZ91RoE58=;
        b=fpfAERJ1MpVLEtQ6NCO+fEbk3+gfPvOP2NaCtZ+Qz8k6XGVRtsHROinU8AEaDtIS6s
         +nKKAnGI+/VJo6mFFJIvKocaTAX99AmnwQZa6NFvDVsrmqi5o4ddw5zYRMuTxRhZihSU
         pM9fcc0sTo4t3AHbElhv20yvhXcX3R63eluhEbeDG9n22OflzlQtBEisAGeBDxWHLszG
         EumjXqrcoHHPPfnkoOa8wlNEmSBPhXe5Tqry0eN4SBoMKg7M4DXhqhZeKnT9ICJ48LVJ
         UybYQl5P5SwAPa9FtEgGPqwH1Hto8U7qv1QGy1H06iakBWAimTigP5wzPVanAhs5xX0b
         chVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ensNw/H0Wnz0bHHK4Bvl9UvZrHCtYOJjXNkZ91RoE58=;
        b=RsFWKzutanLec6dPEQGrnXQcFwxLFKS6cjxyKz7PDjvNsV9tQV+fgK/sbu0XoLqYfG
         ttY4e9Mqs4cHz6vd9aovIErN4pplnV+e4+YU81/DKAvXoC5/8O2S7lt/byOcbGfg5XEq
         v5hm6p7Banm7RCf3OvAym2YEgaOBKWAjYxcCtgH3ZCeK0lA3i9MQSFRmTkzCCMFU2iQp
         396banbmTwHT6trb0A22DhQeWSjBRuGxt6By6O1d/gVi3+6jCDcyAv4FSKrT1KkBtKWK
         QhLW+f0Cd+wK0/Ax1ZC9RmsfalRWMlMZRfMl/0LyqMvYCHvfRjwMznnRj1Cc8gd+T+je
         oamA==
X-Gm-Message-State: AOAM530JkB2Xk95nbFfqt4INqFV6T/2M54D7HK9tRqWtXlXCAywRUj+U
	a/6ByZsLuibcAW/ZtfJ/YlV9XdI6gmNtXA==
X-Google-Smtp-Source: ABdhPJxsF2KOg2TJWMrl/dC9R014HS0giUC5NJ9bh8EXvnQw8MHlT8jTu4WR7FoE5HgL2Y93T4fpiw==
X-Received: by 2002:a17:906:e10d:: with SMTP id gj13mr7093625ejb.380.1629380451547;
        Thu, 19 Aug 2021 06:40:51 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id r11sm1312468ejy.71.2021.08.19.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 06:40:51 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add mptcp getsockopt test cases"
Date: Thu, 19 Aug 2021 15:40:26 +0200
Message-Id: <20210819134026.1155338-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selftests: mptcp: ignore mptcp_sockopt

Similar to what was done for mptcp_connect and pm_nl_ctl.

(No need to add "Co-Dev" tag of course)

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: add mptcp getsockopt test cases"

 tools/testing/selftests/net/mptcp/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/.gitignore b/tools/testing/selftests/net/mptcp/.gitignore
index 260336d5f0b1..7569d892967a 100644
--- a/tools/testing/selftests/net/mptcp/.gitignore
+++ b/tools/testing/selftests/net/mptcp/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 mptcp_connect
+mptcp_sockopt
 pm_nl_ctl
 *.pcap
-- 
2.32.0

