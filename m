Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DE14D8B7
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318052; cv=none; b=VUyLCjCZ3H+owm9qL4SfZpC5IjLBOVKFlbItNUmu+a9aK8bUkXSe/RVXP9sbr5rw5bkHpPNLHsJX5gdVL3u7iC+T5575PGTkAv1+9ZThqpW+Du9XGmF2CiCUytEDSBuLEeTPAXe2DyAvE26Lbj25op6vdwJwz/1OZG5HiMDQ2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318052; c=relaxed/simple;
	bh=o6LlgxvdIEwLce8tmc9hgvLbwZq89r/BeJFILy0OplY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bIPdCHhCtGubtsCJJbUKiPXHLs23knQusWeow6KeM91WgXu8x17y9IYDdAZV4g+yydhdbcAh28Ma5+o9XADESrsePJIP00d5ypVcm93y88xSU8W/bjByritXwQr3BwYSsTbQMU7Hy1zJp8GP/AsUnfFh3aNKgN9iP4PKvV4IIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVU5nbPW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVU5nbPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A11CC4AF09;
	Thu, 18 Jul 2024 15:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721318052;
	bh=o6LlgxvdIEwLce8tmc9hgvLbwZq89r/BeJFILy0OplY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dVU5nbPWDnuP7nXq2tR+I7GIrTLzGmivxa99PPwoe00vXqvr131Ep2Z2HM1sQVTmF
	 FEorshqi0xN0f9be9UfpTALPz3XFyCpvBTNxn3pwFZtoh6wqmsssiJxbfjzxPqFU/L
	 /v4MrGpR7zzKhJ9coC63OWT9D3t1+iH5VEJ5XVjG2XLUVY25v3/w5yg/lbhnomKpAe
	 cr1laZigT2OdNGXoeqiHzauGgI4KDX804jfSFuIR+S5mqV6B/uSCBiLZ0U0AtKiDup
	 rlbt82Oz5T/bVOACqh6zNXICiU762njzXdIrhkbc1QttbvOybudjbtyVWgRKt+hAMw
	 Rm/2P0SAvIy0w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jul 2024 17:54:05 +0200
Subject: [PATCH mptcp-net v3 8/9] Squash to "selftests/bpf: Add bpf_bkup
 scheduler & test"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-mptcp-backup-mpj-v3-8-1f6cd9b89ee4@kernel.org>
References: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
In-Reply-To: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=973; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=o6LlgxvdIEwLce8tmc9hgvLbwZq89r/BeJFILy0OplY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmTqbCJ2HwpDVYEk9CzL0gM4tusMzvJWcRKHAy
 j9h9SssDNCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpk6mwAKCRD2t4JPQmmg
 c0/PEACSWxL0dsFOWxR3sMP1YlZOzNY1tdsI3AtD1rAOx1hbKKNFlxZF971FUo2zgcJWHG/s1Dv
 1pKkkAwywd+JMG2fGKm9xrqRCHU19MK0c1fJsGvb05gmKefxoahBs9ZI3l/20uMjXzwaApvLPa9
 m0wz4/fdibNNgnK2+tR3TV7e2IecweVp/OcqfLm8Uf0Hwbs+dIDRl0imah3J48uIOSuik/JayaA
 EMvWeNcPiUhG3tNg5WYXSLSOxdcXOSQKeFoEy+JT1UoQ53jTeUb77ddKYr1cj2hy9eKcabVgYhW
 YC+HXWrrkdhWKpHIP/JK/0dgmqu058NrN0svEtyUfXwqNkhzEKof5QZ8mPSbL19SavF3b3TlBwf
 AdOjhtinPJtH64xZqxBIvYlHaG9WBnAktJ09N7Bae1vfZx8ctVGj0it9tEulYeH/6Oybyiy0Up7
 QWRbtLl4nPnNGlLs60h6IBESgpv6F7CuwJXlkM+J7lKTwG9zcJt65rJodekOHxH5ELvltp21SO8
 1/gC2LK0rtixftGH3uDPo6ZLzYTawS36hfIfwLTLO/noCPQFWOzpeNI2RsqzKdDfyxl1IC+iA9h
 lfx/bvKqzYkfJENqu/KhHJX/6KruJSFD62WzdMIPHL2y5al4bktXQeaKYuXOOVfrjqkh9amfZge
 9UwtPANx4RFhCeA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to "mptcp: sched: check both directions for backup": it didn't
matter before because the two flags were very likely set by accident.
But that's no longer the case now.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 14091bcc4cde..296f0318d843 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -29,7 +29,8 @@ int BPF_PROG(bpf_bkup_get_subflow, struct mptcp_sock *msk,
 		if (!subflow)
 			break;
 
-		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup)) {
+		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup) ||
+		    !BPF_CORE_READ_BITFIELD_PROBED(subflow, request_bkup)) {
 			nr = i;
 			break;
 		}

-- 
2.45.2

