Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983D70
	for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 14:31:42 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id p36so2341216pfw.11
        for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 07:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59+mmcWfGLWINV3YuSZAlW/g/KmLHgckkpMk004cvxU=;
        b=gYrlWCkI1Fa14rGyAQQ55rH8EDAaZOzYNwenPuXIC3km7QBnBzhBIDUrp7rMnNX93d
         t1XFLdkXZ2BOICTwYwUGvGxPbH2qAC5uxi0M1CN2KVlswb7nooxpo0ZYxWlxJawDZYRt
         j0RCWvzvf0uBZbgMd5ruscwQ8SOHfS5XlCIW/2J8uO4qlkzt/4lWH8sCCiP40Bp+anf3
         +zPearlJfFjSY8TDAsoEvvIUFUed6o0G8iOYYX1rEGUw4KpTMrz9q7e6Tech7rN3Nmqc
         4N4Q1+UD8umGj8SLws6WbFV93wpzoPMNYseKjDD7wkV94JoOZ8nzIE0v4gsQ0BNpkmP8
         IMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59+mmcWfGLWINV3YuSZAlW/g/KmLHgckkpMk004cvxU=;
        b=rEUKB+RBX3llT8r2eot2JcOLCJCsEQcCtLfecXsUXqZYTm/8OWOjP/Ngr2mgtD6TPv
         KcDNfL7D3zQ6DVVcNxR/8i/9YdDZ4MzWYgX5VN6y/TntyE4SPb2woCOyuENdnVfH4y2H
         ogrt8Hm9O7uYw4PwMVX9Hn7iMOjdtXVxy7cEPJsKk1ydM+mijK2V44zRoC1a3ur4QiWN
         JlnoBan5hc2Ee/LMCs4eEXe1OyWxz487YuNR/NWVikDxGvuC693IMqhWW2PpTIVFvzV7
         IbFxK3uxhqWjL+vRF+uj8gXZ5PIswnmfl7kcHJu7d+C2AP+jT9j0wsk7OkRTSoHQ6V22
         /Eeg==
X-Gm-Message-State: AOAM530JscXmhbrvBTHcdgDX4gEGkX0auqDyYIjQ7GJ+rEFy4EnObtkN
	5FGRcXBAx33z8++OCM7qEdhPJseCPyEmgg==
X-Google-Smtp-Source: ABdhPJzoBoDwU7O5jvJ6VKNxweXOdYe2gazS5AjBDOtrIG/7J+9VofiBA4CwhAR9ODSuEPqm7cqzog==
X-Received: by 2002:aa7:9ec3:0:b029:32b:4eb5:4bad with SMTP id r3-20020aa79ec30000b029032b4eb54badmr36644884pfq.6.1626877901699;
        Wed, 21 Jul 2021 07:31:41 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i6sm21723147pfa.44.2021.07.21.07.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:31:41 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 00/10] fullmesh path manager support
Date: Wed, 21 Jul 2021 22:31:24 +0800
Message-Id: <cover.1626877655.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the in-kernel fullmesh path manager like on the mptcp.org
kernel.

v2:
 - Implement the fullmesh mode as an extension to the netlink PM, not a
   standalone PM as Paolo suggested.
 - drop duplicate code.
 - add a new per endpoint flag MPTCP_PM_ADDR_FLAG_FULLMESH.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/193

Geliang Tang (10):
  mptcp: add a new sysctl fullmesh_enabled
  mptcp: register ipv4 addr notifier
  mptcp: register ipv6 addr notifier
  mptcp: add netdev up event handler
  mptcp: invoke mptcp_nl_remove_subflow_and_signal_addr in rcu_work
  mptcp: add netdev down event handler
  mptcp: add proc file local_addr_list
  selftests: mptcp: print the fullmesh flag
  selftests: mptcp: add fullmesh testcases
  selftests: mptcp: del uncontinuous removing ids

 Documentation/networking/mptcp-sysctl.rst     |   8 ++
 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/Kconfig                             |  10 ++
 net/mptcp/Makefile                            |   1 +
 net/mptcp/ctrl.c                              |  16 +++
 net/mptcp/pm.c                                |   3 +
 net/mptcp/pm_fullmesh.c                       |  94 ++++++++++++++
 net/mptcp/pm_netlink.c                        | 116 +++++++++++++++++-
 net/mptcp/protocol.h                          |   6 +
 .../testing/selftests/net/mptcp/mptcp_join.sh |  91 +++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   7 ++
 11 files changed, 342 insertions(+), 11 deletions(-)
 create mode 100644 net/mptcp/pm_fullmesh.c

-- 
2.31.1

