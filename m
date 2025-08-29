Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96343164
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499632; cv=none; b=Ib+hS7YMG5zYnx2c3L765vucpRYOnhibVa7h6Q1snNibJ64qTEJecqNTdB1x09HhY2v2e5vhv2rc/wO3n4GEih8DhkWdi7/qpjwFKbsOYwmaiQw/v7ZSFKb8SLKCRHgmKPOEcrLLL3fn257aupzG6MmVBSj2r7AfMg25/oieb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499632; c=relaxed/simple;
	bh=6xpiOJVfnSp0HZUm4b+y3GtQCdIp6zA+cayiJvK8JDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=raKxe/G9xM87vkdC/gsim9Gm26UfLF9wRbMcPmhljroB80bsi2XlkENU5tG+km4LfUW2vXAS2KVqOjiSIEe6Ekodx0TZsfS70LViGqEHsTHQ6up8cZQL0/gbiOJnJd+i8mkvYAfSyrXWQawcvhJSe/1XMN6Sb7KZtb/ZphKbvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqyz29Xk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqyz29Xk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0EBC4CEF0;
	Fri, 29 Aug 2025 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756499631;
	bh=6xpiOJVfnSp0HZUm4b+y3GtQCdIp6zA+cayiJvK8JDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iqyz29XkRvPWKn2F62yrVB9PpxAs7q4c7taU9sVrOLKGU7cqaWgTqY2gGZHIh+Esr
	 CdAywT17zuaxCliyUTCdBPkEgXzpp3vEiKY6U3a2djYGU6yKvRtUQA8X/oUGmUSllX
	 DclmsIz41GPmpREpzizON/zx4WflRPixra504DYepepAKwNNB7ioUwdL3PUaNTEhI1
	 Ky1iT+0/QTUqCnBKC79+MIONasoAXgI95JC7vxPYQQdHKc1sKWCK0Ad6F3bBTxjdN7
	 SrzxrA847DwD9UEf/CyxWNeWjwcjuCLO96BNKuiwS5wm/GkxkTApGPqYkH/LHEQxAd
	 09B9WgOFwPAcw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 Aug 2025 22:33:34 +0200
Subject: [PATCH mptcp-net 2/7] mptcp: pm: userspace: respect deny_join_id0
 attr
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-mptcp-pm-user-c-flag-v1-2-78b25dda7708@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6xpiOJVfnSp0HZUm4b+y3GtQCdIp6zA+cayiJvK8JDY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI28a0wnT3xX/bBU/+E1FckGQTaePl6HcllTF327+tu3
 ry/TI77O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbytJaR4YK8+92ctT6rIz0F
 z1p9LpBz7LwjWfTjdG+q+zO28OVxQgz/g1f5hGTm/hN+/Iq1583BYwpFlRvnT8+39ZLUd/zYfia
 bFQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

During the connection establishment, a peer can tell the other that it
cannot establish new subflows to the initial IP address and port by
setting the 'C' flag [1]. The RFC8684 is strict about that:

  (...) therefore the receiver MUST NOT try to open any additional
  subflows toward this address and port.

It is then important not to let the userspace PM establishing such
subflows, and return an error (ECONNREFUSED) if it tries to do so.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Link: https://datatracker.ietf.org/doc/html/rfc8684\#section-3.1-20.6 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1911fe1799fa38a53381247a830a9a0daf1c4492..9968dc9a8b45112114953f66848ea22c971136d6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -391,6 +391,12 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err < 0)
 		goto create_err;
 
+	if (READ_ONCE(msk->pm.remote_deny_join_id0) && addr_r.id == 0) {
+		GENL_SET_ERR_MSG(info, "deny join id0");
+		err = -ECONNREFUSED;
+		goto create_err;
+	}
+
 	if (!mptcp_pm_addr_families_match(sk, &entry.addr, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
 		err = -EINVAL;

-- 
2.50.1

