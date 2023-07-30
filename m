Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95047810
	for <mptcp@lists.linux.dev>; Sun, 30 Jul 2023 08:05:32 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-31781e15a0cso2851219f8f.3
        for <mptcp@lists.linux.dev>; Sun, 30 Jul 2023 01:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690704330; x=1691309130;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JpH7d50QcjlB0UPKJcTbCmQKM5Qu33XaovPiSJVQEs=;
        b=ZjH2k4XIfgl6uS73UzgK4wovQ15iQxQGiwFX7IOQscCb+shwV37MQ8aItVNiPlSuQ6
         IlnMNRW1qAhizdzjLqAUW6E7f6R4zPGiFbPvkxnuoBHMSjGI5JXPWnR8CjcdU6n2f1EK
         env7uzYZcAl1Gkf/V0xTRWfBZ/MpUKACyHI1DEKI3JVnd/0cMi3KiuGXhNGp9i/Ty/c9
         /uxhBzDOKBmcAvLa7+J+i2+/MtZvlW83uieHmxKMiSBiYd04/iWy4WSjgWFzPtuitsVf
         QgFUlBLgrG8LMpNlT49e1l+0w/rbahlCtd6LxGn5xCJA61sczDrKx3l5VMTg1FJrXsdj
         ++Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690704330; x=1691309130;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JpH7d50QcjlB0UPKJcTbCmQKM5Qu33XaovPiSJVQEs=;
        b=L4R4FLUDL6w25tWvFFdowqqdC0yxIffXxW+m90Gn4ZWmu6UkROy3Y+jDAwK/RkFUE8
         Ub+38oHy0fFn9yQfw5Bg7gGm3eNcG/vaFOWeyC1+B/DOqbHO/sa340MEulGCY8OS7pEb
         AzLVVnVeLC6T9nErxvGgB1TZ7BVQPhbJ/T34fcRCn/n04UsyaPgX22bAP9Ls123SWDYm
         2iW12dkrizn7X2VcokkSjsblDTwrydrxGr63ytWZ5kINvhmVY9c8ZdGHRgmXB49DGZFJ
         SCyxSXhxvlrdPxB3JUFw7XPt110VxALhpRYAW+9ZMpdQHDtxAZRJ25MTU2OXiVUxJzZT
         Bf2g==
X-Gm-Message-State: ABy/qLYAxc3Dy4quq1OJKlU4XhlbivWOS3xt9ekYdHPjSgCZw/jQRWCR
	IVgEonDVdRA0mkr66ess5IQJp9jAj/LM61Xd7PLLTJTV
X-Google-Smtp-Source: APBJJlGd5gAPj/i7sI/3N9J/Nir1AuCmhJl8wHThq6nlSOmEiXmZovxjHRXi6Otdbw5V65hUCZsQPw==
X-Received: by 2002:a5d:5101:0:b0:317:64ca:eaf1 with SMTP id s1-20020a5d5101000000b0031764caeaf1mr4424857wrt.17.1690704330306;
        Sun, 30 Jul 2023 01:05:30 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm9338684wrq.115.2023.07.30.01.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 01:05:29 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next 0/4] mptcp: cleanup and improvements in the
 selftests
Date: Sun, 30 Jul 2023 10:05:14 +0200
Message-Id: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALoZxmQC/z2NQQrCMBBFr1Jm7UAaQY1XERcl/dEBE0NmlELp3
 Q2CLv7i8eG9lRRNoHQeVmp4i8qzdBh3A8X7VG5gmTuTd37vjv7Er6rWMGUusL7F+H/larGy4pE
 MaspZNLIbg4tpPgSkQN1aG5Is3+KFfg66btsHKLzSt4sAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=R+PsDSeOsK6DRQCgnPaQ0p8AQt2Q2fy33uMXa6qwvZo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkxhnIeqEaf/93z9Oq2kkK8awgQo6LIJLZJuk70
 JbrNVHBe/GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMYZyAAKCRD2t4JPQmmg
 cxNZD/9y/26FJR4a4x5mXCtzWRpRNEs6apsl4qRVW5GrS8INFeu8tmHSmSi1UPe3w4HOqkzNIOF
 sh5+Nh5JQvqUVl6stWCEYt+KhLmN3UnFbHhG18EJ6V82LAzuCBnImFTPsYDEwfBWkvXzYI0pV7W
 M8t11X4K+AJQqnj15rYzy/gFG+T35RetnT/dsrXhBa3OGID1L9A90sWG5v7JUpx+6/5L7h8zliM
 plGTFAOri3/5S5F2rwMrQ4QTKm1ZSwo5O6S0pt5ZeY0FVdoPuvvwNanyH6/H2WpLixxK5Be7sNg
 m7Xery9sz3mLwW21DcXsxmtC6rQuGtJrc9m1keKOIxdefgBve/wb9U5GNYylMlwcXBp4xHRUesD
 8NTciPV7VU/vmVYBRYQ28qLLTQXJK7v45C/wsukEPuWQIGlnQQeGEBFVHMYwP1I+JeQ5+v+tGE0
 AjvLfpYrkRfeygXmt2xMRUQ039qjJNi+Ey4/YnLN4/j+0h/BB4enFxhDxApJ3vvH7osV7Zqjsfn
 tAcObFdSf42A8/VYoEwh0MTdTZx1h3bcDgENlPEB5leE8ujG2OFzQSv3AP0VZs62GmiBigM2LjP
 8r8oScgrtZnFPGm+9cxnU2LZPu/s0HRD6jYZ23pOHScfQLu3h182RkLXOQrm1ujOtuNs0gCo/GC
 o/M4iQ+IGPmbz2g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This small series of 4 patches adds some improvements in MPTCP
selftests:

- Patch 1 reworks the detailed report of mptcp_join.sh selftest to
  better display what went well or wrong per test.

- Patch 2 adds colours (if supported, forced and/or not disabled) in
  mptcp_join.sh selftest output to help spotting issues.

- Patch 3 modifies an MPTCP selftest tool to interact with the
  path-manager via Netlink to always look for errors if any. This makes
  sure odd behaviours can be seen in the logs and errors can be caught
  later if needed.

- Patch 4 removes stdout and stderr redirections to /dev/null when using
  pm_nl_ctl if no errors are expected in order to log odd behaviours.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (4):
      selftests: mptcp: join: rework detailed report
      selftests: mptcp: join: colored results
      selftests: mptcp: pm_nl_ctl: always look for errors
      selftests: mptcp: userspace_pm: unmute unexpected errors

 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 452 ++++++++++------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    |  39 ++
 tools/testing/selftests/net/mptcp/pm_netlink.sh   |   6 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  33 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 100 ++---
 5 files changed, 329 insertions(+), 301 deletions(-)
---
base-commit: 64a37272fa5fb2d951ebd1a96fd42b045d64924c
change-id: 20230728-upstream-net-next-20230728-mptcp-selftests-misc-0190cfd69ef9

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

