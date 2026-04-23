Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4361DC9B5
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926087; cv=none; b=ZvlentQhMjmvlS550XYupSUH0rNuk9icecPQnxXBU5Sxc/+dztD18aFn0ymgcvJfHx2Usm52Tt86WHgoFlmhoLX9hgLhGXe0g8H2FdxUer+6DMV/92bRNmWDk+bwtNv/AL0jcutz26O5BHAy8JHPOAWVaajThp0xpr31EHlBT0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926087; c=relaxed/simple;
	bh=z/yvkHNvige9dyxFq56fUlVbkED7pVLPlli991d36f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bX3LFC09S8TzSjVYKsPWYSKsdlBC5yAmAvHxxcMXzGeoqq3LmkOrFcY32/E2GmJqhWwopJ6oGvWcq4xe7/7td0wsoEpm9edfOwf9x1ElWMEgk+2JONYFNQcKsvK2dyXB3SPL0nkhejYRZ3BwtcvkthigGN5Vy/ASPvDCuZvhlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIW8hT78; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIW8hT78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7810C2BCB5;
	Thu, 23 Apr 2026 06:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776926087;
	bh=z/yvkHNvige9dyxFq56fUlVbkED7pVLPlli991d36f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIW8hT78qfuof1zYbAZsmqWaPvYBbvIF6WIKXBqclSgaPSGBx3U/t+toOTqwCAxzp
	 f2Lh+D+iGY9FqpL1h7lVyCyb53feOxS16wXGEIiUOUe/grpY3gP0R5fAT6j9MaQ+DY
	 uQ3zzp+DgXwZ9+b/V1VjCAdPNJal4krQOil03qCVKB06f2j7O3Lw0D6JGXGSxJyZmA
	 jOitXHla8GOJmXZFpDWzvjdNzhzc7NT1UriZks1+Kl6pBVjqHLg3Ymvp2o5BAeMVUW
	 35KeuZnf0hPtS1M17XwbvSVArONnVMEJl7a5x4PmtozUBn+Wzah0OqNQUBwaiFGuzR
	 TpZ3OCffmSKzQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v16 13/16] selftests: tls: increase nonblocking data size for mptcp
Date: Thu, 23 Apr 2026 14:33:06 +0800
Message-ID: <229ef19648e7a99125bc4322c6f5f54483866ef1.1776924682.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776924681.git.tanggeliang@kylinos.cn>
References: <cover.1776924681.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Increase the data size in nonblocking tests to accommodate MPTCP's
multi-subflow behavior and ensure sufficient data for testing,
avoiding the following errors:

 #  RUN           tls.12_aria_gcm_mptcp.nonblocking ...
 # tls.c:1534:nonblocking:Expected 0 (0) != eagain (0)
 # nonblocking: Test failed

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 0dc6514c2c3f..bf8ecfdfdd18 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1425,6 +1425,9 @@ TEST_F(tls, nonblocking)
 	int flags;
 	int res;
 
+	if (variant->mptcp)
+		data *= 4;
+
 	flags = fcntl(self->fd, F_GETFL, 0);
 	fcntl(self->fd, F_SETFL, flags | O_NONBLOCK);
 	fcntl(self->cfd, F_SETFL, flags | O_NONBLOCK);
-- 
2.51.0

