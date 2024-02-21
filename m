Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A439FE9
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499192; cv=none; b=bCPx/eTwjg/JHoRlZUUbs2nb2cvwbk2f2mmKffJFWBIxwtnoYR8TXkLPICC1zqThLCngKm5dDP3TwHxdos7HOWle4W0rDMp9UJAAk/8EYz5RklHJ8HDEzTx/ZbxT5fm900ECUmWZJ440dC7nVgFCg7jxs96XN/7YhI6c2x6D3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499192; c=relaxed/simple;
	bh=hFDmwvYqLJ+IXscibcUN069qhKRMAEVbtEXrUs1AQMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C8zTErkrLnQnJBM1qFL5D/MZapI27X7ru50bUtgzSvxBeGuQBiM9uWFlu2HgxI8/6b5NiHBJKMyCd7oGsmByvFI74hJnPV+Gm9AwghV624xS0P1UuHFZkIQXAZMkH+1OIHiVlACq73paGjp7mIFECe9IZ5xqHDuw040kMoALJqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQIt6plv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQIt6plv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D18EC43390;
	Wed, 21 Feb 2024 07:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708499191;
	bh=hFDmwvYqLJ+IXscibcUN069qhKRMAEVbtEXrUs1AQMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQIt6plvhu2zLv31JMUsbM8Izn5eqa38sAQJZBdSRyVTaNYH9cfUuTOJ1Ho6Or8yZ
	 7ChiNW1pQzEOktVY/g5XbmoysP1QV3UnlyVLJnHPrCtIz/OOci0wb9FwQjTeMBghMW
	 Gnl5s91VFk8kXqSBw7Hg35jbw+qBHGA+fGdAavMODuAi+XzLzD3Q6IMZfw0dlBN74Q
	 JuOFPiL/hAhiKGelzEd3tJccJxwfycKsx7fRsekbocR8aj1TG6ThTybq5z8V1jbrE4
	 YjzQhlqXv4E01ULwxETiF4mgPHXeTxoz4dWYII3178obPmefe9gO2BQivtqAY+BxR2
	 zlSN7BWUIg8lg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/3] selftests: mptcp: connect: add local variable rndh
Date: Wed, 21 Feb 2024 15:06:20 +0800
Message-Id: <2ca83d472f3ba157ddfc97dbbfb20e2ccbd35c29.1708499011.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708499011.git.tanggeliang@kylinos.cn>
References: <cover.1708499011.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a local variable rndh in do_transfer(), setting it with
${connector_ns:4}, not the global variable rndh. The global one is hidden
in the next commit.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index ea52110c3fbc..b609649311f6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -348,6 +348,7 @@ do_transfer()
 
 	if $capture; then
 		local capuser
+		local rndh="${connector_ns:4}"
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else
-- 
2.40.1

