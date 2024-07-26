Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2270E1F951
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984508; cv=none; b=BRGCRdVLUcbmiLw6tm99qw0Tm/+/VyZXaQS3cdoP355boOHXEtVGgBkoA6UVNPynfngEat49Gb4W57ieQ8e/uve4Y8pqXrOtXQoHHPEI54SP0zl/rZKG0fh4NN1j+GlGpWGRcDpQg+DSY0+I3v66rfwLF6OdfKgOqZN0bJcxnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984508; c=relaxed/simple;
	bh=CMIvj5Kn/ae4uYFwMLOmzCxIuiT+ThvZgJLWR3x8SpM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LylpOshKWy0qQ/ohGq6fXB/xMNDmHmfkhH5cNw84AbOm+xc0WkrI064THEEuGmP81coSuQAu1w5SEYjvjunhegED2smLyrPv7Dpryt1/Nl3QjXKvS/Y9L/B9rBYO50+UoDKSSUZskvPIoY11Mz3K/Ob3lDUFmphOF8GQyJNVzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrQHsyIc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrQHsyIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E500DC32782;
	Fri, 26 Jul 2024 09:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721984507;
	bh=CMIvj5Kn/ae4uYFwMLOmzCxIuiT+ThvZgJLWR3x8SpM=;
	h=From:Subject:Date:To:Cc:From;
	b=YrQHsyIc4C5FOIh/unAYRJPFb0X0HVk3G+b1vNzFHpwNLdK3SnDuROzGqK4fniIGH
	 OdsOisggN/BrYUJD/NnVWPrs5FVVCK8RHrDuuLaDbsMFz1meNqq2KUPwEwnJJBhRdi
	 5fxBj4ZpU25oRz7Jel/2hhFEf1KcGaCjYQA5FzzXj+fjis92vTR0ZihD2Gmn041Z1+
	 eg9KyvbflqT6YQwsPDm1WiZxrc9Ij8cZL9QqJ+JrphlysYDoBvltImiH5I8GYHJQOU
	 9U0V1ZTHGl/r58H/aKmI2WzTtKFWqhL+job1scz0CuFITFgYeP05yovJLJhS+OfD1i
	 N/lFbNTV8UZBg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-iproute v3 0/7] mptcp: guide the user to avoid
 mistakes
Date: Fri, 26 Jul 2024 11:01:35 +0200
Message-Id: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO9lo2YC/33NTQ7CIBAF4KsY1mL4KVRceQ/jooVpS6qFQEs0T
 e8uwYUxMS5f3rxvVhQhWIjotFtRgGSjdVMOfL9DemimHrA1OSNGWEUkEfjuZ+3xkme4AzBto0d
 MZC0VFUwQ3aK89AE6+yjqBb0H1ge3zICuuR5snF14lp+JlqO/fKKYYMOM5i1XSlb8PEKY4HZwo
 S9gYh+kZvw3wjIiVEePqhYVofoL2bbtBQqKuNILAQAA
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CMIvj5Kn/ae4uYFwMLOmzCxIuiT+ThvZgJLWR3x8SpM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo2X6PZVyUkMWLaRhjSeKz7p37csoJjZFC+Ux8
 P2pblMQZa6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqNl+gAKCRD2t4JPQmmg
 c1zfD/9Z5CduJhBtPTo2GfvfrBmhaqPAB/+zUZnQoce67xXSpwtFd04Zxsz3eaVleP6rQx1FWnY
 TAU9/Y9EC45bGaPkG2AkHBNUHgOR3aozEjZL/I9Zcs60ZpCSIUIr6dvQ4ahd7qDltw9G+CQgYLF
 zeCn6OfH3ht6rgiidA3foWZiPPCGI/MCQGa4/EO+S8v5Bw53+azWilt9p5Q+HsZOa7We0mC20+s
 AUmf1QfscdlkL4hnrGfMRQSlwRxvP0EJ/xTR7ihOdYbgo5DgEjKXwHMp7PJif0KN356Y4FmoRwi
 CB7AsChY9LA+cLhn6OSTLzHfHPLcFH0jcR+P37lbsVkz38V0w/Uytbrqi63vUU+nXjIkrthaXQ0
 rieoH4tW7v9OUl0r2wpw+cHl6VKy3yVmV0YIoqwb0AbNzncd6GT+Rz/gaE++dMJplbS7WgMjwsT
 FA0hEwp7OyDhmFG7JgGZ4yuO77qcCdiY7l/RdY6n7KZbqmQ+Uaeq/B5Cw2JZ7GuyE+fSE0wyoHT
 W3aZwiCmQAkEzrizGQ0d+yVh+K9i7xzH79J2+B8MCxi5FdaAbEG4uzy7MvCeh2dwrZybD8lLI02
 IaTJYhdG4xaaaqDl2CluK+dPY8MGF+ismvRRDlKGLeIXmeZnmz/4hBMYKXd4hoKb4ZHDxppm3ZK
 ph7gXMY4tkeaLLg==
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
Changes in v3:
- Patch 4/7: Reword (Mat).
- Link to v2: https://lore.kernel.org/r/20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org

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
 man/man8/ip-mptcp.8 | 44 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 37 insertions(+), 9 deletions(-)
---
base-commit: 3e807112fdf3d7b89a8295379dd8474f08a38b4b
change-id: 20240605-mptcp-user-feedback-0676915250cb

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

