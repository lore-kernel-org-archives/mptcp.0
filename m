Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A527D72
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 07:58:28 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id f13so4367482plj.2
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=swRjQpd6x5XEQF+ndit+HlwhNJwEGB6M2lgBLPKCfxg=;
        b=t2ZW1NTKU9y7BDlTL0s1ObyfpJ0FbUzzWQTrXedxKRJpA4rflpbxkgnT5AuCj2QTN5
         BpEKfKIuPDRfdTg/pdDn+fkNKjP1kVvJxeaXkblGPpyZV3U5z96poM2TwWMevR8h0WFz
         pFsD+FnHDCd+mASKz+mJBRHKotlYcfSeHLKvYHPWEZL9ALtpAnq23EATw882fhPqbKvw
         PFgM8MLymPJ7GuQhyOIG/WX+tpy3eI8cYhKaavQ/GVHR2ZNHwhVfSEFwcPpMBu/ryf3z
         heeq/B4WDbfTCIl642zwux9B77WBuQ0cjqLmUmHuj9JCNI48hgN+voQ3yNIB698ZTK2w
         9oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=swRjQpd6x5XEQF+ndit+HlwhNJwEGB6M2lgBLPKCfxg=;
        b=gh0mfDXxJFLaaWoN56lSxZaBuwKiwGSzrHqdYIpjx9e2tl0/x/nVHpc7OpwJVnzGs0
         bpkoj+u+F8tAost/+m3YPlyJk+HnktnRks6iOzIJsYgprUNUOneTT8MQdUmzaOF8KUwa
         Y8CbRZcpewR2eeFQw07RHoRqoPU0BuKbPsb+Q0JoeaG5zTSFuZDCpgmT9Q29lU6F2Gyx
         Wu/7w36QVwkUseUUWsGK6l1W9FP9H61ntcTE4fgYSRWb2OQeHnaLMixXubb7UXYn6ot/
         L0tVfQ45hq3W3DPnOSHtyAfL0SXCgui+RDS0J5NEs/Wwj18lM9FZKIuHqts67YkTuUa7
         3gig==
X-Gm-Message-State: AOAM533gyQtxTJ2efv36GopufV7FL+mITixmnzrJessXqkzRop21GGXZ
	QzqARKasuo+TUnpCkASbTREt3kcVJlY=
X-Google-Smtp-Source: ABdhPJxNcmqSNh+LmCe3FqjAQ2UmJYy7wpABNUkogi2SCC3hx9vx4/aTnxTxsX06h+GcYIIdck8KVg==
X-Received: by 2002:a17:902:b692:b029:12b:e0b8:3415 with SMTP id c18-20020a170902b692b029012be0b83415mr14209355pls.32.1627372708092;
        Tue, 27 Jul 2021 00:58:28 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id v9sm2544537pfn.22.2021.07.27.00.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:58:27 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v5 mptcp-next 0/5] fullmesh path manager support
Date: Tue, 27 Jul 2021 15:58:17 +0800
Message-Id: <cover.1627372396.git.geliangtang@xiaomi.com>
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
 - patch 1, add a new helper lookup_address_in_vec.
 - patch 2, update pm.subflows in the non-fullmesh case.
 - patch 4, add more tests.
 - tag: export/20210727T054640

v4:
 - add new helpers, fill_local/remote_addresses_vec
 - add max_subflows checks
 - add 'local' into the local addresses array only when no fullmesh
   entry found.
 - add signal,fullmesh check

v3:
 - the in-kernel fullmesh path manager has been dropped from this
   patchset, only keep the fullmesh flag support code.

v2:
 - Implement the fullmesh mode as an extension to the netlink PM, not a
   standalone PM as Paolo suggested.
 - drop duplicate code.
 - add a new per endpoint flag MPTCP_PM_ADDR_FLAG_FULLMESH.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/193

Geliang Tang (5):
  mptcp: remote addresses fullmesh
  mptcp: local addresses fullmesh
  selftests: mptcp: set and print the fullmesh flag
  selftests: mptcp: add fullmesh testcases
  selftests: mptcp: delete uncontinuous removing ids

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/pm_netlink.c                        | 140 ++++++++++++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh |  67 ++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  16 +-
 4 files changed, 206 insertions(+), 18 deletions(-)

-- 
2.31.1

