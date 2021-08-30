Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C04B2F80
	for <mptcp@lists.linux.dev>; Mon, 30 Aug 2021 10:34:19 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id me10so30054878ejb.11
        for <mptcp@lists.linux.dev>; Mon, 30 Aug 2021 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2MDpZvgM6wlfHnK7UuLZkgI28edVBgEjKWxFymPReDA=;
        b=ktHsfupHHqlpvvo7BxsZ/x6psyuk4Q71sVV6JXMtOINvObtG/avIUHJIYpG8e2+Uu6
         6O5BdORMy3AXEE31F1uSCiDC1lMtwl+8Btd11c+G0FkzJeLeJHS8ihwDj9CktDHZHcfw
         ypmJhmCWzVoKBE10sQaDxaGnpmLHkbfmGo1QxdyyHCwdjITil7MsHr4i0oim+Fb5esuc
         GzbqeajU2HLoGBl6Bj1acHHfllnZNArt2AykJr8extolzpoSi4Ukd6NwC7C53r9uEWlK
         h49L087QuCrG6GoYbXVKPskPhD0OOgGCYUecc/njJZ07iRqWl5mjInYS4Z5WITVj9u87
         iLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2MDpZvgM6wlfHnK7UuLZkgI28edVBgEjKWxFymPReDA=;
        b=Sw4hQCfLz7NJ4VjQHQTg0LMuUQzz3n3+kO1a8OXMNPl/4cmeX6D1FxnG31JUqGTX5d
         kiY1/GOPy8ZgCLqIy7uHbwoairlY2JTWeqMuJnKXR1QByt3xQxTshpXDSV2xG4Hlyi2o
         S6WogxT+b6SPFZ9C3ZUqkRTEZUKCa2ku4C49CzBF1+1a947hnH/PpGkWWnS3tWPcp2QX
         hNPpdcMF95qbTguYKgUhB+7wAF+3yrUN1gMqeMyYNVN4DOqKHUAXOVajjMA1ydu8RK6Z
         ZN+qP2QXj82LD6vUiO8WAMyQmaDMZh9CAZGq7NKEn7I26AXfKLv547xXL7Jl/20TOpp4
         Gx3w==
X-Gm-Message-State: AOAM531J3pcww/+VJZzr4OOM8lRs6EhUpCS6FPuX6tgn3GmROE18egwX
	0qjOdamg7mSYM/20hsJE/Yr7pbgBN5M9I/p4r4Q=
X-Google-Smtp-Source: ABdhPJxmazjIPcW2xokKO+x6b95GrlJM524Q6HXVYGbnh/CQlTCFrFTTKXfNGDoiUbp2ZI2Dt5j2cA==
X-Received: by 2002:a17:906:c251:: with SMTP id bl17mr24465424ejb.219.1630319658030;
        Mon, 30 Aug 2021 03:34:18 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id p21sm3282755ejm.88.2021.08.30.03.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 03:34:17 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 0/2] MPTCP_INFO: Fix compilation errors
Date: Mon, 30 Aug 2021 12:33:55 +0200
Message-Id: <20210830103357.3114290-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Geliang and Intel's 0-DAY CI Kernel Test Service reported compilation errors.
Those are fixed in patch 1/2.

Patch 2/2 contains one modification needed after patch 1/2 but also 2 others.

Matthieu Baerts (2):
  Squash to "mptcp: add MPTCP_INFO getsockopt"
  Squash to "selftests: mptcp: add mptcp getsockopt test cases"

 include/uapi/linux/mptcp.h                    | 12 ++++--
 .../selftests/net/mptcp/mptcp_sockopt.c       | 40 +++++++++----------
 2 files changed, 29 insertions(+), 23 deletions(-)

-- 
2.32.0

