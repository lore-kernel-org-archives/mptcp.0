Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3AA3212
	for <mptcp@lists.linux.dev>; Tue,  7 Feb 2023 13:04:43 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id ba1so9420884wrb.5
        for <mptcp@lists.linux.dev>; Tue, 07 Feb 2023 05:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2LNCnTYQnKI2Qi+rIbkgnUL8Nmbo6Qz5VaHG00c9zYg=;
        b=R6b16Anl58GF4Ndnmggam0JqBAZSqo0/T+bhnT/iYTRtuObc/dXZ6xloUhtLwWp9y+
         UTJr92rFlrbCq+tzaHrs69ArfVTgoUR6PBj84O9mvc1/I1Exc0hMdlZGgTDvtwykl0Mt
         IAX8Zic1dqgE42gMDp9jS6SSO/IL9ixdJoXYfBr4v5PBbsLwSy9yhHqt/9vY4ATmV22F
         TPodadJqvEWI3SpF+/IqycXhFvTGxkOmBE5FiauyXH/rK6M+Lvo8f3W8t6OYeoKG60fV
         dqB3sn4haHf/1mH9+XiRfXRDFqrw4o4xjICP9IXP2Yv0ka01Q52bcPpDKi+XDlW3l6rI
         n2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LNCnTYQnKI2Qi+rIbkgnUL8Nmbo6Qz5VaHG00c9zYg=;
        b=xFclP7/TMuZ4EH8zPLZCf8ken35xUxJwz78pe4jYHDPGnXlthlI16KXxQ+lObvAXbP
         rU1y/vslvhh0hAQCDQOE8bpeeqtQuFaEvHBa2nuvgpRUGDxIVWhHvTCjIBYaae9/1/fz
         EMouJZsCPDqvDr4lght+5h/9Z8gOmvdx6zD0yoADznyNddgSJdBn/L/IAhhpF21Q7Exr
         V5S90awgbMMgoLi27YKLoH/Or8rb1KutzxYQ/BRzIOwrkNuGS3lUg3U8iSP42T5B91ql
         3MqveK/7hktelBj6xHIMW1QC4NORIT1QDdgZaTK8a4+xL0q2O5H3pWUprl3mbOSWZALf
         mjAA==
X-Gm-Message-State: AO0yUKXbFMDSWIo5POu5og+jdHeis8eVD1TajtNdS0zzPL8MgSxR510b
	YZXO95vW74C+SKlqw+/KUwcIfg==
X-Google-Smtp-Source: AK7set9YTo6jBw+wu7vaeuAeClfkKfkEd/2ijcXBN2UJsc6YhpTX+cpVF2pNclhOp4qg7ZOFKK1Euw==
X-Received: by 2002:a5d:4806:0:b0:2c3:ea6b:ef83 with SMTP id l6-20020a5d4806000000b002c3ea6bef83mr2957523wrq.12.1675775081619;
        Tue, 07 Feb 2023 05:04:41 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d5989000000b002bc7fcf08ddsm11645394wri.103.2023.02.07.05.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:04:41 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net 0/6] mptcp: fixes for v6.2
Date: Tue, 07 Feb 2023 14:04:12 +0100
Message-Id: <20230207-upstream-net-20230207-various-fix-6-2-v1-0-2031b495c7cc@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAExM4mMC/z2OTQ6CQAyFr0K6tnEYFYhXMS46UKULBtLCxIRwd
 2dcuHx/X94OxipscK92UE5iMscs6lMF/UjxzShD1uCdvzjvWtwWW5Vpwsgr/t1EKvNm+JIPNui
 x7q4dtbcQAjeQWYGMMSjFfiy0vB04FcR5IomlsSjn8e/Jo+TwPI4vG2YZcZ4AAAA=
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Mat Martineau <mathew.j.martineau@linux.intel.com>, 
 Benjamin Hesmans <benjamin.hesmans@tessares.net>, 
 Geliang Tang <geliangtang@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=2gwf1t1oLdLLnLS96VoPdbQ5z+6BonFJUbLHcasVbGo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj4kxofU3dUJPYLTFtKKn31mjpfvMSn+lCifKCJ
 xo/SKVohx6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY+JMaAAKCRD2t4JPQmmg
 c/UCD/9DpgQJ8kzrJ2KEQv1Xi/VGx2/EyabkZme7Vtis7wJFenjHLJAHALXsvAtTY/6mqc6YZ2+
 9KnFFKfL46SvYBIcrieYB1ryxDWGQlmOn+OculZ6VWyUgJZRLOzaFrLTi/LJ3iVgsfDXDMoyPWz
 rtvyqO/nfdoeOQvPCjOuVAqHVkL7xK9lcZa27IyF1rPyLs3e80WmQ69DvcQuRkVXDTO9ZuxshV3
 zm0LCL43YCYh8/Gjmup5/nOG0FjbuJNzzNNZyeer1y6JbrvkXv1fleuSMrYC2fJdpPpWXN8eEk3
 9PYliiKo2h7WT2p7jVe1L5dSZ5a46rNmuwXYiA3UKkkNJEGd5EGy09fhUBU3TuB9vHfZCiFaghk
 kC4o+sS80nxzoJqab2g3YbcaL1Pudgzye5XvjiScEcP0CNO2dIjTWeL9zlA3968vYhE11imsGK4
 yS8e8hDOb3meiFGAxQ4YcInNen9jFPsTIPU/1WjxZ6ciBBZL2rYZ7lwkIJlYVMYdeKjw7stSZar
 TS07d6zvKETpCIc31rtuesf4OcCATbRBWueZx3aE6VDeavG04zAVWu7IeYEq3g3YTWZi8oDi5Yt
 EilmNWGLySNbLcFgJhlcuTrsgZm1Y4Q1/wHOsdr4b0Qj8BT0g03A5QZDgODmLoZl1n6+knuogow
 pe75W2YZdKn34vg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Patch 1 clears resources earlier if there is no more reasons to keep
MPTCP sockets alive.

Patches 2 and 3 fix some locking issues visible in some rare corner
cases: the linked issues should be quite hard to reproduce.

Patch 4 makes sure subflows are correctly cleaned after the end of a
connection.

Patch 5 and 6 improve the selftests stability when running in a slow
environment by transfering data for a longer period on one hand and by
stopping the tests when all expected events have been observed on the
other hand.

All these patches fix issues introduced before v6.2.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (1):
      selftests: mptcp: stop tests earlier

Paolo Abeni (5):
      mptcp: do not wait for bare sockets' timeout
      mptcp: fix locking for setsockopt corner-case
      mptcp: fix locking for in-kernel listener creation
      mptcp: be careful on subflow status propagation on errors
      selftests: mptcp: allow more slack for slow test-case

 net/mptcp/pm_netlink.c                          | 10 ++++++----
 net/mptcp/protocol.c                            |  9 +++++++++
 net/mptcp/sockopt.c                             | 11 +++++++++--
 net/mptcp/subflow.c                             | 12 ++++++++++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++++++++++-----
 5 files changed, 51 insertions(+), 13 deletions(-)
---
base-commit: 811d581194f7412eda97acc03d17fc77824b561f
change-id: 20230207-upstream-net-20230207-various-fix-6-2-1848a75bbbe6

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

