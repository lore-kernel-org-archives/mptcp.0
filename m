Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766BA71
	for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 10:08:01 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id p2so26542888pgh.4
        for <mptcp@lists.linux.dev>; Tue, 27 Apr 2021 03:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7+SMaP5tttHX7x0sjSlru4HmEmGFsheafeiKCLsmwYE=;
        b=vXD4kx06RXQSkN4DX69FXP1fg808A4gBf7gfkWYP9ly0KZc+aJaOu4CIsVuHkgkH/9
         3+r0YO38VRZ65ETcv8YQz9onVw3ONZSJlGtE/4EO28Dv52MXUEG1rJRpGXCGjqaF+zSt
         n9xHZosyT9BYJOA7Pgk+sr4XNAO+BEpoBPUN5PeMRto3fiTvbuH7WHr3u+qIuQ78M5ra
         Pf7MtIUZgiRRcg20mZ2ENsMUV2ZKgKbag/JP0WWrd09Bi/IVhn6dQGFyV7PnXnXVFhOs
         1s3wqxTisjBdl9t1Wt567l06Sv1mVcuf3UZjXtnJ/rJYxSUIeVsBY/NhmfbK1lh06ihr
         Ccbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7+SMaP5tttHX7x0sjSlru4HmEmGFsheafeiKCLsmwYE=;
        b=Cz/E0oyhrL/1ll4ln05woCcLEXs46dAR5WKxkPuLqpQDAlGs1iqyVCTBYEPw78Ci04
         cg3xlm1dGI7aK1/wNtrRqW7P16+9nbC6Y65b4D0uqACQZtnohQkEG8smoYbdrOrRfRXN
         TcojjYsAE/B4EkI0HqXOvjkggVV9fbjGTb7sNicx5eXFwH8+C74AgRvsdSptHM43ZOvG
         q/DzlHqMh1/NRw/RK385RoYvluWRH6ESIDReVM8MEgIHMzyiV1JDl9mvVQJXFfCVzMNG
         +iqyrC2OvP2/Xj+Zi1K7OgaWxM+y01pf2emjgmBSiKuf0kVMXzOMaBRSMuK/toEHcF5d
         rXMg==
X-Gm-Message-State: AOAM533UfEIZ3ADgYsEhlyZnKDif4kt1tZH3naNpU1jbEHOwDhcEMlPw
	dmRg9hspJucEEGAOxv0CCIZRNfstL9U=
X-Google-Smtp-Source: ABdhPJx8/qPy2S/78+RWOt+vdP+KaLmCGLD/IgetqJIl2ZgRPYqHNfzkVHrARMlJBRDs1/RftenpXw==
X-Received: by 2002:a65:6255:: with SMTP id q21mr20620477pgv.382.1619518080685;
        Tue, 27 Apr 2021 03:08:00 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id k14sm4223963pgl.2.2021.04.27.03.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:08:00 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 0/5] add MP_CAPABLE 'C' flag
Date: Tue, 27 Apr 2021 18:07:52 +0800
Message-Id: <cover.1619517696.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set addressed the issue #183.

patch 3 is from the "data checksum support" series.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/183

Geliang Tang (5):
  mptcp: add a new sysctl join_denied
  mptcp: add join_denied in mptcp_out_options
  mptcp: add sk parameter for mptcp_parse_option
  mptcp: add join_denied in mptcp_sock
  selftests: mptcp: add join_denied testcases

 Documentation/networking/mptcp-sysctl.rst     |  8 ++++
 include/net/mptcp.h                           |  3 +-
 net/mptcp/ctrl.c                              | 14 ++++++
 net/mptcp/options.c                           | 28 +++++++++---
 net/mptcp/protocol.c                          |  1 +
 net/mptcp/protocol.h                          | 11 +++--
 net/mptcp/subflow.c                           | 11 ++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++++++++
 8 files changed, 106 insertions(+), 15 deletions(-)

-- 
2.30.2

