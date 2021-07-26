Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91270
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 06:45:22 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so18290117pja.5
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 23:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NwdMCi5cjND9alkju87PncEVxCwNUezYzbiRLOUSd3A=;
        b=lzKWi9C6NIWBcGo6Chg5D4xfDpprd1b84mtvCQnEWvxTMUVoMuhTN+OPdVgMvy/36u
         729XeKU05jUfiz+uwbZ0RhyUVpZIih5bfCIcIjD6Q6oXtlTVBsXOQ+9j+sjTTSDi1j07
         PbEvV7a+LBdBOdeQ61Gbi4IZkL73zmSzF+Yno8rgOc15SUwtFNjxgJiyGImBT0FVAyps
         JxRv6p/L8soiXQoVfKZoAvBIK4NmEING0UTQrvCUHdTmd/WrkKnEyRxIj63wUtVmpKtP
         5R2PDQhENU9b/KoaSIEFxt10TSN86fP4Y1mxmWjfnSVga4x5p85X77R7pbkbTiZ/YA7B
         uOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NwdMCi5cjND9alkju87PncEVxCwNUezYzbiRLOUSd3A=;
        b=Rs8jQmBvV8TRVi7oaceRrtCyE59n4JREhEXhfKwGlF8JUvrvrj9CrxrknuYOjUBPht
         PeCy4LxbK3GfnEdTmCgyN8NcKr8978Ufbjn/UUrM4x/mF6j2sgx1WtQ2sWIo+JnxJC/Z
         a+fgyCA4lt8Dec7qoi3JZeJCXCarwpCsML8LGt5P4u+9VEShdCbo6l0PlcrTt4dUt2LA
         RzNquzFdk3MMscdbfP8lAFZMeMmTCHKlGovJ8AvHjvjIkeC/+mmbSgdj07Ey7dcDn+rR
         YW/tVSEHTiEsvOVlE86JvIp27Z54d2iV2H2pAWadWp8BAglzKys6VbhhvWXrwofYIJvi
         sm3w==
X-Gm-Message-State: AOAM532uuTby6vVDnr53kYfh5TIqc9Rcj0IxlVjYXNNI68ycymlrk1vV
	DC1I9Pb+uqzQq6/HveM2SBCMxSZ/UFd/AA==
X-Google-Smtp-Source: ABdhPJzu5SZPTgkTQ3ijwfl1ttYrnr8lN6haVpTpSe+qApNCfeyXKBNm9TMWlrhaNEO9uZmu0t4RCw==
X-Received: by 2002:a17:903:32cf:b029:12b:8b8b:3a5 with SMTP id i15-20020a17090332cfb029012b8b8b03a5mr13236949plr.48.1627281921585;
        Sun, 25 Jul 2021 23:45:21 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id k11sm10634697pgc.30.2021.07.25.23.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 23:45:21 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v5 mptcp-next 0/5] MP_FAIL support
Date: Mon, 26 Jul 2021 14:45:10 +0800
Message-Id: <cover.1627281326.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

v5:
 - patch 1, change "ret = true;" to "return true;"
 - patch 3, in the single-subflow case, send MP_FAIL and receive the
   echo, then temporarily handled by reset.

v4:
 - just deal with the multiple subflows case, put the single subflow
   case into the new 'infinite mapping' part.

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

Geliang Tang (5):
  mptcp: MP_FAIL suboption sending
  mptcp: MP_FAIL suboption receiving
  mptcp: send out MP_FAIL when data checksum fails
  mptcp: add the mibs for MP_FAIL
  selftests: mptcp: add MP_FAIL mibs check

 include/net/mptcp.h                           |  5 +-
 net/mptcp/mib.c                               |  2 +
 net/mptcp/mib.h                               |  2 +
 net/mptcp/options.c                           | 78 ++++++++++++++++++-
 net/mptcp/pm.c                                | 20 +++++
 net/mptcp/protocol.h                          | 20 +++++
 net/mptcp/subflow.c                           | 18 +++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++
 8 files changed, 178 insertions(+), 5 deletions(-)

-- 
2.31.1

