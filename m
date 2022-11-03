Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93836FAE
	for <mptcp@lists.linux.dev>; Thu,  3 Nov 2022 11:07:25 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id v17so1594959plo.1
        for <mptcp@lists.linux.dev>; Thu, 03 Nov 2022 04:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2dWzk38BsJfkWls/1UWswOlk57f8LnG3Qe+IA9sUEs=;
        b=P9ii/x1HF+aRZfnlFdQqiyfhHWV6AR6QLOCKBJwlQj+2yzVR9NMOOckTu6OOm5dZgY
         wT9lwH81bz4ltdQ95gUC18IBTGrLdBSIp7UxgGMbCV409GEt4MWOunNv5ZBfvE+kONVQ
         uvS/D4aYv5oziD2rJ0tv5OczUo0jiRDMAIwOLfKDQKMzd8L8XH1l52/rp5TrpkXvQhFf
         GbtWv68DMoGkglDkuTNIgSdJzuOgj+bnsdMugcxvZ/caUVP1zdLyR3iWYNNcHVOrQyCF
         x/XFQWjP1MtZHIap+z3ieSoCm/wo/nb/5M9AT43n0kr0/eefq9hDOfyN6Mlest6eagJ9
         B1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2dWzk38BsJfkWls/1UWswOlk57f8LnG3Qe+IA9sUEs=;
        b=x5+hEeL3SdjobISm+UHNjSDJvUT+DWt/oXqaOivTioBOZmTRQFDWAW6bHQRtz9pMVZ
         oeQiuzxTAfSqGLpJfacBYEfzqCsSp098aBM8vOUE6bPp+Hgvj6LML7xbGhVUNu/x2r1H
         0peOhixIYpJZuVhBGWyEqaLGELKDcqOR6JXUea0XkPRpSfEx1rGFveg/Ev/p1dryzFNV
         2q95DeOcqUr/HM8ZNCYBrmZVZUZ3vWqpjRgNtP3pPpmkmhpZeHCRe5zXfVhAIxnL0wLk
         bMzHtcNRh6eZEFE4sIlXthXbZxgFVIvb/yCYaFlcCDfnzDR0q8xjyPQAM2WV4awJ+OI1
         8gmQ==
X-Gm-Message-State: ACrzQf31m2Qlz05HrwFrTNbPCFDnO885YdWL2dA09j4m+YrHq2FdWF4G
	5e0YcgxDvIaTg8YuJWRZJ4M93CLNj1CrLw==
X-Google-Smtp-Source: AMsMyM7HstujDf3UrzSVisOCLJWhs2Gv4NxsyZ7LNBXFfytUvDQB4WkrnDpjTHa1xUexBLxTwW/+Vg==
X-Received: by 2002:a17:90b:1e0a:b0:212:c44b:fffb with SMTP id pg10-20020a17090b1e0a00b00212c44bfffbmr48745374pjb.113.1667473645204;
        Thu, 03 Nov 2022 04:07:25 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.gmail.com with ESMTPSA id w14-20020a627b0e000000b0056bd4ec964csm450555pfc.194.2022.11.03.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:07:24 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v6 0/4] mptcp: add statistics for mptcp socket in use
Date: Thu,  3 Nov 2022 19:06:45 +0800
Message-Id: <20221103110649.299284-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

In the 1th patch, we do some code cleanup with replease 'sock->sk'
with 'sk'. In the 2th patch, we add statistics for mptcp socket in
use. In the 3th patch, we make mptcp_connect can exit when receive
'SIGUSR1' with '-r' flag. And in the 4th patch, we add the testing
for this commit.

Changes since v5:
- introduce MPTCP_INUSE flag to store if msk is in use, as I find
  that it's not correct to check is a msk is in use by
  !sk_unhashed(sk) in mptcp_destroy_common(), because the token
  can be release in mptcp_check_fastclose()
- add the 3th patch
- reuse __chk_nr in 4th patch

Changes since v4:
- rebase to solve merge conflict

Changes since v3:
- rename MPTCP_DESTROIED to MPTCP_DESTROYED in the 2th patch

Changes since v2:
- add testing

Changes since v1:
- split the code cleanup into the 1th patch.
- decrease the statistics for listening mptcp socket inuse with
  mptcp_listen_inuse_dec()
- add MPTCP_DESTROIED flags to store if mptcp_destroy_common() was
  called on the msk. For fallback case, we need to decrease the
  statistics only once, and mptcp_destroy_common() can be called
  more than once.

Menglong Dong (4):
  mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
  mptcp: add statistics for mptcp socket in use
  selftest: mptcp: exit from copyfd_io_poll() when receive SIGUSR1
  selftest: mptcp: add test for mptcp socket in use

 net/mptcp/protocol.c                          | 21 ++++++---
 net/mptcp/protocol.h                          | 13 +++++
 net/mptcp/subflow.c                           |  1 +
 tools/testing/selftests/net/mptcp/diag.sh     | 47 +++++++++++++++++--
 .../selftests/net/mptcp/mptcp_connect.c       |  4 +-
 5 files changed, 72 insertions(+), 14 deletions(-)

-- 
2.37.2

