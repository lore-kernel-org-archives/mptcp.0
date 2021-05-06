Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E372
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 07:48:51 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id gq14-20020a17090b104eb029015be008ab0fso3003886pjb.1
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 00:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjvn96qbX9kMRT1fuE5K7AiwF9E74pnAYEw4W2jDWoI=;
        b=rWnjv8FiuPDE/21Uw2zneL2RA02g+f7wlxEhjo7xD0DOYL1dhqthldxchDqcLXQAEs
         rQ3WMCfcLJ3RG4SNeskcFk/FEiSQe1nFmgpU9ayfP+ppOMHiomse831dO7IRX+4Qt5CH
         mGYOkbSWTmo67DTMek5GNqbYRauSnKYL/Z1kkrjNFVVP1twFb6R2wBu7EIldacsBrR4b
         0l7zKLc7x/uCrAi4Xt23ScKp0+AhdY+U7nhPf5gdZoDiUWRRTPt7Ea89MX3r1HbpiUoE
         6rBdU6DSGe8uxNTwfDVrCuo0sJuLHELRAVpuQPz4tUBI5gsUyP/ztNrHRC7OocJ+JdCE
         F8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjvn96qbX9kMRT1fuE5K7AiwF9E74pnAYEw4W2jDWoI=;
        b=KpeH9VI8ke5Y0x8zEc+2EzHlIl0X51cpBu5CZvik3pkxpgIVsFp8rVvfrUCkSaZr07
         jjhwq8J52q3+KLBBbI2erLUck5Teo+B6lqbdL1oylwSrxIEDm3n/aLCqxmb82HxwUjeC
         wEIpbLWt0rWXht706KF93Cz13AsN/IiN9aWEk3w5iZpnhL3ndUxob048XJJ8p2Tmoa0R
         Ov16uoAL8zsh4bSXX5LhwQ9FEypR2iJtz2dGdGNOvPzsd8JAuv3Ek+oDX0DsmAQewICA
         FJlw+jSsX7js7nPgT4yVzudfjun8/ATQ7F/Oj9gRixTz9eNvNmxSfg/vD8ay7m18MtuC
         im4w==
X-Gm-Message-State: AOAM532xDRjasXWs8rwfG8y7P9i1LPZIO7JYoJyM5NCzsNcX5MoRsXa2
	61EGAuvmpljPailHnGVf3SARVI+Gxoo=
X-Google-Smtp-Source: ABdhPJzRpx6w56GvbcxRmV84uWs0p+QYW093z+/JX0a0BC6JS7wSdZmxDh1C8UqF+j6bTErTdw4Swg==
X-Received: by 2002:a17:90b:110b:: with SMTP id gi11mr15751408pjb.173.1620287330605;
        Thu, 06 May 2021 00:48:50 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id l10sm1238369pjy.42.2021.05.06.00.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 00:48:50 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 0/5] data checksum support cleanups
Date: Thu,  6 May 2021 15:48:41 +0800
Message-Id: <cover.1620286893.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - add two new squash-to patches to rename the mib DSSCSUMERR to
   DATACSUMERR.

Please insert patch 4 (mptcp: dump csum fields in mptcp_dump_mpext) between the
commits "mptcp: add a new sysctl checksum_enabled" and "selftests: mptcp: 
enable checksum in mptcp_connect.sh".

Geliang Tang (5):
  Squash to "mptcp: add csum_reqd in mptcp_out_options"
  Squash to "mptcp: add the mib for data checksum"
  Squash to "mptcp: add a new sysctl checksum_enabled"
  mptcp: dump csum fields in mptcp_dump_mpext
  Squash to "selftests: mptcp: enable checksum in mptcp_join.sh"

 Documentation/networking/mptcp-sysctl.rst       |  2 +-
 include/net/mptcp.h                             |  4 ++--
 include/trace/events/mptcp.h                    | 17 +++++++++++------
 net/mptcp/ctrl.c                                |  8 +++++---
 net/mptcp/mib.c                                 |  2 +-
 net/mptcp/mib.h                                 |  2 +-
 net/mptcp/subflow.c                             |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 ++--
 8 files changed, 24 insertions(+), 17 deletions(-)

-- 
2.31.1

