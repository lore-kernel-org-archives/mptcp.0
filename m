Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10433ED2
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 07:51:19 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id t2so8254812ply.2
        for <mptcp@lists.linux.dev>; Sun, 18 Dec 2022 23:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YIlTivSSiNWf3l/eK8GSonHjpbX9UWgd/QlIKgnsHKU=;
        b=Ul5kLMZ4WZzz/77U7xFNuSKU7GBoXgRpOeAHrpBxZBtukCpOS73Sv/jEPCpDq4LSNC
         pFEKFD3OlgGUToN/sR8TISVds80YOBK1qM4YOln7fY5K7rS/pOJ3JJ3pDpnHF3ToAe7t
         uz1h9TMeuCL9j9sDdOsMjYqzukkwJ0INZaaO5+leMGsufyY+5oxnazfPJx4bcJjQCixN
         HGEIJshMFNJpxilff9wB2y5ASHdDNhAftcUpe5gRiAHokeXbKyvHw7z5if7Jpy9nw5T6
         iT5/LljfStfx0lP1MZm/G9hriPWoVg0pT111/mgNf5Ym0y5mDoRhnDzuHVbxttDsV+8I
         pLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIlTivSSiNWf3l/eK8GSonHjpbX9UWgd/QlIKgnsHKU=;
        b=zMt76O7LY2572M5NzzOnyXDS6AOVSswOen5F0KpFi1lrUstrgOFYMnwOTYAJU0T3pF
         hSx2NbPYVCTeVY3LFoxTmDEVtHFmMUClD+tdvMubmak3Z17jbDD8ZkCVXbJT88I6cRdE
         khb98Yh18iY/eJYpUE2/0fhUomMajLuReSIOPOiDjZ2/7MmQmsEflFr7q61vv2g2LvM2
         SA1hi69BxxbP+um/7IeXCnGRC5mOFIcLR3HvvDiD5xbPIo6bn5gfPOJmrspXstLVtW29
         xb50BBpN7/ZTl/pIf4ehZ/DSQe3o3Cm3jg1N++2WwvtnDkSTC+fQKnGmeEzMifZ/Tdnp
         uEvw==
X-Gm-Message-State: AFqh2krNG5xC8JCYoTca14X81JQByn/Z8Ym9id974+eBsKYburL/Lq7U
	X78Zghyib/hT7+p0Wu1UvZU=
X-Google-Smtp-Source: AMrXdXujjnpeMAlPrh9VSK20NBNQxw8rNs91aSn12yGTS9zXKP5v9inhcvFuOnWC5Nz5dVgLlQtxPw==
X-Received: by 2002:a05:6a20:af14:b0:9d:efbf:816d with SMTP id dr20-20020a056a20af1400b0009defbf816dmr8063821pzb.54.1671436279319;
        Sun, 18 Dec 2022 23:51:19 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.21])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001888cadf8f6sm6366673plg.49.2022.12.18.23.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 23:51:18 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v9 0/5] mptcp: add statistics for mptcp socket in use
Date: Mon, 19 Dec 2022 15:50:42 +0800
Message-Id: <20221219075048.255811-1-imagedong@tencent.com>
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

Menglong Dong (4):
  mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
  mptcp: add statistics for mptcp socket in use
  selftest: mptcp: exit from copyfd_io_poll() when receive SIGUSR1
  selftest: mptcp: add test for mptcp socket in use

 net/mptcp/protocol.c                          | 29 +++++++---
 net/mptcp/token.c                             |  7 +++
 tools/testing/selftests/net/mptcp/diag.sh     | 56 +++++++++++++++++--
 .../selftests/net/mptcp/mptcp_connect.c       |  4 +-
 4 files changed, 82 insertions(+), 14 deletions(-)

-- 
2.37.2

