Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF052AD00
	for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742355611; cv=none; b=N5fUiXmv5/bGDJbNd+WuDcQZ6l2HFtxF7YPa9mKN1CJN1olHuhgsQngn6pTGsiRa2KdMH6HlzoOWo2L8B3sxyLd7reHMUkaBRH/3g1IDMPhASfbFdJhUZHjb7MB8XFwd2ZNRMAdBlZMRepgQTNfzmbwoQYxSjGcembNqKwEZuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742355611; c=relaxed/simple;
	bh=wrhC71qUmCIeWS8sWe+4w4EXYJkfMixpxDAn69+u3f0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZZfSsqm+CKmWezrJgrDJGjD7k0d7ICP85xLvtg0JzMloytVKxT7kiO+oWnX92Ki6i6dTAd37c7oMUxPvvXJe0lttGct4xitFw/9FfyNDbI8s1g7ER37M6kWot3RVTzHk8sER+XBdq5nrhwI0/EKG5L4/BubHywd5H+H2c5/DUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2HD4DW4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2HD4DW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050F2C4CEEA;
	Wed, 19 Mar 2025 03:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742355611;
	bh=wrhC71qUmCIeWS8sWe+4w4EXYJkfMixpxDAn69+u3f0=;
	h=From:To:Cc:Subject:Date:From;
	b=N2HD4DW4ED1q7lNgKaVKq3/ywGTQnCpHf8AGozJrWw5R5qwKAle/Vg6v2fO/eV7UI
	 H5ZIqcLWgTds1lpheYvkst/GX7svquhGeqUhFIHOoO0ArbU60weJBpVid98UQbbRKd
	 nbzGBQw3DjZj/f1/M5Sk+8b95vLdO6B+/lu3N5ZHKCibO6azqRZQv5BdurZ0b3OEve
	 ShHgSCZzdrA/VYV9Y6S3TQ4GgVzkvZqefcJ9J4/W+XFzAcxbgKeUCWvqe8mUE42lvl
	 llGVDOwU/LUy5HGAeBEnAj2mY3MEhACdadMZYRAU+062DeSR8DRpadCSkBMaoLi6ec
	 6mb6xUqXxy+Rw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] cleanups for main_loop
Date: Wed, 19 Mar 2025 11:39:54 +0800
Message-ID: <cover.1742355162.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - update the pending patches from Cong Liu, he said to me that he has
   no time to deal with this recently.
 - delete the second "open(cfg_input)" instead of the first one as Matt
   suggested.
 - drop freeaddrinfo, no need to do this.

Based-on: <59caf78b9d67a0a61a19a46f7820456f6ced3d6e.1742296236.git.tanggeliang@kylinos.cn>

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/20250113085228.121778-1-liucong2@kylinos.cn/

Geliang Tang (2):
  selftests: mptcp: open cfg_input once in main_loop
  selftests: mptcp: close fds when copyfd_io fails

 .../testing/selftests/net/mptcp/mptcp_connect.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

-- 
2.43.0

