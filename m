Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B506BE4F
	for <mptcp@lists.linux.dev>; Mon, 14 Oct 2024 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911951; cv=none; b=sf/OgL5Bf2AYhbgqlPMW9DtwBHBx3hFuppgVh34781vosL7fJHFh4eyrsXe7y+3nLBF9P39jKDXEX97TKLAY8F1Fh+2+NfB+LoMq+mxUOcs/OUyp331U/uuPG03dlWM2xYG9Ta8Olm9mE9TujuBN4pIGNVcx4DBfvgIAJGToFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911951; c=relaxed/simple;
	bh=fTBiz2W/jcGSFPiTa0wuFagt8X1+us6/hCC4ARe85l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iTcERKeU/yBzoiHYXDl2N9STpRbuS+ZSI3KYY/DfHizX2J3qNnyIiLncLC3EWzqZX03Sd2p0pDz8hCqm1kS/5x5HSAUtmEwVgk6Zy2KrsJWDHT6F5+m5Dfu+vXfXpHGUsTwa3n8qgk5kzWqELoiY111IrVcPkDKTrzwUg3+B2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INfzXDUl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INfzXDUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50F9C4CEC6;
	Mon, 14 Oct 2024 13:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728911950;
	bh=fTBiz2W/jcGSFPiTa0wuFagt8X1+us6/hCC4ARe85l0=;
	h=From:To:Cc:Subject:Date:From;
	b=INfzXDUlhHEg4s8JvgQFJQMRxSyVxInehHbTMSzSBJyvYZ4/gvTOTrlUWOtvknBaI
	 i8A6rzrXIwjjQQtEARL3jYBGhXcg6YBp96qsrlZ5x3HIWKG6ffVLlCgZdxYeP9frgg
	 gap6G8xxIKJGOG3+dLQEW1oxalI/GOvVY2+IqP9SYxkVaPLD0B66U58XX/AQdG1JWn
	 6tReZz9e+D6g4SOz6pk6McGAuPYUcZMtCc0HDw7sOzmVDo/E82xI74PN61sK17TWZk
	 L73rVOrkpTZe6AtBhxWk96GRag4cnlMETFPQdxvmD7x6rUb3DjyKlPSwOuludCSGTq
	 Twk0rHg/R7Uqg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: More endpoints for endpoint_init"
Date: Mon, 14 Oct 2024 21:19:05 +0800
Message-ID: <9cde7341aac14f85ba9741e70e2d542edae5a1ad.1728911803.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

IPv6 addresses will be used in BPF path manager tests, add them in
address_init().

Please update the commit log:

'''
This patch adds two more IPv4 test addresses ADDR_3 - ADDR_4, and four
IPv6 addresses ADDR6_1 - ADDR6_4. Add a new helper address_init() to
initialize all these addresses.

Add a new parameter "endpoints" for endpoint_init() to control how many
endpoints are used for the tests. This makes it more flexible. Update the
parameters of endpoint_init() in test_subflow().
'''

Depends on:
 - "add mptcp_subflow bpf_iter" v9

Based-on: <cover.1728466623.git.tanggeliang@kylinos.cn>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 2738951842f6..161459ba6194 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -23,6 +23,10 @@
 #define ADDR_2	"10.0.1.2"
 #define ADDR_3	"10.0.1.3"
 #define ADDR_4	"10.0.1.4"
+#define ADDR6_1	"dead:beef:1::1"
+#define ADDR6_2	"dead:beef:1::2"
+#define ADDR6_3	"dead:beef:1::3"
+#define ADDR6_4	"dead:beef:1::4"
 #define PORT_1	10001
 #define WITH_DATA	true
 #define WITHOUT_DATA	false
@@ -378,14 +382,18 @@ static int address_init(void)
 {
 	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
+	SYS(fail, "ip -net %s addr add %s/64 dev veth1 nodad", NS_TEST, ADDR6_1);
 	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
+	SYS(fail, "ip -net %s addr add %s/64 dev veth2 nodad", NS_TEST, ADDR6_2);
 	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
 
 	SYS(fail, "ip -net %s link add veth3 type veth peer name veth4", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth3", NS_TEST, ADDR_3);
+	SYS(fail, "ip -net %s addr add %s/64 dev veth3 nodad", NS_TEST, ADDR6_3);
 	SYS(fail, "ip -net %s link set dev veth3 up", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth4", NS_TEST, ADDR_4);
+	SYS(fail, "ip -net %s addr add %s/64 dev veth4 nodad", NS_TEST, ADDR6_4);
 	SYS(fail, "ip -net %s link set dev veth4 up", NS_TEST);
 
 	return 0;
-- 
2.43.0

