Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D91AE029
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622675; cv=none; b=TYWJTN6898jE2w1waA/003B54WyUXP23Pd385qR1/VhRu0SnGK1O2/rsTx6+4jHgXZcrnAuiDC4jZR+gTTUbNS9AoS4gjrASb63v8iIk3hJ4nOgaczdwP7tWlvCgV93ikcunB1sM7AUQsF1swY6vNdkWiCTrwFtj5H3xEHsgfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622675; c=relaxed/simple;
	bh=p+sXssKBRXuyrzTaYzPkdWCwoZsrUTtNBWkEogLEWD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NGeCeq6uMqYps+gpN1PCVeU7A8xDtvM1c/yBWb6bhQrInErndc5yqi9iqzJJYI5ZY12Modp+h+UUmHZdQ0XH/tvbyRdREhx/vTc/pAeCcW2KntKY0aA2uU8EDzOz8dezHhz1SRAS1NhCPbeRVzb6DyhETruwz+7P00Dxfgkxhi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnWJmDak; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnWJmDak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E32C4AF0A;
	Fri,  2 Aug 2024 18:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622675;
	bh=p+sXssKBRXuyrzTaYzPkdWCwoZsrUTtNBWkEogLEWD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZnWJmDakmYJczPTgxi5qavfHjuQsh5g+AUSibPLJ5hwX3dQ5HSrNEwvxi8HfwL6/k
	 DQd1Or9ChgzV/LzcJLnrwevSboQMkAgcAKiL8q0soegsvyjy5WpR+yEkoW68hMWCHI
	 HXjvD1dtcvCVmpTFNfQE3gXfXE/L1o5KZE1Q1Pxx8SZEyFAVKzCbpww46vH7DMfYKC
	 yGuvrANPvis9APPmhirLZbM6uMeSs0FgeMnbyfHbss+S9LBw1rAYzerCVkWr33H9f4
	 OYCJ2Y0UTnu5V9fM75ZPLwdqbvyXh1Kw8JgSyHg3meFpsNmn3n9/MPvO70qdsBrici
	 iK1YCCV2W4qoQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Aug 2024 20:17:42 +0200
Subject: [PATCH mptcp-net v6 05/11] mptcp: pm: send ACK on an active
 subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-mptcp-pm-avail-v6-5-964ba9ce279f@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
In-Reply-To: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=p+sXssKBRXuyrzTaYzPkdWCwoZsrUTtNBWkEogLEWD8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmrSLL/0wqM++GZ36mKcdZT9ITSHDT7Q3zdZXzp
 LGRQtJTQBaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZq0iywAKCRD2t4JPQmmg
 cz30D/97tFh266UPuc8n0HekeOzS7SyqPvJb3OR6fGVNsA6vLpOB8KrkB9i0RZPK1y1byRl3WRp
 I+QP0Smp2no/8eOS5urf7j6ScmUvPouYsHA5CDf1Ia7ntpGxQSPYmmUgd7xcEsD32MVSHs4P6oB
 nszrN7HY619y2esbMsBap6QXHXWJRJKLelbeBUySVlFOXtzDcGf/RUhtlVvR+UPDnWsgFBK7l/g
 NBmsArjpHCxKGoP1/NsSE4zV/CRWS2qo6ynCepdFKSF0irO2/hrDKgioSCvkzeVBQTwQ4yeHMLc
 EQnQfYNhuE7Lc+vI/03+TgtLfZVG4ntdZSz6TmwUNpSFoyCEs+jIgpvKJCVlORoBsQEaivhvaSA
 O3AHFnUzJ3TgQoEH7/uUgtLlW5JyjAvchkJulWR/aHFBUqghuk0SBI0gpbmW+vncupARdIYj57Z
 sb+E1iGGPXsXKw6avRH0PfYDIpjRQRvYMoCdHRkY/jmCaL4o5g5uUwS9sXWjjORz2wffDK5/hpL
 UW19q24wIRytXuAjhdu3a+68MANwquchIVegY1ESpGK4hkLS0WrFNJUEBJhBzSLT6UoIy2b8qDZ
 rUm/LHmK/3TgSwLtQA+LmsQFFYen13XHY8OyTd2O8L7BKXp4QjQ5+rwihI/gGw4o+D36tbhpK0F
 aP9cIiMvisF9WNA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Taking the first one on the list doesn't work in some cases, e.g. if the
initial subflow is being removed. Pick another one instead of not
sending anything.

Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - We could also check if the subflow is not "staled", but probably
    best to do that for net-next only.
---
 net/mptcp/pm_netlink.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4000de54c99c..e25cda3909fa 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -768,9 +768,12 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 	    !mptcp_pm_should_rm_signal(msk))
 		return;
 
-	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
-	if (subflow)
-		mptcp_pm_send_ack(msk, subflow, false, false);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (__mptcp_subflow_active(subflow)) {
+			mptcp_pm_send_ack(msk, subflow, false, false);
+			break;
+		}
+	}
 }
 
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,

-- 
2.45.2

