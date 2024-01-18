Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E752D60E
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602478; cv=none; b=Y0BWyrn0LRIW5b7Ac3puz2RUUaNSKOU1ilSOr31bli+MFJNZ62M4WNIPZQQyvqtRXDffTH/4e22zq3gvcdCUgUisCdTuHWij+NZuEd93aC+DvgyERmOQ0qUGHAkPk44FHc7bqwjKFDXQpJtpeJhuou8xGC+Y3Ep51jQs3vFiiyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602478; c=relaxed/simple;
	bh=CBxGEhmYoe2IXYemBuahKjX4uInIvhUF6dVMSB1vXAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rw2TwjHMfp1dnW+a/ej6Q9Gkw43ipBDx2urprUeuK1UPRSzeq1naaYLZXJ20A9slYnKXyXmCJCIIt9ylD1jgr7i4JbSjl5d/hhWXYqpxurNf4OKByUUXYo2Hp4FGlbZW45R0zLfZs6wBCB0Cufe1GqgxmU5Nkh2HqeNryeKpNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBb83ofy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBb83ofy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB1AC433A6;
	Thu, 18 Jan 2024 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705602476;
	bh=CBxGEhmYoe2IXYemBuahKjX4uInIvhUF6dVMSB1vXAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TBb83ofyUEq8IQcHDAev/ZVQxD7FB8CqvqTc/bVBTwePQGlQhv5YE3mi85+kWkbM5
	 SeRVRuCcS3aBLBZoGdkx9X7cRnG3dSYoI6Q9M0pUaUykO/7U+Kcg2y+FKfxnUtjTaU
	 9j/LlifsSOqouvx/vD+xapYA7hVoba1TTYzh/R3X11J9TXEzrKBFMaQ26PDo4cKSS3
	 A8AXJwBQbjkJVeQvuLI1zIGmxoPvyb2lKb2ZSOuws9bfeyeoRee5hpxLLBCbqwJe9x
	 f9xbYFLsSTkLvh0ZzESuD3bF8cKDs223YkeRbXAMw47d8RsOh9oB2Zh1TctJdkSkbF
	 w4hP5niiB49Yg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jan 2024 19:27:32 +0100
Subject: [PATCH mptcp-next 2/7] selftests: mptcp: add missing kconfig for
 NF Filter in v6
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-2-f3a4db41c3be@kernel.org>
References: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
In-Reply-To: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CBxGEhmYoe2IXYemBuahKjX4uInIvhUF6dVMSB1vXAA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlqW2pFRKvYqqPNbPZx1OLu6Bt6ZdEzjxLzCP6V
 9KbIX5XwJiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZaltqQAKCRD2t4JPQmmg
 c+4JD/4sII7A1N+V5fgJ11FyYOjKFe0sk4CKeQtL4G/avs3uZ6ZMYnEIyVKZv1PVnaeCAjk9eGO
 JLenOWvYEaW6Pio2GdEBPFNJBgSgaKnVKwkT+vp6FOhMZc9FPXO5J87saVuTwx4fcFOxsG3BPT+
 BudXKnKLGKjCV2+J+5wtVAAxUX2zGh1MsIMwvXMuNGxTdLz5dYK7QBAZrsHatA+QZZVgVC1Ts2J
 yJtyRegJn8jbOMcqmIgRdk8Lnimc0kDFfeCiVvI5hTrRNladeTuqJrbvKEIZ8ertgowUtTHGGe6
 txSJxPheaXWXdQD8ajS6KQCZWtrroAU9QDtU7tToll/1a7vzhKhGtgE+kslrlkjUCXKGq8vhbaD
 8pzUKPDN3o3Jv7aIJlxtBo9nXaqEFjgPj2svIHkeupO063djWIg+M7n1h1Rmdv2tRrepCkKkb98
 +KSuv7e+UVG3FpG14OpXB7HzmLail4v/FBz1heQdosYKwM1kbwtoWeaieqwKYn0kdquCGdTSYC1
 jENeSulkuGG3Eb28xXnxlwvFZb/NPkH7w0EaTEBj4jsmZol1diy+Eyc7iuzbSOfrWPg3DxP0QW8
 pvaUqj1eyShDJBh9gsfFoQcAwIwsYeCComGAYy0l6kvU3kNNJkplY8ob5ZuiAQyyTQETsXYNps8
 cVFzrZNb5zr8vaQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the commit mentioned below, 'mptcp_join' selftests is using
IPTables to add rules to the Filter table for IPv6.

It is then required to have IP6_NF_FILTER KConfig.

This KConfig is usually enabled by default in many defconfig, but we
recently noticed that some CI were running our selftests without them
enabled.

Fixes: 523514ed0a99 ("selftests: mptcp: add ADD_ADDR IPv6 test cases")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 2a00bf4acdfa..ec70b27288fc 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -20,6 +20,7 @@ CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NFT_TPROXY=m
 CONFIG_NFT_SOCKET=m
+CONFIG_IP6_NF_FILTER=m
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_NF_FILTER=m

-- 
2.43.0

