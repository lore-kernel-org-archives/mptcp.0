Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720B1DFF2
	for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6qTYvKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D46C433C8;
	Tue, 10 Oct 2023 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696945708;
	bh=t+S6IvIcfjPUzv3IiouUs/UhEad0/8BSBO+JDp4vmQ8=;
	h=From:Subject:Date:To:Cc:From;
	b=s6qTYvKY0Wc/bvv50tX73B0oCmL1YdC8WQ8qGhL6a2ZpZbgMY49PPKzGsXflpIHpf
	 djxNdo3rbzevNi01pqTz4Xj4RIwKwSNyJg++fjfgR9yf4uUzXfhBjWKIm7mSsHPrsR
	 PEDPqob1ql+Nm15hCYHN1dF/NxWTm5S7zFWuJQoFjlnNwCIQ/oVV/NhOqQpoghQoHz
	 zAPYjfqclIX4QCh66J+g6Wv1IUxc6B8PX/+J8yAA97Lgb6FiMOJ947w0cylw0J2DGu
	 VKrD6ApGsQ/VsCBfWDe0nLAyPnR72L86Tk73xMrNylJiwrswGzK3uRDmGXBv6huvtH
	 EXB391/g38vIA==
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] selftests: mptcp: join: correctly check for
 no RST
Date: Tue, 10 Oct 2023 15:48:10 +0200
Message-Id: <20231010-mptcp-remove-id-0-rst-v1-0-5ce17026f748@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABpWJWUC/yWMywqEMAwAf0Vy3kCqxX38yuJBbNQc+iAtIoj/b
 nc9DsPMAZlVOMOnOUB5kywxVDCPBqZ1DAujuMrQUtsZojf6VKaEyj5uP4eEmgv2L0uzdU9jHUF
 tk/Is+//7hTsJXGA4zwu96+lscgAAAA==
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>, 
 Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=t+S6IvIcfjPUzv3IiouUs/UhEad0/8BSBO+JDp4vmQ8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlJVYrZa8SAEVqmb2QqEif0uswy047ipU7iTcyB
 oQeX92JOXyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZSVWKwAKCRD2t4JPQmmg
 c1shD/0WgbaH38q+nOBI7j+uGPk8o8BOp5UvscfEoStbgAQSO/i9SRevHmbIi36AdGDsX8IItmP
 lwqzB5KA6mFDDu73X4E/XF3LvuRQR70GUIkHdB4B+bqkRzbjZx85smwK6rWq0tge78/hHxRF7ET
 x/0z+HVLejhIsLlPlZozgRZ5quks61eQ2WOTD3sQtrO1ie7M4ZqT2CZFlliu/WRRaf/ZZDYnfHo
 H5NHuk9YM4tj0k8bqubpWX7aOtLS3zB+lA1X9/qmlNGCD2SMg2B+aZ/orE3Yj7SpfgIMkkxXOt1
 sJ/CT+yeqOIrVkPyYS6TSj60Y4n8tSeBK/Ai0nNrvoDW2A+ft/1IV9GLSRpp3tnPqaIb5QRaKOf
 xsj4EAq72zIjF0GDMGM6/VsrCt4C/oQGvEKG50eL6k0oUI4bD5fRqwb/CKvDlqUAgsbnfSPYw7r
 JVjIHHOk2NeN9Z7NAHfu5EDKd1lQMIZM+yFaR/zcX5FlLd63SC+2Xtjae0zc4HR8QVRSXl1EiKY
 1Tqpq+NjY+xXmohivxS8mGP1qMuf8fTaHXULFzED+d7lNcn9fvrQvEZbeVFG+qJReagCkXyTlk5
 YchxulywLf7gq/cbf7G8lrRoAxSVxFG0cf06nzkrhuje8KYAtFpU7d/x0pl6l8AD5AN4a3F9mT8
 0hSmvcXI1P16RHg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When reviewing Geliang series called "userspace pm remove id 0 subflow &
address", I wanted to check if we were generating RST when removing
other subflows, see patch 2/2.

We don't generate such RST (except for the initial subflow but Geliang
is working on that, see patch 2/2) but the check we used for that was
never reporting errors for the "0 RST" case. This check is only when
validating the checksum and it is now fixed by patch 1/2.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
Matthieu Baerts (2):
      selftests: mptcp: join: correctly check for no RST
      selftests: mptcp: join: no RST when rm subflow/addr

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)
---
base-commit: d739ec05b2034df60065e006c64352ef530c5887
change-id: 20231009-mptcp-remove-id-0-rst-6840f4d714d0

Best regards,
-- 
Matthieu Baerts <matttbe@kernel.org>

