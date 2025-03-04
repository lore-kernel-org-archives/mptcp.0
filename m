Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85381F76D3
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 07:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072585; cv=none; b=fj13aEyblOwKvqy/HDhwAiBXYvyO9g4YUJkkpiEdaloN6SJ5JQwAgFl0IprLtReoQ1cJb0eWZ8HtfEyomIih2oyH0eEVeXbsD4aSMaiPh0pLdYe6I63k+IxuvWKDKgxOLVf3WddjGdbDKouhygyKuWLIe7HNgsgRvqSsORfBRso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072585; c=relaxed/simple;
	bh=I01Ip9QsfOB7GrwceUj33OfhhnbuMAArRxpFx08IwDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pEor4p2vagNuUX1SbXazRn9UbwLusY30795+ezso/CwkRScx7himVaxLys+kROA+l/sGgNl1jYBG3PxUJcEjxsVmKUOqIxMpyVY2xKl3ukLbVD9rAihIwUrDX3za8SeuJa5OTidqeq33jbHeAfyrJNYJmz9DrOTAzDHfi0Uf0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GorSCWBE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GorSCWBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA63C4CEE5;
	Tue,  4 Mar 2025 07:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741072585;
	bh=I01Ip9QsfOB7GrwceUj33OfhhnbuMAArRxpFx08IwDk=;
	h=From:To:Cc:Subject:Date:From;
	b=GorSCWBE3m9W2wHMNNU2A9hVsxRnynXMUK4j5HqHihLTVVrQbZH/t/mU0SJTq+lIR
	 OwVi2V8efTXt0iwXPBuc5ectJY5m/xBsCXfoWD1fk/RECr1Q53cW2qxVbckhsP6D/Y
	 W9V7uR2iFO1jybF79KERbYSHO9j8TWXAF+9+n49+7KEXkHIo+7wE+52y0SQOin4CwK
	 3tZbyibtS29AqFlnVfNdyBE+MtZzgM9wHfhZBk3HyqihGy/NKX5GIX8LPtrt5VkZzW
	 8AlCQ0HyrEl5sVn1CFfWgeisMDeqzYP89LbJ2EhzawRT4AGyZwVSypNzTIz4rAyTW0
	 vPoujOOhGRl8A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 0/2] pm misc cleanups
Date: Tue,  4 Mar 2025 15:16:15 +0800
Message-ID: <cover.1741072099.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Resend two pm related cleanups.

The set "add sock_kmemdup helper" is accepted by upstream, so I think
similar patch (patch 1, use kmemdup helper) is valid too.

Geliang Tang (2):
  mptcp: pm: in-kernel: use kmemdup helper
  mptcp: pm: use pm variable instead of msk->pm

 net/mptcp/pm.c        | 8 ++++----
 net/mptcp/pm_kernel.c | 6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.43.0

