Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7647FEEB2
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004134; cv=none; b=HMDTJ4eOPWZAppwfjn4ksR7D2oa5n1pIQMD27TzaAyFmU31cfrMQgkX3cTBP5wv8YhYdjKoTLOvdxtONKZDBPyZ8ym8b+usksziHRYN0lp1ig5iP5Bbp5VJ55M5BbXuyBzAx8sAu1Kjq4jdiPHF4YAQJWJdUrpk07mwwKs6/xTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004134; c=relaxed/simple;
	bh=QTID3HPrjG3lfKaMKRNmiCmpVrUIWSta/TU+7EZDKz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hx8YzmelHWj79XwGevmsmVw74Q3cdBlh73EbtPFcdeDens4Zg6sRh5J8HCbVmtIcuzj6VIGlXLEFv8SWM7Uf2kZ8GJ6vP7A5QFPR3r39tT19GUi2irDH8UqIb2ul4B3ybXbD027a/w5QOLCa0200JnFDX9QDf1lYytiDpolpdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S44MB1kA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S44MB1kA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D862C32786;
	Fri, 26 Jul 2024 14:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004134;
	bh=QTID3HPrjG3lfKaMKRNmiCmpVrUIWSta/TU+7EZDKz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S44MB1kAAUefV6VFqroSI6BYWtrbC8X3HwwWEpSuK06JuKq8jo/JMEkLvstt00KSr
	 0zqRvyk0bN6Rf6tldl5d6hmx6rYqZnkTFECPGBwzZFZ3tv4tjHZCH6wKTRfw+bMJEY
	 F9AybpDHHhrQJvG8iX05DbuXXsPtFbIOKVk5ehjBVViDHUknh7kzWzDTJRYt7hv90v
	 J5HzrjLV8pSq0ygw68NMrU90Ute7iVrPFOsDFg0JdCJyUQbpPcIkFBrzfpJDIk0rQS
	 eR2hLHs+fDcqze+XihT3/2UGq76OQoZy3E1NmwuzjHfzPqDdNnwHEAhYUnPOYKlUVq
	 Lfqan7so2DXWw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 16:28:32 +0200
Subject: [PATCH mptcp-net v5 06/13] mptcp: pm: check add_addr_accept_max
 before accepting new ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-pm-avail-v5-6-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QTID3HPrjG3lfKaMKRNmiCmpVrUIWSta/TU+7EZDKz8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7KcMv+H0tU2px5aGuQTAJN4XmAcXfL6NKqOS
 lpHAQUorDOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOynAAKCRD2t4JPQmmg
 c0qoD/4g1pvgOXLNiKkaM4Mr4RD6a9UYyKL1CCLPHXL81eJrrpwFm/ze83pM7dA5tkmQwsgsZ0Y
 BYDf/zO1vmBTHgVlkAl2v85pGRGEfmHJT3OMmqVS6IsEc3ITqHzDlyxRjo76zjizv819hExgY0p
 NbRxJvYuFuK3ENV0PKzeyq3atCFNawKM+j97aOn7nkW9bnQshEKjZJwwLGX4a5O9sVs5L5qRphF
 k4ppzkMI2Y+ZrRx+tX5+3Fw5QrWGGiAuL0Wx7bnGiUwfF+AMJejpd9M0HO4gs9Qd95XkwFChe8O
 kQ9CZREXzaj4nbAma+ZvZXYL2Wp0iQtynjzVhUAo9Q5kqUAngccxoeSv8aD6+5A6ozi5sU1JigE
 2TlAvU5WN9v2wA8oAv+QxqmKh2jnFFsUYW7hgWhpj2lX+RDfoadB0eUGERV5ePnJGzSNvjJvbme
 oYNFVqYZ6YyhFlWFDiFIof8e6tyFD3qN1xEMQrgtJz+3Zwn/NltgYJB2Ka6V/CNw319u7iFBmeU
 7jP4KyvmBSbOVnC7msRP43oD+4UDPKYMjEyQKpLBCWDpMZaoNQN0FU0+iAPhJhG3Fko3hbDyEe0
 5YGv/hJfsTYV71EBMhwO1sD7i6nc9zXHg6bkTQV65s6DrVt8BUMOA52WmQzsYct91yILmTMgQBZ
 8eQks4aarKie9BA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The limits might have changed in between, it is best to check them
before accepting new ADD_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 061fa3183eca..3cb02fe359c0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -848,8 +848,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			/* Note: if the subflow has been closed before, this
 			 * add_addr_accepted counter will not be decremented.
 			 */
-			msk->pm.add_addr_accepted--;
-			WRITE_ONCE(msk->pm.accept_addr, true);
+			if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+				WRITE_ONCE(msk->pm.accept_addr, true);
 		}
 	}
 }

-- 
2.45.2

