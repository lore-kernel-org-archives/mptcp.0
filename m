Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759975F
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:40:53 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so7487607pjq.5
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MBzVBOiT33o/wDxCK+NAa0svRhck48DKTgyyObhXTPE=;
        b=g5TT0G1hEWWyFNQKyX7hAF2QgFZhi76KbTqt7ryk3Ng8Z7d9BaNj36Cgj+aTFb7Hz6
         +77Z0OSlWKof9WVHYHcQqimDKkMUE2ufEPZHmJCqE+c8KyxQJTu2ZUdfWA9X0G1l0+Qc
         KipdwQMsoH0KZsQD4aKGPMtkWMoysHSup+qL+9/aUBfbYwr9WOuAW35Bh4+IYcI+LvjY
         2gFdsO+J+tow4z6m+NTds8+bWX7r1N/rqmm1Dd7oDron40fg1AlO43vRMck7vEf53szk
         NZcZas/kCdnBpObfaRrla8Krax5HOF7/ykekVB/tIVstj2vhnytyW1LG2hU55k6GhVZk
         Eihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MBzVBOiT33o/wDxCK+NAa0svRhck48DKTgyyObhXTPE=;
        b=lgydgU2B4xjwWHpI/swu+Ny9ZuLhtSIppVwWMlXMjEhIMSEf71LZDqDBrSTO+UBvLE
         f/eudP3pxfSOYcOGRMcqYT3yPwsI+FFcd/L2RWm9ZhB5BqjEwLmJy2VSXhFpe+8OtH17
         ILHdG1hWRe8T654iJ5uN6vLtyOtSgWX7xRA2Hndgv9dmEm4VGLjcokeQIKbQfvOxKKpU
         QVYZVPEXZQElQd7N3cNGqsdXXNLEuVpyVhG4nBTNFQnAMLypW7KtiDh5EAPrBydZDN8W
         vtWdilnFxlFueGExsFJ7lEw+Nr3sKdWS9LvbtIegLVXTJF+33BjX5k9J2+GOAlG1prtt
         Gy1Q==
X-Gm-Message-State: AOAM531zU2xj52AmkIjBH2Fqx/+c0KzPrdG5Mdm34wq2BRt89pt/Qoc3
	dOAY6xq8iB3kZ/ouVqhoWu2VxMd2P9jHJQ==
X-Google-Smtp-Source: ABdhPJwAEuJm0B7R1EzlfNUYBlod16FVzGYPGn8yg2wkujHL06AGzaBYBx3+6CVw2d5TdLc5HC4WHQ==
X-Received: by 2002:a17:902:8497:b029:e6:f01d:9c9f with SMTP id c23-20020a1709028497b02900e6f01d9c9fmr28091790plo.7.1617014452270;
        Mon, 29 Mar 2021 03:40:52 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id q34sm16414474pgl.92.2021.03.29.03.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:40:51 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 00/16] data checksum support
Date: Mon, 29 Mar 2021 18:40:31 +0800
Message-Id: <cover.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - add the checksum support for MP_CAPABLE + data too.
 - validate the data that has been split in different skbs too.
 - add more patches.
 - tag: export/20210329T052816
 - patch 14 ("mptcp: add trace event for data checksum") depends on the
"add tracepoints" series.
 
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/134

Geliang Tang (16):
  mptcp: add csum_enabled in mptcp_sock
  mptcp: generate the data checksum
  mptcp: add csum_reqd in mptcp_out_options
  mptcp: send out checksum for MP_CAPABLE with data
  mptcp: send out checksum for DSS
  mptcp: add csum_reqd in mptcp_options_received
  mptcp: add sk parameter for mptcp_parse_option
  mptcp: receive checksum for MP_CAPABLE with data
  mptcp: receive checksum for DSS
  mptcp: validate the data checksum
  mptcp: add the mib for data checksum
  mptcp: add a new sysctl checksum_enabled
  mptcp: add mptcpi_csum_enabled in mptcp_info
  mptcp: add trace event for data checksum
  selftests: mptcp: enable checksum in mptcp_connect.sh
  selftests: mptcp: enable checksum in mptcp_join.sh

 Documentation/networking/mptcp-sysctl.rst     |   8 ++
 include/net/mptcp.h                           |   4 +-
 include/trace/events/mptcp.h                  |  38 ++++++
 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/ctrl.c                              |  14 +++
 net/mptcp/mib.c                               |   1 +
 net/mptcp/mib.h                               |   1 +
 net/mptcp/mptcp_diag.c                        |   1 +
 net/mptcp/options.c                           | 112 +++++++++++++-----
 net/mptcp/protocol.c                          |  65 ++++++++++
 net/mptcp/protocol.h                          |  20 +++-
 net/mptcp/subflow.c                           |  20 ++--
 .../selftests/net/mptcp/mptcp_connect.sh      |  13 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  40 ++++++-
 14 files changed, 294 insertions(+), 44 deletions(-)

-- 
2.30.2

