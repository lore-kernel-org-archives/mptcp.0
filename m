Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D771
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 04:32:15 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id v13so2732029ple.9
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 21:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0VwZx37/ZzcitpjPWqOZW5IXwAz+GmllwQw06MuVE28=;
        b=V+FqZSukKXe8S+TSJd4X2IQvJDK/Am9V5pg2mKWL+G/Py3eZZx2HXCkQ6e2YA5EbPx
         4ZKnsLSM3emRehbwHCdShdoOsdi+q6sSOIeBii/l5X6nneo1+09gI64e7XSc+Xz+APsX
         DAIGuAoEpIHSaNVwzv6FSZNC3QLovu1o3Dld+NDsSQTvMITiR3AqEb/16AiLp/bc5ayq
         gGAfjiG/wpasG4rbyeG83CpPyonHY2Myqz2iYttY+zBvjw6sbv3hTGiO/nbIVVqLvmPs
         fgraWnTB7Knf1s8aZK6Xonn+FWnGeOIS2Lurwr5FmGPYy8fP4lZCiCEmzD52gPx0EmZP
         ceKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0VwZx37/ZzcitpjPWqOZW5IXwAz+GmllwQw06MuVE28=;
        b=mkN1MgmUim+OUsTIqjUmXKnZ7IJtjuj8VVQ8k5hCdJP5qdumoryXwzx8Jk2oC+75C1
         DIVuUQhXhY4inTLbZgL+AaPgpyJ+G5P0VH8DnKb6YYawDIkqUQ2tTmrZs95vgUgTwa4c
         r35IoHgWbvaB1GZSEnpsEUJFFpGQQo7eXzZDbDfRmRO9gJ4FxMM/i8Xl9Xrwbyb4aKOr
         j9yaQ5TLoxThLhDk04qox7GsrMI7pFeKuUfwYrIbXZiYOTODsfDTy322rCfxus0Zro+2
         0oq5GTv1adHv+myyHCs4iVgHj+Oq1HYmLVbrVAAngomT0eTNZKHMXopDu4slNOH5MM4z
         cJBg==
X-Gm-Message-State: AOAM533liybP844jRMg7X5PCgJdjcDi8u5zaRmfEoYbLbEjd7VuzxbPb
	dDh00nO+40EeV0I6bwQ6aubEQ7H07cY=
X-Google-Smtp-Source: ABdhPJzq7Q98L+ehtxrvYgLBXoGD3PlYB797e7l1jLCfyDgjRuS2Ob7QAGC9a7rFCQvVhfsyyFq8jg==
X-Received: by 2002:a17:902:b7c9:b029:ed:5a0c:d1ca with SMTP id v9-20020a170902b7c9b02900ed5a0cd1camr2620866plz.4.1620275534777;
        Wed, 05 May 2021 21:32:14 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id s8sm740323pfh.108.2021.05.05.21.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:32:14 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 0/3] data checksum support cleanups
Date: Thu,  6 May 2021 12:32:08 +0800
Message-Id: <cover.1620275257.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please insert patch 3 between commits "mptcp: add a new sysctl
checksum_enabled" and "selftests: mptcp: enable checksum in
mptcp_connect.sh".

Geliang Tang (3):
  Squash to "mptcp: add csum_reqd in mptcp_out_options"
  Squash to "mptcp: add a new sysctl checksum_enabled"
  mptcp: dump csum fields in mptcp_dump_mpext

 Documentation/networking/mptcp-sysctl.rst |  2 +-
 include/net/mptcp.h                       |  4 ++--
 include/trace/events/mptcp.h              | 17 +++++++++++------
 net/mptcp/ctrl.c                          |  8 +++++---
 4 files changed, 19 insertions(+), 12 deletions(-)

-- 
2.31.1

