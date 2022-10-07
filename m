Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92AFA4E
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 09:31:35 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id 2so4160072pgl.7
        for <mptcp@lists.linux.dev>; Fri, 07 Oct 2022 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pfsQ2LAO7AtCBzxRgL0oyELKFtjPoOjRhQKgX10ycNk=;
        b=VR1gtafpVwu7kX3GzyUprY7IOrEfdMLXPh+kJKhWMOgcvpi5MWnJz35xrpy3ebNdNg
         l8Ur3bc76P3D76UpmVkoUNdndo6f7GqMR72bi8IMFmJOs9bTYHRJ3RZyhyKSGNt/0lXP
         FTIpVGF5aoPsZVKodDi5lhDjwYNIs85UykbLoS8qBOJf8v9Ps/jJ450d4rLr6l53mYJP
         pqOmeNUwq6MnWI/cXSa59nU8fa3MgPF2YrvSw0WzgTfB4VitiWzvlU/urxUVOoIExmW1
         1+WGGWW8aseP1TwWnEcyd9g0DEyAmIQnhVounVwwzE5rzvxAzVXYFOHAG7ONL++lxZ1k
         PUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfsQ2LAO7AtCBzxRgL0oyELKFtjPoOjRhQKgX10ycNk=;
        b=0uPP46Ukq5ONpgrvkBtNm07UulQ0YOEZ09szNcoxkZiedUc3UWUA2LGsy8O/GGlaio
         ukrzZf/C4gBWL+VPkYewFAUDpUd3KSeb4GUlVlXPVAf0vO/aLMW4uKPL9eeGu/3TD8k7
         UicgnTyoWbczGxhrDi5o7lLh7StHilRIAysbqgrqvFzwhWi66ESJyrP5AS1+avf0mVMM
         FHfgaSyKMY6yhNqTg0W6TPgVzEoVfMVlIr/U0N7UuuuIbkJVL0sbLwLmwEw2+tTAN5z0
         XI/f9zWV5dWw67ncT75hO9gLbArSk0iGxbXdySNVFndP0nGP6KdZwgOgGWy3OGl0HmGp
         kzaQ==
X-Gm-Message-State: ACrzQf28eXbOptYyuiY0tFa1KTqje8QGH1+aPR2kj6qLNWxztaXEYctM
	hS3bOvxcYdjqhWps6nAc8uGztHX67k4WGg==
X-Google-Smtp-Source: AMsMyM5yHYShYlEdLW0mqjxy9zn2oOJ3nAcBYIZsGCLj4+hS63mEFUn3ER/YfsMZ8uhvVCKpUCuqiQ==
X-Received: by 2002:a05:6a00:1989:b0:546:410f:bdd2 with SMTP id d9-20020a056a00198900b00546410fbdd2mr3955945pfl.83.1665135095291;
        Fri, 07 Oct 2022 02:31:35 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.87])
        by smtp.gmail.com with ESMTPSA id 61-20020a17090a0fc300b001fd7e56da4csm4187421pjz.39.2022.10.07.02.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:31:34 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v5 0/3] mptcp: add statistics for mptcp socket in use
Date: Fri,  7 Oct 2022 17:29:19 +0800
Message-Id: <20221007092922.13169-1-imagedong@tencent.com>
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

