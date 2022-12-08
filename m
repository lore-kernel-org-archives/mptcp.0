Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03825370
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 02:46:28 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id 62so99254pgb.13
        for <mptcp@lists.linux.dev>; Wed, 07 Dec 2022 18:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AcyFgJUJIzEqZi1NqQ6ikanQWhPq38fNHFeJLV3etxs=;
        b=EVnw5BB92dZZ3n8epil029d7Hq4Ro6NAbYKhfUryRyy5Nj91oTy/51AYDYtf2A5FaU
         yCM3QwObhJFf/FiutMpkfCe+hgXlWok/7MQ2Q5awIM2yjYDrKcWjg4n8yAHRlTSnTBfo
         ZGZoBnhkwi2wWNr3sin4cBXrlkUiewlUbzM8syaV+7dCRbrhI/WXYCQB1R4t2JgX03LL
         tiBTjZcpz2+mROoNGC0dgkqp3n/AhuFkWpiLvWEszM3K44Qp7w7u/u/ECauvKvP9yVhg
         w7vPMHxtCozRfVZyrPgDlqb+7Fgc+tBZmBTargKsh+qWkTBNVbjTr9vC9gnnPyb1siTE
         Yi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcyFgJUJIzEqZi1NqQ6ikanQWhPq38fNHFeJLV3etxs=;
        b=XYEHgJuawXq7sSTPHDxyhFF3bEpPXXDJFR1aZM/iOUa1ss3fLT+KQkTRVPayCvOleb
         uS81CNxqxZFe/SNt2Rl6MhhpvGg6A+b/5iV44UTHw6nDap85xnhJPG1PGaGoX8DFevp8
         FM5PFUb7h2Qqsgpi5R3/GrdkPX05Yf+eO57USadblkw2pijCUB3OIBVtsiO4NB55wNN7
         o74jnQmRApoFanzPCdH6rcr2MoTcrTg7vgRURkMSAIJGjNS31J1KA2GEcbrMPu7Yfjcx
         fgowXqDJlH+GJnTjigkMuquoQTkZzoLkTor8LANIlCzHliGoXrw/pzCCzjwZdHfY1JrJ
         PAJg==
X-Gm-Message-State: ANoB5pkLr6hV4SYYjMozuFIYnY3ZDN6Ch79lXc6dmyVPi3ZlpieDAdeH
	LqsWoos+VfkYYtP7F/YepQs=
X-Google-Smtp-Source: AA0mqf5JxwGairpRXymkLi7HNAcmn78AQqGLiLk4K/+G7pbaeyEJxgOC/GPFbfyXV3OKTSTWuxp0JA==
X-Received: by 2002:a63:1747:0:b0:478:1391:fd14 with SMTP id 7-20020a631747000000b004781391fd14mr45393931pgx.112.1670467588350;
        Wed, 07 Dec 2022 18:46:28 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.gmail.com with ESMTPSA id a26-20020aa78e9a000000b005769cee6735sm8606394pfr.43.2022.12.07.18.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 18:46:27 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v8 0/4] mptcp: add statistics for mptcp socket in use
Date: Thu,  8 Dec 2022 10:45:39 +0800
Message-Id: <20221208024543.113633-1-imagedong@tencent.com>
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

