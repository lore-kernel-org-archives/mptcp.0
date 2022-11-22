Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8978EA8
	for <mptcp@lists.linux.dev>; Tue, 22 Nov 2022 03:51:20 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id v3so12994830pgh.4
        for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 19:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkuRuTh64JiVAeRqGjzkhRUMwDLIFy4FD+55JxiVX2g=;
        b=Ii4rsAaNBvTdM1jtoczQVm7/t91ZBxBoby8PlNBZNGmzowX91pm34wQDJEYnuUNs/Y
         qu9ZCMS5ubQhCLKy7ZqdbSX7OQUjP2r6TcKGeRwT8n1niCsOg8kxw6MWgziXoveBXm8c
         WRUB93iarr3oS/J0gh8K8XZgsyLaIGc9Kcsf3OZiZ+EXgSQT6ByQHuEwFDsEnTOZOhPY
         A0Fu+95NQC+QysnI3oiBRayDSghNMRShCjG0WDuIB8LUhSMoM++J8kx41iyoMNvdpRVn
         u0kvfj2fSHIFKfC4d+8WaNQ69P7FCfO07/3I8dxcRqNBIU7N+CzHLE2tKwgZ7FG6A2+q
         jtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkuRuTh64JiVAeRqGjzkhRUMwDLIFy4FD+55JxiVX2g=;
        b=aAKxe/vwNzFmklkUxMH1Odmj56TKhTsEqFavgQHSktedZ60MRCXlurevJBwv17+iBl
         XIISZCrOAbzUmMq1o8Tdw2FdhMXf1OXnxR1Zpfgx4JeUicEXjkBjpzT9y0SYo7nA22M1
         mZDcW81zedcLB04XJSflpE5Bf0hbdIRQa4jvrTwvAYYlwmzXIVfgbET+bMCQ1acNGDzT
         M63Y7W9uKitAMhUqlzv+v15vZcRbmSuQE5U87S7pThvRgauaLUxLrfID0DJl/owI16PY
         frIBhCS+yKLtKK3OGztOIgyE/QxMGSuLggUgPgWiyjc3658a/CbZclN6pA8lWp1jHWXT
         EAKw==
X-Gm-Message-State: ANoB5pkvwOBj0WMR+o21CzELMUyArbNUIdG4IsZ3OH0cMP1lyb1Om2wK
	ynHxrny8ECPE3ruO0rj0plE=
X-Google-Smtp-Source: AA0mqf4GdmBwVm5hi8nWf9E9ocauv+Fcml7XoK0K6IGVcpL9jSSKJnJGCTrNcySQISXuqjHhvBmZmA==
X-Received: by 2002:a05:6a00:21c2:b0:56b:bba4:650a with SMTP id t2-20020a056a0021c200b0056bbba4650amr2061210pfj.4.1669089080374;
        Mon, 21 Nov 2022 19:51:20 -0800 (PST)
Received: from localhost.localdomain ([162.14.78.182])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902ec8b00b001869d71228bsm10707220plg.170.2022.11.21.19.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:51:19 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v7 0/4] mptcp: add statistics for mptcp socket in use
Date: Tue, 22 Nov 2022 11:49:19 +0800
Message-Id: <20221122034923.804955-1-imagedong@tencent.com>
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

With the commit e8695e504942("mptcp: don't orphan ssk in mptcp_close()"),
I belive that the testing of diag.sh can pass now. In fallback and
simultaneous close case, the msk can't release normal (sometimes?) without
that commit, and makes the testing fail. Enn...let's just see that the
CI is saying~


Changes since v6:
- check all processes exit in flush_pids() in the 4th patch

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

 net/mptcp/protocol.c                          | 21 +++++---
 net/mptcp/protocol.h                          | 13 +++++
 net/mptcp/subflow.c                           |  1 +
 tools/testing/selftests/net/mptcp/diag.sh     | 54 +++++++++++++++++--
 .../selftests/net/mptcp/mptcp_connect.c       |  4 +-
 5 files changed, 79 insertions(+), 14 deletions(-)

-- 
2.37.2

