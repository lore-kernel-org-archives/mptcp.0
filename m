Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53F2236FA
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174669; cv=none; b=cG6tJ0b6ObBlpBF5Gf8r74yUspJSU5FvgYcm1HdhG/ZLWsRCrFoCI0ub+jnPOVgWBIOOv8Kyd7TEeCs4hHs3LVsFDvM5sCYTISA/AnmwtLAsb0zbEe/WjYsij2+jdRjnal0jyw9TU9V17gJtr3B1IumUYGgUL+Sfmrj3q4gq0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174669; c=relaxed/simple;
	bh=JUk+V7+BC+lkMoAifGFTRedw6UOHlW97lAtjujuGo3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZm/Qg+UkFOnmtDi4xPwHhV767aUD2uTfGJQSbYShpc8sPdrpxuO4LHTG0HdDJmjQppq6hSQDX9mQd3lA6msjvj6RHB33Lat28BJ67S8N/L5m5wMuKVpV9Lw0rdbi64K8lOl4ATxkr1Gclbzpop0RFKEytUFudupkI7FZjeUMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzvjDQDN; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzvjDQDN"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-340ba29d518so4438530a91.3
        for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 08:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764174667; x=1764779467; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YOzfVQwGYNqC1lxFkH12YuFq4cbbjh7siJwig+OWKTg=;
        b=kzvjDQDN/mPRBaW/3ojKZ9KEpUlOZnEMhwqAkEWvIOuiHZUWw4D9uMPeCL95+6GpCv
         N/H3YI1ZqqgNS5hajaF+0h7/xW+DSiUFFO6eS86mC1+Sw1jCU0UK3QiOgqRfuLTW9suG
         F0LHu6VeuwNGeEanzCuyzsglyz4W+3gJ5JUWy3OyJG63nmscTH76YeLKbuRBzViTiVB2
         g/EuLcT5htdQUZH0TpONkZr3gxbChaNDaxcN/0JkOXFW9UXVJ+8leNyXuSVa/PYVPbNN
         iRaGThNLJNVbVqJwelgPz7LX1Ft9ERU82oOfe+oWlAICOcOxyp7ssqmM0Rhw0rQQ84IL
         OHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764174667; x=1764779467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOzfVQwGYNqC1lxFkH12YuFq4cbbjh7siJwig+OWKTg=;
        b=TYwxVy4lYnlraV6KLrnV9V75/8q1fGxUpN1XrjGFQztUegVo5e7urKrGEvh9QpHSh/
         E60tUsxF2hl4Fcv6ItVrdTYTph+Fia4bSOw8OhoIRS7TfimML8ECK6yk6GhRtpsVnPO3
         ZJPXt05lRJLzkneWNRcNDOWO+0enlqgu+XQLPOmwzz3CGQnByVFwFQX6Z+YOw2UmNBau
         HrHj+ljWC6BC5PSQTswXM3ZukkBPiJClk1qO7msA4dippX/BAPLeTc60YiHutMbXv8vt
         Kaz/GSRtCN9wZGgAjU0syFrKtKP63VIzMB/1WLCrvrZfNwoB19IZ1a/8UpK8/2mAN532
         YIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIsodDG0oR58hrWzfbZp5aMoIy9bEYuUiOSrjJoIbu39fZG/4dgsh6O941Vj/tEHwXCaWDSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZ7sBgqg9yLrbimVxKvCO2PBTKx14Pa8m2N1ujstASy8Qiba3Y
	slU+QANltWxSPl6bczTaeffRFoM5Aijp3t8AG2KDQx2z9Jgcdwp/bS3w
X-Gm-Gg: ASbGncvU0Qp2JrjwIX8OK6tJ83PuJziP06d+HFt47OIj1ZyYh+XOSCitGbTfKF2b1T3
	7Z+kDPm5Xlj498KoPVAv8901VeMxPj4/tt24KNpWlNqIUmpKOIfTtlzhB1bKm9XpLCuY7cqjkIt
	3APbe3X9pcMV0WGXFOlfTd4+O68MfJAtI8JVogntx/y7m2zE+I0zSaZ/y8solrBU3wVnsg7115X
	QTgWLxgBi6YjxYxeqhZl9xSwL66twGl0V+pI/p1k7RNDZinSLLcgWEYvdoUYNGEgPxtjQlNNwjC
	Ha/jTKoDkJyNXoNoGa+Q7YuQaXZTqN/S+j2oV1hwl92oNEYndU+BL1K/ljTq/FD7NYpN3ej2nsn
	g9Kc/SYOW1ZpP9A434JljqtESOSKfa9Dg/lZ7p6g95LdCIYzx/WntgjuMK/0PzH0xLqHAWR1qSi
	CZVZS+RIMeLsHirXoVexjYnGNiRVY5Dw==
X-Google-Smtp-Source: AGHT+IHYlOs7ib3WRoxz+IosxSmgFDE9P7H1+e8rCoPRGJ8hqrHc7dD/TBxgldig3bre3IVxR56yzg==
X-Received: by 2002:a17:90b:2247:b0:340:f05a:3ed3 with SMTP id 98e67ed59e1d1-3475ed5141bmr7678530a91.17.1764174666979;
        Wed, 26 Nov 2025 08:31:06 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fae9e2sm19829401a12.31.2025.11.26.08.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 08:31:06 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Shuah Khan <shuah@kernel.org>,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftests: mptcp: initialize raw_addr to Null
Date: Wed, 26 Nov 2025 22:00:46 +0530
Message-ID: <20251126163046.58615-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "void *raw_addr" is left uninitialized when else path is
followed raising below warning.

mptcp_connect.c:1262:11: warning: variable 'raw_addr' is used
      uninitialized whenever 'if' condition is false
      [-Wsometimes-uninitialized]

so the fix is to assign *raw_addr to NULL to suppress the warning.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
compiler used: clang version 21.1.5 (Fedora 21.1.5-1.fc43).
compilation cmd used:
	make -C tools/testing/selftests/net/mptcp CC=clang V=1 -j8

this maybe also be false positive. But somehow clang - 21.1.5
triggering this.

---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 404a77bf366a..cdb81e0d08ad 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1248,8 +1248,8 @@ void xdisconnect(int fd)
 {
 	socklen_t addrlen = sizeof(struct sockaddr_storage);
 	struct sockaddr_storage addr, empty;
+	void *raw_addr = NULL;
 	int msec_sleep = 10;
-	void *raw_addr;
 	int i, cmdlen;
 	char cmd[128];

--
2.52.0

