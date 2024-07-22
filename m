Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AB1C695
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676961; cv=none; b=rhjPx13utKVmfSt74/YEtAhNIo6XeTOnPcit6CvQmw7ujnXygaSuUgPHZvuzeO0H2Mah3rtFQFxtngDpHYmGnLGFrY/hlOaZoTjGplKlp9oW3BPqEDDo5jNctQWmzCCF65AcyVI8sv47yKwJwnLJnQYWl+MtuVFdKUBMYSfuOFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676961; c=relaxed/simple;
	bh=Uk5krQmua1YGk0ItymKu1THhzRWDba0Om0yojxoq1YA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nRYx75Otj2YSZ6CDID954+b4a+6Lgs6Gybkv6SOYOMhe7JJEaRU837GIDEzGFr24sBrbF5Mq7iHjmMuaqQjB4JsdavEgaC+SJous2sAUwTP0aq1p6RQCZBMBdoHQ5fYFtT0otuayGMwjDuiZqMeDoPztT+v592XryauRvV3Q19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKoqFcmO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKoqFcmO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8086C4AF0B;
	Mon, 22 Jul 2024 19:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676960;
	bh=Uk5krQmua1YGk0ItymKu1THhzRWDba0Om0yojxoq1YA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uKoqFcmOj0uopwdhZA7+91FoCb9bnsESnz/+bYAPbV3tAM+ljQVGZfiRtB2LQSDja
	 GygnEuCdPLZFMhtd98aU5fCrFWJstrM/Wx8+OKppnc4wnym0nH5B72N+lHuymbqRMC
	 Z1q35skITFZk4SKYyE4HZz0WvyO+PQ7GcHIFhQfE88St0P2CiFB0feSZQAd8GtQ4Xp
	 kDzxgIzdUIvV9B8g3wHwXzn7ragTRS178YMbi90h6kAb95IMKrrH2Ee+VrqQSYiQ7b
	 WCRQadmfPFnIyqIKuwNinEYVKWlG+eLWoc3vY4o2AbBPN4HbzHWaclQlaXKVKReBps
	 uJ5bPSliqfguQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:45 +0200
Subject: [PATCH mptcp-net v4 07/23] selftests: mptcp: join: test both
 signal & subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-7-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2396; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Uk5krQmua1YGk0ItymKu1THhzRWDba0Om0yojxoq1YA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSWY373muf77UYBGSu0c34T/3Ko6zzLt+tEi
 G5wYAVKOvGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 c0+lD/9uTqan4PJu24SAzLruuNXNlY43/EljFn738awLB1+kkmvln/1KoXCvwdCqtOU8HwyRaZh
 UtP0YLY0+UtVo3bPiMM3Zv4rpU6Ssz3KTsD5oXp4Mt5lBbnB4Bu8uocz1LuaFGJOr1p7l3Y0qLD
 HCd+VDy4SJY9PmVMuTedMqj1i0+9gm1JH8/R4r/xi4g64Y3USpwqKVKug4XoNAiIiPIl9t25FSU
 q7SyB9zgtot0mWKH4c/hcKgLxlBzSo3vnp6XE9Gm706IRihn8T9OBsl+/Ex+XeR6KJK2XOHBhpv
 XPtgQbMwkC2KAcOBhlFrQyXPZfEn80RvZCql/DtFktqpoCLEmUeUPIK7NEE/eVeo2UcJL7XtB2b
 Sl7/5gnwn5UWYmwufp24F1mqhuMGy6hdzsquDN8l1kuI2PIj3HR88hM48BvUMzPcdT8I2CZNFbA
 BjU5pHYBrDRpR21VCB7UOL1lz7Hf9iZLP2US+NO0lhOOHi8M9JsV13Uhf18XyfvI4U/T9Df718J
 3w67e2QuenQjcajWFc6bP1Q86gM0+n27JdGZ3T6dMpWqWUAdf0NEY89nyZDGU5MODyqpaqzI/Zx
 QuLCsWFl1vkgb4ZHBZ9HirURh8gDTumYdqAb0UYo2ELo8kkQiOBAgf0FvYJtkPBTk9oYvGKXy6W
 3oTsVDBbnHMJGLA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It should be quite uncommon to set both the subflow and the signal
flags: the initiator of the connection is typically the one creating new
subflows, not the other peer, then no need to announce additional local
addresses, and use it to create subflows.

But some people might be confused about the flags, and set both "just to
be sure at least the right one is set". To verify the previous fix, and
avoid future regressions, this specific case is now validated: the
client announces a new address, and initiates a new subflow from the
same address.

While working on this, another bug has been noticed, where the client
reset the new subflow because an ADD_ADDR echo got received as the 3rd
ACK: this new test also explicitly checks that no RST have been sent by
the client and server.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 55ccc4fdf18a..d25ac561e050 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1967,6 +1967,21 @@ signal_address_tests()
 		chk_add_nr 1 1
 	fi
 
+	# uncommon: subflow and signal flags on the same endpoint
+	# or because the user wrongly picked both, but still expects the client
+	# to create additional subflows
+	if reset "subflow and signal together"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags signal,subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1 0 invert  # only initiated by ns2
+		chk_add_nr 0 0 0         # none initiated by ns1
+		chk_rst_nr 0 0 invert    # no RST sent by the client
+		chk_rst_nr 0 0           # no RST sent by the server
+	fi
+
 	# accept and use add_addr with additional subflows
 	if reset "multiple subflows and signal"; then
 		pm_nl_set_limits $ns1 0 3

-- 
2.45.2

