Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995291F179
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 19:08:25 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso9976105e9.3
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689275303; x=1691867303;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=anHT8NkBOltAXcbHeyf8HzLfEwyYXq4DQMoWTXq7Sc8=;
        b=w2Hzd57mxA3jBYX7oGZeKbab32L6LL3ePNGf22FsiKTvUMbD1inkHpw1euPbyDzD31
         Z063EviD2DviW6PPDshjF9CIgNKn9tOvZwP06u/vsfBtwr5GAVMKCand+9XLk3Eu56/I
         yTVAXQxSgsxo2hTMphXfeh7LdQGKyUWpJae1HQr2jiJIJvFX9noJZj3eqrr3kBzWZLQy
         bZv9+A4Vxa8HNkJ5rOEgjg9JWzqgur32l5XgFJQjBjADMuz2xH9gwDxEk30F1Mwyo0gU
         BXbdMVDn+A846QGYlZn9ugec/l6nwmdiAfyTlMz0vR1V00KW/5ADKY9X6oasvcwrx9NB
         U79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689275303; x=1691867303;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anHT8NkBOltAXcbHeyf8HzLfEwyYXq4DQMoWTXq7Sc8=;
        b=fZCkY53tx34Ba9ohLdNc58r50TGTXmaO51TJIbLA4rtKKQpHEqw5j0/w8A8g1NVgL8
         TV7Kb4rN/Go7pKWXcR6fmhioFTZCZfZMTSupWSFgBzzyT8wRwRpKWB8dKYe5qYPBmMTp
         zsOeDkkLBjHMFR9Wpf/Esa9AcOlXLEI1QRnsLcEL2jd9jRcgZhmljXCgPPij/j4n7p3+
         vAIECDXhj0yI0XPK8zD2oBz4+uMiNqKqUL4xB/qk8iz6phm7uPaSOFk89UJ1qlQXwEvZ
         X0NzmQSwTl3EHvRVTqja80O9YdrYHRWc45co3fiOyCZBXOFg+mTvCKvvpmcF8NnGtJLC
         BK1Q==
X-Gm-Message-State: ABy/qLYYxhLuygUr2oDwbzfkUUq+CuSq/uWUO/9Vs6JEcZ3tDAP0APst
	vtLmlW6LGWX85o8k7YwAPjPlA1ZCOvuW+d4DRr4YbAD+
X-Google-Smtp-Source: APBJJlEKYDcQ5uepfx5LbKOxY4buQOWCAUsgSvlYRATwj1J8Z0ichsUMcv4jxGD4B1j4AYyW6y9bhw==
X-Received: by 2002:a7b:c8d2:0:b0:3fc:500:db7c with SMTP id f18-20020a7bc8d2000000b003fc0500db7cmr2187652wml.21.1689275303390;
        Thu, 13 Jul 2023 12:08:23 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003fbe36a4ce6sm18988530wmc.10.2023.07.13.12.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 12:08:22 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 0/2] selftests: mptcp: pm_nl_ctl: display
 errors if any
Date: Thu, 13 Jul 2023 21:08:13 +0200
Message-Id: <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-0-eb9582b8e24b@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ1LsGQC/42NXQrCMBCEr1L22ZU0/VF88h4iJUk3NljTkI2lU
 np3Q72Aj8PMfN8KTNERw6VYIdLs2E0+B3kowAzKPwhdnzNIIStxEg2+QjIBHfObsGrPGF6dHzu
 Txk6ZJ2pdtrKxje57BZkRIlm37Pwb/K6elgT33A2O0xQ/u3ou98WflrlEgbXQxtpaGN3qayJmF
 YmPnjJ827YvonpO/NkAAAA=
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=W9X59AeW9UwWfzu5xT2PxWDZFcNNuMVs4Oncq6H/vDY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBksEumLANGz5h8S7DdDuAiy91Jcpue+pJvTxYgs
 /M4yszy0MiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLBLpgAKCRD2t4JPQmmg
 c1NZEAC/SBuLnU2SznHrW90x42T1LpmC4PkABKJaA/g3eAVhJrH6V1vFpzSrtzeiDRB+7I6qteS
 xK34CoU+GNYadpOWvgHIQoU6XOHCVUWF//AgWIyX19aEEZUnmdYIo3ZRQ7/RQ1x2UQ+b45EUgWj
 KUdbF77j7cq76fjnalXUrqBQJDPa/RErajf5cc4HX3vJtXnEQmT0O9N2Fs4hbj9ClvhDiUT6Zyv
 iRPfUMY8ak2+C3VVXufAhEIxjscGU5/B8PhHouJcWzwGoH3lswGBBSY5Ya30gEo5UvJaxqYNyQV
 9CxoZ1eXpZewGfMoYHqlkR8uZFRaStTSc7mdEZ3lc1bwW5El6JleejS+qANMMBjkRqRtUJSgzyp
 gl2+G3CKvQ8M1d+pI6Mb7pPoji+4pwvAppSEuMwqQfi23oOyyLsA6uNdAYGPWZqMm7AongSTBzO
 l0pNnAwukohJQUAdOqodXwTls4V21g7ZwA/tI5meFzWupM0CuM5LZmh2FBVvyOHofyR+ACDOhhE
 pQMnSqnkTjqV55EeZLEzZjzwhNcFG5MtbTfIBmvqawqI2rqu3ZshUe4TfU9040juOMDngSPBI0w
 GeTKGUMKkSzjhFtN01ItZx/EWs64f4qLzUJmfQSR13dxTozHg1WM8RAv8UKH5BmZQBKhIS/ISiR
 4LIk+T6hZpa3qDA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, I wanted to understand why the userspace_pm.sh test was
failing on some arch according to lkft reports. There was nothing in the
logs apart from seeing the expected event had been missing. I then
realised the output of pm_nl_ctl was muted but also this tool was not
looking if there were errors after having sent some Netlink commands.

I don't think it is a good idea to mute the output and ignore errors,
especially here in the tests where we do want to validate these Netlink
commands. So now the tool checks for errors and the output is no longer
discarded.

Note that I didn't manage to read the error message set by the kernel. I
think the rtattr pointer in nl_error() is wrong. I think it should get
info from &err->msg instead of nh. Anyway, here we at least print errno
and just in case someone wants to have a look, it is easy to test:

  ./pm_nl_ctl ann 1.1.1.1 token 12 id 0

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Changes in v2:
- Patch 1/2: mute expected errors in selftests
- Link to v1: https://lore.kernel.org/r/20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-0-40bcff40cb6b@tessares.net

---
Matthieu Baerts (2):
      selftests: mptcp: pm_nl_ctl: always look for errors
      selftests: mptcp: userspace_pm: unmute unexpected errors

 tools/testing/selftests/net/mptcp/pm_netlink.sh   |   6 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  33 ++++---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 100 +++++++++++-----------
 3 files changed, 75 insertions(+), 64 deletions(-)
---
base-commit: 3ee02a7d38ae4c5fc98a3f833f2a6f44f4b4b15a
change-id: 20230705-mptcp-issue-368-pm_nl_ctl_ack-bb1625f5bdda

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

