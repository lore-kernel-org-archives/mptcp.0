Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B137E1841
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 02:50:27 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id x1so2833110plv.5
        for <mptcp@lists.linux.dev>; Thu, 29 Sep 2022 19:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=2Ne6KSLyT3zg+NeGqwFB/XG6YYok1S8UbVWaP95BxFE=;
        b=KDkwpK9TDhghjyROkoiiqjTvi8kqcwROG4s8+9SgKWHPrrQDR1pWeENGXJm2UWEGs8
         g2ssmGzzdMxqbj5UnqimxKRf0qWtcNqSqXlsoC9Z1oHAy39IHzW43V24ipu9mJscSP94
         RvpJnTCMPZ1IHFKF9uuu7zZcSgCYLezyGwoVWwoh/JXa5CJfmU5uBD1lZrWOz+aPoJVo
         0nmtiPom9J+0pcB3L54t53BZDQod1i1WXlhEB9iEvrBUQu0XA3jGij8zzEA+5nG+E/iS
         mTSDV/FJ1gEb1s1+CtfMBcIuMs28CCx/1jpLvlimKV07lIlQxRTbggTFlaxbe1dpLlhf
         tXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2Ne6KSLyT3zg+NeGqwFB/XG6YYok1S8UbVWaP95BxFE=;
        b=734Hb3CwMgJtTlhT3NJxdpy7QIwpyd7325IwYlDS3hwS20xalrnl5YWSP79C/3KnLk
         SDNwJUemu4eEcY3TvYkDmuKGDvSaUjbrJOKmvTSvCN28e83rUCfv7DBXSmaQPEvRUDBm
         4/cOk9SC3DQg4MUze6cLbIOmtwtn54tUvXnw+5odiv4L2eVNU6IXFn2KQhR2qumxFhOu
         iDVO3VAn5NuilSTUGHetfhxxufvEkA3gKx+O7PYP1EroYNOWVq/7W1ChDlMI2UTDwjcZ
         3FCJd0equWTaCHesSGvGmLN7OSYAnpEgThE3Q8F5Db26TFYAyq6og/1CU1Ei35Hi/ET3
         qKdQ==
X-Gm-Message-State: ACrzQf2vBeQuELAls3XXOIYkTzs9Q/66sDaXK27G760zySxQHxt0M8C8
	d6LbldRpD3MOW7ZQjR343go=
X-Google-Smtp-Source: AMsMyM7SSYnruyK2OdiDU2iumuUJPsboGBNgjdO+iOgMdIreaORqsRXMIc5LKhpXYvuUTTKEZ3Pb9A==
X-Received: by 2002:a17:903:1109:b0:179:d220:1f55 with SMTP id n9-20020a170903110900b00179d2201f55mr6456267plh.42.1664506226957;
        Thu, 29 Sep 2022 19:50:26 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b00176d218889esm606911plh.228.2022.09.29.19.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 19:50:26 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v3 0/3] mptcp: add statistics for mptcp socket in use
Date: Fri, 30 Sep 2022 10:46:04 +0800
Message-Id: <20220930024607.128202-1-imagedong@tencent.com>
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
use. And in the 3th patch, we add the testing for this commit.

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

Menglong Dong (3):
  mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
  mptcp: add statistics for mptcp socket in use
  selftest: mptcp: add test for mptcp socket in use

 net/mptcp/protocol.c                      | 35 ++++++++++++++++++-----
 net/mptcp/protocol.h                      |  1 +
 net/mptcp/subflow.c                       |  3 ++
 tools/testing/selftests/net/mptcp/diag.sh | 28 ++++++++++++++++++
 4 files changed, 60 insertions(+), 7 deletions(-)

-- 
2.37.2

