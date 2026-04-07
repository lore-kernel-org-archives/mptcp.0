Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6937D128
	for <mptcp@lists.linux.dev>; Tue,  7 Apr 2026 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551528; cv=none; b=FM04/UbPMAJIAEW/KMw2njNuHysNzLws6Yb9S6cb7m5iy4W+iY+LDeEjtCotsBBi7TWXQZqhcpqwTImEklGJdLXYjFQXVpx2sMNH6/JyrfjycQWxvSbFN+kuRuJBwpu3FxVWaxVKbWtj8JwBTLR+kRxVyVqqgziRIHa3V62LqaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551528; c=relaxed/simple;
	bh=NSZLGA9JKd6oQ/2INTtX7kkcFQ3nf4at/ULzUmC7C2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T5AAKA0JffwBk2RNcy/fN1lGZue6enfynaxGoiaSyBiMUXGgOSIPYB3I/k9Dxur7JkqeVuAbi6KYnUJG3v2VNUNTkn9+R9WMC5hpdxTNzo9goPXoNBG4fnX7LZ3Ye+GCPFcdlWguxwmC7+iPhj2jroqrE7Z7RxechFqPd4lGgx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dia1f2AB; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dia1f2AB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775551524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5KjANe/YPbubJD+aN8vMb5pALNFrygBWzMuP8j0JnXI=;
	b=Dia1f2ABa/MW6YV3zw+xfysYdJfGD1EYutms0Z3oqrjep5FLYFW2di/fE8oQwhx8Wr6ZjU
	xS4JaaU/VCiJn0su74+1DEIWwOcFb4dnFax1KXy6IDIT5hCdxgk8Pt7gUr+pvdEYT0n1aC
	ErsHoWm77gob8eHuu7EAMFUXLSUGp4k=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net v3 0/2] mptcp: sync the msk->sndbuf at accept() time
Date: Tue,  7 Apr 2026 16:45:16 +0800
Message-ID: <cover.1775551182.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Changelog:
v3:
  - Add a check in diag.sh to check the sndbuf of the server side.

Gang Yan (2):
  mptcp: sync the msk->sndbuf at accept() time
  selftests: mptcp: add a check for sndbuf of S/C

 net/mptcp/protocol.c                      |  1 +
 tools/testing/selftests/net/mptcp/diag.sh | 26 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.43.0

