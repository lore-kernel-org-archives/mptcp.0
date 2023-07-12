Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465D27701
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 11:33:26 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso70598975e9.1
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689161605; x=1691753605;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XYk9EyFEZdcAFH/+aDKQFbrFcWXgboS9PTB6Rbd8EE=;
        b=XR/vTFnRW2p9kgMb4mRl+cNEWSCFwbqTCvjMOcP7mgF1GGAdH6xm9XLa8l4gDFPlDv
         V9GwybSvVQGKM9RToD/xmWWpyxE8Oat9dCZCLcBbWDesy/p2b2qbzpH/P5OXyeqMpRmP
         Hz+TJjOhP7L/GbvEhEZPuSQKW65a/Hru1SpYKvQv3lCizYPkhfh1scx8nkSCdZgzDgYv
         8XwvXaU8Sgeqjmc7dGcYUpuiNi0Has05vUEMLe1waJvzimsUJk71fby60K+9ZuSAoDUk
         /NObX0JHmWTI0l4f4eAVRC5+5c+qdB2lhTU+UMGcE9LXG5JeGjGD0WDZYw6w2te1QC8e
         StLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689161605; x=1691753605;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XYk9EyFEZdcAFH/+aDKQFbrFcWXgboS9PTB6Rbd8EE=;
        b=A+3Oj7jlBbhy3F4QfcQlOvUQbhNK/6ZezwfpKok30UmZB8ruwLIq/iR9OlacCx61Cv
         tbdXVZ9IeTn/eg5wCRfVSmU9i/3ORN25I0BsXEuJAvt3LuJyg7ysd4qykTNLgYxNW9bj
         SFdbDLtGA5+z6Wtpw3iJwZiWu7vK0PqmuZq8moRO1Vw1/bgMadbpB3Q9ZQ8g0LunrmPF
         J6uVFEdIXXkjYUboJ9Q0w3LEaAe1KkeOH9ZuHejAfOkTgyqrS5AcyXUvMBHVMGV1D/oH
         KNGRP6ed9ZFyM7QWfb6SP/3knBDMItfNGfW1N9kqtMTXc77bEWQf8QoZvZerdV7VrcFI
         aWtQ==
X-Gm-Message-State: ABy/qLZtfZxhOaTuv1o51n0ChWl+QyiCNRgKzuHWgY0NmyedgVEqYVm+
	aLYS5ejkmRMw+YTwAxrTkc8G0w8TwVkdiEqsf1hpeiMw
X-Google-Smtp-Source: APBJJlHF9z29CHPABQBpoHv2FKehixjDd769ib+Tv7zvLHN60AvfBC0CCTkYCxTttLIK/pjlYjOrOw==
X-Received: by 2002:a5d:6e90:0:b0:314:475:bc47 with SMTP id k16-20020a5d6e90000000b003140475bc47mr15439105wrz.69.1689161604632;
        Wed, 12 Jul 2023 04:33:24 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id j11-20020a056000124b00b0031417fd473csm4892673wrx.78.2023.07.12.04.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:33:24 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 0/3] selftests: mptcp: format subtests
 results in TAP (part 2)
Date: Wed, 12 Jul 2023 13:33:05 +0200
Message-Id: <20230712-mptcp-issue-368-selftests-subtests-v2-0-c8b174c18f93@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHGPrmQC/5WOQQ6CMBBFr0K6dpQWJOLKexgXQztIEylNpxAM4
 e4WOIG7+fMnb94imIIlFvdsEYEmy3ZwKahTJnSH7k1gTcpC5arIKyWh91F7sMwjQVHdgOnTRuL
 IwGNzDIVWNVZlbbQxIoEaZIImoNPdhoqX0XMMhP1W+kCtnXeDpzjgjuYoXqnrLMchfHe5Se4X/
 3hMEnLINVJ5LZBki4+0ZwzEZ0fpw7quP5rV/VcAAQAA
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=EZzaowYcot63YLw1WssYBjF8cjzwjL8zvrVQofeoS7g=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkro+D+hEEprwnkNz8d3rPpOmiM9++93Ert+ZRz
 bLeTUsjzMGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZK6PgwAKCRD2t4JPQmmg
 c0JMEADcDkN/uCsj/bsGYcZMODfTgcLrOPL7HyVGjVsMrJ/t7H17dcSXLO04yEfKLgdz3VlKVw6
 8nrpSsmq7EN7o0UbmfTNIVM4G/Oni998ErNcIVIuDjXDoGOZbJeuiCElzfK2QyjJlvmajeq5ev9
 Wthqcb/EOnhuRt1i9be7tto2nbxyrjIIaRyB911X6BLsZEWPYuJfekNx4fWhu26GKvEmPM0b6Vp
 WmJcsCRzqZNqV3oZafbEsgNLikyACj1omVIj+V+bR8V56spMXwNXM4vk05BX45hw6s/5USytYoW
 ThRe/ywaam0zG1n2l3L3cRUXvvjTsZi3VGOyiyaMQPhU+eAHXwJxJEH2OM7w1tSf8F9cGjkBSQE
 LIgp8+sBjLyOe+6ORUX72GATMhuSIi/24ISqJ3NG5j21sfXmZCUF2xMvZV3MYABElseNc7VHZ7H
 8PaR30SnodwxpyIJDIHKHO2GsqnGljK4lSP4CB+M524Kpf9p2gK4zHtV8W5jrJOJpvqRqqPF7XY
 D3gtMC7b5WiNCt9VwDWKJKWVcvX/oltkwzGwIf6C+/X0dPcU4CJUTNyKkEYAxgPhL+z8+XOFt57
 obHKzaZk+Ez6MTrfvzb2d9wz6fZU8bNHn8yk7E7bDIoyHcNiM3TVCgbFgJSx8fmfFJrJvQoq6A7
 SOR7RPwcH5g7pFg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As discussed at a previous meeting, it might be good to print the test
name earlier to avoid confusions when there is an issue: sometimes the
error is printed at the end of the previous test and then the test name
is printed.

While at it, the code has been uniformed and it allows new features,
e.g. colour support, see patch 2.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Changes in v2:
- Address Paolo's comment in patch 1/2 to print info only if there is any.
- Add patch 3/3, a fix for -net, a bit unrelated but discussed when
  working on part 1
- Link to v1: https://lore.kernel.org/r/20230628144927.828117-1-matthieu.baerts@tessares.net/

---
Matthieu Baerts (3):
      selftests: mptcp: join: rework detailed report
      selftests: mptcp: join: colored results
      selftests: mptcp: join: only check for ip6tables if needed

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 454 +++++++++++-------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  38 ++
 2 files changed, 253 insertions(+), 239 deletions(-)
---
base-commit: 5fca7ce8c3c8d7badac7a9dd8b552bb221d91ee4
change-id: 20230621-mptcp-issue-368-selftests-subtests-3c29a649dcdd

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

