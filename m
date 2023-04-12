Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530542F24
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 09:20:36 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id v27so951108wra.13
        for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681291235;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=77a5Zd29mShgETk9mrvYzoDupB/QEbLM3u3+5ecy5zA=;
        b=cr74xkftMZ5Gp6DMXWH0C8694PuSuncq6RjaTzoQCmukCn+ZmHVymR51opJ3kTyEPF
         VY5YKZGYOJY4cE91z9EOieceHaqPEk2TMvssdKmQTZm9BAPYRMivZaocPAs2wOmubXk1
         yyZSJQcAEsAQTFuIJcbECgWPXU/FWEcQ2HCXPDXbkkHWL41t3vr1e578OAYfEvlU5FhR
         AMHeUf97lynlWYJEPnCDoZ+jl/dfAGjd/tp/rMVLCY9FyoOI1+3HuA9LhNRV7oNWmdd1
         z/Ycsi8ROHeFhdaZRP2sxrXxKsOjeFGDDZTDoIvzUH6pdVHP1X2i75dZdv8div9eAMvv
         ZHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681291235;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77a5Zd29mShgETk9mrvYzoDupB/QEbLM3u3+5ecy5zA=;
        b=HBg8l1u/uoTdk43YjtpCgvMbgvlnbVLduyMxq75S9cjpWHreT58jKOVf7m5yDZdF+g
         b9fo578qwOjQclBtZ4YZ2mSZ7DkiofQUxIBPXurnQDUnVaIKFonKglTwW4JwkAJT95Rj
         uUVg+AXY8gYnAPdyFWvsC2BpaZb2W/u0kC+pGAyaEY5jwMeUcbSP76hZMAvJZ81QAowY
         ShRtsgHP7XyP+YHoJMhkVwd9UAvVrPG91s/qOq3U+vACpYgYmfbemKvVi2umP0utjquf
         wxY/GH+jbuQZaM8iC1iZbSSb22SMfta3sRajCFy2vgLCi1XOa4YUOtAxR0fpXXb3zYjK
         Vwrw==
X-Gm-Message-State: AAQBX9cTPvVojDcz9GR1ciU9SuU2Pjqc65voQA0bEy7ykDwKSkYQT4vw
	/hTD87TccxJBldt9uIPH9/Z0dQkC3a/pFgsA3j/U5A==
X-Google-Smtp-Source: AKy350Yp7wal476NBP/V79cwfs9LV6yuVdkWlwPTeBWC1vd1y6POY0GFh3Q7od2QOQ7GS16dJOecJA==
X-Received: by 2002:adf:d088:0:b0:2f0:2d96:1c5a with SMTP id y8-20020adfd088000000b002f02d961c5amr1238249wrh.32.1681291235081;
        Wed, 12 Apr 2023 02:20:35 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id k1-20020adfe3c1000000b002f01e181c4asm8981069wrm.5.2023.04.12.02.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 02:20:34 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v3 0/2] mptcp: selftests: join: support BusyBox
 and ShellCheck
Date: Wed, 12 Apr 2023 11:20:11 +0200
Message-Id: <20230404-mptcp-selftests-join-busybox-shellcheck-v3-0-eab5dd7bc996@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMt3NmQC/52OwW7CMBBEfwX5zJZ4Y1DCqf9RcXCcNTYEJ/Kai
 CjKv2NS9dIbHEczevNmwRQ9sThuZhFp9Oz7kEO53QjjdDgT+DZngQWWhSoU3IZkBmDqbCJODJf
 eB2juPDX9A9hR1xlH5gpksKxt1SqqrMi0RjNBE3Uw7sVLu/vAKZK+vcohkvWPVeNH/D4ESuKUK
 +c59XFaBUe5Dt52GSUUcNhXNSqsdL2X33nPOhJ//d2M+CEaM7qWsrRatWgI/6GXZXkCm0fVZ2Q
 BAAA=
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1677;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=2hHK9SNdz1aqQL/JM14fzWdxcLAT2uGtyE8BjqgFN+o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkNnfilcQFGnMx4aVV96RlIEaGcRcawR2Z0KixM
 F4qec2niUKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDZ34gAKCRD2t4JPQmmg
 c597D/9kLud979QuplYl6MO1YFQX0rTX2EMCpHFsttX3gF0eCq4Rpkk+/XCEOLSdKiF9jrG3LWA
 UwjPviNLhv3fg3scCVOBbrgyPqHpmKbWDvaE1WFT9fiyoeNE4k1Tk5Ttr2Rk/YznBMrlJ0WdHRf
 iIfEU4NTAIcHvyQ/4x75XZ7bAAhN4Mq7Et72/wcdVQT+Kk5vXh2AupTo9wM3D3tklsnHp4yPec9
 JLN/pZfYrPEN6seZ7SjulOdnjn/EPkiuALh+gIuXtOShF1ILwVtvKekRXAnZMUGDExQJIUyQb4V
 PASK0I8BfDi3YJW4PbaB6ZGodyzsY9ByK0xUf/UpuIv0NzMEtRBLT006RjSFBzJf263IldEwEkJ
 Q/OkkxwBVwIi6rHGlKVFPHw3k6qgALGq2G+9+GhNVg0xUBj/fWKJfIjDpOIfKucSatUBJ8cEaaF
 LsQSAELGGX5G2+OJG7wlk1m7kLUKNluPOj3wPhp825GuIz0u0U/k/XwiWZJh6M25NAZFaiSwtsI
 6Nq5XYpqiYHahcYBfvisAFFiMdhPGrz7oiS43iS8xGBrFJoVEvOeiBC879OKbzUqKNZ5+sykCqo
 6yiDTJ0nBSw7o8kxEL71iYN665gmxSs4w+zOaSVjnS/08z07+t7av7lXzSQz/h1K5YBWzeVV90T
 tcFYniiZ7BUFkhA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are two simple modifications, not really fixing anything for us but
fixing issues for those using BusyBox like LKFT.

At least the first patch fixes a bug they have. They might switch to a
different version of cmp at some points but it doesn't seem easy. So
probably best to have this patch flagged as a fix to have it backported
in order to detect when other mptcp_join.sh subtests are failing.

The second patch fixes ShellCheck warnings: it was reporting issues for
most lines of the script. Best to fix these warnings to easily spot new
warnings that could be linked to real issues. But no need to backport
this one I suppose.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Changes in v3:
- patch 1/2 use a tmp file and delete it in the cleanup phase just in
  case the operation is stopped between 'head > file' and 'mv file'.
- Link to v2: https://lore.kernel.org/r/20230404-mptcp-selftests-join-busybox-shellcheck-v2-0-9113fa4d2ce2@tessares.net

Changes in v2:
- Patch 1/2 now shrink files instead of doing something useless
- Link to v1: https://lore.kernel.org/r/20230404-mptcp-selftests-join-busybox-shellcheck-v1-0-65892428a951@tessares.net

---
Matthieu Baerts (2):
      selftests: mptcp: join: avoid using 'cmp --bytes'
      selftests: mptcp: join: fix ShellCheck warnings

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)
---
base-commit: 7abc2bc2d1a8d495956f75440f45088d7d118f9a
change-id: 20230404-mptcp-selftests-join-busybox-shellcheck-ec239f8d4e8f

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

