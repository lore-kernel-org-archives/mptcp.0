Received: from fallback13.i.mail.ru (fallback13.i.mail.ru [79.137.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734984D123
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internet.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="CE3lysTB";
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="TZnVj++v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=mMZ4qe/MufKevhwKQLb4XCF//0aIccmJETgmXQs68wo=;
	t=1700670077;x=1700760077; 
	b=CE3lysTBsDk1IJQuycl+UvGNttVq8q6z3m1tFCmXxuYah2osL9+lqnczhnSpVI41UGhZytIKhd4eg1B6XkXAjIuuhdsDskyjEBL3+08cMZ7HMtGaVNPG3iKYspS5Qd3hN8z7smxbU+PQAU3EMhH/4fpppYUcvFYAFo1eIllvDt6JCQhUfyGJ/NJ5MDBf/HUcaNwKFT3EoOlngbi2GRCwQYkiZUiJCD0r09I2eL7I2s7ojB+za56DPqXcJq5pnIujj1Vd5ReGiNLgWRcATdYiF7/0DmbTFENyIx39bDNuHvlxV/gUkQZNOaOxl1gqkRssnqgXRUK0gji42xWpwIhFBQ==;
Received: from [10.161.55.49] (port=48420 helo=smtpng1.i.mail.ru)
	by fallback13.i.mail.ru with esmtp (envelope-from <max@internet.ru>)
	id 1r5pdj-006BsO-Vk
	for mptcp@lists.linux.dev; Wed, 22 Nov 2023 18:59:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=mMZ4qe/MufKevhwKQLb4XCF//0aIccmJETgmXQs68wo=;
	t=1700668787;x=1700758787; 
	b=TZnVj++vzwLkV6sfGsodJIDDrZk20wsTBA/2Hf4xp/0vI0iR/Nl6ATb8cWikpDXstUKC43Zse+75vPT9rOH+CsreYMxyd00HNjItxfPw9jad9CCDc/c92IWlJnldaur2iZTbRpRUT9zm5UYKdxjFp0m/CcJ088KNmggdJxMS/c2lrDquBgUvicpLxYMjpXs6JewOnQH97waHCdNHp37RNEQFPUYTGkjsLkgFJ8WCUbOzenmmoIbB12qighZmBgYzwRQNGfr/Cjsr5zl8TPDyCkNSaVjZGQBCHocGFfHIdg3ChM69h9es1EkQCy9W0WlOcd2PYIXw4eLH4UtZV4LjHQ==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <max@internet.ru>)
	id 1r5pdb-0002rH-Q6; Wed, 22 Nov 2023 18:59:40 +0300
From: Maxim Galaganov <max@internet.ru>
To: mptcp@lists.linux.dev
Cc: Maxim Galaganov <max@internet.ru>
Subject: [PATCH mptcp-next 2/2] selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE
Date: Wed, 22 Nov 2023 18:59:19 +0300
Message-ID: <20231122155919.11393-3-max@internet.ru>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122155919.11393-1-max@internet.ru>
References: <20231122155919.11393-1-max@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9FEA8E122FE2215F5F9A7F26A9461D4801668790ACF3513421867C24CE74E72BB5FE18E9CBFBE7C0749595627237A030DB35728C0F0432A41F07C4114B69F52B92890F9C47E136152
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78F7806334BA34DD4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371DF52D98DC3592C48638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8A69ED5C5BCF5D3B8FCC2540E947146226F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7328B01A8D746D8839FA2833FD35BB23D9E625A9149C048EEB28585415E75ADA9F04B652EEC242312D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B44DFDAE72D78788F389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC3A703B70628EAD7BE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B895CADBD5EF1EE27EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A553BB7EF17E3C77E2E22301315A8F93B2DCC402196A0CE6E1F87CCE6106E1FC07E67D4AC08A07B9B01DAA61796BF5227B9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A09D2DCF9CF1F528DBCCB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF6789EC4FCDEBBC101C87FB8AA82DB67D49D0BF2AAB791813447DA6E5D4A68408C69CBF34C6AF1FF588AD3775A6B0C834C65EA8E46CD9AE619801BC1E0607620340B08DDBC5CE87D002C26D483E81D6BEA5ED0C00A4B096A39697699CFF2E0C50CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojGZhPsaRkbblfKTVpvF6JdA==
X-Mailru-Sender: 689FA8AB762F7393590D8C940224AE334D974532C77D78A0ACCA6F5B7CEB67ABE94AC9D29F4E5226FD262907200E8C52FB559BB5D741EB96C728B2FC74FAA16AD7A14DD9E34ECE7467EA787935ED9F1B
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4C412E14AEF4742E1D915F33BAFA678CC53B93FBE07102DFC049FFFDB7839CE9E432D8BDF4FB0405F83E25376A5BAB7ED39525C1B8DEA9C82BC136391F456C3FB
X-7FA49CB5: 0D63561A33F958A513372EFACD8ECAF7D48813DFF84AA9C4003398D44B157586CACD7DF95DA8FC8BD5E8D9A59859A8B653555A62B7CAD886
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdjNtV51DQSTBn4UV4nD80eQ==
X-Mailru-MI: C000000000000800
X-Mras: Ok

Since previous commit, MPTCP has support for IP_BIND_ADDRESS_NO_PORT and
IP_LOCAL_PORT_RANGE sockopts.

Add ip4_mptcp and ip6_mptcp fixture variants to ip_local_port_range
selftest to provide selftest coverage for these sockopts.

Signed-off-by: Maxim Galaganov <max@internet.ru>
---
 tools/testing/selftests/net/ip_local_port_range.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
index 75e3fdacdf73..0f217a1cc837 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -146,6 +146,12 @@ FIXTURE_VARIANT_ADD(ip_local_port_range, ip4_stcp) {
 	.so_protocol	= IPPROTO_SCTP,
 };
 
+FIXTURE_VARIANT_ADD(ip_local_port_range, ip4_mptcp) {
+	.so_domain	= AF_INET,
+	.so_type	= SOCK_STREAM,
+	.so_protocol	= IPPROTO_MPTCP,
+};
+
 FIXTURE_VARIANT_ADD(ip_local_port_range, ip6_tcp) {
 	.so_domain	= AF_INET6,
 	.so_type	= SOCK_STREAM,
@@ -164,6 +170,12 @@ FIXTURE_VARIANT_ADD(ip_local_port_range, ip6_stcp) {
 	.so_protocol	= IPPROTO_SCTP,
 };
 
+FIXTURE_VARIANT_ADD(ip_local_port_range, ip6_mptcp) {
+	.so_domain	= AF_INET6,
+	.so_type	= SOCK_STREAM,
+	.so_protocol	= IPPROTO_MPTCP,
+};
+
 TEST_F(ip_local_port_range, invalid_option_value)
 {
 	__u16 val16;
-- 
2.42.0

