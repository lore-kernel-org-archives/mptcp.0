Received: from fallback18.i.mail.ru (fallback18.i.mail.ru [79.137.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09AC1CFA0
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internet.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="KsulB2sO";
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="Obf8TweZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=syEcwYkR+GzVQN0l4J2Zrn4zgGdZIThEXG7APVgErQw=;
	t=1701258653;x=1701348653; 
	b=KsulB2sOjrxxUQhvKGNmnhTK+KMwuPRliXQR47k5WrU/73l6Hdm8/ZjNPfAhxldqgnz+jNOj74LL9U3ZoWHq8d1P8VeXTmaFNYLK9CqQclTq0oxk1qJ8sRqP9Ktj1vpjRVRzuL73mh4qR+6aZgevACH65DK1Xv1n5mJTdgWSpfjGODie8nh80szqRxLluNcQeyy12xmlpLi7b2rW65rrM0FwbIF4fhzzqrKxFcx5cOljTMMZufZSGBU86fl0zTYBvjxfrOmzMVxtQ8h1br1vGXwcTA7HSXeEPyaDg+SgSYvkSnW3OtMzLJkFTzJrgJELc68JnL3zbWA8Ib0MWiQdtg==;
Received: from [10.12.4.19] (port=34576 helo=smtp43.i.mail.ru)
	by fallback18.i.mail.ru with esmtp (envelope-from <max@internet.ru>)
	id 1r8Ipc-002CKT-6f
	for mptcp@lists.linux.dev; Wed, 29 Nov 2023 14:34:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru
	; s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=syEcwYkR+GzVQN0l4J2Zrn4zgGdZIThEXG7APVgErQw=; t=1701257656; x=1701347656; 
	b=Obf8TweZtC1eeiGSnZHCzqrMdGDwAyigB0VEI/vZJWbAfRU40BUsBBdInxVO/J2XHlo+RxIGin0
	mHz1WZsOI095pWEs3E+SEtf9jwCv/BttsGnuM7VuqZNmA8eFHl+5RExmiJp6UCNrAQulKbf/R6JOE
	QXZ6CK3ONvd61sTBZ8hyR8+o68V0Q+YeuR/Ks73SCZt7zSVEP4f0jV4UVqPhFahrk3NUW3MIORo3y
	wWZzCzMAuGMJWNVoIm54PWnnhoIi4PisHJSQuunNahuQ+jE5y4AubQynnf8pHIQX9J86oBsCLtpYu
	AVjsQMRhjKXlsUuakDizbAkrriFAwfqoIfjA==;
Received: by smtp43.i.mail.ru with esmtpa (envelope-from <max@internet.ru>)
	id 1r8IpT-00Gl5I-24; Wed, 29 Nov 2023 14:34:08 +0300
From: Maxim Galaganov <max@internet.ru>
To: mptcp@lists.linux.dev
Cc: Maxim Galaganov <max@internet.ru>
Subject: [PATCH v2 mptcp-next 2/3] mptcp: sockopt: support IP_LOCAL_PORT_RANGE and IP_BIND_ADDRESS_NO_PORT
Date: Wed, 29 Nov 2023 14:34:02 +0300
Message-ID: <20231129113403.157953-3-max@internet.ru>
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
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D2A6479154BC7F418FEB8BF5E14AE60FC43E1EA487F9FC57182A05F53808504016660FBC00641858384E65AEC385B59A12F8EC3B8163E20101B7EFB717C26013
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79145AB6E9E75F07EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D8F5094E9BAC3E9F8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8A46F852967F4F77A99AE77E4E5B44DE96F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7850F8B975A76562C9FA2833FD35BB23D9E625A9149C048EEB1593CA6EC85F86D28451B159A507268D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BCC99A7B061B94ED7A471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249D52CD31C43BF465FE827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B68A0907C648FB30DE089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5D9594784CA32331C6340F1FE64E119E551AA1021F38D39E3F87CCE6106E1FC07E67D4AC08A07B9B0AD0E433DBF1FBFA39C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFBA398B841D2061AD23D0E724FDF8F240AFE0642A5BC73278400508AFB4A805A2F6452569441AF364153AE024B6FD0844F2999BB6407CEA060E0AA513ECC334A540B08DDBC5CE87D002C26D483E81D6BEA5ED0C00A4B096A39697699CFF2E0C50CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxXIty/pLbajBCbYUPdY91A==
X-Mailru-Sender: 689FA8AB762F7393590D8C940224AE3337997398C20E5AD83F59F22B935F4BE0E94AC9D29F4E5226FD262907200E8C52FB559BB5D741EB96C728B2FC74FAA16AD7A14DD9E34ECE7467EA787935ED9F1B
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B487EF4F2ACC83E26BD6E5864C7F64BC8EDEDAB508AFE0088D049FFFDB7839CE9EF53F02DB5938BDCC6F9D1994E6E7F4955FCEC374AC5079BF7A1287C063BC18CA
X-7FA49CB5: 0D63561A33F958A5AF5C9C2858DED8D452A7667805D1363443DA9A49429FC502CACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFddY4eMfORNHPB3JWZRqnMDA==
X-Mailru-MI: C000000000000800
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
 net/mptcp/sockopt.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a4bf337e6f77..a164a3e21be4 100644
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
 
@@ -688,6 +689,7 @@ static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sock *ssk;
+	bool slow;
 	int err;
 
 	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
@@ -710,6 +712,16 @@ static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
 		inet_assign_bit(TRANSPARENT, ssk,
 				inet_test_bit(TRANSPARENT, sk));
 		break;
+	case IP_BIND_ADDRESS_NO_PORT:
+		inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk,
+				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+		break;
+	case IP_LOCAL_PORT_RANGE:
+		slow = lock_sock_fast(ssk);
+		inet_sk(ssk)->local_port_range.lo = inet_sk(sk)->local_port_range.lo;
+		inet_sk(ssk)->local_port_range.hi = inet_sk(sk)->local_port_range.hi;
+		unlock_sock_fast(ssk, slow);
+		break;
 	default:
 		release_sock(sk);
 		WARN_ON_ONCE(1);
@@ -755,6 +767,8 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_FREEBIND:
 	case IP_TRANSPARENT:
+	case IP_BIND_ADDRESS_NO_PORT:
+	case IP_LOCAL_PORT_RANGE:
 		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
 	case IP_TOS:
 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
@@ -1346,10 +1360,20 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 			       char __user *optval, int __user *optlen)
 {
 	struct sock *sk = (void *)msk;
+	bool slow;
+	int val;
 
 	switch (optname) {
 	case IP_TOS:
 		return mptcp_put_int_option(msk, optval, optlen, READ_ONCE(inet_sk(sk)->tos));
+	case IP_BIND_ADDRESS_NO_PORT:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+	case IP_LOCAL_PORT_RANGE:
+		slow = lock_sock_fast(sk);
+		val = inet_sk(sk)->local_port_range.hi << 16 | inet_sk(sk)->local_port_range.lo;
+		unlock_sock_fast(sk, slow);
+		return mptcp_put_int_option(msk, optval, optlen, val);
 	}
 
 	return -EOPNOTSUPP;
@@ -1450,6 +1474,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
+	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+	inet_sk(ssk)->local_port_range.lo = inet_sk(sk)->local_port_range.lo;
+	inet_sk(ssk)->local_port_range.hi = inet_sk(sk)->local_port_range.hi;
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.43.0

