Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [95.163.41.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A038F9A
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internet.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="mxXjz93X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru
	; s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=JaTGUuPM5+noS1XthM6U3pT0Do+tI/6Lt0WLF5hbDlQ=; t=1702296239; x=1702386239; 
	b=mxXjz93XV44LAi3P9AriV08/fAkNuQjgdyKcajQA/53uQxoDTab+1+40K7sZ3QkEYZ4DwkQVRV5
	xffVLF0dIhj73aBmyzxBXN66aIqE+5drYOjnl2BzPz86TDuIcPZPBqgSKJ2dcbmBIh8GVTYjqmOG7
	hHqmZaKiOXv9gXFi0/Ma3ODQZ3vUooQ3fy5IM7Hevd0KrQeu9GkvJ9OeD29lUbXlOIRuo7tjyaRJv
	U3z1V42N6CkvjOAnsNNY+Jk0erCcfDfWs1yDbtwDN2GZWzxoSgffn9tAkKE9oFiNaU4xH/n2AGBIW
	NSMVYf5Cu67FE9UQV6845NZ21wrZSMe0BBTQ==;
Received: by smtp44.i.mail.ru with esmtpa (envelope-from <max@internet.ru>)
	id 1rCf0u-009382-0j; Mon, 11 Dec 2023 15:03:56 +0300
From: Maxim Galaganov <max@internet.ru>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Maxim Galaganov <max@internet.ru>
Subject: [PATCH v3 mptcp-next 3/3] selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE
Date: Mon, 11 Dec 2023 15:03:09 +0300
Message-ID: <20231211120309.20752-4-max@internet.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211120309.20752-1-max@internet.ru>
References: <20231211120309.20752-1-max@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp44.i.mail.ru; auth=pass smtp.auth=max@internet.ru smtp.mailfrom=max@internet.ru
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD97533543916A0F71A35DDB53065FAAF90D862B8BD9C04D0D0CD62213F67905E7A7647C9A88FBF13A2E4B8FCFF82495CE931A0EA4EC84C67EC6C831481B6BD6C10
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7ED971EE68B26EF8CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063779089FB2CE4EA2908638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8AD7192D3D31388BAED671395D48BF7BB6F9789CCF6C18C3F8528715B7D10C86859CC434672EE6371117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC44DFDAE72D78788F389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC82A336C6518635091F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6A1CB4668A9CA5FA6E0066C2D8992A164AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3135EDF6918C5D223BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFE478A468B35FE7671DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C30B8B320EE581A76035872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A547EC70D6A7D289CC0A0CAB60E820A5D944F832A2B2FFB660F87CCE6106E1FC07E67D4AC08A07B9B0CF7CD7A0D5AA5F259C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A09062BEEFFB5F8EA3ECB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF73BB1999CD841C9253654D469BEECD4B5EF5035033155B7B00BFD2EFA93E679F248F49047001ACAAFC43826C574F1C6F03DB101613BD4B98E7EEAE2B49A402CDE48CAC7CA610320002C26D483E81D6BEA5ED0C00A4B096A39697699CFF2E0C50CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojUXpChnEw0AXnV6fyj97fIQ==
X-Mailru-Sender: 4A46F6E6BB1A04662A3B81E17F92FA49C353AB07635CEE2033DC5904F8AB6C0C130BB289A1C4FBB910AB1EC7B4FC32D5C77752E0C033A69E0ACD20E4C8A7C03EF0AEF442C4C8402EB4A721A3011E896F
X-Mras: Ok

Since previous commit, MPTCP has support for IP_BIND_ADDRESS_NO_PORT and
IP_LOCAL_PORT_RANGE sockopts.

Add ip4_mptcp and ip6_mptcp fixture variants to ip_local_port_range
selftest to provide selftest coverage for these sockopts.

Acked-by: Mat Martineau <martineau@kernel.org>
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

