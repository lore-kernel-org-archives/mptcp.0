Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86564C
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 06:11:50 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id s206so1012184pgs.3
        for <mptcp@lists.linux.dev>; Wed, 05 Oct 2022 23:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=R9htzrpnCpEqGGCISjPG2gaHurPUyMlK1YX4JqddanA=;
        b=XhHESmosnZBZDaIvLGVvS32ReLYwZYAsD3MRzjfv6xwZQXLJS/hG7Ah3Wv6ulAddCK
         CvFDKnfvjrjoH9gjkzKD7Zz8l49vSk5fY9f50/DZY2w2qjWURepXFvQTXWS111mjS9DG
         X5TUKqTKwXYXWbJzYIXVjFDmV8HY83LB8nNLnw+QpMy6aK7yeBbRKIDlTuYd+iQBpaIN
         rDnNEmcjjuEu44uZwHXwLmCfTKh/GHKk6e1uFSPRWCFm57lh7HChDwvbbnBakakKfXL4
         Zz9XPeKCQCE4i8yMQUc5Vy8nJThP75CtmVV+vNwMnlDByA3FKsArW9DKxn1BJMG0cDSk
         +vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=R9htzrpnCpEqGGCISjPG2gaHurPUyMlK1YX4JqddanA=;
        b=6NHu3SMDnBHzun3IaPIEaGpGA+OFkqdDbrHw0uBjao+IuLQavVulYSTxxaoHgBdEWW
         qxoAZJMCdejAhqx6jLEBovvaZhaNWtoJXfpLfW2GuMrio7jI3/P2CYZrDFKhOnTNZd9X
         6xu8Mtfal397iDS4iaODZxBSwi9FOyvm9bCSqRJaIAVG8m5ytdAanUtAUw3Wf4coLFWX
         oXD61iBNrVN5ltB3EOqKTHN9kBfv0B5UAyyx3p6RFreH3PWfQ6GdIRctRZ29+7gcHErO
         k6Epy29RC+PnxHum0M2+F5BU9D91bsxGXWQ6O30ZKQArBt2NJtsPc/uY/Tw279xW1Cu7
         sYGg==
X-Gm-Message-State: ACrzQf3leBwIbpJU2D+zdRgdMkTIP3GCBImTaSYjjhYijNrUhu6SLMlT
	Gwvbeq4Pb11HSiNPnXOE+B0=
X-Google-Smtp-Source: AMsMyM5XsVJi3eSfObvteRRKwZuAP7/yOagyf8vW0SCJkNdWHW2lQc9nKl6rAEgEThnsGA5r+48XpA==
X-Received: by 2002:a63:1608:0:b0:45a:355a:9420 with SMTP id w8-20020a631608000000b0045a355a9420mr3140389pgl.354.1665036709761;
        Wed, 05 Oct 2022 23:11:49 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.12])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b0017bbd845c17sm11398046plb.158.2022.10.05.23.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 23:11:49 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v4 0/3] mptcp: add statistics for mptcp socket in use
Date: Thu,  6 Oct 2022 14:11:19 +0800
Message-Id: <20221006061123.1474224-1-imagedong@tencent.com>
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

