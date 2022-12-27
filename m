Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6590663A5
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:21:36 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id c17so19992952edj.13
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VW296BWRbwmRPHY4fYPrUGKSPkzb2XbEA1UDLX3bhdY=;
        b=sNLCgl351ThBTTwtO3zo+o86tuZ1dUiyCdp9CzH3RPg1mj2TGOnuxTz9YCvLxb5GrN
         of9t5lNOkDPxlLMcI1nm1hJTsipSZYhuPFCoodW0WPtIvaxYeBTf1qPtDX1Q52qZ3q8k
         2yfPwJ0BLcwdZLvekEA+DW5QXW9LOjp2widfTo+poZTffcu69p7Mixv82DeD4JUDfd35
         SrndMg83YGILIVP9XRPmPHs9m8rFwM30qMYX5fz8lAFGtMztUHfcWgrVfesmd1PLJ4zN
         khQhkVbhsTcqqlj3fWItyjMEbiHigZcIyet1rrkQ6vOqJgmHj1Mtce2Cm1CZhl5lbF+r
         lJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VW296BWRbwmRPHY4fYPrUGKSPkzb2XbEA1UDLX3bhdY=;
        b=q5S/sf93mdYWs6mFi5Z4lG3A5z7eGCsjY9MpB4g632VL4KFOS1TxZYoYFB8gRHxhd0
         BhTVHB5Qu6EkmTSMgJxJLuWn+7UmA3/3TqDwa6RO0Ne1IzNk/BOFV44SLz4F1SG4Nd4J
         KJejm5LMMSM375WaM/hrg5+W6BWPOWdDtWVaQEocyCEFGuCRKTql+1fA3OYnqyh2fFvR
         vvcw2VIFuLODTQDU7BbMuCMxy0O/1DNHbMSysrg8LteGZ8qC62aUmWG8ktecbunmoiX8
         gD5OGNOIMgRXyPGNWqkqWPoZqaYF46X06beOGq0nfRvtAWkTPGT4rTqnAWMNeIYuM8rZ
         gQqQ==
X-Gm-Message-State: AFqh2ko+iYippD5kgGi5GA/8LJI73BBWJ4hCGl1VYUiRIpDNhI/OyR1P
	sNvefcbTW8C5Gg/vWqYIBpi3KyZJ3jXxBNUnZrrLTg==
X-Google-Smtp-Source: AMrXdXvWJ8KH6PvpYYozzx+0VDaW7VWpbHUf+IndusN2363b09p9HbQ1cf53Rr0OkVln4iFavNMc6g==
X-Received: by 2002:a50:d0d1:0:b0:46d:7ed4:1f66 with SMTP id g17-20020a50d0d1000000b0046d7ed41f66mr21194320edf.3.1672165295024;
        Tue, 27 Dec 2022 10:21:35 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b007bd9e683639sm6336612eji.130.2022.12.27.10.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:21:34 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net/next v3 00/11] mptcp: add support for mixed v4/v6
Date: Tue, 27 Dec 2022 19:20:46 +0100
Message-Id: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2567; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=iXET1W6rey/uKfzz83tYhaHkGa7MsjL2YCKvoMr+U5o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjqzd5YUxOgPQz8NN2coBfwfN7jLqoGQftBNTivYF7
 EvlI7yqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6s3eQAKCRD2t4JPQmmgcw/0D/
 9hrR6baEGhUNAP438l89oy7EcOeQdUFXxB9U+RUkrpVbBN5iKtZ79zmV3eIwu8zrLbZpPs6Dsn4NuW
 BVUuJndeprG+HT17JkCIMW9gaqHM7rG5pNBnTPdUZR9ObtIbd1+vZcvMUG6cJnlUEf+X9k75+Bu/H4
 5sTZNYf70hqXMX/wtdE/XOBUmEdG3GvTiM1m3wol/gxJYxSTCs1HK7EMiJkW2XrlEVTmWnsQItquzJ
 sDUCNJ6rf74ZcsY1iknG/CBzjd9YSqvWI0ooGfsyBMUtmyEbkLweZYMagXtUS/uvACeaRD5dlXbYlt
 wesP+967uieTpJGqeRv/4V056NPVvH06w1mRcWVGKhpp8j6Kax4C6m2ZAAtmFDCYZcu34gWd2SqFnh
 nxbTFM5pMhu81i8LRHQTXZE5xFwOpX8goyyl1ODce0Pho/qsvF1xdLaXEmCViGDJiy4Cai4PhKGQgm
 mlBGKYk+6zYI2O3hP9SxOdVd01ZSbYXOmYLI9zHwHxzADEuKqfiMaf9dGnLBY0GLjxIwQzdTwaRyV7
 sWvKrKAk32wj5dg0MKNcJqKAn9U8YAWISGxykBWH4GXiPGg/5xXG0dMwzYnh1i8zuzoDQWac4s/vDk
 BRFV7TMc8PMshnwZ/Rry7hDpCzdr1WwnuzMQCXECPimfTcgU8TBNnpPIt4WQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This is a v3 of Paolo's series with the same name with some
modifications and additional patches.

This series can be split in 2 parts: the 3 first patches are for -net
while the rest is for net-next.

Patch 1 let the userspace PM selects the proper family to avoid creating
subflows with wrong source and/or destination addresses because the
family is not the expected one.

Patch 2 makes sure the userspace PM doesn't allow the userspace to
create subflows for a family that is not allowed.

The core MPTCP implementation is just a few bits of properly supporting
a mix of v4 and v6 subflows, we just need to allow specifying the
subflow family explicitly (patch 1) and remove artificial constraints in
the in-kernel PM currently enforcing no mixed subflow in place (patch
4).

Patch 5 makes sure the sk_ipv6only attribute is also propagated to
subflows, just in case the PM doesn't respect it.

Some selftests have also been added for the userspace PM (patch 3) and
the in-kernel PM (patch 6).

Patches 7 and 8 are just some cleanups in the userspace PM, not related
to the rest but I saw them when modifying the file.

Patches 9 to 11 improve the messages printed by the userspace PM,
especially in case of error during the validation.

Matthieu Baerts (8):
  mptcp: netlink: respect v4/v6-only sockets
  selftests: mptcp: userspace: validate v4-v6 subflows mix
  mptcp: propagate sk_ipv6only to subflows
  mptcp: remove assigned but unused value
  mptcp: userspace pm: use a single point of exit
  selftests: mptcp: userspace: print titles
  selftests: mptcp: userspace: refactor asserts
  selftests: mptcp: userspace: print error details if any

Paolo Abeni (3):
  mptcp: explicitly specify sock family at subflow creation time
  mptcp: let the in-kernel PM use mixed IPv4 and IPv6 addresses
  selftests: mptcp: add test-cases for mixed v4/v6 subflows

 net/mptcp/pm.c                                |  25 +++
 net/mptcp/pm_netlink.c                        |  55 +++---
 net/mptcp/pm_userspace.c                      |  14 +-
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |   6 +-
 net/mptcp/sockopt.c                           |   1 +
 net/mptcp/subflow.c                           |   9 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  53 +++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 164 +++++++++++++-----
 9 files changed, 244 insertions(+), 85 deletions(-)


base-commit: fe84ec2a445f2ec26dc0484538f2175945b43822
--
2.37.2

