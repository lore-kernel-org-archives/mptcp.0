Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F109B1CEAA0
	for <mptcp@lists.linux.dev>; Tue,  5 Nov 2024 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799667; cv=none; b=a6AfF4hVATMtkb//F0JSGb8b+qBsiiSq5p2YdqGYIsQpOY+QVKuQoJPXJx3K8VJHwa/LDKZy7jrJDPCcAzcT9eBJz9SVOpBrclc6HJjk9D8Bvj1yszD75cSXt9LLOErQ4PjzvXeMueeMwKmyzRWwmPkuvEKpRbXVX/hVX1wcm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799667; c=relaxed/simple;
	bh=YU9x5iCUwga3z0lR6bfzkkgoKQOrxs2ZAS380Vt4wnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tfQuYM50pUSVwzNznxmuSTRXwyiktnuNzN6RG1WZhda924AsZXELl4zbSehGOrq0gdv102x/8/+Msum5Nh0mpIBJv1dE4l2GUtAqz0SembL+Vgf7k9n0pt5d5krgQuxg9BF/FS94p9lEtZYUZvHAuA2kjyar1upMUYjO/jRkx6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6bI6sRU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6bI6sRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A199C4CECF;
	Tue,  5 Nov 2024 09:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730799666;
	bh=YU9x5iCUwga3z0lR6bfzkkgoKQOrxs2ZAS380Vt4wnE=;
	h=From:To:Cc:Subject:Date:From;
	b=T6bI6sRUwWjJfWLn5k2lzbHDJJGMKgBrRkGHle39klFR9Smkef8LKCb7KSpptDaUB
	 TeBlIY3k1BR7/a4/8kMlWCE3atCfTdQqE5nefRfrLZvSnrbxrNlnDP3TwMziTZ+ABF
	 YhLQwumsNCqG4ac9nRoltlJ+BeZruNxSNKPSZW+zLgqIPkz1lGnJDUIDR+Na/IzeVv
	 Na7Zr/EU6r4C4MX80kffp/f5PhyvH2x+zqLevOoe8w12Ls9OmJIUl67pm5sBmQFBkh
	 AMct586hjdT2RlUdeRYKRCkXoT6+tX+Z7ZLhngb8a4oRUOrmffCSutqfU9kmdpmrZi
	 ZLGayHQ0cCOEQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 0/3] fixes for userspace pm
Date: Tue,  5 Nov 2024 17:40:57 +0800
Message-ID: <cover.1730799589.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Three fixes for userspace pm extract from "BPF path manager" series.

Geliang Tang (3):
  mptcp: add lookup_addr for userspace pm
  mptcp: update local address flags when setting it
  mptcp: hold pm lock when deleting entry

 net/mptcp/pm_userspace.c | 72 ++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 28 deletions(-)

-- 
2.45.2

