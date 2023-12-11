Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [95.163.41.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708CE219F1
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internet.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="pp7CeOSc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru
	; s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=ZQLD7MvnHYcJQmd6My4XWk0UOeqcdtWewW7kWZoKZH4=; t=1702296238; x=1702386238; 
	b=pp7CeOScJYI058cSa13bdmLKYq0q9WylhWrMqoQzo3U3xgBu38JHzS2z5dRR2P+bZdySVKMtCW1
	/Y3zN628uzD/kVfCgg2lG3NMRFOwwiqDT0rqU2SwA3YWiMEd9L9KckgKIZH72QAYlra9BrsegFCzx
	KY25t+S3S1mzDmKRnT09oGxlmr5MTJ9xnN1s36Gg6foeNqpR9i65fPDALuiA4LyD3yOR5r37kOzxi
	Lsn6U0JB52qfLcqItFm2G4I18QUjqdeJ6sUQW+3aKHP5I4X57njxecLuFK6+tzjkuQqmrMetUBUFM
	glCejnyPrZkiF8Ko3gaiY+lpOIK+LRh2XLpw==;
Received: by smtp44.i.mail.ru with esmtpa (envelope-from <max@internet.ru>)
	id 1rCf0t-009382-1f; Mon, 11 Dec 2023 15:03:56 +0300
From: Maxim Galaganov <max@internet.ru>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Maxim Galaganov <max@internet.ru>
Subject: [PATCH v3 mptcp-next 2/3] mptcp: sockopt: support IP_LOCAL_PORT_RANGE and IP_BIND_ADDRESS_NO_PORT
Date: Mon, 11 Dec 2023 15:03:08 +0300
Message-ID: <20231211120309.20752-3-max@internet.ru>
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
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD97533543916A0F71AAFEA554151D011C2857CB10EE404042BCD62213F67905E7A5089C445FEF7FFACD566A3AD6BE0A83C31A0EA4EC84C67EC6C831481B6BD6C10
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F65C230EDDCD559EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063767500BC4578134A08638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8F64DA79B590D303387588D97C24D6A876F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7850F8B975A76562C9FA2833FD35BB23D9E625A9149C048EE140C956E756FBB7A2CC0D3CB04F14752D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B63AF70AF8205D7DCA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC028AECD13B03DE2FD32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED6299176DF2183F8FC7C02D242C3BD2E3F4C6C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CA9FF340AA05FB58C2E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F890A246B268E114EA91E23F1B6B78B78B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5AE103A7BA9CB3DEF0A0CAB60E820A5D9C6615A230ED7E0A6F87CCE6106E1FC07E67D4AC08A07B9B0251EFD5447B32ED69C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF13AA933D9168D9051A868575DD3F5A0296F5112948D9A90A65D1193337EC17E12DF5FAC740BFE7CDFC43826C574F1C6F4AFB09B4340EBA674B787F9853954833E48CAC7CA610320002C26D483E81D6BEA5ED0C00A4B096A39697699CFF2E0C50CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojUXpChnEw0AXnV6fyj97fIQ==
X-Mailru-Sender: 4A46F6E6BB1A04662A3B81E17F92FA4992FE2D013536E36BEC6FBC9639908154130BB289A1C4FBB910AB1EC7B4FC32D5C77752E0C033A69E0ACD20E4C8A7C03EF0AEF442C4C8402EB4A721A3011E896F
X-Mras: Ok

Support for IP_BIND_ADDRESS_NO_PORT sockopt was introduced in [1].
Recently [2] allowed its value to be accessed without locking the
socket.

Support for (newer) IP_LOCAL_PORT_RANGE sockopt was introduced in [3].
In the same series a selftest was added in [4]. This selftest also
covers the IP_BIND_ADDRESS_NO_PORT sockopt.

This patch enables getsockopt()/setsockopt() on MPTCP sockets for these
socket options, syncing set values to subflows in sync_socket_options().
Ephemeral port range is synced to subflows, enabling NAT usecase
described in [3].

[1] commit 90c337da1524 ("inet: add IP_BIND_ADDRESS_NO_PORT to overcome
bind(0) limitations")
[2] commit ca571e2eb7eb ("inet: move inet->bind_address_no_port to
inet->inet_flags")
[3] commit 91d0b78c5177 ("inet: Add IP_LOCAL_PORT_RANGE socket option")
[4] commit ae5439658cce ("selftests/net: Cover the IP_LOCAL_PORT_RANGE
socket option")

Signed-off-by: Maxim Galaganov <max@internet.ru>
---
 net/mptcp/sockopt.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a4bf337e6f77..c40f1428e602 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -440,6 +440,8 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		/* should work fine */
 		case IP_FREEBIND:
 		case IP_TRANSPARENT:
+		case IP_BIND_ADDRESS_NO_PORT:
+		case IP_LOCAL_PORT_RANGE:
 
 		/* the following are control cmsg related */
 		case IP_PKTINFO:
@@ -455,7 +457,6 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		/* common stuff that need some love */
 		case IP_TOS:
 		case IP_TTL:
-		case IP_BIND_ADDRESS_NO_PORT:
 		case IP_MTU_DISCOVER:
 		case IP_RECVERR:
 
@@ -710,6 +711,14 @@ static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
 		inet_assign_bit(TRANSPARENT, ssk,
 				inet_test_bit(TRANSPARENT, sk));
 		break;
+	case IP_BIND_ADDRESS_NO_PORT:
+		inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk,
+				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+		break;
+	case IP_LOCAL_PORT_RANGE:
+		WRITE_ONCE(inet_sk(ssk)->local_port_range,
+			   READ_ONCE(inet_sk(sk)->local_port_range));
+		break;
 	default:
 		release_sock(sk);
 		WARN_ON_ONCE(1);
@@ -755,6 +764,8 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_FREEBIND:
 	case IP_TRANSPARENT:
+	case IP_BIND_ADDRESS_NO_PORT:
+	case IP_LOCAL_PORT_RANGE:
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
@@ -1350,6 +1361,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_TOS:
 		return mptcp_put_int_option(msk, optval, optlen, READ_ONCE(inet_sk(sk)->tos));
+	case IP_BIND_ADDRESS_NO_PORT:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+	case IP_LOCAL_PORT_RANGE:
+		return mptcp_put_int_option(msk, optval, optlen,
+				READ_ONCE(inet_sk(sk)->local_port_range));
 	}
 
 	return -EOPNOTSUPP;
@@ -1450,6 +1467,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
+	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.43.0

