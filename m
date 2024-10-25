Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF51C0DF0
	for <mptcp@lists.linux.dev>; Fri, 25 Oct 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848771; cv=none; b=L1gFBKgZ8QAN6W7MYeVVg+qMfDhEb6h3i3RoTmLS74VXzn5gwOCArTEVudB7YmrJYf0hXFjnAWluJEWEj0j2bNAnNicVmP/SFXtVLiskcJoHhW2gKzJvtBqU7NCnzfgE6AYbLXMD3/LqBsEcBggHmdkKY6ke9kYKpIG/bEFaAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848771; c=relaxed/simple;
	bh=YHgqfS0bnjI6s+u4AibeuC/tSVnbeo879O6EIvlWc6Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uBmPGWp6+2vUbLyI0SipZf86Gr3LNro3O2dqXwMNsQUFJS5rEcEnk2a7Dvei5b4Q2VovMtVNM7//z7CT6Q/Xqcn33ZgcKpxeTHfOEt9tnbg/5COHxrWqCUkr924UFSUl++7YAhVRlsizvsj9SpSwqR/cnW57pXodMectKD3c+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcRXEwHe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcRXEwHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860D0C4CEC3;
	Fri, 25 Oct 2024 09:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729848771;
	bh=YHgqfS0bnjI6s+u4AibeuC/tSVnbeo879O6EIvlWc6Y=;
	h=From:Subject:Date:To:Cc:From;
	b=pcRXEwHe16olHpSxYaf+gnT/hAsCIZsLu2Ew6bJy/1X9vl9mrEI8+RPGuakghBxfL
	 tHpuAmss41mucGB0mviq1J8KX8QfPPHEPGH3MeSVXt3cAEbk4DS73KjrNnQ5U+lNZ5
	 aWRAGJbuejgcPX67j8Gul17kajITCYaIRMInUVPXptWWM4uK5ugPMLgn5PSkOIfhbr
	 qMRks7PcsiKJqdbbbgz3RLS/ryDU4S/uHybHwmH4bk1YdgC2g7q5MRvVHyN5kGUi3K
	 4QN1rZQz1n+09TMvL9Ts0+KCpaPOjyGTymiHPfnBtQ69HEGfSx+OhK6uDzn4a4KWcR
	 szpVDRLZv8k/g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/3] mptcp: pm: use _rcu variant under
 rcu_read_lock
Date: Fri, 25 Oct 2024 11:32:28 +0200
Message-Id: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKxlG2cC/4WNTQqDMBCFryKzboqJptWueo8iIsmoQU3CJEqLe
 PcGe4DyVh/vb4eAZDDAI9uBcDPBOJtAXDJQY2cHZEYnBpGLkudCsMVH5Zlf2OzctPq205paUiv
 LeVUU2NWSSwmp7gl78z6nX/BrWYzQJGs0ITr6nKcbPwP/9zfOkmpdyl7cVHUXzwnJ4nx1NEBzH
 McX1/JpXMwAAAA=
X-Change-ID: 20241022-mptcp-pm-lookup_addr_rcu-01833ea95155
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YHgqfS0bnjI6s+u4AibeuC/tSVnbeo879O6EIvlWc6Y=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnG2XChdGiYgkoQuZhVon/R38YzVlS8yJ1jHCDj
 y2QpNYpMW6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxtlwgAKCRD2t4JPQmmg
 c5UMD/9YFI0Ptsa7Dvqb9OpcbatIk439iJWZLefyqaUYbcG0E8M7DzzQSsa1PqyqDA6INWHmN09
 zYkOyFBMbr2T0Oy7sRzG0mAV+HUdRbJxfLhlf875ScR8W2Rmc+tZr+g+VTlY3bgpkCUM5laKV/0
 owFYsWEtPk/ZV8P/VZ16FzHnvuVKetiYEzXyVQgdRmwZI5RnHw4FqxBkIzY+cOaY1v61uAHtr6X
 uWHxWf1Q2qdrfXTtWmMrBHXAytNuqTnouB2wUqODKFA2h/VPxZ2TlMfd85R/wse6FBpiABOJc8k
 5l/OP3RREfKHzyQqP8A/flE+DWRKGxKVI8jhF87tLFj5NyijOG11V8IRRydgeKuEizAVZE81lhg
 Skt5l36ROmu6ssGYYAwtJGVxuoij75EgsdwSuhrNjqAym/bXEBDqIhojoxMGBj3PrbKjKuwurX+
 ZY8a9GAHn+uL2XiT3t8eOLy4BE5bvc1OmWZ2FKMVvY6G++rG2qlVF4tmUxH5jQxePxyWT5sX+9P
 YvyCgVW7wt0WCDTFFcJcX4MshqN/9hd7guCG9xTkpgfOODZLSdXPAuBaWfc3Vs5ubWyTvxeWX1U
 zaYotOeFvXkQiyEC8dfDBfN33r5fpCak8Bar4fF0qXcn+fldygXOmgz3bAy6wMRHR6mG89I+06c
 9YeAW/2dXZbqNpw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at something else, I noticed that the local endpoint
entries list was iterated under rcu_read_lock, but using
list_for_each_entry() instead of the _rcu variant. That's what patch 1
is fixing.

At the previous meeting, Mat and Christoph mentioned we should also use
this _rcu variant in mptcp_pm_nl_set_flags(). But then the modifications
look too important for -net, because __lookup_addr_by_id() also needs to
be modified, and similar parts in the code as well to harmonise how
entries are read from the list. That's what is done in patch 2, for
-next then.

Patch 3 is a simple change to remove duplicated code.

Note: I see that we are using spin_lock_bh(), but the RCU read "locks"
are always used without the _bh() variant. Is that OK here, or did we
miss something?

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Add patch 2 and 3
- Patch 1: avoid > 80 chars per line in __lookup_addr_rcu() + update
  commit message.
- Link to v1: https://lore.kernel.org/r/20241022-mptcp-pm-lookup_addr_rcu-v1-1-19d45f26c872@kernel.org

---
Geliang Tang (1):
      mptcp: pm: avoid code duplication to lookup endp

Matthieu Baerts (NGI0) (2):
      mptcp: pm: use _rcu variant under rcu_read_lock
      mptcp: pm: lockless list traversal

 net/mptcp/pm_netlink.c | 69 +++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 31 deletions(-)
---
base-commit: c2990db510fcdde78645791def80551c0f77ff76
change-id: 20241022-mptcp-pm-lookup_addr_rcu-01833ea95155

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

