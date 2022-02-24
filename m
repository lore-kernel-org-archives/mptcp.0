Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60811373
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 21:34:59 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id w3so4719258edu.8
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4NimNmVkVYx5K/eU/Em3ZP/di34vYysbpGsDvMFFpU=;
        b=2ACgM/4fzjFiJoOSdkdfGw/pbmEjC2+RMuEoZARNOxCpGnPENckrj2DF1iD4RlU2Ty
         eCpV6rIOBTlR76aU3ROZ1zdoB8UPqfh9Zn71eIA027k5TEDp3iqrNaqQT7Q2Knuu7oXr
         CpoDREFovn6fp11IJHosPS/518wS8whqzKH0v/WionVZdflW+szp8JKmGktmOjZSRlFz
         ilqttAps14tSFD+JaYNiCxnXwJhaHXhzOLDvrBMy00Gqs+rf3UO8PYYlMseWKB3NxvPp
         8uTILWTt1EGUf6UtCJLadqCW0eVbahHdfTdcUPvB38/+X26RK80LL5zk5ICnRZ0/uIVT
         dfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4NimNmVkVYx5K/eU/Em3ZP/di34vYysbpGsDvMFFpU=;
        b=sHiEYIzbk+sZWxZ2JirV4D1eqGXBHsFH9EHXQ1E/vgG1b5R000NQax07+J87Zvmkt8
         /xUUKZCvPQP8mMFfrPNcg2mLCYzsxl9eTm41VYuxNnHdU/9riSV8L4S2lZkAv3Bl58BK
         0vm7aZ3aNqNBLwf7/wulwfOORXtdJ7KM3D89XqF39e2oCsmm8ET9gcCwlBr+MZM+tHbX
         BEOweKtTFUUBCNjo2Z4Ntr6d8tB+6WbBddWr9DYALHRJXJmO0OI+XmejkNRNWih4O4Sz
         OtW1+Fu1cjyvtFZkRmByBmFoc9MC1ovs9XS4x664CLdCkxhvqpKe/EclAJoxQrJX5olr
         H5qQ==
X-Gm-Message-State: AOAM531yhEiiCna0GtI8VUKnaH26hZMQt4ku5B1sK/M85ozsHWIfpZPg
	hyn2H3IOHJM0M3yiFzXS94p1Oowhuojeg7pk/oY=
X-Google-Smtp-Source: ABdhPJyExlUj02k6Db4snz7pFN8GThZISeARP3ffCwyhmmSUTEKTPL+HTIuNQdkqz7o299JQ9D6L4g==
X-Received: by 2002:a05:6402:40c9:b0:40f:9397:a2a0 with SMTP id z9-20020a05640240c900b0040f9397a2a0mr4157607edb.249.1645738497515;
        Thu, 24 Feb 2022 13:34:57 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm175195ejp.223.2022.02.24.13.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 13:34:57 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 00/12] Refactor mptcp_join.sh
Date: Thu, 24 Feb 2022 22:33:54 +0100
Message-Id: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes 3 issues introduced in v3:

- patch 3/12 reworks more the original patch not to increment the counter
  per subtest. See the commit message for more details.

- patch 7/12 modifies the new 'reset' functions recently added

- patch 12/12 fixes a typo reported by Geliang

I also move "helper to filter TCP" patch sooner, before the clean-up.

Matthieu Baerts (12):
  Squash to "selftests: mptcp: Add tests for userspace PM type"
  Squash to "selftests: mptcp: join: allow running -cCi"
  Squash to "selftests: mptcp: add implicit endpoint test case"
  selftests: mptcp: join: define tests groups once
  selftests: mptcp: join: reset failing links
  selftests: mptcp: join: option to execute specific tests
  selftests: mptcp: join: alt. to exec specific tests
  selftests: mptcp: join: list failure at the end
  selftests: mptcp: join: helper to filter TCP
  selftests: mptcp: join: clarify local/global vars
  selftests: mptcp: join: avoid backquotes
  selftests: mptcp: join: make it shellcheck compliant

 .../testing/selftests/net/mptcp/mptcp_join.sh | 2451 +++++++++--------
 1 file changed, 1307 insertions(+), 1144 deletions(-)

-- 
2.34.1

