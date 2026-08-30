Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3B29E10B
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121025; cv=none; b=sjP+XNeznbi8mAsd2vNuHUgv6Kik7f+LHIQ7sX0bZp8zPShQJqSd6Yk2WDhIGfNyTy+yCHpPkKisr2CEJYtSnUlu/TYWn/qoK3VSjtwLnndN7buf6w9zRYI3jyoj9Zf5Mmwqa1qFgNVRIZT+T5xTiT15Qdq+VmuhjtKS41czV4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121025; c=relaxed/simple;
	bh=e1JVroCpy0yxR3TLrzWrxJUaIa9LSvQI5OwiRs8w1Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtZhIy4VMyCzRXLC9PKHSxy1g1cIrik7Pc+Mnhz+P/64aKQAypK5/LON/m8AcIDuk09fsRfHl5g79JDnmdZ4EWunuegDAre90M79qfP7YW4DHNARsW9vwE9tqz742Qw0PPKwgPdG00yXn5Dohe9perg47VnKgMRW9HIV/1ivW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rq/BSMLy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rq/BSMLy"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b8be0409fso16089595e9.2
        for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 13:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788121022; x=1788725822; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xRwk2mxThRhdae+9PHJjX8tprSZn9ioaIXoGdJjtfRc=;
        b=rq/BSMLyuWa3JPRmhz2nOTPqqKFWTPOfOiluilFVEqYlih/aNQ1vkfeO5iFtr+Ff2d
         wRt+yUQRwdIKJDndmwYBgRvdxPisJRFnXNAlkbUu5dZ0NMNyQcvOxD5U1GyHze9fYysD
         IDihErJYrtl3ybWWTvVsSUGh+y7NMI9eRPpNQp2rXRn3YvuqxwBnY8DHgom8SNWn8qHu
         +4o8THYNN5CR0N+onWVrRk3p5V7vxej7ZDQRjL1V7NSLZ0Ip9bJpuYfr5ytseRcEKJcL
         rLn763pbMo3HS8tf36sPpzFV7STSn0Gm+JfdDT/pNH8Xn0KzRkqKKey0/yngPlzG201A
         uhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788121022; x=1788725822;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xRwk2mxThRhdae+9PHJjX8tprSZn9ioaIXoGdJjtfRc=;
        b=eRZhdm25Vb/0STQ4GuIr7PP+fGXCpQbiGoyAzYVuwNJ6jlsDTI7+JIoZvOihjxlAbg
         qNLglo6MO4y2Vyr/OcNS7RhJvqexU7/twkGr0dC3quVqtoBOM6yAIx6mAgoN68ujR4x0
         ohmIfvWKbsxj3HlaQG08iUuAvKMtpRAKLMKoTsUu3E41/4n6B99rZi3L0nAHGIMeD2ID
         1xgzfRynkNEfD/N98PqCF6BdQtDWazx0E/2L04Qgf1h7ZDLgDyROMz1Nm22/TZPyPd2u
         ww+j7oU/rTkO5/CvNaS5O9yBuelH9n88EMT7DfzA3QSAnf4evxMdZvcQfK3Bp3N2rTd/
         L9KA==
X-Forwarded-Encrypted: i=1; AHgh+RrXzcADpi+j0/dfxGu+ILOrdnfcg3WmAY0UoyMiVYIq9e5JZ18kL2DYc8E45AdLDoWe9d0lbA==@lists.linux.dev
X-Gm-Message-State: AFuF++n5TKyyhzOt9ky10kuu6JBGTOSqFny26PnwZt1b2+/gkNtk/vNx
	+Xkj6udFPXaKDQIt8M92+f//ygyJmjPgVJzfExD+LOd1Cgv/jEsrJUNgP27iSELj
X-Gm-Gg: AR+sD11jzOhgSrcj8vfy586+W7D+BnzHgX1ovfdEFx+QkuOzbkDOnj7pMzRrw0uj87o
	MF+IS8wSAPVm94Oi8+Y2EpU8jvbyi+JEdDhOabxYouWxLPX7S0EqlUdWD9kDA+MTAkpDfkTseZl
	8HaSsYnfyVtbnUL2E6/xMS2oF5IT7gzexHSvcyswnafqIxA/UIoAGB3p6D+9B/QFoJ8BhMbV6cq
	aMdRTn4JAZduf/oZ4+3zlmt2BU05pw2Pr0OmunUK/CtEpTjK6qF+cPKBjuP4XL0qsYzE/mpNIVB
	rJw1+TsShGLnl9E47UIJenNWwr9GbKWtfd4VP2pGRxryuHORGMyxwaxd+8VoL5uhMBgLNXgwoxv
	2tfgO911ja51nnuldFKYprjsorlvwo3RC6eXGN7gAVv8pqB7GM+Vhp0yxggaVnkMaq96Ey80CQ7
	bdlxdmzd2/j9EPH67FpRB1EW0/bbTAWHQGVEC53Fae0BIE/28n4HuVSBqsUlnFXZu4EBAtJHeJh
	3Uk1YnVyjWAkA==
X-Received: by 2002:a05:600c:6215:b0:499:5a50:b022 with SMTP id 5b1f17b1804b1-49b91c1bb18mr334176195e9.3.1788121022190;
        Sun, 30 Aug 2026 13:17:02 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c5790csm193360025e9.0.2026.08.30.13.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:17:01 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH 1/6] samples/landlock: Implement best-effort fallback for network rules.
Date: Sun, 30 Aug 2026 22:16:45 +0200
Message-ID: <20260830201650.67050-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830201650.67050-1-gnoack3000@gmail.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The sandboxer sample tool added network rules unconditionally, even on
systems that only support lower Landlock ABI versions, resulting in
errors.

This change implements the correct best-effort fallback: As on older
Landlock ABI versions, the given operation is not restrictable, is
also does not need to be allow-listed.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 samples/landlock/sandboxer.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 030583273f3f..1c514efecafb 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -198,6 +198,10 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 		.allowed_access = allowed_access,
 	};
 
+	/* A rule without access rights and flags is a no-op. */
+	if (!allowed_access && !flags)
+		return 0;
+
 	env_port_name = getenv(env_var);
 	if (!env_port_name)
 		return 0;
@@ -657,19 +661,27 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	}
 
 	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_BIND_TCP, 0)) {
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_BIND_TCP,
+				 0)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_TCP_CONNECT_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_CONNECT_TCP, 0)) {
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_CONNECT_TCP,
+				 0)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_UDP_BIND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_BIND_UDP, 0)) {
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_BIND_UDP,
+				 0)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset_net(ENV_UDP_CONNECT_SEND_NAME, ruleset_fd,
-				 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP, 0)) {
+				 ruleset_attr.handled_access_net &
+					 LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
+				 0)) {
 		goto err_close_ruleset;
 	}
 
-- 
2.55.0

