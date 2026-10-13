Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F310470E8B
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860220; cv=none; b=ozJ6+2+WwwWIu3uG6kwbAO/SBR4WY4w+0YRjufzmj8nJPV6H+pjpqZvkhudmPcmcnxMejGu9MqsAbMis5xOh/PGiPf0TwXIPz7sdj/SV5ijTbGoZLWbV9l6MmRbLAVn14zcDGmhqrOL0QRYOUXIDrWUBrtc3IlEpqFuZE0dj/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860220; c=relaxed/simple;
	bh=bFrz5wo7sCze2JWREtcZrtE56FE8F+IKrz09D1L9VdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q4rU1bTHOCJTmHu2CwsZDi6LALSwzW+h3MFu2vM23HdpChSUSqCX9xt2fEAbocIxfo8OHZr50eqTV7mv3ZNmRpxmCjeAFSxvoqhoOnN/d78eoPW5wl9HsOJvAuAn3cIgoQ5hUyz3zSY8TsVjvKJSIhKGlPYR1E0uoAp4V+cu1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQzzZ4Cv; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQzzZ4Cv"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-354ba08cfd1so4347498eec.1
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 19:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791860218; x=1792465018; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fHu9Ww8azyxyab0pRNKy6K3oj/2MCS91S9kwLy3/j8E=;
        b=AQzzZ4Cvk1wDVWG3mv4EFh8uin4AoKJBQOF6y+eZKzlJGZQ4c7hR+biV1s2+ttmWZ+
         BBLb73+NEYywNmV6PawVhhuF+X/j0sxwZbDWFJN5T21bECVyp8i3e9ZhhkJpJzwFCADw
         g3u+mAYKNe2MHYYpCOasnwq9XlSDegRS+CGJ+McOh9TgQt4zOwjVpj9cwXN439pnCwD3
         9QnZlWs1xpBjSdYl0fPVQoakPHRgNLZNyArcuCXALtBi1wOr3P2wYbjfB8qbnccLdMeh
         EhTKE5NomB22D3atdftvl6Vt8eYun4Z/1Y8Nu2j8UdR0eWQE9LswCIF12LY509EYSq1Q
         m5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791860218; x=1792465018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fHu9Ww8azyxyab0pRNKy6K3oj/2MCS91S9kwLy3/j8E=;
        b=z8hqccssr7dDQ5xNbGwEDIEK7D8CmaHeWUfnMscRLk+PWNLJi7b7Rm51GXh8QVHqyc
         aYPypdED5Sz+19X3gyOQE4Kima7yEFFqPA3BBxqNOgiZujD6XZvlaB5y/qXIJwtqbhQz
         ZyDymmfLf7slT0WkK/WafwOt5rp8qXgzjVFTqykT5tNDSiUFGaEWnCahFqw8HP8zPHDP
         8YIrFObCJYcg09fYvAvbo/xwWRTHc4cb3qkd9cp+/nV2y/afYwtYNxRNMss2rpCY34vM
         JJ0p8O7HzRRRQKbCNQaGsiB+mbMuhyXNdYXeWc9lrnT0uGzaxtSyz743JyVqpaWqMi8C
         yoJA==
X-Gm-Message-State: AFq9FYIprdhFL+Hajp/zC0wUAcddMo8KQmA0098HdLMSRWaJsXNYEqbo
	HYAtgKRVvTOfu5cWxreb+UeCQKhWbUb/WZuh2CAdqLGI//heI2T3qrNiDQOb/g==
X-Gm-Gg: AYBFou14GDVneAyf26oiuW9t03rKIFjE/yU1h43kIpZMvMT9IdNRm6d07Yil1crzK6j
	L435yrjlMIUBzJrCDTxOQRQbQ/uF2ijtxbYthptKp1ca/YtWid474WdpNSirPz/wsJM0/FAPtYf
	90Fpf2v6DtpltPcajPFkfFSn5qY6BLkmbZkvia91DOwYGWUm9cUgsJLqacXhK58ZqaSAi5L4/wj
	pOV826lauJGRnSy9SMlOcsY8TlURvxDL/tNvg6KPso2T6ZL4JeiHTw8dhtiD/GVLn71zeRpE1CL
	DPs7ezKEFxEq1/mgVGoEfx5FtMS5UfVq9b0897aQGa55a6LFyIr7d8DyDv5ed2ltbqftp4Zwjb5
	Xm56Fmj62YEcrVZbypaey9B071wVAVvwiOI46xsEUWZpu3J6wfZsMC8yDQigEy6ZqOMUBGSBPzV
	oCIyUWU8tSuTS6i8IcivR5HHheQ91uURvmZzt2t/l3Mjl+1XD3wGrrVTdC08iJCaGoVLNwnlpvu
	AOo2tM/SIyO1aIt8XRgfwJbqjeg43fx0LDIZFBy17ydkdlMup92Dy7MlKHQR1LrrsLECHDC0qhL
	gG5pJ0a6uvjqL3LZG5F3p/akgrcrLr8mE3mujc29JVE=
X-Received: by 2002:a05:7301:298:b0:358:bbb7:88da with SMTP id 5a478bee46e88-358bbb793e2mr11286199eec.32.1791860217988;
        Mon, 12 Oct 2026 19:56:57 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2954bsm39890217eec.26.2026.10.12.19.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 19:56:57 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [RFC PATCH mptcp-next v2 0/3] mptcp: pm: kernel: retry subflows closed after an error
Date: Tue, 13 Oct 2026 02:56:50 +0000
Message-Id: <20261013025653.523755-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A subflow closed after an error is never re-created, even once the path
is back (#440).

v2 has no extra list or timer. The PM opens a new subflow to the same
addresses right away, and if it fails, the same socket is used for the
next try. A new sysctl, net.mptcp.subflow_retries, sets the max tries.

Is a sysctl fine, or should it be a netlink setting?

Patch 1: I saw the EAGAIN error only with the new tests, also with the
retries disabled.

Changes in v2:
 - use the subflow sockets, no list or timer
 - sysctl is now the max number of tries
 - code moved to pm_kernel.c
 - Fixes tag on patch 1
 - one selftest with netfilter
 - Assisted-by on all patches

v1: https://lore.kernel.org/mptcp/20261012171740.464517-1-anilkaushikwireless@gmail.com/

Anil Kaushik (3):
  selftests: mptcp: connect: retry write() on EAGAIN
  mptcp: pm: kernel: retry subflows closed after an error
  selftests: mptcp: join: validate subflow retry after link failure

 Documentation/networking/mptcp-sysctl.rst     |  15 +++
 net/mptcp/ctrl.c                              |  13 ++
 net/mptcp/mib.c                               |   1 +
 net/mptcp/mib.h                               |   1 +
 net/mptcp/pm_kernel.c                         | 116 ++++++++++++++++++
 net/mptcp/protocol.c                          |   9 ++
 net/mptcp/protocol.h                          |  20 +++
 net/mptcp/subflow.c                           |  53 ++++++++
 .../selftests/net/mptcp/mptcp_connect.c       |   8 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh |  90 ++++++++++++++
 10 files changed, 326 insertions(+)

-- 
2.25.1

