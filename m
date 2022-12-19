Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28DD10EF
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 10:24:21 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id v3so5857093pgh.4
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 02:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PMY7Yj5zP9SERXR2hO7dFJ25r/PLgWbUujMeAkm6izg=;
        b=Bmmf4/mNWoWetRsmC0BwRJKU2J2H+qDv6ByjTM5RuOhNw6SqEVXrLAd3ptuYTx3a38
         itPlxaWrdueibAv1FFNVXFCqBVbL7/xSq32+IGc8W/ZuwUONEEd9FULLN7j4Ah86rwpD
         n9SC/7FokNOoHzEkqrgOcrHLAA26o1E2rI9i5sx2VS0iccMpEU6ha6qmnSxxb0oBDLos
         Q45ES41O+S/Kum7sQFKF211cfPIG73bXIEvxVGLBMsqoCi5KWhZpn9SvgGBM6otWyg69
         3XU4OEBtKOLkLwHHwk22EJQMkjXO94o4IOEq/gVuDTEuwbbncP8EcNb868LvAIi0/fR9
         VFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMY7Yj5zP9SERXR2hO7dFJ25r/PLgWbUujMeAkm6izg=;
        b=f81KgtoP8xgXFTxafQs9kPtg03u4X2erQgIOKJU07YFXR+p21azEL5wRgXOAU824JW
         YsMImmZMvpD0MnDcyTMaWczs2MStPkKL046pWbqG6u9xO8IEc2svMWpCTYuLBkQNm15y
         E8IZJ1XqpJ2kmMI/q1KFftv4yEI9fGCPUymJfs7eCS3Z2HPhgirabPliffKsVXp5j170
         pGei3o6leCnM+MX0kY9M2RZKOjVC1qP0AkuXyHXN5zLvyOmVNGW5SoSxXoSoPjFNf2t+
         HwI/L33mJqrqyBDPWM2q98oxjENVIviy0YDB9lZNNKAyYD+mYi4UQnc29g/w9Ntj7j0s
         t8lQ==
X-Gm-Message-State: AFqh2koQwVIw2uiUi/BzABy8Sonul0oIqtoz2T35HWYEmIJN2MZ3sjJC
	oZorogWQnjJBEt2jW/2+HnA=
X-Google-Smtp-Source: AMrXdXvhAUBRIbwuKHKS8DcwYKafomx9ZTTdOKIT4htC3oC5zHkhVVG8da6GN+d6VZGRTZE/DPTOTA==
X-Received: by 2002:a62:17c6:0:b0:576:c454:38e2 with SMTP id 189-20020a6217c6000000b00576c45438e2mr7686773pfx.30.1671445461133;
        Mon, 19 Dec 2022 02:24:21 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.23])
        by smtp.gmail.com with ESMTPSA id n5-20020a056a00212500b005775c52dbc4sm6206517pfj.167.2022.12.19.02.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:24:20 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v10 0/6] mptcp: add statistics for mptcp socket in use
Date: Mon, 19 Dec 2022 18:23:10 +0800
Message-Id: <20221219102316.627491-1-imagedong@tencent.com>
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
with 'sk'. In the 2th patch, we rename 'sk' to 'ssk' in
mptcp_token_new_connect(). In the 3th patch, we add statistics for mptcp
socket in use. In the 4th patch, we init the 'sk_prot' field with
tcp_prot in build_msk. In the 5th patch, we make mptcp_connect can exit
when receive 'SIGUSR1' with '-r' flag. And in the 6th patch, we add the
testing for this commit.

With the commit e8695e504942("mptcp: don't orphan ssk in mptcp_close()"),
I belive that the testing of diag.sh can pass now. In fallback and
simultaneous close case, the msk can't release normal (sometimes?) without
that commit, and makes the testing fail. Enn...let's just see that the
CI is saying~

Changes since v9:
- rename 'sk' to 'ssk' in the document of mptcp_token_new_connect()

Changes since v8:
- fix the panic caused by mptcp token KUNIT tests by init sk->sk_prot in
  build_msk()
- check the state of msk instead of ssk for listening socket

Changes since v7:
- remove the MPTCP_INUSE flag and do the statistics according to the
  creation and destruction of the token in the 2th patch.

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

Menglong Dong (6):
  mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
  mptcp: init sk->sk_prot in build_msk()
  mptcp: rename 'sk' to 'ssk' in mptcp_token_new_connect()
  mptcp: add statistics for mptcp socket in use
  selftest: mptcp: exit from copyfd_io_poll() when receive SIGUSR1
  selftest: mptcp: add test for mptcp socket in use

 net/mptcp/protocol.c                          | 25 ++++++---
 net/mptcp/protocol.h                          |  2 +-
 net/mptcp/token.c                             | 14 +++--
 net/mptcp/token_test.c                        |  3 +
 tools/testing/selftests/net/mptcp/diag.sh     | 56 +++++++++++++++++--
 .../selftests/net/mptcp/mptcp_connect.c       |  4 +-
 6 files changed, 85 insertions(+), 19 deletions(-)

-- 
2.37.2

