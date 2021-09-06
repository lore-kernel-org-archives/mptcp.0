Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE229CA
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 07:58:12 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id 8so5979777pga.7
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gnYZepfCkIJH7dtC8K/9Nwr7eSpyA/YgpKyhdXOHjMg=;
        b=A9hBkoMLXS0qnkhxG3lEOQ8lTLw3CiBvdJXBB4efum70aPbpuZuKR9UJP9GWJ0PWd1
         G7J+PQkeIDeLw35GWv4kc7aes/I2Z8P0p6I9wUQu4KJSAoyx3+sU1KTT+UFQ1KOapI17
         zZ/t6p9kIFcDuhHrMbeeE2D8qj6Oiw7N6M45QgH6dCQOej0tNg2gTc8PH1jmKu0f2d4K
         2E1C+VQ07apYhGgHIpkUxXU3LCnhzlz62+hv9rN6HhYyQNnpTAJX1O5PZQhK3TZucmgj
         PvmjBjuvwH1xm16IPbLfzV2xzcFEhca06tAq/hOeGRJWwHpXlyyLi3PudFW9AxW2KkgJ
         B+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gnYZepfCkIJH7dtC8K/9Nwr7eSpyA/YgpKyhdXOHjMg=;
        b=HrY9r6VE9NkQKWKQMbwYrZ0Kl81Bg/CnITaL+sWfB/mr5yt2RjcryFhG1fCX5amQRu
         Ffsj7ScZGNjM85a8/iyoYTYwPPHcgMqKBTEfvW9c4HEgGO3wtceVd3I09qpO6A9+oOFr
         7nX/74eFvjshEW9Xza5KvmxElsZwDehBqLUpf86HNgL6uFEKirJLfXRQqUg9qqZfsH/s
         Te+NRhlI0W+gP7B4J1tfmSocmqVNh+ECnrxAKz16ysCwKVSngkXaapePcD9dOuD+Oqky
         J9cg6Wy0/DsvW9+re15pITQYqMYIFWdegO3ehBgN82QvQ9QPQYvX0cO2yeD5V3vzja5l
         djaw==
X-Gm-Message-State: AOAM532oo7vemzl3RbJgQD4cKK/OTRdSyzuatCK79CfmZDrF22wOI6VZ
	iOewNXx3d6jK6sCCzJlkKgEZamRdwPk=
X-Google-Smtp-Source: ABdhPJxHGIVb23rpViJRsCKM1lUI4RakD4u2n6RyVWUXAb5hMJT5d6U8tv8wXjaEcq1mm6a2n8cRRw==
X-Received: by 2002:a63:3602:: with SMTP id d2mr10197616pga.134.1630915092434;
        Mon, 06 Sep 2021 00:58:12 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id c24sm6895702pfd.145.2021.09.06.00.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:58:12 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next 0/6] The infinite mapping support
Date: Mon,  6 Sep 2021 15:58:01 +0800
Message-Id: <cover.1630914699.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

v1:
 - add noncontiguous flag
 - add the mibs check
 - tag: export/20210904T080009

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/216

Geliang Tang (6):
  mptcp: add noncontiguous flag
  mptcp: infinite mapping sending
  mptcp: infinite mapping receiving
  mptcp: add a mib for the infinite mapping sending
  selftests: mptcp: add infinite map mibs check
  DO-NOT-MERGE: mptcp: mp_fail test

 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  1 +
 net/mptcp/options.c                           |  8 +++
 net/mptcp/pm.c                                |  6 ++
 net/mptcp/protocol.c                          | 40 ++++++++++++-
 net/mptcp/protocol.h                          |  4 ++
 net/mptcp/subflow.c                           | 18 +++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 56 +++++++++++++++++++
 8 files changed, 124 insertions(+), 10 deletions(-)

-- 
2.31.1

