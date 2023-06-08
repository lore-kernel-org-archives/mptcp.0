Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408D947B
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 13:21:12 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-30aef0499b6so431242f8f.1
        for <mptcp@lists.linux.dev>; Thu, 08 Jun 2023 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686230470; x=1688822470;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JrLkSqBXuXFaPtOlLMxDD4QQOh/SbBZYNkY7RLKJl40=;
        b=Yg8gZkNTI+QaGC7zmMGDlRLZgD+hwa9fiSskHeCXWMpONvKCeHrMare89xI66O5SLi
         qK+YB2/pCdU2ZcvhUwk/heyho8yvRwZT3jCm/sW9Zvmyu/Axl2MVVJtDNK23i88wzdOT
         ES0wozDmJ/BiEVMCeoMnk/gi+EiFTYBlT0osi/kW/uICdpFx8gH+qKC5+ERA4tZQrQzf
         eTUeXdpalDjJSGGq0a1bSHlmQ1NHGUAZnhAmBwxlUSjVi/XvltuABc7Pf/hPDMPf35+Q
         Y9V9Mgtaaii6YKY/VmUhattjBomXD10zXYdruNnycw+7Pe137H6WvT/12qe5id1OnlsD
         vXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686230470; x=1688822470;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrLkSqBXuXFaPtOlLMxDD4QQOh/SbBZYNkY7RLKJl40=;
        b=G7uFVQxRIMaOGkaXAbfGLUk2HT0DJLjRoitUYqsG05VlNY+pjFmLYCYIUquoYzZXmx
         IRf3keQEwVouaEGVh1ONtWt76i0S+Hhl9bIkFyS6tFBLCnn4FKU4ixCb+1qhsE6QXBeU
         afe/wVZ7nYj0GF4SeA5QPzMcV54QIWzCiq/CeKCZ5vUhdB4peHlyAjUmV34R5ye1up9w
         Wwy7PCPzTMlJnvtZHLh2y4vOiUNWTHituiZkrB3fLEGoxeB7IOmQVGMxBRaYZb6k10vE
         NK27G8MGhixPKSqXq42Hv9iQ/RksHrUFho4cbLOIIWEs/XYorX8lUL7/f/TUb8QMi0R1
         nUuw==
X-Gm-Message-State: AC+VfDwqAeqzDT8GtHcmwKpcratCpeJW+1c7tnbagpVOTGARF5h8mqRp
	8L41G4d75op3Gej0P3iYLlJJkg==
X-Google-Smtp-Source: ACHHUZ4OOQXSdAgl30N4JRXHi0RCBmxm5KUs8n+YpjgHEKZlHmzL2uB9axV7caQ1xk9lUpBU5h/LNA==
X-Received: by 2002:adf:edcb:0:b0:309:41d8:eec4 with SMTP id v11-20020adfedcb000000b0030941d8eec4mr7124852wro.39.1686230470319;
        Thu, 08 Jun 2023 06:21:10 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c021000b003f7f1b3aff1sm5001100wmi.26.2023.06.08.06.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 06:21:10 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next 0/4] mptcp: unify PM interfaces
Date: Thu, 08 Jun 2023 15:20:48 +0200
Message-Id: <20230608-upstream-net-next-20230608-mptcp-unify-pm-interfaces-v1-0-b301717c9ff5@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALDVgWQC/z2OzQ6CMBCEX4Xs2Y0VK/68ivFQylb2wNp0i8EQ3
 t1igoc5fJnkm5lBKTEp3KoZEr1Z+SUFDrsKfO/kSchdYahNfTSNueAYNSdyAwrlkinjvxpi9hF
 H4fDBOCBLphScJ0V7PYdw6sg2lqCoW6eEbXLi+1We95t1LWOiwNPv0x22FXgsyxfvJHDsrQAAA
 A==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Geliang Tang <geliang.tang@suse.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=PksWG9xpjpNR6taGD8lcKubOv6ngqDUSLnkTPjYnXCc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkgdXFQUslVvsp15U+xKqFpBZ7y2jt7uScqvHmy
 fcsE86kucmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIHVxQAKCRD2t4JPQmmg
 czyqD/9HRQx7w5GuMDuHNwmVsIBetoSufo+y5mLulkSMoxJtMUL/PDvEJL5s00rHTqFdjiIGpzK
 hDk065KHpY7AeVH8GZX6IhkyMTYkN/XOuAc7hO9gZrh8s1AXxNb2MidpHd6Bphaq706NvaBI1U6
 kmewaDEdPjCcQJG456ORjGdqsnxBCZpqjC1tP6mMk1E7+HiINBGPh9Qm/3wGsNArLz3Ust64X6E
 4DLTI34hNnTyIIkhTdDWXhfZmleIRzlRVkffF6xieuhboYVLD15n78vjWmUdLWI2hE+d/Et7aB/
 HfaDrYyeaigUUKT4rC+UXbJk2dgjsFteWj2FJr4/gUyh4bmpzAR+30vsav/SqMjDjorb8FVMoEF
 iHwum99/9D2IXnSzlt4l62H3BOqXClacc0nTUCypurP/L71gF07FMpW120avJrUqIlhi8ICaFWQ
 +79mjUuj0v7UWG3DoBmIdmIuv2/ZkMDWkSlvCIYUQTJQpMVWrYDT/xLrG6+LZKm6z0rYozFyddW
 gT1Q+f6UcwMjxN8x+ag/vgQZad7Q3GyZTGeu145qjgAZ6mI9ncZQdyJvtlZNpcFSbKHWDXCephp
 6Om4+lAmSFPDwk8VJ+be0PyY935h8dzFX1WFvdJOK9FG5lrwfw22CAa1tXVpVtuVSM7egc3NzyZ
 dEhZY/hzSWreDjw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These patches from Geliang better isolate the two MPTCP path-managers by
avoiding calling userspace PM functions from the in-kernel PM. Instead,
new functions declared in pm.c directly dispatch to the right PM.

In addition to have a clearer code, this also avoids a bit of duplicated
checks.

This is a refactoring, there is no behaviour change intended here.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Geliang Tang (4):
      mptcp: export local_address
      mptcp: unify pm get_local_id interfaces
      mptcp: unify pm get_flags_and_ifindex_by_id
      mptcp: unify pm set_flags interfaces

 net/mptcp/pm.c           |  41 ++++++++++++++-
 net/mptcp/pm_netlink.c   | 132 ++++++++++++++++++++---------------------------
 net/mptcp/pm_userspace.c |   3 --
 net/mptcp/protocol.h     |   9 +++-
 4 files changed, 103 insertions(+), 82 deletions(-)
---
base-commit: 4a56212774acf71a7356026fb11b78228a7ad24d
change-id: 20230608-upstream-net-next-20230608-mptcp-unify-pm-interfaces-497ff5de464e

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

