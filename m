Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [95.163.41.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AA9219F1
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internet.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="nxRK+Kco"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru
	; s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=rfKJBpVYYsjSFI0DPmC2CLU9x1UzXQTPVDOt6+4Eu1U=; t=1702296232; x=1702386232; 
	b=nxRK+Kcog1ZKWFFEJo9FY7nQfzG6WGzH6j1lpIw7U6p/my4OnO00sHH0iRSDMdBz0pv5F9fQltD
	rcinq6Hdz3Z6J5cxJQRMy1mjPkhxcu6gGtbp+PHFIS+GH2dKpto4vqws102PJOah1cAEdeZqgylKV
	uEfxhUKvXtCInkaGpbB/oYQY5nEo8czqSUkhSUElSvBGQaVFTaLZv5DIcCprzI0LxTmtGSWLQBr0W
	hd8wQBbUVxIra217aVkaO79ZVgioydHing7FMdFyh8xqsXbKsrAJy0b8EysRLWKCZGCVB1pqiDl+U
	RRtROYifgEAodr3U9vxpt1J7uDCOQTtU+o+Q==;
Received: by smtp44.i.mail.ru with esmtpa (envelope-from <max@internet.ru>)
	id 1rCf0m-009382-3B; Mon, 11 Dec 2023 15:03:49 +0300
From: Maxim Galaganov <max@internet.ru>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Maxim Galaganov <max@internet.ru>
Subject: [PATCH v3 mptcp-next 1/3] mptcp: rename mptcp_setsockopt_sol_ip_set_transparent()
Date: Mon, 11 Dec 2023 15:03:07 +0300
Message-ID: <20231211120309.20752-2-max@internet.ru>
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
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD97533543916A0F71AD15911439ECC4B5E02235F2F5915E4EDCD62213F67905E7AF1FD0C15DF9B9DD47138328222504DD731A0EA4EC84C67EC3555984C5E13135E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C2204D4F9A221771EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637040380BD28C1B15C8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D85E0096E28DB524E892A5EBCBD5B120826F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7850F8B975A76562C9FA2833FD35BB23D9E625A9149C048EE1E561CDFBCA1751FCB629EEF1311BF91D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B292D688DDAD4E7BC389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637ABF6AAD2844AC3A4D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE7F979CA31F59122D9EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE7A03E8F3C2D3812562EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7509F8262B3B2DD16731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A568C85307C874B4200A0CAB60E820A5D91AB777EC901EB9E0F87CCE6106E1FC07E67D4AC08A07B9B0A6C7FFFE744CA7FB9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A091D471462564A2E19CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF5B6D8A625C688DD87262E17F48F8F9EDB59F5F61742A8211321EC3D1B1E780F9AE7801A017AB3E4AFC43826C574F1C6F3288DAEF6FDDFEF684BFAEB0F3685B6AE48CAC7CA610320002C26D483E81D6BEA5ED0C00A4B096A39697699CFF2E0C50CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojUXpChnEw0AWp80g9+2EhZw==
X-Mailru-Sender: 4A46F6E6BB1A04662A3B81E17F92FA49CB63699B1C9DC0E223D2AC2F24B331F6130BB289A1C4FBB910AB1EC7B4FC32D5C77752E0C033A69E0ACD20E4C8A7C03EF0AEF442C4C8402EB4A721A3011E896F
X-Mras: Ok

Next patch extends this function so that it's not specific to
IP_TRANSPARENT. Change function name to mptcp_setsockopt_sol_ip_set().

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Maxim Galaganov <max@internet.ru>
---
 net/mptcp/sockopt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index cabe856b2a45..a4bf337e6f77 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -683,8 +683,8 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t op
 	return 0;
 }
 
-static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int optname,
-						   sockptr_t optval, unsigned int optlen)
+static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
+				       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sock *ssk;
@@ -755,7 +755,7 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_FREEBIND:
 	case IP_TRANSPARENT:
-		return mptcp_setsockopt_sol_ip_set_transparent(msk, optname, optval, optlen);
+		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
 	}
-- 
2.43.0

