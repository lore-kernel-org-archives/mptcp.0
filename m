Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7EA4A
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:15:55 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id m21so49412891edc.3
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H7A1PqYQEene1UuO9/VaIy67Fx4Gq2fGUvZbkEQqdHM=;
        b=WBlDc3d3o6YH5AhrESe2wqI6BDHEO6PYj4yqExnGTnf+gxOB+eDdmZvXyCW/JIyDS7
         Tgu6zt3H9m0OPs8uYh/JgmRHmw9KF+SF+28tny1NrcY/EFe37Hpos/lZWmibpNU/H8OM
         bQTlBB1wkpQWN8hTvDoyznXDlic8RgISsYK/bZDSA4W21i0hgZWg4EjWOG/yUr8pLItM
         daoAWSlPXoguFUe6FHMYidavZX7U0XkfL1KnG/nI2erXVnVaNL7q+0fQwrXzGxNiB0xk
         hT9BdDHDxebwes4n4HlSnYJQqLB07j6SYGtsMHQbZ7UVmxBTbrw0UzG5HzWcjYoS7k8u
         x8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7A1PqYQEene1UuO9/VaIy67Fx4Gq2fGUvZbkEQqdHM=;
        b=shZBFrVXeBJDPr9pjWeON1RcTHUO8zRqP63DYjQR+g7VbsGDlOETLEeC425SsVXDqi
         7ubAZyXWuJs6uF2kn/yW6PmxtaWed5mNKl9ktvVceNDMNMGfaNEOhH8sHhBQu4xfvRtI
         BWw0dYaWCcPhy15bzQRoOTDgtNeXUtKuT8/carAhzIT5jjizxKIQcZtDxrqWx+1oaX/8
         vEwoSSK7jmd9yBdhInDd9T3X2UK0opZTJSy2l/h1XAeRS77xJLC5AD/aWhYD1Nqm6D8G
         5sQdCRE1I8QQvR2keObFUeQtfVHwapRD+NnR8DHV/2Fgliymqmi4FT988bVXLIs/7umx
         DoNw==
X-Gm-Message-State: AFqh2kpL8b37LyZWrjLcKU3T9gFx5i7h6OZQbeOY425q/6ztgbao9LBB
	foySIvxb8iWFvSCLGIb4BrAbUTElwgo/D13qSYs=
X-Google-Smtp-Source: AMrXdXsvVCuz6/k21b7YJsGMKdnR2uAarf47RU7LcTj1lpd9dShREhWlmg8PX3TthArGOf6fBpFsow==
X-Received: by 2002:aa7:db53:0:b0:479:973d:8672 with SMTP id n19-20020aa7db53000000b00479973d8672mr41406703edt.3.1672852554079;
        Wed, 04 Jan 2023 09:15:54 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b00487fc51c532sm9258074edi.33.2023.01.04.09.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:15:53 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net/next v5 00/12] mptcp: add support for mixed v4/v6
Date: Wed,  4 Jan 2023 18:15:14 +0100
Message-Id: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3087; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=lBNT+Hv2KHEh30vs0EHh/tBrCrDDhOXLYwXrCJP3cTY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjtbQHeREOnzGAHXriPag+NlmuAsmcZ+5QI3dh0ECN
 V9l80KiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY7W0BwAKCRD2t4JPQmmgc2ReEA
 DP+BiGs6PT8MqlUDlywbeByPm3vvQ+QeoPXe8fuMijXLoJWwc0wBGaGQ5E2O7dET+zcImwGkOcWB7Q
 bCZzp+QNrYmvrcGsdZFlOu+nZ+iJh+32HeETZFHmFWWvvjzoSM7OpN4s2pIjE18O012sT2vxpiMo/n
 FOXD/vvLtRkTCz+lUpR28wTMyDpDKGahiGnPDZTEYDk1tPt5oSi2WBCITY3cTpch8WdbrV8O3+ekDe
 OXM78nsknH36j84MPV7QQA4SAx+XV5JKgju5Q81J29ukdssa6mSmmLImsVv6ga1bPrQmm9kV0LUz71
 +NslieWfAMTCviK9OGrYDhpVqp2MHXF460+IMfkpgxEGbIgpNDfFi3ufXveRO9zoTlT9IqXG3hlsoL
 +0l9vGrDA/zjKYz4lw19WkD6T4ek/rhqFSjjQjjWiKfG/0E9UUMkj+usLDx8QGnUq0Rszn7J1xijBT
 At39+/PxWtvZuRhA+VMj2bbSxe+73JquQLfYKPE5u6YmLL/t3DeqouUXCwdjpSr3eF6UxlDACMZ6YW
 XJPPjToL6zr4EXzvBHxKkBsZJ55YzBvr4Mwy+iYL7c+QQgvbFf1GfD6A31aoEyNHRJ91X8KHEEHHsR
 e/dayhSeopoa2fxFxCaKiM4gj6c0wAOnWEXIhhy9mJ0+CRsVMg3UCuEYuzbQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This is a v5 of Paolo's series with the same name but with some
modifications and additional patches.

ChangeLog:
  - v3 -> v4:
    - Fix a compilation error without CONFIG_MPTCP_IPV6 in patch 4/12.
    - Add a title for the cleanup part in patch 9/12
    - Add the patch 12/12 to avoid "read" errors
  - v4 -> v5:
    - Fix typo in patch 2/12 (Mat)
    - More details in the commit message of patch 2/12 (Mat)
    - Rebased on top of the latest export branch

This series can be split in 2 parts: the 3 first patches are for -net
while the rest is for net-next. Patches for net-next depends on patches
for -net, that's why everything is being sent together.

Patch 1 lets the userspace PM selects the proper family to avoid
creating subflows with wrong source and/or destination addresses because
the family is not the expected one.

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

Patches 9 to 12 improve the messages printed by the userspace PM,
especially in case of error during the validation.

Matthieu Baerts (9):
  mptcp: netlink: respect v4/v6-only sockets
  selftests: mptcp: userspace: validate v4-v6 subflows mix
  mptcp: propagate sk_ipv6only to subflows
  mptcp: remove assigned but unused value
  mptcp: userspace pm: use a single point of exit
  selftests: mptcp: userspace: print titles
  selftests: mptcp: userspace: refactor asserts
  selftests: mptcp: userspace: print error details if any
  selftests: mptcp: userspace: avoid read errors

Paolo Abeni (3):
  mptcp: explicitly specify sock family at subflow creation time
  mptcp: let the in-kernel PM use mixed IPv4 and IPv6 addresses
  selftests: mptcp: add test-cases for mixed v4/v6 subflows

 net/mptcp/pm.c                                |  25 +++
 net/mptcp/pm_netlink.c                        |  58 ++---
 net/mptcp/pm_userspace.c                      |  14 +-
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |   6 +-
 net/mptcp/sockopt.c                           |   1 +
 net/mptcp/subflow.c                           |   9 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  53 ++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 200 ++++++++++++------
 9 files changed, 262 insertions(+), 106 deletions(-)


base-commit: 0e6e165b9b9b5ea418067cfac1e861892ee7e12c
-- 
2.37.2

