Received: from fallback19.i.mail.ru (fallback19.i.mail.ru [79.137.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5D1C2A3
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internet.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="Yzvhi8rL";
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="g4Oo9J5F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=lTLRSSHAlsm+INntQshffSpUALZtB447ovwVini4WyU=;
	t=1701259949;x=1701349949; 
	b=Yzvhi8rLw5zVTbgPEDi1zEDlBDaaJScICmDkIsQmSEstFrWsWjPJH1F7gDVU211XlJuX24hUGb/ocvWVajIKA7NnwX4KZgYpqdhBMA3wvTsx51aLI+7IO3byS3QhQONKvHaTdwfwrKnFa6NIhEjuM9/WSwe/qXvHjESIYb+O3zfAyEwJja5kRz0qwt3istCcaiHQXgOnswzki/cm+JEQ3X4JvjOG4fwwhr8HDQPDwxXWPmdEFatJbrMUZ+S+/0bxAhc1qhBmfdTVxyGqAKWBFJZ6KdryB29KJT/aoSd2S0ky/is8mVUqXGIVFdfwsoldHbJhRQFLhBRWl/xFMHVnJw==;
Received: from [10.12.4.19] (port=36772 helo=smtp43.i.mail.ru)
	by fallback19.i.mail.ru with esmtp (envelope-from <max@internet.ru>)
	id 1r8Ipc-003cq0-7L
	for mptcp@lists.linux.dev; Wed, 29 Nov 2023 14:34:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru
	; s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=lTLRSSHAlsm+INntQshffSpUALZtB447ovwVini4WyU=; t=1701257656; x=1701347656; 
	b=g4Oo9J5FpWHHiUbplbnVnToR8bQOd75etxojzcgtkpSOiIdvA772g+smXtNyOBbT4uztdrztKNp
	rJEmAzOivNlHJZ7VM2utHgr5S5lRWd8sm66pT7jufg4EDPCNV4SPWCPIO4T3bTUM5GudEb+Dy/Vtg
	j+3zJvNse/j7z6uBoacPIrgygZr3MTLVLvZDbZkVTSaXicchNd3TB3OZ1ji7A2H6i3N9ePiPHq/ET
	xfTxYOHsT5zKoBQMcHme0rzclCaww9HGgHqL1/1yJmpYKzC4aoK8Ou/e+FvNuUeH/hsLGdz2avkHg
	gqQiR+DpmclfsfUUqu7D9b5GDvHlYkrRV0ng==;
Received: by smtp43.i.mail.ru with esmtpa (envelope-from <max@internet.ru>)
	id 1r8IpU-00Gl5I-0M; Wed, 29 Nov 2023 14:34:08 +0300
From: Maxim Galaganov <max@internet.ru>
To: mptcp@lists.linux.dev
Cc: Maxim Galaganov <max@internet.ru>
Subject: [PATCH v2 mptcp-next 3/3] selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE
Date: Wed, 29 Nov 2023 14:34:03 +0300
Message-ID: <20231129113403.157953-4-max@internet.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129113403.157953-1-max@internet.ru>
References: <20231129113403.157953-1-max@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9191BD113CEFD9C8A6A6425AFC4D6F3D0392560FF5E1B18661313CFAB8367EF908E2BE116634AD74D75E7703FBE0A00BF904305D09F3D266DC192D0DDD17BDC685E6CE7239E2C5700
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE76A312A092B0E1E4AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637C8BD49B17AF1FC7C8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D876B3D4B84BD4017056DC8648DCD3141A6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE767883B903EA3BAEA9FA2833FD35BB23D9E625A9149C048EEB1593CA6EC85F86DF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637E5FAC37A846F0F679FA2833FD35BB23DF004C906525384302BEBFE083D3B9BA71A620F70A64A45A98AA50765F7900637AC4ECE65C2AF15826D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F790063747074E5DE1517656EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5FAB80E91099F1D516340F1FE64E119E5EAF0B08A1BD6E2FEF87CCE6106E1FC07E67D4AC08A07B9B0DB8A315C1FF4794DC79554A2A72441328621D336A7BC284946AD531847A6065AE478A468B35FE767BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF6105CF60D5E2F32ECE21A24CAA23FA42AA10034FC243C36BC873F4C586FDDBA44F3A61774D94DB0C153AE024B6FD0844AF1D45FE45AD01321BC1DCCBC93FBE0D40B08DDBC5CE87D002C26D483E81D6BEA5ED0C00A4B096A39697699CFF2E0C50CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxXIty/pLbajBCbYUPdY91A==
X-Mailru-Sender: 689FA8AB762F7393590D8C940224AE335B9AAC3B7A6644CC94EBD09642E030F6E94AC9D29F4E5226FD262907200E8C52FB559BB5D741EB96C728B2FC74FAA16AD7A14DD9E34ECE7467EA787935ED9F1B
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B487EF4F2ACC83E26BD6E5864C7F64BC8EDB4BF2F3B7547FEE049FFFDB7839CE9EF53F02DB5938BDCC8A8AEE29BE94AEC1727E96F838768E3B7A1287C063BC18CA
X-7FA49CB5: 0D63561A33F958A5AF5C9C2858DED8D483E3897AC1FF8579524EFC2FFDE2F5E0CACD7DF95DA8FC8BD5E8D9A59859A8B60BDB06C55397FC47
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFddY4eMfORNHPB3JWZRqnMDA==
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
2.43.0

