Received: from fallback20.i.mail.ru (fallback20.i.mail.ru [79.137.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7555E1C69A
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internet.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="gAxjAM5q";
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="ULQeQd4V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=muhEWtPlqYh6ASh7rY04FIhdlY7dgwNZt0SE5b6si/A=;
	t=1701257664;x=1701347664; 
	b=gAxjAM5q3JeSTRFdYieWetAyBjbC4e3aTGW3x7tfOEMIAbO7cOLWOSR6LpTt+PriCgmmnxpKWWIlfev1a96/m52WvP3VdMmJ2YQiNZoZwB2Q38C1e37p2MP7CxJVDAuQcs7Kwlqphxo4ttKTB2pf92S2oeEFKZeY46XS5q7CvCNZF+n45h/CXUVxf0ANiR+aOeVKD2qqTRo5Lqi5gkKSF5G3pi5mGUkS+zgm8G2PnJwe6gzNbEbATo8Nt6thm3yBaowNFCftVlm9+aVR8hMmvgRy2PuA5wN2QFo8VWueHWc1ibcs/bfdzP4A6ID7PQvwk9yEro31fTwcFBAF3Vtb4g==;
Received: from [10.12.4.19] (port=51218 helo=smtp43.i.mail.ru)
	by fallback20.i.mail.ru with esmtp (envelope-from <max@internet.ru>)
	id 1r8Ipc-008tHC-7l
	for mptcp@lists.linux.dev; Wed, 29 Nov 2023 14:34:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru
	; s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=muhEWtPlqYh6ASh7rY04FIhdlY7dgwNZt0SE5b6si/A=; t=1701257656; x=1701347656; 
	b=ULQeQd4VgycjnWyhmI5drEm/4DMVsF4XOIL64bfw9J+NFKVvotJdY74lwnTSg1pkuOzEfFTXPsb
	qe7eITDXOIZIxDkB91D21N5gyyxJZiv0jUWYBFxH4kDfazi6/01KbuXM6WhURnzy5cmshePmMtRmU
	rJ5CRvMqyjwghC+4JBxUM95dBkkPOv5Iy0z486aQ1QK+dsIed7jUaRnhu9J5d78aYGsundNo8ezeD
	gDseqw/47hxS1Ksq7Jvzmdb7MfIQEyqvx9hu6Hz727ThF0sUjE63EmVT+Zzs8zGdmI2s021J75FbR
	Hm4GVHZYAABfkBRCFIWY8+CL2YKbKrtXbVeg==;
Received: by smtp43.i.mail.ru with esmtpa (envelope-from <max@internet.ru>)
	id 1r8IpT-00Gl5I-0J; Wed, 29 Nov 2023 14:34:07 +0300
From: Maxim Galaganov <max@internet.ru>
To: mptcp@lists.linux.dev
Cc: Maxim Galaganov <max@internet.ru>
Subject: [PATCH v2 mptcp-next 1/3] mptcp: rename mptcp_setsockopt_sol_ip_set_transparent()
Date: Wed, 29 Nov 2023 14:34:01 +0300
Message-ID: <20231129113403.157953-2-max@internet.ru>
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
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9D2A6479154BC7F417F3587B7BFEB0898590F1491F5F80929182A05F53808504016660FBC00641858DC9C42A1D6C5AC75A3E8FBA0E3B092766656EC6F9E6CC462
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F9D3BE5B596754B8C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7548C33FFD72831AFEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD8713E6427F13679E39030580414F251F25220879F7C8C5043D14489FFFB0AA5F4BFA417C69337E82CC2CC7F00164DA146DAFE8445B8C89999728AA50765F79006375FFD5C25497261569FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3A12191B5F2BB8629117882F4460429728AD0CFFFB425014E868A13BD56FB6657E2021AF6380DFAD1A18204E546F3947C062BEEFFB5F8EA3E2E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F616AD31D0D18CD5CA91E23F1B6B78B78B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5D9594784CA32331C6340F1FE64E119E5959FF6914E02ADEEF87CCE6106E1FC07E67D4AC08A07B9B06A1CB4668A9CA5FA9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A09062BEEFFB5F8EA3ECB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFC86E0A124B49B8F284976B132ADC111DF9C2C58CFE28C19E6468B5922F23ADD685EFCC6ECD454202153AE024B6FD0844F2999BB6407CEA066896790422DF237340B08DDBC5CE87D002C26D483E81D6BEA5ED0C00A4B096A39697699CFF2E0C50CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxXIty/pLbajr58ac6SbFJQ==
X-Mailru-Sender: 689FA8AB762F7393590D8C940224AE3337997398C20E5AD8BDC22D298FA16F2BE94AC9D29F4E5226FD262907200E8C52FB559BB5D741EB96C728B2FC74FAA16AD7A14DD9E34ECE7467EA787935ED9F1B
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B487EF4F2ACC83E26BD6E5864C7F64BC8E64D4A666CFC15109049FFFDB7839CE9EF53F02DB5938BDCCDA438BDB920314CDE6B1C38D5C181AD87A1287C063BC18CA
X-7FA49CB5: 0D63561A33F958A5AF5C9C2858DED8D46B91BC2D559B31C62236A5C195D92641CACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFddY4eMfORNHPB3JWZRqnMDA==
X-Mailru-MI: C000000000000800
X-Mras: Ok

Next patch extends this function so that it's not specific to
IP_TRANSPARENT. Change function name to mptcp_setsockopt_sol_ip_set().

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

