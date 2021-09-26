Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6903FCB
	for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 14:29:46 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id m26so13364318pff.3
        for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZsX9P3vjo6uJ12iU2l0DD2m2GbITuX1D00UOC3ejwo=;
        b=cLVXk2tMgGB+CM+4b8049cv97Y9VjaOCbB2dqtqpwY1VMi+z6EjOnVThcd6SmBlwOK
         G5QXcbDlLklNJh9c4UR3WTIATzTD7NxylKLLqg8LzCMByr59ILK2UCur2is5jf9xAOwM
         HMwpEWOBoKvhn86pKNDDzepspeKKuudhkWdq/LDtbhypTPEYlpo8Rlz+fr4LNMCa01Mj
         TZBuVmtO00UcH6ocOvf2OXr0lk8SDVjRjUYA+FwJ/PzESndr033xWBNvHHZKKivPuhWx
         /+RWj2JRDKaXIr+bM7ShW0BvXfzxE/G4IGqg4TuDYa56xAJDdwRzTpCfjUufMHAb2Q0O
         5axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZsX9P3vjo6uJ12iU2l0DD2m2GbITuX1D00UOC3ejwo=;
        b=25JQrhD1rYs2xXPj5fbVDwF+dEWkJQHhWC4A/l00q4GMtJAi/FYm6U0luM67B22JbZ
         TEYkSChmuBpcTZs72TsLkUF3K22ISsuX+P8oRLPkUEtZM+xLvsqkr8T6oN5eK8sc+AE5
         85R+nlmUppJKpkwtk038ugGL2PlhZpALaLPLfe6E4rmSUHOEW7DRKLRTDUSpUAQe8Uzj
         7PWW1Q6NZwxzQb061TyMkM9lsKzQf3KyeINor0KhqD2BLtbDC/AUGR6XS8X1KIdwqCpS
         Q/Rb6Qyjy+HrSSb/blGFEQi4VKAm3IWwdo+dThIAOFPcTV5Ym1s1LYLUUyx5NTGCsorE
         BIvw==
X-Gm-Message-State: AOAM532C+1KQ9xoi8c2dOt7jrJqKq/eKufmprVCA494LYNGUZF+vmYFg
	0fByyA61ur+flc51DfOiAABDXMmql/s=
X-Google-Smtp-Source: ABdhPJxBq9pEZbzhSqa0ngF9HBIQFH5nAZqnsC+IadQaZqIkSEXb74NuLoX2fHXKiScuLzrRtIL40w==
X-Received: by 2002:a63:7b0c:: with SMTP id w12mr12515222pgc.246.1632666585681;
        Sun, 26 Sep 2021 07:29:45 -0700 (PDT)
Received: from MiBook.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x9sm2421082pjr.44.2021.09.26.07.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 07:29:45 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v5 0/8] The infinite mapping support
Date: Sun, 26 Sep 2021 22:29:30 +0800
Message-Id: <cover.1632666254.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5:
 - move last_retrans_seq from msk to mptcp_subflow_context

v4:
 - update patch 1 and patch 2

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
  mptcp: track and update contiguous data status
  mptcp: add last_fully_acked_dss_start_seq in the msk
  mptcp: infinite mapping sending
  mptcp: add the fallback check
  mptcp: infinite mapping receiving
  mptcp: add mib for infinite map sending
  selftests: mptcp: add infinite map mibs check
  DO-NOT-MERGE: mptcp: mp_fail test

 include/net/mptcp.h                           |  3 +-
 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  1 +
 net/mptcp/options.c                           |  2 +-
 net/mptcp/pm.c                                |  5 ++
 net/mptcp/protocol.c                          | 38 +++++++++++++
 net/mptcp/protocol.h                          | 21 +++++++
 net/mptcp/subflow.c                           | 55 +++++++++---------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 56 +++++++++++++++++++
 9 files changed, 154 insertions(+), 28 deletions(-)

-- 
2.31.1

