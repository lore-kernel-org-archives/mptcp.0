Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31E20012B
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754136111; cv=none; b=mphiPdOBCQx14SquBhCMAVNv9b+1v1vs6hO/x1RsgCgu38W2zLOejK7lFm/7Lqzacv0Ut0a/ylH98JavvwpmDGpQM3VZ0lu7UJxZDCZLkrWUgjLB3uTbVrt1C+9ExXIV4VGEhU3K3NxwIiy4wCZyz4ViT5yS4ZJ4b7KCONmC0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754136111; c=relaxed/simple;
	bh=P5IkVrKwQ8WJ1ath1bLXwOIM1QDSslquRAlmpH2CFKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/qU+E107qVeYBGPnY3hp+Zy8DFlRYSHXxPN8VuJZTOExaPBiq+4Rl0kXFzDAf/p9xzou038GxKVSePSvFo6cN1vagG8ntlzRUevCopTF7FFTDg3oJJWtL5+hlh8Dq+FcOZklslGBLWFY3rtuzd8YKp/BlKLJEv+dM3wtNGGi+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTLa8qXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTLa8qXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EBEC4CEEF;
	Sat,  2 Aug 2025 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754136110;
	bh=P5IkVrKwQ8WJ1ath1bLXwOIM1QDSslquRAlmpH2CFKQ=;
	h=From:To:Cc:Subject:Date:From;
	b=PTLa8qXuVyCB1Fza7pK3a51+PE8uCPYaX8/yxhPWy/dQxmC0DRq9qGAQukr1eCvko
	 Zcv1N/QSNwPo2WhiBjcEHLjkO35ymFc3J4eIYWNar+KDwqx+PFhnRmUtTkb+7Lg6/Y
	 uA1gLHPsZ7NyfXDxoNfLoOlH2GvObDzXPxADxYjIecwHQVa+EGFUI/6iUjGq/V7ffv
	 6N7Lt+emYzuoKmU2H4Xlz2CvBWve/tzAnLzZ0lGEnZN2X+V0aYaJj8SLdjoVbsunJD
	 ftFEj11kSoenLMBbEPUizAyxRfYj1NHe/kVfkxPAG7Jws0EsTaxzJ74D5hLQIFI1wu
	 hqTKLqO6XBD8A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/2] mptcp: TCP_MD5SIG support
Date: Sat,  2 Aug 2025 20:01:43 +0800
Message-ID: <cover.1754135958.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - drop CONFIG_TCP_MD5SIG check.
 - drop sk_state check.
 - use WARN_ON_ONCE for __mptcp_try_fallback().

v3:
 - limit the use of these options for listened and closed state.
 - check the return value of __mptcp_try_fallback().

v2:
 - trigger fallback to TCP.
 - check CONFIG_TCP_MD5SIG.
 - update MD5 comment.
 - drop selftests, packetdrill tests will be added later.

This series introduces support for TCP_MD5SIG socket options in MPTCP along
with code improvements:

Patch 1: Refactors TCP_MAXSEG getsockopt handling to improve code
consistency
Patch 2: Adds setsockopt support for TCP_MD5SIG/TCP_MD5SIG_EXT (first
subflow only)

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575

Geliang Tang (2):
  mptcp: Handle TCP_MAXSEG getsockopt in common case
  mptcp: setsockopt support for TCP_MD5SIG

 net/mptcp/sockopt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

-- 
2.48.1

