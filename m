Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C3EBB
	for <mptcp@lists.linux.dev>; Thu, 16 May 2024 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822786; cv=none; b=lV0Nwc6SeV+63YrL1rKeq/QdvG9703Xws1IiIEW8a0KOpjYGptRTgRrCAxCKoS3bl9sxFU7pt3nxXP6wxYahUY6iDjxgXkgGOf7qo2GNnQRzugoHlNIBtscBrcVhksgtsd0fOPoWgg7Ovd5MKLZl17ifW9/sIvecUBzAEXvmrzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822786; c=relaxed/simple;
	bh=tKyksfmii6talCfFODQMoy5swMfJW61bhwiA2gmOZnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N49VIHezXsbLeGiGuqLgddBytSpb1utn4Yp2M7KSlZEFOcE3q2Z9V25YKF+ifIJOwk4KxguRZDK6rtd2CChEnFQ0umRUEp2WSzWPjzczkSTcarVTmv/CJmJUqUaS7KgKYDReyNKAm3yQUJxV34UfzOxCmbOZRpZSNTNB7iJrSco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEZE4BU6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEZE4BU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F39C116B1;
	Thu, 16 May 2024 01:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715822786;
	bh=tKyksfmii6talCfFODQMoy5swMfJW61bhwiA2gmOZnM=;
	h=From:To:Cc:Subject:Date:From;
	b=nEZE4BU659OglM+FbIDapybUnfHDjB+4IYdz/MSj2fo0yVOhZ3K7xXk9E7OvJ+QET
	 3Chg6Mx1A06diTYQyeX6ebV3T2RCwcF0lA7Yvj8SxBabHoGAFff+E+QULVpFrH9dQc
	 sff38pA5ztXJZ3/SDH3RhCOsaqcro7rXURxlNjYbKbTkUCVqToPXFiA/U8ongUNM/j
	 uLkzLBjklWxDWeYzlIvxkwruqAUeVKyCVTGEvdVJqOGvYl34TdngSVgUlbEFENFo2R
	 m2ydYXAeQK1jdV8KNON1hu/bKga6nOqRQaMudaQZCAbT7g6TT0bjhN04XzJ4LQ2pus
	 XV0eTWq3p9Qiw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] fixes for create_netns
Date: Thu, 16 May 2024 09:26:16 +0800
Message-ID: <cover.1715822527.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Since create_netns() is updated in "bpf-next add netns helpers" series,
some mptcp bpf patches need to be updated.

This series epends on "bpf-next add netns helpers" series.

v2:
 - drop patch 1. Now netns is deleted first before adding it in
"selftests/bpf: Export create_netns helper", no need to use SIGINT
to delete it anymore.

Geliang Tang (2):
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  Squash to "selftests/bpf: Add bpf scheduler test"

 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

