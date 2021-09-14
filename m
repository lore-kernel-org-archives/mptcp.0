Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8D3FC5
	for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 09:19:15 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id o8so4672388pll.1
        for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptPb/xOnGQj35FfyDkIojwau652ptrpZ5Rv/SyYp7lc=;
        b=aPIW2sqVcahkQbgjBtcsZW+HK3m3sighviUIEyDdqSohMqvgWEU3VvVEEIXcTzBR8n
         O5EPy+Dv70xft6/9oVMFiP29ddlZTBl2JJ8h178S06qrHcLjYcrQf15aKr+ybTUUCLNR
         rYzz0tom/NtPyG/1t5AnzaXPb4u6H+1CEUZgk+9OaExNccep1qTjIQiprGzPohlbv2LO
         IXkjJNTFj7JdrXOH9+rsB9Eyv0HLeW1bthUYrTJzX17QvKiJ2g5/ViNCCxr4KblAfwXu
         JWEELfNpkebsFN/SOhQOtzo1epi7/2Ra4z7MO9iEGPopfMxrkhY0Pxe9jKTZ1eRYujrd
         fOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ptPb/xOnGQj35FfyDkIojwau652ptrpZ5Rv/SyYp7lc=;
        b=rpVYCef0H75z05giNTNW8XcnIx1pj9Rd5kIX4AWi20Du8bd1m1Z6jKPNrqRZ+hOrex
         5XIgkKc5H9NrVJi/5hyT/T28WjJ0c2klyOPtXnNkUZ5NMSiCgF8PaKmTjf3BjpE+x0Os
         H1xM+vf7QwDJ8g5AMHRzSZ+yZJhLamXEBZhtbyfMqORlhqEBJZ3thNm213iAMPrlKD8j
         gOnx03l3LXnweWxIga3cREozSr8sS4mHGQSU5UbxZDyHGk/ISGlijLMiqXxZm5fOqjfi
         6F2y2fIQpXYuljOiVcdqnc3Xt+GZ1j+GFveGvEzfqG/rqAvs1IWg+XKvHhIHWnHs/zMb
         jtvw==
X-Gm-Message-State: AOAM533wHP2cyeDIcBwYVO6yzayMLy4YqmKqbDa6nNAQmOZRMXvp4dOA
	ZqNBWQTRzQ+qAfLy11mTZCM6x2WEpEc=
X-Google-Smtp-Source: ABdhPJxihSnFuciulosGNhr7cnmNCpghvT0KE5v/AC+k8dlBcuKNUJzk1xPVfxn7uxJudFGZNfCpcw==
X-Received: by 2002:a17:902:778a:b0:13a:bfd:94ed with SMTP id o10-20020a170902778a00b0013a0bfd94edmr14217432pll.24.1631611154747;
        Tue, 14 Sep 2021 02:19:14 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id i21sm10851317pgn.93.2021.09.14.02.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:14 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v3 0/8] The infinite mapping support
Date: Tue, 14 Sep 2021 17:18:59 +0800
Message-Id: <cover.1631610729.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
 - drop MPTCP_INFINITE_DONE flag
 - drop MAPPING_INFINITE
 - add mptcp_is_data_contiguous helper
 - add the fallback check
 - The u32 target testcase has not been completed yet.

v2:
 - add MPTCP_INFINITE_DONE flag
 - add MAPPING_INFINITE mapping status
 - add start_seq in the msk

v1:
 - add noncontiguous flag
 - add the mibs check
 - tag: export/20210904T080009

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/216

Geliang Tang (8):
  mptcp: add mptcp_is_data_contiguous helper
  mptcp: add start_seq in the msk
  mptcp: infinite mapping sending
  mptcp: add the fallback check
  mptcp: infinite mapping receiving
  mptcp: add mib for infinite map sending
  selftests: mptcp: add infinite map mibs check
  DO-NOT-MERGE: mptcp: mp_fail test

 include/net/mptcp.h                           |  3 +-
 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  1 +
 net/mptcp/options.c                           |  6 +-
 net/mptcp/pm.c                                |  6 ++
 net/mptcp/protocol.c                          | 35 ++++++++++++
 net/mptcp/protocol.h                          | 19 +++++++
 net/mptcp/subflow.c                           | 55 +++++++++---------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 56 +++++++++++++++++++
 9 files changed, 153 insertions(+), 29 deletions(-)

-- 
2.31.1

