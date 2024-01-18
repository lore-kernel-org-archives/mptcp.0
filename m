Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3B2D603
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602478; cv=none; b=Ob/nH+RyJoPBA+e6n7fh5QPnbjTZaWWyomSdj/wTUNClOWT3x5KHlxB2xBTHrYZDgYMrHArIDOxD4CnIxYH4By7o2io/H136e06GbMpg253BWWGskuRRa9eQps/91UEnirlDcUBUnIbT0z/NeBzMDg/iVqJ0yY2L0/yE0QqtPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602478; c=relaxed/simple;
	bh=yGQW07/OLFPLHEyWRsJLTsl21Hqp31bREfr5/x9Udyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5Ii1F/QgulHnq1uVF0qE9hTx4adxgWo9zbe4i0K5aI//ywLVX0ACibllx0T6+Cescj/amCxNpK4W5sMoga0hOmL9rL8PNSJasy11+sVd5Zv8RP9CChu6tDhQEE4na9H5cqaSJ0FJKWkqG3tf40AvL46eAHQQ/6pDUfUNOqXQmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxNt9A4P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxNt9A4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A0FC433C7;
	Thu, 18 Jan 2024 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705602477;
	bh=yGQW07/OLFPLHEyWRsJLTsl21Hqp31bREfr5/x9Udyo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oxNt9A4PfjfgxdI+CC2vO1RvDAjntVb6uw/mcw31wup0b+z0j9wvGpMJQ343mRhPX
	 dpWgE7+kP+1rYTxhEufudZQVmuwCCXJU3/5UETPO3kbiSvM+2ABQ3XwAtkYnRlw0RT
	 yUxU0UzTwH8HkiwzJ2tV4CmZ1Cej5+ZV/NrbmV2YQ5Fa1T9QKcGAP4IiRAqwhAvqp2
	 kxQS6DmiA63Zg4iUs7s3fm5VhFa+wu4rUn4xdcpQqLfziwciQhiuDKTnOqVwypDdWh
	 OWrVZ5t0RMjucUDLLmV9NiFaGaw5YXjTtwB2ypl6wFGytAqpa+0qwVQn1FL9Fyy5hI
	 iGLB7BINe1QSQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jan 2024 19:27:33 +0100
Subject: [PATCH mptcp-next 3/7] selftests: mptcp: add missing kconfig for
 NF Mangle
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-3-f3a4db41c3be@kernel.org>
References: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
In-Reply-To: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yGQW07/OLFPLHEyWRsJLTsl21Hqp31bREfr5/x9Udyo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlqW2pDih2aGGoQa0dXi8On09xesvalS6CSWMbJ
 Ms8PAKEi2iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZaltqQAKCRD2t4JPQmmg
 c2/1EACwDmc3KMGszTZ442nL7/Okdq/i2z0Mozg0TTXcVTxGk+o7VF+hgKXQulcxigAvwJ62zIN
 tT1c4y9YqhDDqQvBoMPm8a5LWXjCF3CSqXA+y6sjsWvd1h6yVL6BoUlRNuaH9zPDv0tCFT6JYIY
 QPt1kOhFqY2oZshMuIms+tET4PwljouwqOEAS2HtEMi3B2GlAXPVLcBTW4uzzEfKbzj/6dVdgZA
 XFlcSNLirZ5BJB+xJ3Kz/mjypgE2x4vbQLFHOnH+HInqF8iUiuuQ3jFFYOB0D46x6CLztV4OZ42
 w1w65HKlDMW+Po4qZ9FftYZHc2bws65sMQzzQX/3WCn8n8anVsI6AkM0oFWZSX5jE+rNgp/6lUS
 5Uh/uYNa6hUzuGxIY0Ui/rafI642DzKsafzmil4d/Qs6cd7aBdKzC1udKVpuQTSraqyWqJXjUsM
 +JBpZlHnuR72TThRJwRQOfPQzE+mWeefte3+gxkvhHQNCpaRjgpxLEHpT+XgHyNTbSkdRc8zsYS
 y6hqcM4ZZGmA1xxLsaeX4yANCJlf7tJoIVfc/WzNRXtUmIhsMOUpBD7EwBm3jpGjMgpKaoxmSW2
 ONwlzryAhYPxOCXA3GgJ62haqa1chkZ1V7bR0bvhR56Wrw11B5HxZP6juxRrI5Qn6W+l6ynIZMw
 NDIuPCcnAXANrRw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the commit mentioned below, 'mptcp_join' selftests is using
IPTables to add rules to the Mangle table, only in IPv4.

This KConfig is usually enabled by default in many defconfig, but we
recently noticed that some CI were running our selftests without them
enabled.

Fixes: b6e074e171bc ("selftests: mptcp: add infinite map testcase")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index ec70b27288fc..dfc8bdd0a11e 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -24,6 +24,7 @@ CONFIG_IP6_NF_FILTER=m
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_NET_ACT_CSUM=m

-- 
2.43.0

