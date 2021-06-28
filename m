Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5387370
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 04:29:16 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id c7-20020a17090ad907b029016faeeab0ccso11973980pjv.4
        for <mptcp@lists.linux.dev>; Sun, 27 Jun 2021 21:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2xSt4amcVoz+/qU+qPX8jCTZ7gBlvwiv12DK/lRszk=;
        b=mlCO8hcKKHAoYOws84tn3XsBaYZbTrs6d7b6aNlZyTuOrAICk7xY5+IfGF54RCr8WB
         JvC6zac76K8xwN6bPVD/T1xrPI/EuK9reHJthHexyUFk9R6HzVHZOvT6tcJW5tCcjVZ1
         XYV2OHEZgBesioc1kIO1GIyVLV7cphEXyytBLGw+R0b8xNnoxCxQchTKL4NCTO3A53ey
         qN/3uHxT8z7Klfhzr5SWSoiGRkesFncHkF8tXoZNf3W9ctdyBjZVcl5GBkIbHjWCW8T4
         nRG4cPMjyJGgUlk9EXo1/r4dvjj2ewrAc9eiAmtONf93WsouDcBAUbMYe+ncm/HamjIa
         Os7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2xSt4amcVoz+/qU+qPX8jCTZ7gBlvwiv12DK/lRszk=;
        b=HIiV/CVNCNAfjq/vRkuB0bvQ+VNrKbFahBbXhHgYJvEwPx39TY7o5X8quR7CniYDcn
         7Z8k9jIqDWlzLlzQCj4RrUvHe+DZY7rDA5EhCRBweX5K5Z7kprhhQ+PWCX0g46NH9Pfk
         4Xmo4FG25ZvF+lrVcCqspNmqTgplFhW7NoVA+enICZ5y77pZrdvFwi1IATa6ILJO7F3F
         8CxanLviixw/E78vz3A84ruSoAcrYdaTgw6bKCHAFBDhnI8Q2EBScU+JZkyxENjqH8aF
         TI6AcQ8guKL+oc8MWDodR5NXrxIJl99Fcbvngnj9B/kLVd9IXsU3jQpzCiWJMxTVmyKU
         MHwg==
X-Gm-Message-State: AOAM530JjqPoe2QK3Avey3iQE7TjccdTtjnOyAeyzq5vVq4whjC8Uyw2
	3L0N9KR04y/cfN3frA1IkI+tN2eYapR1kA==
X-Google-Smtp-Source: ABdhPJx5BpUxHbkmWauYfiuHiOmubtRPd7qwz/p+RM85Jk0koKTeg10571mEj6ABLSHMTb/1GxgUyg==
X-Received: by 2002:a17:90a:9b13:: with SMTP id f19mr25434709pjp.229.1624854555673;
        Sun, 27 Jun 2021 21:29:15 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id g8sm12837391pgo.10.2021.06.27.21.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:29:15 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v3 mptcp-next 0/8] MP_FAIL support
Date: Mon, 28 Jun 2021 12:28:56 +0800
Message-Id: <cover.1624854005.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
 - respond with MP_FAIL
 - add single subflow check
 - add infinite mapping sending and receiving
 - export/20210626T054902

v2:
 - MP_FAIL logic:
   * Peer B send a DSS to peer A, and the data has been modify by the
  middleboxes, then peer A detects the bad checksum.
   * In the multiple subflows case, peer A sends MP_FAIL+RST back to peer B,
  and peer A discards the data following the bad data sequence number. Peer
  B receives this MP_FAIL+RST, and close this subflow.
   * In the single subflow case, using the simple implementation, peer A
  sends MP_FAIL back to peer B, and peer A fallback to a regular TCP. Peer
  B receives this MP_FAIL, and fallback to a regular TCP.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/52

Geliang Tang (8):
  mptcp: MP_FAIL suboption sending
  mptcp: MP_FAIL suboption receiving
  mptcp: send out MP_FAIL when data checksum fail
  mptcp: add the mibs for MP_FAIL
  selftests: mptcp: add MP_FAIL mibs check
  mptcp: infinite mapping sending
  mptcp: infinite mapping receiving
  mptcp: add a mib for the infinite mapping sending

 include/net/mptcp.h                           |  1 +
 net/mptcp/mib.c                               |  3 +
 net/mptcp/mib.h                               |  3 +
 net/mptcp/options.c                           | 96 ++++++++++++++++++-
 net/mptcp/pm.c                                | 20 ++++
 net/mptcp/protocol.c                          |  1 +
 net/mptcp/protocol.h                          | 28 ++++++
 net/mptcp/subflow.c                           | 28 ++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 ++++++++
 9 files changed, 215 insertions(+), 3 deletions(-)

-- 
2.31.1

