Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE570
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 08:40:19 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id mt6so9318546pjb.1
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yG47jFmmhDxo8F9loIhG1cp/o1hubwJbQFGOEDWHNYc=;
        b=r1aqwe7z9W7k7fehNPGYm8Ec+a5mIVAxkzGaADVGvGiwYDDNXTZOezl9l4Cl6hGVjH
         rw3tfLOVCd5CjIwzXuHuUneNWNKfz3h+Eg036+JJfxAnGzTKgL/6JdRruHH4T9Oz95WJ
         zJUEUUZL51b6qeHRGPt0l4Nvf4N7iSq2Z2I2/BdJSPIR3UVD1Xs4Bj72++xeCyX1HKLO
         GDebb0v/v8zc0N19Ll/RqXmDYv0JDyd0aKYW9akxBYq6Oet61TmuRL8alOt3VckF6obU
         ZinQJUPi9xz60vooX1ZX+riIGplIqc5ToNW35n/cLAHBxq/Sf5V0Ylk5JjcMaVs52XDS
         F31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yG47jFmmhDxo8F9loIhG1cp/o1hubwJbQFGOEDWHNYc=;
        b=sZHvi3Pr8q9NBlteS6IgVfbdGIIPARokrz/d73/fxhNC5C1oeSYHlQH42MlGSQ+L7U
         pLtDdkd+X2lgjDe7h9e7/n9AtfwiYyirntNURxGGmxz+yFu7Y4ecQGCsvNTfA9NOPIQY
         GVpvQWgV0KNueU+muOgz9hMURQtVHtv2ztQg8116wyB367Ph/e8XYfHIcfmIgAap9xaM
         y8LiKqE5py16DTEDPU0g1nAHGgNw/7S9z5tK1c7P3irMfGoe9PZtYwVuwGlxW3vDui9r
         c/Mpn+ES4bPNW7pIrRzFmrwjaiYOzSvJOZ3t+x5iQPJrvsRbGW7ExqjzLjDkVPxP+I6C
         nGMQ==
X-Gm-Message-State: AOAM530Elh0SBERhXIbhlfauiPJk+aZGvHPr0ob1Hh+dOcpGCjX+4oOI
	y4iz/tL6HRZsK78h2pnVN27MJIiyjxE=
X-Google-Smtp-Source: ABdhPJxM3RHT6t/Loe0E2Q1ZBdMZRFzt5fB8TEzNFLLP4NZDbCFiafGVat0DVln99B01fM8rkZxwow==
X-Received: by 2002:a05:6a00:10d0:b029:337:abdd:be39 with SMTP id d16-20020a056a0010d0b0290337abddbe39mr4025642pfu.65.1627548018550;
        Thu, 29 Jul 2021 01:40:18 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id f5sm2401539pjo.23.2021.07.29.01.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 01:40:18 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v7 mptcp-next 0/5] MP_FAIL support
Date: Thu, 29 Jul 2021 16:40:08 +0800
Message-Id: <cover.1627547666.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

v7:
 - The single subflow case is handled by sending MP_FAIL + RST instead
   of sending MP_FAIL echo.

v6: only rebased patch 1
 - move the struct member 'fail_seq' behind 'ext_copy'.
 - define OPTION_MPTCP_FAIL to BIT(12), BIT(11) is used by DSS
 - move the MP_FAIL writing code at the beginning of mptcp_write_options,
   and add the 'unlikely' tag.
 - tag: export/20210728T080904

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
 net/mptcp/options.c                           | 76 ++++++++++++++++++-
 net/mptcp/pm.c                                |  5 ++
 net/mptcp/protocol.h                          | 19 +++++
 net/mptcp/subflow.c                           | 16 ++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 ++++++++++
 8 files changed, 158 insertions(+), 5 deletions(-)

-- 
2.31.1

