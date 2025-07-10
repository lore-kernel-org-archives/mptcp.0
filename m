Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A44122C339
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130136; cv=none; b=N1PdBR4P+fcAFBi+kQqcBwGOR52ffV4twlWu2fl59K3PI1bUFHScGAp7qAOcnOaydzkXgyFJ70em7leJXYhCs51otmCFBaxHMLsvQ9Q6+/v9sIQN0AoqJ5U26ENYg2AMgsOunrRF9q3OOdmBS7L1KZ9bfDGFO9Eoxi7mbZzTY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130136; c=relaxed/simple;
	bh=flFRFucIP+VWBkTig+naQXwq77NunYbOuSRFxXyWpw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WBZnk9qJ5joazzLZT8F666xQ8kttJcIA8IOPse8uCqiLWepcfD22qgomQiGKZhT+qN/s7to1LYiywDsfmiVSru5y6/A964tRs6o8QUx4KTyaiajgE6v2k/Kym3Hzni1nXAONt1jmg64C5D6qbl/VrwuaP0ziqqewCzM0Pf7vbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaJmerz4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaJmerz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81D9C4CEE3;
	Thu, 10 Jul 2025 06:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752130135;
	bh=flFRFucIP+VWBkTig+naQXwq77NunYbOuSRFxXyWpw8=;
	h=From:To:Cc:Subject:Date:From;
	b=WaJmerz4bAZy+E7zpjuWuzcOTr65CdN1078FU7NUx7wxGpHrb5k5C2R4Eh/T/CbBc
	 Kd7RnGQ3jxK0XohtCfeO5qR6Ju3Ac8Dzv+rA+ya5oiyHP5cYgC4NdGRBHKsbRROnKv
	 seGCmvlDulaL4QfPjoz9pzLFFmCgSLzS4Y5atyFBK6qSS3XY4kuyUQk0tSFNz12yA5
	 ZMn4HN/fqIfNpQpQX2CeGSPDnDE3Opv8QLN3bRW8FiJgCEaHfBxh9oLo2Tur1WSEf2
	 7Vn88sSDidqISnhWjtgnNqOgoM52+2L6Ih5l4rzFJe67HULwIGopqyTWSi2Nr0tmjJ
	 qXwpY4Xk2wfkQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] Squash to "implement mptcp read_sock" v8
Date: Thu, 10 Jul 2025 14:48:42 +0800
Message-ID: <cover.1752129934.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop "shutdown" parameter of mptcp_recv_should_stop.

Based-on: <cover.1752045499.git.tanggeliang@kylinos.cn>

Geliang Tang (2):
  Squash to "mptcp: add recv_should_stop helper"
  Squash to "mptcp: implement .splice_read"

 net/mptcp/protocol.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

-- 
2.48.1

