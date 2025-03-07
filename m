Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1802153D5
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347430; cv=none; b=nmE/erg5c3mt5n3HkY2/4J3CrDBfGSYgqyogtz6YGA9fuzo0iayU/QBBLs+e7D9F+iRZH/lO5khcHQOutgVPv0am2sD+AqG194JY6qHLyDUxl//Li8RbO2/iTdxn3gLAXxCNb3YNuQYBKmhfln/agXuR4OMk+ky8w9B+YfuLunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347430; c=relaxed/simple;
	bh=aWbuzqhrMGMpWk2fN1unZjqdZve99T/YrAOS7/lYdwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oa2civcW2D8p1jcz9Dz3vHA8LCeGsb4uMSAFqwhcRP97RaLPE0Q0jI4mh5Bkn/kIAo1o1aQIWjAnA4V/Q2F2tyfVfHzwt/NCrm43y1Inhmnx0MKDbDTaKgYRDFiafQh3RPOSCFaestoasM72V1yKn6U1n+FumzFg1Sjriw5Mmks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRk6P8iq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRk6P8iq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73681C4CED1;
	Fri,  7 Mar 2025 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347430;
	bh=aWbuzqhrMGMpWk2fN1unZjqdZve99T/YrAOS7/lYdwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRk6P8iqiGpCeEuMpP241RuCEjj2U6hBp6U3sgXJBwVpX6wQbf5Lohh/WV+nH/qwS
	 JzkAi1CZ9lnOJnOh64JNUwa5gCKLTktoNdbB3cWNcTJGVdw2bpEwABkHYj4HKG4MQV
	 XAz2dB0bwi15YFqzAHoqqVT29v/0aOIEMQhnrTQ4WJnMPJIdfcuOYsGS48/TqNIEGX
	 J9X2mWNXPrhydBpEEHu3gTOSqgDNbg+eW+Cht0Czh/Xm3f3aZmbWjqZm5ImdiRDR3a
	 lRKtjlaeSBBlXnUMYrYKtwv6s1+sYueXGVq3ZQkF98dyOYlfpP638zp4w713odapjl
	 AAsoIrp07swag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 06/11] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Fri,  7 Mar 2025 19:36:47 +0800
Message-ID: <b8eb7b02e61729d4607f3e4419f87d4959fced95.1741347233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741347233.git.tanggeliang@kylinos.cn>
References: <cover.1741347233.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Keep mptcp scheduler API unchanged.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index d71c50c7f441..73b18eeeb62f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -17,7 +17,8 @@ void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_first_get_send, struct mptcp_sock *msk)
+int BPF_PROG(bpf_first_get_send, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
 {
 	struct mptcp_subflow_context *subflow;
 
-- 
2.43.0

