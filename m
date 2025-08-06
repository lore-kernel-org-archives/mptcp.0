Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592B38D
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754450260; cv=none; b=rwctVhSVH/UPDArduEilumhioQ0S4p5wwIuG2LF+367Oy2GgCMb5rb/cVsUDpQqTVTt0093VjHZiSkJLAxcbUb6ZVuCVx4a3YP53VxXIVHvMsA/iuVqbWGe4aQFtaXozOq2anzVh+rA3Q66aFU2CirK2/kbMrmH/8GUxipHzpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754450260; c=relaxed/simple;
	bh=DOn2lk77V1yxaXRIEeM2R9VzHV08ckcJwxQXHzWQ42E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJjxx5l7Luj3QR3XtS2kUYnVceJA1A82tg16/R4YvdOOVOYpijnJeJ1tHeTGtUxqz5XejJwAlxtmpyGHClzwOAty5dcAJkNvqCimU64dFEa27fMAf17ykM1n2OWJA+iiwYbzUIRyQGMghSHubybg2zKJyrYe9zWObtnrg11JH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGGSFLgj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGGSFLgj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316C5C4CEF0;
	Wed,  6 Aug 2025 03:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754450260;
	bh=DOn2lk77V1yxaXRIEeM2R9VzHV08ckcJwxQXHzWQ42E=;
	h=From:To:Cc:Subject:Date:From;
	b=GGGSFLgjZHa07FdCNPsqFjtdCfOo4YWxcurkvt/VI8nBcXfN+8i8JXf24KtFNjEhb
	 mCo8ADvy33/w8eqR1/zwX45TvCUEqXS1Fv5JS86uJID6QWB19OwuuYwD5zuv1GEsnw
	 mgAuI76ItJWXszE5fapgVBhikn6pKXhV5eQnkkwDhR3Ed6tzDpcKph1bnwOdIYAFE+
	 RDDjy0xJucNofFuN2TWP7sNnbDq+7PqoDpYIeL+TkG/a+R/kWgRtrOdl1VZscLHyEx
	 EiDll9VQQ/nZrchGn26055VYXmHdN9yLHlyv8dA88KOybunix+mXnnwQA8mnkUHzrs
	 x2kshl8Qirn1Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/3] mptcp: improve ADD_ADDR timeout handling
Date: Wed,  6 Aug 2025 11:17:33 +0800
Message-ID: <cover.1754449947.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - a new patch, remove duplicate sk_reset_timer call
 - use __tcp_set_rto() * 2 instead of icsk->icsk_rto
 - update selftests.

Based-on: <cover.1754449726.git.tanggeliang@kylinos.cn>

v2:
 - do not rename add_addr_timeout
 - use icsk->icsk_rto instead of tp->srtt_us
 - increase the time after each retransmission
 - https://patchwork.kernel.org/project/mptcp/patch/40706ad511220729207ccd7cf48e320e4d0d7dea.1754028199.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1753777199.git.tanggeliang@kylinos.cn/

Geliang Tang (3):
  mptcp: remove duplicate sk_reset_timer call
  mptcp: make ADD_ADDR retransmission timeout adaptive
  selftests: mptcp: remove add_addr_timeout settings

 Documentation/networking/mptcp-sysctl.rst     |  4 +--
 net/mptcp/pm.c                                | 36 +++++++++++++++----
 .../testing/selftests/net/mptcp/mptcp_join.sh |  3 --
 3 files changed, 31 insertions(+), 12 deletions(-)

-- 
2.48.1

