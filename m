Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A2322533
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290063; cv=none; b=vBXdsZeA2x70uRY5qEIZJ64QzKmzbRCwqSI6nj2u15yKM7uSGJYw38Xv7uuGMEqCkT/wpH35qLNOtRLm7gHWoTJwmA/M/5GmPgQ2n26sBjyFepXD6qMBBy6R2I+QdxhDbguZ53PnxJVYZ58EdIyTIca3XtXxogFoIgKCGiFFfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290063; c=relaxed/simple;
	bh=ghTW1GFEYKhf2skGWV2VkUiGnVzrltdEpqlslsFQg50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KwLuodmRx+tpGv24G9p5XiFEKCT+luTFjBUuB7u25YLgRpGczpKM/mLOHVVckDII4kCDEJ3jafEbkggyrxL1tZpAW/Om0p4GPQhzwhIqIN4NypuZ/H+W1Z/x0JAQy9VPB7cOj+ZKLikxt27JE0+D+CnEXeZoFO127lTzWcdYgQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpCI3BGK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpCI3BGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A85C4CEF7;
	Thu,  5 Feb 2026 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770290063;
	bh=ghTW1GFEYKhf2skGWV2VkUiGnVzrltdEpqlslsFQg50=;
	h=From:Date:Subject:To:Cc:From;
	b=qpCI3BGK59nbAvNLAWtZ2eVtHIS/wbViafNdx7LbiqGuRgYqmzWIbR3ZHQrDFAEH0
	 EepJbyMrRwRcsOS4v7E16rZEJ7ByX956OpopiBUpLWRyVmc98GuR38xa1Eebwt8IAq
	 ezNoY6F72o8yulayp6bwn0F+8h3L4i5ZPveLayug1z1NXCXSzgcZsY/+w3yuXppnoP
	 sHdp+IF/5naoWtzc74IkMJBSdfxsQ4sGUI9p374R/vHSg9c0/2de/XynddfnzKktW5
	 TGAq79q+TVbiqNacLazpxtCW7lQ7XQLocpKKBetrspZJyMnItxPvdkRLJz9+9rkqWW
	 3M0lykNz9LElg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 05 Feb 2026 12:14:18 +0100
Subject: [PATCH mptcp-next] Squash to "mptcp: fix kdoc warnings"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-mptcp-fix-kdoc-yml-v1-1-9858c4b7baf6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIl7hGkC/yWMUQ5AMBAFryL7bZMqGnEV8VG12KCaVoSIu2v4n
 Lx5c0MgzxSgTm7wdHDgzUbI0gTMpO1IyH1kkEIqIUWJq9uNw4FPnPvN4LUuWFRqyHVmOi0UxKP
 zFPcv2sDvWzp3aJ/nBZdzA5xwAAAA
X-Change-ID: 20260205-mptcp-fix-kdoc-yml-486f3a1cba06
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=989; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ghTW1GFEYKhf2skGWV2VkUiGnVzrltdEpqlslsFQg50=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJbqvsiAxLkNNxVOA7Yz6pd9+ZbzFOtoMb5shffOu782
 RP2IYOpo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCIz/zL8s98arudQyvL50wMb
 ZbdOlwe/n0/zNVP8dPTMC51L19P2mDD8r8zcznTso56gXW+Zz+0nDmsvFtX6L3B8W3+hebPM1T1
 P+QA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

include/uapi/linux/mptcp_pm.h is an auto-generated tool using
Documentation/netlink/specs/mptcp_pm.yaml. So both files need to be
modified.

Link: https://netdev-ctrl.bots.linux.dev/logs/build/1050830/ynl/summary
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index ba30a40b9dbf..39f3facc38e5 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -15,6 +15,7 @@ definitions:
     type: enum
     name: event-type
     enum-name: mptcp-event-type
+    doc: Netlink MPTCP event types
     name-prefix: mptcp-event-
     entries:
       -

---
base-commit: a1fbe7e455973fd255fd7f536c728f88d542a773
change-id: 20260205-mptcp-fix-kdoc-yml-486f3a1cba06

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

