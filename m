Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36DE1A08DB
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615402; cv=none; b=REW47yF0HkT4tv/DX+SS9PEfQEMZ2LAxiDOG9QU2VM0RayJK52Mx5wxZt/V80gu5DK7gWxaZMT8KwvMY4BfDJ2+FbzsIgQXTO0J5W3CYMyvMbatAQW+8vQ8E48TcMyz9HgFgAB0b5917+LVJ6S3Udhy+MFAOEZJa4I5tZzMv+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615402; c=relaxed/simple;
	bh=yzdeFLazRT4M0G8gEpKnDHPg0IiDgr+vUh17bkhfMm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JATVXSwgvmjUg8wIlYrT6xzHTDS2u1Fl2L1Hw1MhSGCEzm+pS3iUN+sy3nNzvfYBNcgwoJfYp8RpfZjx8JyPWQcHkcbyO02fiw/n1hOK+c7bgTfY3rFaKU7WMc5nXMyk8RiLQ8a529SKbk0HbtJQiXDuR8tARZRZbWZzsHgh2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+X+tEtj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+X+tEtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BDCC4CEC3;
	Tue, 22 Oct 2024 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729615402;
	bh=yzdeFLazRT4M0G8gEpKnDHPg0IiDgr+vUh17bkhfMm4=;
	h=From:Date:Subject:To:Cc:From;
	b=F+X+tEtjJFLSaUTr3KFJ1JyWj1Wf0+tgLgR9HT3eAHMSK5LY8ctWNRhrIsmLNZ/As
	 rucRAvQb5qWGjWLExNKd4IH2Mi7S1DKTv6MtdNS12CYN1N1+X9rdaIkAgnCk6dLDhE
	 +a0hoVTBD77h3Xp5o/ymL6X0145Ik0sp5XXvuRuVB24hmUXmrICKr3aBY3iXaRd9LE
	 0Hl4pvDfhMBxsZdt65tsdkp29Ux/GTXqbbTH9RR7y6WBcv1riweQjecn8MEcmHv5Nr
	 ROm45aqHECKe8Y04WUJWHfk426qtxorr5zTdm1YbGkHpMPOj1QZ5Ymgcqktbdcl85S
	 pDViBvx5U90eA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 22 Oct 2024 18:43:08 +0200
Subject: [PATCH mptcp-net] mptcp: no admin perm to list endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-mptcp-pm-dump-addr-admin-v1-1-9ad328d01817@kernel.org>
X-B4-Tracking: v=1; b=H4sIABvWF2cC/yWMywqEMAwAf0Vy3kANuj5+ZfGgNmoOraFVEcR/t
 7iXgTnMXBA5CEdoswsCHxJl9UnyTwbj0vuZUWxyIENFbojQ6TYqqkO7O8Xe2pDgxKMZiL5VWXM
 zlZByDTzJ+a5/8K88b9Dd9wOk6/A0dQAAAA==
X-Change-ID: 20241022-mptcp-pm-dump-addr-admin-0b226758e9f5
To: mptcp@lists.linux.dev
Cc: Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yzdeFLazRT4M0G8gEpKnDHPg0IiDgr+vUh17bkhfMm4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnF9Yp5sGN9ovz3o+0Y1HJuCdXTXS5FAkl6y5DA
 /SiBo5cb+mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxfWKQAKCRD2t4JPQmmg
 c9ClD/9TilHuabBIgStoahqpCfusJYiu/kUUgRFIsxKgulF8O2N8Z0WmF8MXEmkLa8zXIHA1+8N
 i/3P172UJQRxNX+8wpil46yFjk4eYEdhbV6W4qCoYy5QGrPr4MMm+113oR3R1amu6dv4debu+J8
 VmhkPRFHCYrWdji0NVeApplKZCX2CXOTMbXwdJSDDxZuhW8k84uJk6TASzMMn5QHHrapQqlWqrc
 lBfhv02QpxWd0ERsAaX+eYCelDOz3ghEKTS3qaIazxmTj1cWJeiQ2ykkPOg1Nvu3+TURVCocvRU
 6r34RhtaM83m9QUe8qufW+AssqK5ioo7ZVlUmZQ0ddXMCovdemIZycZrLAeSvbAppxQElXweh16
 ZNmHEbmR7Doc17baJ1yvWTfsnqjpStvePgYHmCnpRBQbU7UW0LCed62/Sr6jWWJUcH2k/JRzorZ
 62VZExm7YRoKqBVjoPSEl7/AEkuACqcs+10ocGaDfhR3eOjaBtobRTioCiY0sWVnOnlWaALj4S7
 9Nj9hiMP/iEAT+21R2RguQ404errqKKKbTt4e0PHzwIR1PLb0Lf2uRAtx2GOz1qohNr4ebU4dgE
 gI8BXGWAN3SkSVXafYhFlfaeUpWy+dilhZyZj0t4b3HA8oIEFm0L34aaG8BrMv/y3opJ7KRqYTd
 XAA7lsMi1XBnfOw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

During the switch to YNL, the command to list all endpoints has been
accidentally restricted to users with admin permissions.

It looks like there are no reasons to have this restriction which makes
it harder for a user to quickly check if the endpoint list has been
correctly populated by an automated tool. Best to go back to the
previous behaviour then.

mptcp_pm_gen.c has been modified using ynl-gen-c.py:

   $ ./tools/net/ynl/ynl-gen-c.py --mode kernel \
     --spec Documentation/netlink/specs/mptcp_pm.yaml --source \
     -o net/mptcp/mptcp_pm_gen.c

The header file doesn't need to be regenerated.

Fixes: 1d0507f46843 ("net: mptcp: convert netlink from small_ops to ops")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 1 -
 net/mptcp/mptcp_pm_gen.c                  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 30d8342cacc8704c42b84c9e03f96c906e81733e..dc190bf838fec6add28b61e5e2cac8dee601b012 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -293,7 +293,6 @@ operations:
       doc: Get endpoint information
       attribute-set: attr
       dont-validate: [ strict ]
-      flags: [ uns-admin-perm ]
       do: &get-addr-attrs
         request:
           attributes:
diff --git a/net/mptcp/mptcp_pm_gen.c b/net/mptcp/mptcp_pm_gen.c
index c30a2a90a19252dd41a74109d5762a091129269d..bfb37c5a88c4ef90740699dfda345b52e206966b 100644
--- a/net/mptcp/mptcp_pm_gen.c
+++ b/net/mptcp/mptcp_pm_gen.c
@@ -112,7 +112,6 @@ const struct genl_ops mptcp_pm_nl_ops[11] = {
 		.dumpit		= mptcp_pm_nl_get_addr_dumpit,
 		.policy		= mptcp_pm_get_addr_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_TOKEN,
-		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
 		.cmd		= MPTCP_PM_CMD_FLUSH_ADDRS,

---
base-commit: 66bee427d4db76bd1afbf0184a2fd1f238a4ee27
change-id: 20241022-mptcp-pm-dump-addr-admin-0b226758e9f5

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

