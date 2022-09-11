Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EA97F
	for <mptcp@lists.linux.dev>; Sun, 11 Sep 2022 04:14:39 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id j12so5454969pfi.11
        for <mptcp@lists.linux.dev>; Sat, 10 Sep 2022 21:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=APSd9l4sOq4+RYFEJ6ymch0y3E5fHXLvflaPyJ/9fGQ=;
        b=IwcA1MiBHyL6uMcsqHg/994Gp/a3bvXlGbG9XTM7YjtlknBlqN7IfbRWEhXQKAHVhQ
         cm5eA1VZYGtabThjCZg96CJOFqbUcDgQ2MxWV5ezuL1V0obnWCD7dgO8fQ2rqeve29PX
         z4BwHQ/fDmv64bAICulQXB9TA698LGDCBydsTfjcueDp9LWVcSszdr0iO6vwRzg5BxrI
         vLd2V7pxb/RKFCFw919EZCK2Ryqj8lHWnn3nmaY5vf2zp1qbxLPAMsz+iAscKc3APeUe
         nRbSWH9NeX6FPJvB3+eYI2+3HLmsb7UgXQY8OILjcVX8Kkp2Qb4GYRbaujTtjZvyGDsu
         UzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=APSd9l4sOq4+RYFEJ6ymch0y3E5fHXLvflaPyJ/9fGQ=;
        b=poJKrJseSpJO5IuZBrFNeEqv3byECbCuOlV/xsIssE8PxlHozsasIsRTJg8gGuDZNY
         YtAIEWXYduwXljqZxYuQWGVNHdVNxiSiUTxmrqgN2kSFtnd9YUvUpCzK7JYUANaRZOJZ
         4TTMp1V3f9ww/y6RoCBd+OxvgJpLuC/B6S7t0EEckLeGkZmCUyajdmEvrJVgqasbYezS
         mshO4fHnGdUyGIL5dsGMOZRnuK4bnDOFdeStUIG8YHc8uOdz2ELD5B29PUYvyFl/DNAO
         rs0oM1RhTbX+Sw3qUFahkdZfzNHnSxumThJp8Y0HZujOyozVacVYRu4a+NAnc+61l+w/
         Rblg==
X-Gm-Message-State: ACgBeo2kkyZ9uolQgTH9zUyC42vBBZWYDThMbLoD8so9lgjmB6oSDwRm
	3NxbCr/CbAy8JYvYiGVA6fs=
X-Google-Smtp-Source: AA6agR6UphYAeFDrsZnntEhL2rkoQFtgmIBGiNTBGm6DPweNUTSXi4B58IKFTPKoC4OnTunIjTlYVA==
X-Received: by 2002:a63:484a:0:b0:42a:1a4:517e with SMTP id x10-20020a63484a000000b0042a01a4517emr18321346pgk.86.1662869679045;
        Sat, 10 Sep 2022 21:14:39 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.24])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090ad48800b001f2fa09786asm2783752pju.19.2022.09.10.21.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 21:14:38 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net v5 0/2] net: mptcp: fix unreleased socket in accept queue
Date: Sun, 11 Sep 2022 12:14:16 +0800
Message-Id: <20220911041418.818201-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

The mptcp socket and its subflow sockets in accept queue can't be
released after the process exit.

While the release of a mptcp socket in listening state, the
corresponding tcp socket will be released too. Meanwhile, the tcp
socket in the unaccept queue will be released too. However, only init
subflow is in the unaccept queue, and the joined subflow is not in the
unaccept queue, which makes the joined subflow won't be released, and
therefore the corresponding unaccepted mptcp socket will not be released
to.

In the 1th patch, we factor-out __mptcp_close() which should run under
socket lock.

And in the 2th patch, we fix the problem we mentioned above by closing
all of the unaccepted mptcp socket in mptcp_subflow_queue_clean()
with __mptcp_close().

Changes since v4:
- keep sock_hold() in __mptcp_close() in the 1th patch
- rename cancel_work to do_cancel_work in the 1th patch
- don't make mptcp_cancel_work() inline in the 2th patch

Changes since v3:
- factor out __mptcp_close() and replace mptcp_close() with it in
  mptcp_subflow_queue_clean()

Menglong Dong (2):
  net: mptcp: factor out __mptcp_close() without socket lock
  net: mptcp: fix unreleased socket in accept queue

 net/mptcp/protocol.c | 16 +++++++++++++---
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 33 +++++++--------------------------
 3 files changed, 22 insertions(+), 29 deletions(-)

-- 
2.37.2

