Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5631741C8
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984509; cv=none; b=cDIRLfhvL/B3e+kKDdVG4L+bgUFJffZ9c2uihK+nV/p3ZtCYqo2KttiWrnTK7v8EAoTaFxMLyVygd3ovWl9PXr1+Vt0qoRsZjMrExDPars47pgLPTrlGWhbLn2aFITqfOshJcHXmG8S9gHvNB3Quev7S6ckEp91L3KPFn01aadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984509; c=relaxed/simple;
	bh=MyS+EwUW0YWnKz/PhHMEA8YFpC8AJpbZ+hVxc3AqPZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhyQQu4ra+eZYVLuQ+/ekjSYQOCb5WRPbDu1LkyZ7e+H2EwEwKRVegqTURQ2XIhr/JmbW4sneF7YeA5kq12VQXQDl2dhPJmIXWZ1eEsoHiw9CO/SA2wJA83I4E7iMjktbmIHg+CmpQV9Nhgjp1CqUpio+4HibJEaqz1Dv6ELfC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvGMPIEA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvGMPIEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DCBC4AF0C;
	Fri, 26 Jul 2024 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721984508;
	bh=MyS+EwUW0YWnKz/PhHMEA8YFpC8AJpbZ+hVxc3AqPZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uvGMPIEAbulkBbCk8T2J59951gpghj9Cyb0DUAkzfS2qS+sdFxQukWzg40s6OIreN
	 p549+aOwh2D8o37C172lBaKscu6HaSs9Z7gFYy5Q/z8WfErPc0F35dmwJj3W6/dkXl
	 kFoh1NE5f2qJwuaiyt4syRFrpVwZ1Ahd/H0+YkXk7QJKfw/Mp7LDE5Xy2nyArFMfLu
	 sBNRpFjTY3X4VKiJHwhnSdkNmhEGHjlPVUIJybJHl1+3hnzGbtJ7hc18PHeWC1rdHG
	 5Z+RxKTaT46KwRzi6uyfjuFiZF9FLj+lG7oicTeoYcLmLaPYwk6mdmEahTwOR1/AI+
	 NqoZ5WLI0iQfg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 11:01:36 +0200
Subject: [PATCH mptcp-iproute v3 1/7] man: mptcp: document 'dev IFNAME'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-user-feedback-v3-1-c6ba1f5fa13e@kernel.org>
References: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
In-Reply-To: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MyS+EwUW0YWnKz/PhHMEA8YFpC8AJpbZ+hVxc3AqPZ0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo2X6vQZrC5rDhJER+KGaaJvabvBrk85vVyuDU
 qp0JYUrpE6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqNl+gAKCRD2t4JPQmmg
 cxfrEADDIGQXJIDdJgXvwvfETaEArHn/hNR1uusC4y+7CiPLoR0n1xYWZCP9sH2URAQraLqG53z
 QFovd5s4ahWYQ6498O2b2Sw3uP7KsQg9L6JiNN1Z5FmiVd4Rvj4BFrQUbr09KCUU+0s74chKabk
 ybwJGU8zovpM8eq4unLUrwCWgpS//tprM3eDh9YXxXKt+6mmQQ63AbHAzz2U2hL6OxZhRMYQ/yW
 zAhCRTkVTJFMSDq4eSbcgBxZ5LgSiPtykp+0SmJ/RYmMVldlJKzTHu5Dbc3SG/Z8SFNW+Kp3OBB
 QL2enkEbtaIa9qRZGQcUwygWRF+sNwKY5FbtPYke5BEWI4wPFTFSA1l/XxDpZJZCeOTcXvg4EXz
 DHbbI1cqn9HKdJLADzwAsOqVe0gRUyy2N1r9zgttao2nzGRAN+FOChdFl+Hg7SWpVxasrmvBB8u
 1QsAw0qWB0sjML24Sgdna9ExvFQTHDvvbITZXqR0whxIOA9FAo5UiJwWXe40cvsG8WQzpspy3IE
 j5sS/GdYnvOywX3CS4tjEueciOy1rdImMFsUruwm8dLVTvzX1Xlr8koyxs6bgp9sKBz5uzkzMbs
 k1CVjhpiL9BCo3rVYDYAZe1OVYExPtlNzMPZF5omA2QahTz+kxqVAM/Xsz9EWrVANAipYOGvSWW
 XLsEHtiz8qITh8g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It was missing, while it is a very important option.

Indeed, without it, the kernel might not pick the right interface to
send packets for additional subflows. Mention that in the man page.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 6c708957..89fcb64f 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -135,6 +135,14 @@ established MPTCP sockets will be accepted on the specified port, regardless
 the original listener port accepting the first MPTCP subflow and/or
 this peer being actually on the client side.
 
+.TP
+.IR IFNAME
+is the network interface name attached to the endpoint. It is important to
+specify this device name linked to the address to make sure the system knows how
+to route packets from the specified IP address to the correct network interface.
+Without this, it might be required to add IP rules and routes to have the
+expected behavior.
+
 .TP
 .IR ID
 is a unique numeric identifier for the given endpoint

-- 
2.45.2

