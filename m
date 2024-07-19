Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8467A83CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391883; cv=none; b=X1lzYrU16c+GhjEKlJnZAGX2aT4vnI1ZIF7sIajf3kHFdekhsJ1aBwOHxBJKhg6sV6qVMW2E/8dKeGjPRoUmKzGHDYMatmnTJFAUidLj0AtXXDDfSOFWVmqs+1flgWJYm7u7EleA6W5f/DizLAmBQPGQLfF1/INuWHYPQ0Jqtag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391883; c=relaxed/simple;
	bh=2I6vmk+jwCRqxKwCtsRxnsAvhqqiS5h3MAqfuPR50Z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtTijtux40B8ytq70MTuiK0afcWvHIpOm+luMS5RZo2+NGEzj39mZnmVVOfLZyYIBdSTObRM3AhSBX26LPhTxFMLAUYTFrVMz4Ld+I7VflVvDIU9pHTg9Lu5NfQHt59JaqkQOY9Uq+vAAHNwhkpFjnabI2nmmQ5LxfIna2HLiAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyrXbgq/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyrXbgq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6846AC4AF09;
	Fri, 19 Jul 2024 12:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391883;
	bh=2I6vmk+jwCRqxKwCtsRxnsAvhqqiS5h3MAqfuPR50Z8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PyrXbgq/0roTqHe3F7c6niKFbRYdXoq6feE5gKugNZF4BSTN+8MLzQwpBPYSTal5j
	 N+SDKEpsDEqDktl9fZtTFCwYSXxlFErMdCiIlxU6985gjGA0CXzSUUzTz83lfsVlZM
	 aPh5oL5gtI/+0ENsL0lwMMWu4o5k3Q+XDZ9WjT2VubLPSMv//w+8mztBTZiu2W1o4R
	 rWnlF1RsSeGdeorUK2IIAjN2GUB5KCuXIllyNnCsgp/aTjvo28ZM3lFG+8XNk0pYz8
	 u5MK4VNwAvBo+/KxiEtN8heIjnmVTlzMtVkJyPQvry/hEqoQTGUyHsWTj9HkER1Eqo
	 jDXEeHi8Hq+rw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:19 +0200
Subject: [PATCH mptcp-net v3 08/20] mptcp: pm: re-using ID of unused
 removed ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-8-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2I6vmk+jwCRqxKwCtsRxnsAvhqqiS5h3MAqfuPR50Z8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlr/XS3QjNyxEGoYyOcwIhys5RFf1opKQXsjU
 uY09a+FFOeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppa/wAKCRD2t4JPQmmg
 c7EsD/9Qse6diF6flBXjB2TT967Jg8Xo12EXfB0oeFhBACSDoY0lZyMkE1XDz73DNUW2klTANYK
 HIqbBPgSx9qPn+HgWq6G5ZaNn4Vc33/HfzWD2vpR7B48+o0mJreGrOt/155JkZwT37iRPIo4wBY
 W5YwyRZM/ZFL9VFmt42P5MgopOKPEWQ68r0x2f1P6BFkb8EIrarIdB03igdDhe6C7E2qtllllp8
 2Qke2lbYcLNSwjUzLK31+TJKFYZUAE0BkhmDu8JYXUt1pJl4AV5kNOGGaUL2pyqtHJv8EO6bD7H
 qCI+XHGIjR+qUZqbq6GoF0YVLhlyhvpcsUFaNtAiiSg7P/S2DHc00aZV5N4jfiHtrZubNLCJLB1
 kOCxSVyYPKZeATjHsOg9edyWPS5+7Pz/c6YqmB4N1myy3yPMgp6BsJfiBdNBWfzzf/07zv/iTHv
 y8y7/qwvCyiRWM1Ju6rP3TUl3BQ9QaiVVmFu1NWCSn3YRaLgunxHFjGLmAhGl7T+dWlCCf3TTTJ
 2hzJXQ76FMGhIU54TAnzc/8nxg1kIwHE90t7YaqEEet89vKA91DZDuMUdDsdpvPB5jjY8YDJn+D
 TRsaASWIXZ487YmvNY0YPvuscq4wwAw6KPVjimD0QTEvSlY97Y9wdc4Ha5LsCJovSa4bVIrEAiw
 K7wdrKoXDOWkWgw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If no subflow is attached to the 'signal' endpoint that is being
removed, the addr ID will not be marked as available again.

Mark the linked ID as available when removing the address entry from the
list to cover this case.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2e94f2a9f2a6..d44d318dce03 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1394,6 +1394,11 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
+		spin_lock_bh(&msk->pm.lock);
+		__set_bit(entry->addr.id ? : msk->mpc_endpoint_id,
+			  msk->pm.id_avail_bitmap);
+		spin_unlock_bh(&msk->pm.lock);
+
 		list_del(&entry->list);
 		kfree(entry);
 		return true;

-- 
2.45.2

