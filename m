Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149E3A1CB
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042677; cv=none; b=iG3sszojJDhi/VwHsUhcmdqWKF5XrkRIiC+aTL4AK/5edwinn57FOxMBCqwixUHtjPFAA9QjXQqBzF4Gzo2BGY2Mtym5HgOYtGBNEu/7rOe61oq6nZB0PQt1ZBjihzg0B7Uxd6qr1ibEhW4liBG1ed587ua1QaoP+FV5SccaSI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042677; c=relaxed/simple;
	bh=E8wfXfEQTQks65NLFdPmY9LAXB8f215SIbsBjNEPNbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lzEDjsC6PfokQMSOxIOKbfoVtPNig7sLtQCALfSTF4R5e1sk6MP6ffToSByMTO5oPvRL/oJ3sT3vcTxlf6v0U0E4FCzZho6zYONJE18AgidLteaijcU3GMc4GXQLj4b+/7I4Cv8/Cw4+3GFiiuHZq+1JedaJV4fpBuLMiBA/lY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIyAtpve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIyAtpve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D4CC433C7;
	Tue,  2 Apr 2024 07:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042677;
	bh=E8wfXfEQTQks65NLFdPmY9LAXB8f215SIbsBjNEPNbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fIyAtpvemSz3aOqsf3sXd13ZewDgkIqoOJYzA1UF5lr8znahkalxSTe8/lXK3+Vqb
	 EgUSduvA0boXxvmtqCaC0S4UXYhKvTLG5kDAkyL9j7Lb2QcLvNUsl0gy9l/2vH+PzY
	 kB5dwmGAKqrP0qCZO5fDJrTkhy9IxsT+SEfBdM5O1Ye/Ctd4+j62+90kuQse2pN2Be
	 SoZM3FkuV3sP/Q0bXqqORUdzEmV5CPI2gOQKc7JlbOhbNb5f8yTho+rcRfEmPssCYS
	 zRIDiYeNhKduwlUoQdxPTQp8GAHyVR2yBYWMEByUoFg3qOPsPVMuDXCWkkEHsySitZ
	 23gAlYYIqyotw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 2/8] selftests/bpf: Handle SIGINT when creating netns
Date: Tue,  2 Apr 2024 15:24:22 +0800
Message-Id: <81a8524beeb96916cb42752b26d3624cb967c0ed.1712042529.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712042529.git.tanggeliang@kylinos.cn>
References: <cover.1712042529.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 88899ff02a70..660964062e3d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -69,11 +69,17 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static void sig_int(int sig) {
+	signal(sig, SIG_IGN);
+	SYS_NOFAIL("ip netns del %s", NS_TEST);
+}
+
 static struct nstoken *create_netns(void)
 {
 	SYS(fail, "ip netns add %s", NS_TEST);
 	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
 
+	signal(SIGINT, sig_int);
 	return open_netns(NS_TEST);
 fail:
 	return NULL;
-- 
2.40.1

