Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA37F72
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 10:42:01 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id z2so1274899plg.8
        for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cLas7OGBs57eX222ucMB78unpBDQxho8KDaoRLVvkPA=;
        b=lex2WZbsM7IuX+yTxE6HPYPtQhB3xeq/6uSnpc9q17FC4S6CBsPxdW5Im1ob7CO3kz
         xK4YYO7ehK5uzC+3rgjjmBaXU8lhX+Cm5J6+YCEUAaDuNS4Z+lOqeKi1uD3lcAO/41lS
         eOjf+gUnHG05sOD0zzPknxe5Uyp/VGNeOKs0wZrsxddqh+2dOixDUgS9aJcWtKr+9OMx
         NAvp13wFIdKQDaVmXYyt7Hr6BCOiyCBEt4kDXuOFTyYfoHhiFr0jbO5MvxjNfSTldxO2
         lKqlduxnTQc0pPaX7SJid/aHMDf4y5KV1ACMSDaGhg2hkrAD0dbR6kkYOT+r5ntWF+g+
         I9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cLas7OGBs57eX222ucMB78unpBDQxho8KDaoRLVvkPA=;
        b=G1X9thM4GB4CrHPex0dBcGUMXDrmc2fCKoRk92c6UKaGnc75fbZ/6MVVgJOvDcg0n3
         MMJpR1RQvpKp7uH3oyKAXZ9MxFvCyYT/BVLA3dzrYyygrY0RVguh5BtgHX45R+guCJqA
         P82SdXn5lQpGL6GOD51wIVwihWsYssr9TtMFS9zU+vKSpdTqpbWuw4aiW0Cy/PVx2MxB
         Eaw07Sa7U/jckE+XqKRmFoK1edufM4COxBREQ29SuFZaqkPha8ilV+P7sOvRlIZOCkT2
         /10439f6dLeGEBkL9huYFMQ15p6jZL7NYqZWtRbnWGfHapu9jTQCmimielfQvrFlwKlH
         efmw==
X-Gm-Message-State: AOAM531hjmC02syr/fcpBpmPZODXgG97GrxwN+grHK1OtVaDkFMOv3GA
	l2tPlLve1bVmqOcc1Hl3+/Nrq5j5iAkyJw==
X-Google-Smtp-Source: ABdhPJyrYyDawmVIKmstyGWQrcAZ/epX+b4iPHgsCSYMgaR8Tv7lJGsoyGTEoICqdAVh/b6E1byvkg==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr3119297pjg.202.1626259321325;
        Wed, 14 Jul 2021 03:42:01 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id x18sm2122904pfh.48.2021.07.14.03.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:42:00 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v4 mptcp-next 0/5] MP_FAIL support
Date: Wed, 14 Jul 2021 18:41:52 +0800
Message-Id: <cover.1626258797.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
  mptcp: send out MP_FAIL when data checksum fail
  mptcp: add the mibs for MP_FAIL
  selftests: mptcp: add MP_FAIL mibs check

 include/net/mptcp.h                           |  5 +-
 net/mptcp/mib.c                               |  2 +
 net/mptcp/mib.h                               |  2 +
 net/mptcp/options.c                           | 78 ++++++++++++++++++-
 net/mptcp/pm.c                                |  8 ++
 net/mptcp/protocol.h                          | 19 +++++
 net/mptcp/subflow.c                           | 16 ++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++
 8 files changed, 163 insertions(+), 5 deletions(-)

-- 
2.31.1

