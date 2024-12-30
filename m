Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC741A83ED
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735565067; cv=none; b=uBIQEBt9kkzotH5ofykZi3xt4YtOTPZNLI6FohpRVVDumuGGG4Fncsm8P1P5U4SoWcD7MULs5JX0SaadVi580nFCgBJnXGr2faq1tvLKzAXk+Um07xnuyYfngI0WihWK9M4SOUAJu+O0//VPUdTThnEqOq/C/OBircycCDBCNbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735565067; c=relaxed/simple;
	bh=Es71Mr1nub8axQ0kH7x3XSOub9QelhmHRvIeImNKxK4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LWh7oOsf8cSCkQv7c3lzQwWvHsVdTQkgWhWpl+f185hvhOtpYlfMEdNcam5OVNkjrRHdPGdTkCCdEkoYlPRVHlqGl/UmbyICFp19suyLVMLc1D/dU+lko6quMdJmtYzjYKxTI+8I01jRuMh/EhgmfAaqeRJcKkERn57Iq3dHYR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxzR0XfZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxzR0XfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1108BC4CED4;
	Mon, 30 Dec 2024 13:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735565065;
	bh=Es71Mr1nub8axQ0kH7x3XSOub9QelhmHRvIeImNKxK4=;
	h=From:Subject:Date:To:Cc:From;
	b=DxzR0XfZlkmBDcdkOVvdrD8/sOLZ9uZusIEuGhJIFptIgwoM3nqnQG/EFkPHweeEQ
	 ma1jjrGv8/FATFWbnGS40W7GwEd41xVZRXIn9DZJFycrFSxhrlsOoXXBcLppprckR5
	 HZW4OBbOaqGi5DUQnIrGDaRWa0k7eCK6bE/8roq12NHtqnrw0gaTS64P3ua0wsEEd4
	 5/wMLjwZ0cHdtEtoUCliE1jfET6dUvC635KIBzru7R8zTZKdjP5CBQLO/BZTcbjVzc
	 60CHyOrzoQySQQ9aXXFc87AaZvZdwq9wjiB08FiObSxa/ZqhW6L067BcjWdkiSVVcv
	 Zo/6Qe0NSRcNQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v6 0/7] mptcp: use GENL_REQ_ATTR_CHECK in
 userspace pm
Date: Mon, 30 Dec 2024 14:24:07 +0100
Message-Id: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPeecmcC/x2OwQ6CMBBEf8Xs2RJYagVP/ocxZLtsoREKlsZgj
 P9u42nyZjKT+cAm0csGl8MHorz85peQwRwPwCOFQZTvMwOWqCvERg0Spi7Ks6OUYsej8EMhMRP
 p1jXaQW6uUZzf/6s3mNfEqwqyJ7jnzMVlVmmMQv9dQnFsjbbcl2c0VSXEZe9crQ05rFu0tWXbm
 qI6Z6vRp5MpBp+KlL8NMvks18d78mHZCg7w/f4ApKJk3dIAAAA=
X-Change-ID: 20241228-genl_req_attr_check-2accaa49f84f
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Es71Mr1nub8axQ0kH7x3XSOub9QelhmHRvIeImNKxK4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBncp8J82E6PLpm+V4TrC3hAL3t1Qr8XVgYPVjDh
 RF4oobVcyuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ3KfCQAKCRD2t4JPQmmg
 c844D/9CdjZdkoYYM4MxhR2T9TFap1EX2LPrMlL9GCNU9roKcxyfyiolsw+3vSCjx8mlF6z6kNP
 p7ve30CL1M9y5/2spK/dhXSBTcRhikWMMxyUWXAMBRnDyNRSxw1XrhjlJx4ndCDXDPj8ihw0890
 l2XSfEdP/YhxPYKQnD7+HMxNfDMXg4v11l1t233rjJsCVGP7UoPOO4gra8uFBQrGBAtS/aazfAO
 Ey0EOSGmSLO2yCskpZkDSq0ghcsrdIhLhcK537s1eCxKNaxu41RKRwWU9SM+IIj19apVF+yKPUI
 +ccQYBDbPe+BLQ+l59wiXnZq0rMKR1NMqBBcQVmHDMWFRduDqEpvD9bJRnnq7aDLgFVkswC5N2A
 c1KnLAcqAXRFnqUxhDUzs1ASFufa1UbZz3sxpb3/Nwg3/AwGCfH+B8prxNusaOqsisBc/zGA/54
 uVLGCrIMfBO5qUEjwwT59m0/Ossmnl91jXiyZc8iMpvT5ol7/Az9SvxTlWryBn7ScktzTLIMk7Y
 xG56CCgJEg1rz1xEMg2aNVuHSo9iAj3ls/MEC+f8ti3ncWeRcJQzpXIxM6g9sJwKSEtvb7q4uIS
 D3GloiY7WR5SYUIaXTy5njB+weWCzwP4QjdbfskB/GiXDhueZ8omKel2BXpAvsWIBHfCXDI+zW2
 k4ckvYxxdoqdKCw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is a newer version of the series started by Geliang, now making
them more uniform on how the NL errors are set, and giving more hints to
the userspace about what's wrong.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (1):
      mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK

Matthieu Baerts (NGI0) (6):
      mptcp: pm: use NL_SET_ERR_MSG_ATTR when possible
      mptcp: pm: more precise error messages
      mptcp: pm: improve error messages
      mptcp: pm: userspace: flags: clearer msg if no remote addr
      mptcp: pm: remove duplicated error messages
      mptcp: pm: mark missing address attributes

 net/mptcp/pm_netlink.c   |  50 +++++++++++-----
 net/mptcp/pm_userspace.c | 144 ++++++++++++++++++++++++++++-------------------
 2 files changed, 121 insertions(+), 73 deletions(-)
---
base-commit: f770d70d123db1907d419f715117245d7060816b
change-id: 20241228-genl_req_attr_check-2accaa49f84f

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

