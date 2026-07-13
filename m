Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C755831715A
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913163; cv=none; b=iTfYziBIbmEkRGTjYzgwTTBKZLtmbIePp8hOxy6TPyMHE0XN0Wl5sv4zoLYLQojMN3hiAK/Epds6ba84CxI7EEhcqKvHm2K11R1HL/+/cF7VmKc8ZMCKF/gEdnmiZVUOffQbwqnPGLJ+lpMEb5fCn9MtLYV6h5HzWtiirxtUda0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913163; c=relaxed/simple;
	bh=QoqKXbemCwi8A0CaldJ1rRxMaa9Qma2R4YQoUQOtCYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWdyHZDK8G39mRZEke30pYYfzSAEnRCqVESiTuVJJabkYJ7N7z9VUSFg2M3mWCAfa0gikD7yynd3sP/S78o9U39kQrOoXcYEeQ9fXO7DbrTwrDO/QZHGHYi2mKaOqKESs7AUNKBw7nafbwj11RQZBad38AtXjq+4NDCsrxIKF/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoDV720o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoDV720o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FABE1F00A3A;
	Mon, 13 Jul 2026 03:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913162;
	bh=9uDDnXc6/OcJkBmk8OyibhGoPv0GFXCaNHt108Mw8wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PoDV720o5ONuPjfmHkr6a9MEdgGw9ctonYSW0eijdb9qCqFS/8/MRx2vSxgOfk3n1
	 hLor5Qf6bZQ8qM7MsyiUv+CN35tVbY+dEoyn9fWPRy8DOha74reeKL+z0jeeyGFPQZ
	 zwpFtR4R4GCGKXmH18Ssf+6xvl46383IECzvSn8OANCkQppqF4GjZLCk9P7j5g+yJv
	 x1kFUapBQWDC9cMKqnALheeRMqIXclcnen1c5qFbHvaah3TuaJNnJi6slAHnWanfjG
	 IROJ9HivEYw+0w8PIBZN/8C/BKCdLSne1trLpXcw6GwNKZoWLkBsTWFcjrm82zRkac
	 rsf+FSl+ld92w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 09/12] selftests: mptcp: sockopt: read exact payload length
Date: Mon, 13 Jul 2026 11:25:33 +0800
Message-ID: <079fd762433db0f6559df88a9725e300f06349ab.1783913010.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783913010.git.tanggeliang@kylinos.cn>
References: <cover.1783913010.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the exact remaining length ('len - total') when reading the echoed data
from the socket, instead of the full buffer size.

This silences a false positive -Wstringop-overflow warning from GCC, as the
compiler can now prove that the destination buffer is large enough for the
specified read size.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 9a8b60512f0b..2540516fccee 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -638,7 +638,7 @@ static void connect_one_server(int fd, int unixfd)
 
 	total = 0;
 	do {
-		ret = read(fd, buf2 + total, sizeof(buf2) - total);
+		ret = read(fd, buf2 + total, len - total);
 		if (ret < 0)
 			die_perror("read");
 		if (ret == 0) {
-- 
2.53.0

