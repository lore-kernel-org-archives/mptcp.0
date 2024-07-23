Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBD113C3EE
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752291; cv=none; b=H8k44qZn2eQmY8ZekqNDfAoCf/94SPvwjmJVzohmUJ0xWkWusI6+q7EnWMXaJEHn36K3A0kakcXxuspjs6WuGBFA1OsvQ0SjB7WWlj6tVdw4PWTovrxC59RjWQz68eRmOAfMftm9CNi4Ml2V6ygThZeuCybgoFxkSXxUZOBrtf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752291; c=relaxed/simple;
	bh=MyS+EwUW0YWnKz/PhHMEA8YFpC8AJpbZ+hVxc3AqPZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sG1d2FeYvXQkJ8w8x0iXuoUlHh/1/fpGx4zeDGWKtscZLGDU7BNE9c2h3WkBKwDWhgiUOH2sFimIS3aXiGSIaXOogGGfrfDk63MonO/5DNrF0ySyJE0cpDRB+V9NszSOirRKo0V2cBA8LpT4rvTeitjGtHytk2cq5UEeaPY8sMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9aSqqFU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9aSqqFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB58C4AF0A;
	Tue, 23 Jul 2024 16:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721752291;
	bh=MyS+EwUW0YWnKz/PhHMEA8YFpC8AJpbZ+hVxc3AqPZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e9aSqqFUHI17Y7YaKINDhpYkAofcO9aLS+Dedf/YqqSCDJZ3TKxYVisuY73SLpa7G
	 aEzSdzRt0SAk1k5yGikU0iZ2Yhon0neCF8X0375RysQ48lUU7r4vb+k+DWZkLXQWmD
	 nShTaQtvDYsnVSCB5w3lcHdnMymV7QBzWwX33D37q3BrH++I+sJ8t1Zj/IHdUbTA9h
	 bJoP7xbkAvPlTv1koToVKCrM+Vnyz6t0Bate3Mtuf61NU86/7xJOIODnMYzSAXkqyN
	 CKg8JSo1nc/kVZ+7OJNDTeHsm6e01nCLwSBslrRD4JBiSDh+Phst0KqGijYhj2B4fi
	 6+as/G7WwrodQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Jul 2024 18:31:04 +0200
Subject: [PATCH mptcp-iproute v2 1/7] man: mptcp: document 'dev IFNAME'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-mptcp-user-feedback-v2-1-59f18975401c@kernel.org>
References: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
In-Reply-To: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MyS+EwUW0YWnKz/PhHMEA8YFpC8AJpbZ+hVxc3AqPZ0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmn9rgAxKRbpRXotYAaZU0s+NBPm7GZvCk4UP5h
 zFb9teYI3eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp/a4AAKCRD2t4JPQmmg
 c85EEAC5E6YJMQwu6tDN5kmtRxZW9CFWdWi+t19JaQfW6xl95YR1aJe4PKy6XRr06styc388CLs
 YUrmw6zUdZhY0X6YEPoJjXbJmYyVN590fiEtOloAi70XNklhnFhBgjWUN3UygN69QmnJSoXBr1+
 itXTwi+u+OGcS3No9b9XDcoAngrDUoJRrgj7QfsudwERqlUz75wENqbemmpED3jcBNG1acYfi1M
 hywDh8zEafuQ3uNWnnRjSKoC4RKY435Xt9IiyeGiTsM6pLueepzusM2HqAiFJsk42dU7lsgzuAi
 zXxeoGl4lSSeZokPNhnHBrMNlozB2dkWlsLby7jdafih7p75wgLzpaA1voY1Ml55rl4G3dyX9QN
 zd2Qw/WSUYyvmiAlV/aWpBg0V09b3+5VbdsoyZdrwARRBBilFOH9Ga8Njywd3gTnwgoZapIED4+
 Vdu9NqqHJxSOtz8UKMCydSJZzSz0rOe2RfLbeQD9KFxWM6Kq9heh6pY01N1rugPgwC6NuKnDbLq
 jfO6iiJ+LA7CPU/ZA9P872amyuUwzTmIPgBPwIPuUtydEw4DszPFyZqsDduZvIvZIBDwMrmhLdH
 eQHkfLomy24JJEchwFNnGKm5cnGr6dMSUbLnTJ1yqGSqaDMA+GccpAXGG9ZtFRU+G2ClJpFGjxR
 lnwX+WPHtht+ytw==
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

