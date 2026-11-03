Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721309;
	b=BamjSip+7+RS4b7D78bxcHD34JsxMV9efVHsE9QzOJSD5zpCLThuIOaJxTvIdxkjTKp7
	 DlQj2JZH6u2h5nE27+47vWN1GVzS/+NEIziYUd7XEDr/Fz3zlZXO6BhwUU8HzRxdisOsY
	 BEb+coEowybvzS43Bfv97JSeh1u7zlxYXRLQQnV3Kr0kjI8TYNIIaY2DXEGvE4QNW2y3b
	 EZlhpsKQbayWTV4HK0RVC4aT9pEj9CVSgS6aShH5MNq+iezq++yiUnukzc9VGAfivw0tz
	 XNui7OHtOWji1GihfyKpknebYLqmGFXpgEDXvz56blaYd7eAE2OyvChtv2tfhOawJ9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721309;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yaC7RemHrCY0ZTmPbLRW/qDx17GtrNAPuzVu4bchE2s=;
	b=yAcHH5N8SvjDFxpvfjaLahOIOgrP5xWPTliUe/vCn3HIagex08nQtutDiTes9Ifl+LhB
	 xE+8t1K5+T9m9ADSE5zPjOWDpoAFFyQRBldgtZ7ry8Ayoi7XPlA77E5/maIrZbZd+ncdQ
	 SNZQJqqJ5kpDyZZeplKIUScFYGn/INp/MofNi0rQSh3T6js95px7/JgxhkMO7R/PAO+Vd
	 d1k1+3AUmrFpGmYUjRT5HrNQtG7a4VjNOTs7HZ8dclqe9Z4igLXFAtjU5WuE5ZpFxj6sO
	 Ub1tVZ6EsregjaScTk5djkaoNQzhGN1Y9Q3h09nHzjn/XOwAPqWsRboHHnQuk5yWgzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLXgIEv2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F9606EEB6;
	Tue,  3 Nov 2026 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLXgIEv2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028791F00A28;
	Tue,  3 Nov 2026 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793721308;
	bh=yaC7RemHrCY0ZTmPbLRW/qDx17GtrNAPuzVu4bchE2s=;
	h=From:To:Cc:Subject:Date;
	b=hLXgIEv20wc45g5EP92/nbkUmcT8jSo/ey6cPa3pZL6+CRTUSwhTO3h+5/Jn2y3np
	 AAxaBZXOgQ8M9HZzxQlw6kZlQMep09bYP3TA2dE8micrX78ffs+6OXswRW3A0SDOwh
	 viU2bTDftxu5pJhWYV0iCTIaKRN778XFwJBGE2UHjs5Jz6Pch0qgzbhzlT1QsyxOTq
	 /62GxXwMEMN4HC2ZXzruD4sLfM7JWvKnAqYPQlxwHQb1TdOl+oNQI1FA3YbVsJgOIh
	 kz0z9Xo8+nhJe4hmWx7rRG7U+wB67m9UN12Vk0w0jcxNuKjPg3PjjtWwB57NYAA7GW
	 ItouEshxcpb5w==
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: mptcp: pm_nl_ctl: print sizeof() with %zu
Date: Tue,  3 Nov 2026 10:55:06 -0500
Message-ID: <20261103155506.534973-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 32-bit architectures size_t is an unsigned int, and printing
sizeof(struct nlmsgerr) with %ld warns:

  pm_nl_ctl.c:73:71: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Wformat=]

Use %zu.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with a 32-bit build of the selftests with a 64-bit time_t (gcc 16
and clang 21 with -m32 -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
KernelCI's 32-bit arm builds show the same warnings. The changed files
build without format warnings there now, and the x86_64 builds don't
change. The other selftests get the same kind of fix in separate
patches.

 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 78180da1efcc5..36a6d39b31bbf 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -70,7 +70,7 @@ static int nl_error(struct nlmsghdr *nh)
 	uint32_t off;
 
 	if (len < sizeof(struct nlmsgerr)) {
-		error(1, 0, "netlink error message truncated %d min %ld", len,
+		error(1, 0, "netlink error message truncated %d min %zu", len,
 		      sizeof(struct nlmsgerr));
 		return -1;
 	}
-- 
2.53.0

