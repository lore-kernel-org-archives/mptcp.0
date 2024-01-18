Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3252D603
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602476; cv=none; b=R0ySEVZGYBFz1zlJ5T1KhOwmmERVdYcwD1nCbuZB0cb3grvtahgzCz4T49WjK63Vy72ZjJG/gr6bH6Aplw2sesT75MGHAMA/Z0QEw7QGUmbfob2nJHfaveFLPbnMhidDL7WDyyEhlWdFgIQIjE/LuorsZ78VjHU0QOCY1mh9Ruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602476; c=relaxed/simple;
	bh=SDBb6RXrWYX1luv9PnOcPtbZMucA995tbj8SOsqw+Gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcDWyqv0cOhzCW3mjB4rpc29uP5IrGyZd+KAxNwVLAkr+x/HIgJuW20QHfe0VHiWjiPC/YG2eagC8zrMs9YuHP4s0SIe41OOPZYVD+rcyW6QN07wBh0IamByO+lLVbRV4GPQsOwnwgNITORSyfzhyEaaaeng21O00x6URS4V32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egt8+hpE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egt8+hpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329D3C43390;
	Thu, 18 Jan 2024 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705602475;
	bh=SDBb6RXrWYX1luv9PnOcPtbZMucA995tbj8SOsqw+Gg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=egt8+hpEquL4zj++AS/TSWiyudBmlGOQ5gGKAut7rbJyTPWRhiwA5OMHNUl8jDfHd
	 VnIblGmft9E8/UagR764kjWJ0YwQswsjRY9KctvOgkNnWsJZbtv44XFlKRmahOj1+9
	 beAsB7ry28VgWaKNI1I+/ViQiDuQ9Hd3CaM2E7EfiWzeBPABf8dqGvN5os3aJ1OcD5
	 ++2OaRz5YFZUhDZWgi2kpr9GQ/q/pkdk1uMJAXN/XSjcT0aWj36xeF4AMi6C4EjQhu
	 ZtVz8p35HpOGhdo+Z9hcMICxHgq/t4B9Kmiq/rbd2u3KaxOzLAHl2iNissZTBe40c+
	 EjuonmRZcCUJA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jan 2024 19:27:31 +0100
Subject: [PATCH mptcp-next 1/7] selftests: mptcp: add missing kconfig for
 NF Filter
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-1-f3a4db41c3be@kernel.org>
References: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
In-Reply-To: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SDBb6RXrWYX1luv9PnOcPtbZMucA995tbj8SOsqw+Gg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlqW2pS6Nrz4FdLil6jAX5zq16e6lAjZwlTNrTJ
 8oI4H3mHNaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZaltqQAKCRD2t4JPQmmg
 c3A6EAC4lafHwhn+OCZm8V4nIHQvvYEuh7ir1uqdxC1IdgNcDFTd0d3Ah6Z12iNp4183CA/t/u6
 rmqko6bQzv5OA3H6PD4Hwy33LdWPSOwqlLB1UJO5AMMPeNiJdIzddBM879BNDpRpOOTPE4RGUUv
 ZIRcJGGvqUyKs2trZcGixRTBcbCGWlC2mEIM8kSi7uynA2budRiiA5caJKNH7ycbSCPSQbJeC9X
 MS8RECeSRlGwepaAc+7EXcanJpia6UBLU5MBd/rLI/NjFdyfy8L8VKsz6ceBg6h80Gt0j8KVFJK
 8skF+AfAgWorTbIuvlkirHJuzefyLCbC4QmRL8RFxS7dMroTGi2mEtokvgw6REJ08N/yGhRsnTM
 9sMgwEZvBYhUrgeSoZoxYy+0Cs4FUXyP7gmAZEK48IczsTgq7syohGTjUeNq6fU8N42V/jd3TBO
 NXL/3ZgagwZXyYwT5MGAJfHy0qcTWJE937YZQ5Mnc4j4/xpWT1Oj4qcIzWzdJ9vJpp1lECwmQu+
 tLnnuq1eUViy3YdfHLXn3wZBdHdGGELO1MhMXP49HgxzYm7rv5b8WsK5OpuxQRn1b2/OC/2/Qi5
 NTzu6bN/t0YtxfBPgOSdu/1wzvLSYdZhofA6UVz12JK+daHNxILRMYoAgK1FMTQsATH6ZP6Wtvp
 al+SBA7Nht91wTA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the commit mentioned below, 'mptcp_join' selftests is using
IPTables to add rules to the Filter table.

It is then required to have IP_NF_FILTER KConfig.

This KConfig is usually enabled by default in many defconfig, but we
recently noticed that some CI were running our selftests without them
enabled.

Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index e317c2e44dae..2a00bf4acdfa 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -22,6 +22,7 @@ CONFIG_NFT_TPROXY=m
 CONFIG_NFT_SOCKET=m
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_NET_ACT_CSUM=m

-- 
2.43.0

