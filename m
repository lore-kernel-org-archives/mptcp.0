Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2117915491
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:38 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f60dfc6028so61174725e9.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542597; x=1688134597;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DIzhMQ137Oz9IP9ekJEZ7aBZ90q+InWhDBrWFcAxIsY=;
        b=TB+npp/A+KJCRskJPYt4agdrqkz+ryJUgDsLk0rsIstJqdqFuA3WbtZIWCcol0Wcql
         +dRyWSkX367hG6hrnqiUE1Zx4UPuO+PPNA6mNtanUD5Mow6qT7fcFv5hZBXj3Pko15WE
         6UtF7pZucgsJDU86tuXN90pVGLFFJyHLAzo/EASocUXf1z0sti4q7RGmGcilU65pmis0
         S68mNjMZhe0XId44aA/LxPnAY2GyvJGly/vBNA7BAFKIFZ6rqi30XeuBiWgpCLIQm/hY
         6IswwfnrMp/JYsVr7f2Xi4TxxNRwS+gC7wPwwiHn2XYRgB4V3zCjn/pVM1j8KB2KE05z
         cFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542597; x=1688134597;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIzhMQ137Oz9IP9ekJEZ7aBZ90q+InWhDBrWFcAxIsY=;
        b=NOJTrDA9GXLr5RSfs+rmGxsDMszaLPBNo3WHOeaKuz304vPiWoffMh1NdNbfh8vQM2
         q1SppgcqBdJhZxqjH0wAIYK7Op9RBLFxgmGKVBmrCQ2MokrhqYXKfdZtK/rJuv3dH+Nu
         EouFXSwNCKGgFBF03WMig/4XH4VxgvId/3+RrgLl7TUt+jQv78byuo3bdOti+vNxrA/a
         jOzkFsZkvmuDqWrPtxfOhpQah6SWCaktsYqdyL3PxuBQAtpGwf3XE5qmyGGyw2VzNVli
         t5/ZBTMX9mVhk+D6umNtVksFcYkye4KGozhf9VAX2as5a8ktFS0a4FvYpe5Gn/fjmk41
         Lm2g==
X-Gm-Message-State: AC+VfDxEF5aVPymfsLPgZKhTSc3Q/nKOkEcWc6L3g9hZ2dygJZv/dGIU
	e5rO13skQ1bCdSLG8jBNqAbNjA==
X-Google-Smtp-Source: ACHHUZ6vcweJFYPOsSI2rw3N0GZpznVt8Fi7uGVysFeX+qapJn0jpe6phvn+kBSOgJfX85Yd5+RblQ==
X-Received: by 2002:a7b:c3d4:0:b0:3f4:21ff:b91f with SMTP id t20-20020a7bc3d4000000b003f421ffb91fmr4150726wmj.28.1685542596958;
        Wed, 31 May 2023 07:16:36 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:36 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v3 00/32] selftests: mptcp: skip tests when
 features are not supported
Date: Wed, 31 May 2023 16:16:20 +0200
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALVWd2QC/52OQQ6CMBREr2K69mtpsagr72FcFPorjVBIfyUaw
 t0tGDfudDmZyZs3MsLgkNhxNbKAgyPX+RTkesWqWvsrgjMpM8GF5DlX0Pax6sER3RGk2gNhYyN
 SJOgaAzcMHhsCa61RB6MKc8hYYpWaEMqgfVXPtLi99xQD6nYu+4DWPRaJM3vzPUZ2SVXtKHbhu
 egN2TL40WTIgIPIla52qihEbk5pQzogbT4ng/gLLBJ4x2UmMbd7qcsv8DRNL1v4FqpeAQAA
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5857;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=bn4C2Q7UDclQcCIpKK0JGf8LLegJqxR6YMI5lOzGe5I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bBpY3pSyUvFrG4izmjC1wsjHVMakD0HJgMO
 u8hMNxlvGCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwQAKCRD2t4JPQmmg
 c1G2EADNM77d9c2B3miFodoPBXesoLq/cKh5oB5QFBxy0ZL+tW7gmgoxi7l+t0ug5j2N2ZdZCww
 8job+XR/pxlHqOVrtZDN2IFOUB+rwr1gbtnGN0JOkJvZDCoSoxKaFobAs/yeo87gN2GwwbAfYoT
 knAXZaApOsUzbrWCPSz2cMFR4g2PCSv8KQGGl0QR6yXFebJVU0wx48sGfvdXC/0T5NV7E/lMLr5
 1VE0H+iB461AzAAPcsTUivjoGTCIptd2UveVDVhnpPiLE7H18NbY+DkecI4GTtJnuvuP07tFG+u
 +izTjWQujR5tXQ6xgIB7oVExjhfJQwIZjR2E/Brv6ZZcqvc9Bo4qJfxUKn2XSTeiWZ1/LhhzGml
 ypq6H7YG63LqjNYOcedLyUFCOrIKEfWFnspEcqZFyAnfIm8vRYlEGz5jtnG09yD2ACqIWQfPpVd
 jTcf398hggi4+8VxU7riW8OVmrIJEYVB2Ug+H71CoCSeivcpCcaOA0aPtPuF9hNofbv5ZKl4j4f
 Rxn5otECcuxt6DiPJVIQKWAxAQQM++cfdsEeHrNAw6k4e2lPKpIHYKhnh8mAunXcCWfcT7+ygs1
 8HkL2eqKjIJsz8Gf7OUuR6N5ohodfF23HORjHl1KD4nKsh6UV+6jUZJNPlE5a+XcvOu8MD4OSWt
 hX+EXM4t4m9nrzg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

These different patches allow the different MPTCP selftests to be
executed on older kernels.

I tried to minimise the modifications and do the checks from the bash
script not to have to detect the feature when being used in a .c file,
then pass the info to the bash script, skip the test, clean the
environment, etc. As you can see, even with this minimalistic way, a lot
of modifications have been done to support old kernels.

Note that if we expect to have all features available,
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set to 1 to mark
the tests as failed instead of skipped and track regressions just in
case one of these checks is wrong. The public CI already set this env
var to 1.

This is a big series impacting new development. Probably best to apply
it "quickly" in our tree and fix issues later to avoid multiple rebases.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Changes in v3:
- Patches 1-7 have been already applied
- check kernel version: new env var that can be set to skip the versions
  check so it works if a new feature is backported to an older kernel.
- get_counter() to get the MIB counters: I can help the stable team with
  the backports that will not be difficult I think but will cause
  conflicts
- check nf/tc issues: looks safer just in case a kconfig is missing or
  an issue with nf/tc but can be removed if you prefer (still I don't
  think we should exit in the middle of a test so I kept it for the
  moment)
- one check per block of tests around the same theme: it would indeed
  avoid re-doing the same check 2 or 3 times but it would break the IDs
  (+maybe less obvious a test might be skipped when reviewing code)
- backports: at the end, we just need all these new checks to be
  backported on the last stable kernel (6.3) because that's what is used
  by the different CIs. It is fine if it is not backported after. (but
  still I can help with the backports, I'm used to :) )
- New patches:
  - selftests: mptcp: join: uniform listener tests
  - Squash to "selftests: mptcp: add MPTCP_FULL_INFO testcase"
- See the changelog on the individual patches
- Link to v2: https://lore.kernel.org/r/20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net

Changes in v2:
- The first patches are almost the same as in v1, the main modifications
  are in mptcp_lib.sh (and in the commit messages): new helpers but also
  the use of SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var.
- Link to v1: https://lore.kernel.org/r/20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net

---
Matthieu Baerts (32):
      selftests: mptcp: lib: skip if missing symbol
      selftests: mptcp: lib: skip if not below kernel version
      selftests: mptcp: connect: skip transp tests if not supported
      selftests: mptcp: connect: skip disconnect tests if not supported
      selftests: mptcp: connect: skip TFO tests if not supported
      selftests: mptcp: diag: skip listen tests if not supported
      selftests: mptcp: diag: skip inuse tests if not supported
      selftests: mptcp: pm nl: remove hardcoded default limits
      selftests: mptcp: pm nl: skip fullmesh flag checks if not supported
      selftests: mptcp: sockopt: relax expected returned size
      selftests: mptcp: sockopt: skip getsockopt checks if not supported
      selftests: mptcp: sockopt: skip TCP_INQ checks if not supported
      selftests: mptcp: userspace pm: skip if 'ip' tool is unavailable
      selftests: mptcp: userspace pm: skip if not supported
      selftests: mptcp: userspace pm: skip PM listener events tests if unavailable
      selftests: mptcp: join: use 'iptables-legacy' if available
      selftests: mptcp: join: helpers to skip tests
      selftests: mptcp: join: skip check if MIB counter not supported
      selftests: mptcp: join: skip test if iptables/tc cmds fail
      selftests: mptcp: join: support local endpoint being tracked or not
      selftests: mptcp: join: skip Fastclose tests if not supported
      selftests: mptcp: join: support RM_ADDR for used endpoints or not
      selftests: mptcp: join: skip implicit tests if not supported
      selftests: mptcp: join: skip backup if set flag on ID not supported
      selftests: mptcp: join: skip fullmesh flag tests if not supported
      selftests: mptcp: join: skip userspace PM tests if not supported
      selftests: mptcp: join: skip fail tests if not supported
      selftests: mptcp: join: skip MPC backups tests if not supported
      selftests: mptcp: join: skip PM listener tests if not supported
      selftests: mptcp: join: uniform listener tests
      selftests: mptcp: join: skip mixed tests if not supported
      Squash to "selftests: mptcp: add MPTCP_FULL_INFO testcase"

 tools/testing/selftests/net/mptcp/config           |   1 +
 tools/testing/selftests/net/mptcp/diag.sh          |  42 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  20 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 536 +++++++++++++--------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  64 +++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c  |  26 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  20 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  27 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  13 +-
 9 files changed, 506 insertions(+), 243 deletions(-)
---
base-commit: 3d6d7b1262115b5ccc87b47a61f0a2db3d1b2fbf
change-id: 20230406-mptcp-issue-368-selftests-old-kernels-fffd69d67d91

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

