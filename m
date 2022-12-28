Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85110E9
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 10:18:08 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id jo4so37407705ejb.7
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 02:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qxEgD5ugbVDgpN9ZZF8jlwBhB7yxS/xdw0vHQKcfAM=;
        b=XRflJPSBFSHT9etLFkUXkhFBkvif7FJpv1QhKe8PNExtipz9FRZsKQekqPfbp6OPCL
         1/rTKEzTX5jp+B7TLJwJ+EL7QXX9ECFZGBPFrriQiyhdPPdQkKMPxEQkY1ZlX7MXpCj+
         QRFaiuhU0uUgYQAPX/CPeA/DDqqY8nv/4QSCIfyxApx0dZ3bylfF9Ct2pjrheHvHPp+3
         Wxy3mbzuHdw9wfqDuSsnxtNam7o4/7zkJ1rToOmdogK104DKZX5qmuAUYoz+PTVn2t/9
         rD87u1CGxmOm75JUq47KPAAF1jHpg0H+cpCfGroSIueWX8BEqDxCP4DxUcc8baEzb2oc
         UGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qxEgD5ugbVDgpN9ZZF8jlwBhB7yxS/xdw0vHQKcfAM=;
        b=aIWbiOdZ4BgCi88ng1JNhh1dHS19YYQNc1owi2OzOCAmgd75P0EI40vYzbEEWr/tN+
         AyeDCuimmMF6Z2IhDcjoGr6ZvBtfKcZ++vxeAMgBfEYyEnkjS1/sVSLcc80BdjS04aUp
         gAJ+8S2AoNSO8QQ6OiqzTzffM9CpD/dEvKYp2N1Sv7c7bXh2GQon7esLYp50dvDebfkL
         bpaZ/wgOlsbKhpGzVX+nFYYUb4FVo+g1F4+VLNdEJqyVKjRo+u6uchszNlZZJhTEdIHL
         0fB6VYpxB3zae63UPoDzmr7SLLxKB1u0b4/jN8oy172/USXkUbBfsOhumOWK0Ej03quj
         FLhg==
X-Gm-Message-State: AFqh2koaoKiY+3akymiTq3KMqfwKERD82xiY42jFQwOrRqN+vgXPIsVa
	mOZv+bOLmBd1clm463reA0bzQO6ayyvYam1XMy2BlQ==
X-Google-Smtp-Source: AMrXdXseX45Yx7lqbMcTWG4bty34LeUUQ3Ralga5mh6ELZudMX0hew/S5QwyyRzD9ys1wPEKDEFrRw==
X-Received: by 2002:a17:906:4f88:b0:7cd:5a34:8932 with SMTP id o8-20020a1709064f8800b007cd5a348932mr19447520eju.21.1672222686648;
        Wed, 28 Dec 2022 02:18:06 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7174127ejn.198.2022.12.28.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:18:06 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net/next v4 00/12] mptcp: add support for mixed v4/v6
Date: Wed, 28 Dec 2022 11:17:36 +0100
Message-Id: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2920; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=ijRaBGWloDQY099IggnIDynPLWg/nRlVDKZn7Rq2Kcs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjrBe+q92FMGVUChSsMAn6kcdgFZb8S0kT8zfEt2Qu
 /CDMqIiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6wXvgAKCRD2t4JPQmmgc10FD/
 0Zj3Bnj3D9Zvc2WpM+yHUmiwjJbjAKUo/CLKc+pUeWKcuLcqiPTeIS1U08RyxxSEY5T4g5H0JQViR2
 7bwkuGVZhlaXRoBhZAhydD3D6JOO6KVmmw2IgW0J3VxRuUoKQ8AtyIubJwDAkGLF3nX9GBslDslAYO
 nav8dttiSl2QzKHY/9nwbVWLq7nUjF25rLrA0CrO/wzMyXW9G1xf5/OryVWN19rrIME6vG5R732Kvp
 M4RQNrSf7kG2sfvdsDL8VKrfKClth3mv2r+kdxc5s6kJ4rB6HWlqgZh4jl9Z5fbdVWIRdGIAQjeKeS
 okeWHLa5imTJPpfJplMc4sXUdVuATcCMSgoznDUxZyn+XCLWHsSjTGkUiPrRvfmzop0Mx6aMIxRYQ9
 LRixBXR4VFRzMV2akmaqBjCqhzlXrUZX8mVEiX0kCJmseGz/RAp8gAiW8suhHJ6NXcqwTnbgkP5R+Z
 J17lsFuk5janCT8imRuRi5e+Ffqx7dZeOoy9ni3LtnpCT7SCSwh9HVwnJGppNgs47i/zKZoz9BR9DA
 LHgcMu3J02wOsSn/E2S84cuHHQColeWhhY2CLNZijTukjO0kVoK8OoMsRDIF44pAqcT8C+OgWvRJ6H
 2ACh6k9uxA+jOL9UXh7EL1JAxwwE/F40R1KKH94bh+ZuJ1FEqNCQzthB84CA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This is a v4 of Paolo's series with the same name with some
modifications and additional patches.

ChangeLog:
  - v3 -> v4:
    - Fix a compilation error without CONFIG_MPTCP_IPV6 in patch 4/12.
    - Add a title for the cleanup part in patch 9/12
    - Add the patch 12/12 to avoid "read" errors

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


base-commit: fe84ec2a445f2ec26dc0484538f2175945b43822
-- 
2.37.2

