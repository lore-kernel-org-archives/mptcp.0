Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49913C3EE
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752297; cv=none; b=dzeExzkOqXDZepKsRLBnj4r/X9hL/JEObScozwrBYylL6gbBMTfScnM4nNIjrUCG/xNnGEGCJyUb5eHV77zBi57IV5FpHnnYpRcacBFppLPPz+J/YFFhXDwypxdRpV9yDIxY/TY/GFq/tUVoFahaqjHsGz9gIOW/qtZ1s8IcojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752297; c=relaxed/simple;
	bh=PplTJohmT5S2cPHnQWFnjnzrj4AGTAH5tTm9GIwqejA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GFPi7N3FdMMkLXN6bA/OetLXp10FnVxdmi9MgD0AxmJ9CIWyBaTwvqSy3L0q6PNXqk40qf7Xqa6QdKGzNpJeeYmN2JHiIRbRlGUAaJ5Usa3HOL4M2vLmnbLAdYZb9sGObaQCMC6x6w0vZmug1JM6bdH3BtTbJ7yokWgb+AIKNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrNcJadc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrNcJadc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E3EC4AF09;
	Tue, 23 Jul 2024 16:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721752297;
	bh=PplTJohmT5S2cPHnQWFnjnzrj4AGTAH5tTm9GIwqejA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hrNcJadcmAmRpO0eWTBZjOrOsUnayRY1Po/gtNKxTagfwM1le1xwQFViFcXU6ZZPl
	 7lnS5VCQRORbd+X/3ToVfthJzPTZpZSMPayzv9UoLjP/5L8PBoGu1/z2c3jZliNYwx
	 y4Cn8OU3qEZ3W+C4wmtqK39isYPfChaZ0KsnTP6NwTDJ2+At2asM5glGdmcvVpGsXz
	 PRRzPw2KLWU8kHvckWhdwFZRL+BASoR1TvYY1Rd4c3lTmRdnv1ZhkiWlaHfOqoUuBx
	 GoCgOQ4k9t7FZ5UgF88sIC2nzqcsYd81dwnYNABP+0aSm2qWlvEcXnax/bPs3JcTzd
	 dsemRjWTr/5YA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Jul 2024 18:31:09 +0200
Subject: [PATCH mptcp-iproute v2 6/7] man: mptcp: clarify the 'ID'
 parameter
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-mptcp-user-feedback-v2-6-59f18975401c@kernel.org>
References: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
In-Reply-To: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PplTJohmT5S2cPHnQWFnjnzrj4AGTAH5tTm9GIwqejA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmn9rg+mb1EHXAkeQlL3ckSF+TFWDxQJR2HpJ9D
 QPCQcgYebOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp/a4AAKCRD2t4JPQmmg
 c/TVD/44RmK8qgbOMcCiAgNbo/Hq4HqvlmFSjpBLHbqi0KI6SrJd/WCSpvdBmX519dRBpzsV6u5
 wayLGssNT7hMJ5+xJm8SIsKDLirWPhfMnBHnh5+LvCnwsksrpaYZet4aZ/5tod2NeTHTMjxyiMC
 Gn87W3/ZmQlkG94YNvMlFxfoUhV19C06DlU9mDVx0UbgvRPsV5m2kFegK+twLV1ok/Fg0zgjBwW
 4PghRJklPZw5DeCtACvYXEjt5Ixvjx6hkJxPop4D7CCb06ueSC5K7iPKv/0sw7hI43Dz80+uEvg
 nJoOOwUJ9AxObhIBl2ymQXDMvhgUcS7gyzkt9kZQmb9hzIvFZQ0fONHfl6c3YW2WJ88U8cWNg4q
 oJDMK5IttXvGizA3lVMstWCMjmAggbsVvW5TW+lpZWqX1OHpP7JeHX9x9D1fdMdAyFOoT+faSXo
 vAwclWawcYJBdtMfPMGSpVPW6ouOkGtzU+2GAGTb9Ir6+R9VttFbL8YPjQh1s7NzIPouKcUBiGt
 1lcN9pZ0W0QIT2c0aDP8tSaP5Q+TqYIJ4ii/m5Bh2+07G5gnixHcIcG2hO3CEA8OenFxFTD+Xbq
 H2F/0COGCnd5JmPTwI0hObJbsaqaRtQqGjFnkBcZZyEnf31GB2aZ6Uoj4dts2xF4GyHLLRcnELy
 DdPdhh5q3GzbuJg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Explain the range (u8), and the special case for ID 0.

The endpoints here are for all the connections, while the ID 0 is a
special case per connection, depending on the source address used by the
initial subflow. This ID 0 can then not be used for the global
endpoints.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 7eeeeef2..9c2e4ea6 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -148,7 +148,11 @@ expected behavior.
 
 .TP
 .IR ID
-is a unique numeric identifier for the given endpoint
+is a unique numeric identifier, between 0 and 255, for the given endpoint. It is
+not possible to add endpoints with ID 0, because this special ID is reserved for
+the initial subflow. For rules linked to the initial subflow, the path-manager
+will look at endpoints matching the same address, and port if set, ignoring the
+ID.
 
 .TP
 .BR signal

-- 
2.45.2

