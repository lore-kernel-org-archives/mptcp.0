Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1F14EC57
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752291; cv=none; b=M4czwGcO6xBM3qF0mLdNRqJqbpi6JTDV4tKfKIGLZ/yU4phZIMtAiqEbv0pKYUb5AdMYbUH5cdpNFc2ebjGi96pV6cyL+6gsggkZIrJU6PkpXxTvmXiAoFuck9td44Sz46Kpxe+kBgaGPddNRXrVxbD5qI0+5yPgyOMRdm+g3F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752291; c=relaxed/simple;
	bh=AFHBQkP/X2hyscalx5ixrdzp8Lbm9VkZ2Nw5C6hq60o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RApo6IRA9YMrNkdfLTYT3au8aNDS/nxoG2FMWrfinXuYYUaZHZ7rhXqNvR1g133Oxh0dr94dGc2bvXZKFl3zktFhbsj0yqR859Xtx3nigYgnxU2bswYrmQ2Dj9mPGbkkaJUYjRnjuOxX1Miz0li3TrMVvU5Ymxon+DPex2lg+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StH28ktb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StH28ktb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A47AC4AF09;
	Tue, 23 Jul 2024 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721752290;
	bh=AFHBQkP/X2hyscalx5ixrdzp8Lbm9VkZ2Nw5C6hq60o=;
	h=From:Subject:Date:To:Cc:From;
	b=StH28ktbjrQYe9+DnO66y5garYw/pZT3EsJIjOg8Tnlj8hCzNHEGF1alSOKg9gf+5
	 DkUoMVzAVNxSk7Cnj+PZ2jxgsxfT6y5euyCzB1W8u/iORKE9Ei6EfOVeTk8YchMxHK
	 LSTjpP3z3NxaER7stmQxRoCvHWzD9sPwE6YlH8OCZ6tt01I697QQnmlCJEssJX/dHx
	 XEfnX2pWFtcK2488uMFYcay4WivwdNBqPyycebDjBFrYOvPbcX6IqZGOuRJzN3rpOo
	 XOtcC85S2Bf53id8GckI8ttYc4kli1rGHorw/HwoHICqVj3WmlJJUDeZpxw52YBj8W
	 l994QYkMcoS4Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-iproute v2 0/7] mptcp: guide the user to avoid
 mistakes
Date: Tue, 23 Jul 2024 18:31:03 +0200
Message-Id: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMfan2YC/32NwQ6CMBBEf8Xs2TWlQA2e/A/DAdoFNihttkA0h
 H+3wbvHycx7s0EkYYpwO20gtHJkP6WgzyewQzP1hOxSBq10oYwq8RVmG3BJGHZErm3siMpcTZW
 VulS2hUQGoY7fh/UBP4CD+GUmqFM9cJy9fI7PNTtGf/VrhgqddjZv86oyRX4fSSZ6Xrz0UO/7/
 gXtcSNYxgAAAA==
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AFHBQkP/X2hyscalx5ixrdzp8Lbm9VkZ2Nw5C6hq60o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmn9rgwx4wbIXaQZhuBAVfKBvswwgnphh8O/krl
 InPFV85fJmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp/a4AAKCRD2t4JPQmmg
 c0VnD/oD59RCKwzWLtTQbLz2MGzJMuLPsaZghw4doKpCiKAscTLRVCygWibtscsrVYobS2KNJY8
 5+90xkjxKywPhWVrySSRHx0raj14VtOuL6N6eb1suaqMBz6SG5RZoBpdhrECpIy4CpU0OxvWXW1
 fjJuebGAa7ipo58Q6KgFZ1E0Mstw1WJGKq7pIPXkF49SddPGBi3F4UpDsYhOlwXBffsntumdV0T
 kxbCLAk0SCcEc4vQauHO8Mu4i9ACaqkDLfNBi18gl0Iq5/u/aN5cUIdvwRCfF9HwZbzCc6tjY+f
 rAFQX41+48/tH8pTJS5a8+VNLf2s/VbKdPs0rnjKGtyEZBONXjrKvFgHq/BQqpzg6bLcQc2Zq4S
 pto/cUxvGYxeS/g8LoVmjzxN2vAGMyMxXaro3MExrfwjOu6sfBBSsuddwgPPWSDDmRjKxQIv1JP
 i4rvBSuFZLT2wXonGuDgHhV6ruiWodq9cywHoBZBQXzOJFILvVmXyr4Zojs//EgJY5HvYFA6LbF
 A8+EgrTe7vp6VdQEQGEh0J8xvWcBvHbusA8TTkXj4C7GDCB6aWv0J8QcSMrfot8oRS+nxIo9wT6
 qVEDSh4nA5eB4rYDak8RmUnOhnzAzdy8lzE1a8Sk3ERr8xm95LJ9vWruUeKkJst4WGEL0TcaYzO
 +HsdJPEKkyru7PA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

According to some bug reports we had in the past, setting the MPTCP
endpoints might be confusing, and the wrong flags might be set.

This series adds missing info for the 'dev' parameter in the manual, but
also clarify a few other parameters.

While at it, a better error message is reported when 'id 0' is used to
'add' or 'change' an endpoint.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Drop the patches adding the warnings (Mat).
- Add patches 3 to 7.
- Link to v1: https://lore.kernel.org/r/20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org

---
Matthieu Baerts (NGI0) (7):
      man: mptcp: document 'dev IFNAME'
      man: mptcp: clarify 'signal' and 'subflow' flags
      man: mptcp: 'port' has to be used with 'signal'
      man: mptcp: 'backup' flag also affects outgoing data
      man: mptcp: 'fullmesh' has to be used with 'subflow'
      man: mptcp: clarify the 'ID' parameter
      ip: mptcp: 'id 0' is only for 'del'

 ip/ipmptcp.c        |  2 ++
 man/man8/ip-mptcp.8 | 39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 7 deletions(-)
---
base-commit: 554ea3649dd15b19202d7e9791310c3bbb910b34
change-id: 20240605-mptcp-user-feedback-0676915250cb

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

