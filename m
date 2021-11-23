Received: from fallback23.mail.ru (fallback23.m.smailru.net [94.100.187.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8D2C81
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 07:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail3;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=/r5oKKCrfDIWXMjq39MOHcVUXGKGYEpRabtOSh/GoLo=;
	t=1637653762;x=1638259162; 
	b=AAezzhxW/2L+dbbG6rDTYi3XxmyRq/af1XhgBM1J37I19IG/iUTYiRFS1nBm4dfw6TsoJQEXT6YnY3VqwmrmywA3qhz4ucSpb0B/bL2NLwqY1Mr70bdar3Hovrdi2xvcgsja8pMQjK1eXudYbjqAXUYIzP+feERzNFgPnIfzjys=;
Received: from [10.161.64.43] (port=60030 helo=smtp35.i.mail.ru)
	by fallback23.m.smailru.net with esmtp (envelope-from <max@internet.ru>)
	id 1mpPtx-0001sy-Nc
	for mptcp@lists.linux.dev; Tue, 23 Nov 2021 10:07:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=/r5oKKCrfDIWXMjq39MOHcVUXGKGYEpRabtOSh/GoLo=;
	t=1637651257;x=1638256657; 
	b=PuVV4S73YFAZCXE+NJprRS4dwJ/3YmoUy7uNpZsMNj2mLGGL2vPcspiTI4IzSDR6VdYj4wPV5BalyV0v/oD5faaKbifHYU45UYAZy2hQ5zr15ZP4Km2JokkHnS7cmSN6H+4y/bePTJMC8SUWmscj4YKeUPHaN4nXq2RjdVtvgQdaQqGWXUxn9znueFfeKzvnru0zQbhCHzI20z1mZpCP29xDH8pXsaOyuGTPwUEEwQ2SzY6h64WtHA9whqth3wyJoxnzbgLFd/bTWjB+IjSZtgmYEzPTcIUpVP2U7UxUgclmElr3rguX+mjq2j9S/hIM3kaY0PuF+eW3TUyL/qbf/Q==;
Received: by smtp35.i.mail.ru with esmtpa (envelope-from <max@internet.ru>)
	id 1mpPtp-0002NB-IM; Tue, 23 Nov 2021 10:07:30 +0300
From: Maxim Galaganov <max@internet.ru>
To: mptcp@lists.linux.dev
Cc: Maxim Galaganov <max@internet.ru>
Subject: [PATCH mptcp-next 3/3] mptcp: support TCP_CORK and TCP_NODELAY
Date: Tue, 23 Nov 2021 10:07:08 +0300
Message-Id: <20211123070708.2897469-4-max@internet.ru>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123070708.2897469-1-max@internet.ru>
References: <20211123070708.2897469-1-max@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9BAEAA343CB33328DF92459FC902347094773BA340476FEDD1313CFAB8367EF908E2BE116634AD74D5AD3A22E445012E9603561DA1CB10086503835FA8921BE82C72A02DE8EF075F6
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B7733D0215A2F71AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006374B2D40F594293EAD8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D85152B88630E2408431D5A986FED178706F9789CCF6C18C3F8528715B7D10C86859CC434672EE6371117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC2EE5AD8F952D28FBA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD182CC0D3CB04F14752D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EED76C6ED7039589DE4D0DA9BD313A0613D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE31F9513A7CA91E5556136E347CC761E07C4224003CC836476EA7A3FFF5B025636E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F790063765DCC2E2BEE1D191EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-B7AD71C0: AC4F5C86D027EB782CDD5689AFBDA7A213B5FB47DCBC3458834459D11680B505A64F04A8DA58D1F3A7627F2A65545C38
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975CC559E5F89E84DC55D4CF228061722C235D919DFBAB43A9589C2B6934AE262D3EE7EAB7254005DCED7532B743992DF240BDC6A1CF3F042BAD6DF99611D93F60EF25DC386152A6764A699F904B3F4130E343918A1A30D5E7FCCB5012B2E24CD356
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D347324AA9FA07FF01E0C8C8F21883E77FFA9B1E1E77343519254A9D9FE08DC63BA9D8622B518EBE2C81D7E09C32AA3244C9F959D46CD5559FA659345AADF294F2A853296C06374E602729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojutWt0++zX5T1l8lDkT4iYw==
X-Mailru-Sender: 6B47EA55652F5E70849B49CCF28A6C3B79F2D85E841A4C7ADF4334CDCC15A839C93384347223FF60AA92DCB28147B367B60569B44082A3A3CC338593878DF048773EBFF2F43C11D60D4ABDE8C577C2ED
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4EE34287C01580B602FF54B759B37932369B5239765CEB9CF049FFFDB7839CE9E53879DFD0F690E42A1ABF948FCF29E5D2968813A697059DE967915647A064788
X-7FA49CB5: 0D63561A33F958A5927FB84AB53B504343D04C1312C21C09F21F2D2C081F2F4ECACD7DF95DA8FC8BD5E8D9A59859A8B699B836357A5F2ED6CC7F00164DA146DAFE8445B8C89999728AA50765F7900637FBC651BE86AB0F05389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC87C7DAE56957A78C8F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C706E30CA5231861903F1AB874ED890284AD6D5ED66289B52698AB9A7B718F8C442539A7722CA490CD5E8D9A59859A8B634381CAC65D01DA6089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: C20DE7B7AB408E4181F030C43753B8186998911F362727C414F749A5E30D975CC559E5F89E84DC55F5DC25F94A884639CA4B0D72CF4506D49C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojutWt0++zX5QIFJQCOptVlA==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C90059EC859477DBBED74C056BE3D4CE15F9313AFDEFA4BDAE50C21401CF93FD6FA5584390AFDD794B14678274A4A9E9E44FD5B858845640BC0C1AB428D199E4977E267EA787935ED9F1B
X-Mras: Ok

First, add cork and nodelay fields to the mptcp_sock structure
so they can be used in sync_socket_options(), and fill them on setsockopt
while holding the msk socket lock.

Then, on setsockopt set proper tcp_sk(ssk)->nonagle values for subflows
by calling __tcp_sock_set_cork() or __tcp_sock_set_nodelay() on the ssk
while holding the ssk socket lock.

tcp_push_pending_frames() will be invoked on the ssk if a cork was cleared
or nodelay was set. Also set MPTCP_PUSH_PENDING bit by calling
mptcp_check_and_set_pending(). This will lead to __mptcp_push_pending()
being called inside mptcp_release_cb() with new tcp_sk(ssk)->nonagle.

Also add getsockopt support for TCP_CORK and TCP_NODELAY.

Signed-off-by: Maxim Galaganov <max@internet.ru>
---
I've tested this by doing single-byte writes and looking at the length
of packets in tcpdump, also this is now running on my tproxy setup.
Enabling nodelay on a tproxy gave a decrease in latency to first byte
and lead to improved user experience in web browsing and voip
applications. Existing selftests run passed on a debug config, I'll add
coverage for new sockopts once I grasp how to do it.

Should these bit fields have an explicit zero initializer? I've looked
at recvmsg_inq and it doesn't seem to have one.

 net/mptcp/protocol.h |  4 ++-
 net/mptcp/sockopt.c  | 70 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7f199fb720ff..47d24478763c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -249,7 +249,9 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	bool		allow_infinite_fallback;
-	u8		recvmsg_inq:1;
+	u8		recvmsg_inq:1,
+			cork:1,
+			nodelay:1;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 11cda8629993..e0501f6bfff8 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -616,6 +616,66 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
+static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optval,
+					 unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int val;
+
+	if (optlen < sizeof(int))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&val, optval, sizeof(val)))
+		return -EFAULT;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	msk->cork = !!val;
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+		__tcp_sock_set_cork(ssk, !!val);
+		release_sock(ssk);
+	}
+	if (!val)
+		mptcp_check_and_set_pending(sk);
+	release_sock(sk);
+
+	return 0;
+}
+
+static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t optval,
+					    unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int val;
+
+	if (optlen < sizeof(int))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&val, optval, sizeof(val)))
+		return -EFAULT;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	msk->nodelay = !!val;
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+		__tcp_sock_set_nodelay(ssk, !!val);
+		release_sock(ssk);
+	}
+	if (val)
+		mptcp_check_and_set_pending(sk);
+	release_sock(sk);
+
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int optname,
 						   sockptr_t optval, unsigned int optlen)
 {
@@ -717,6 +777,10 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return -EOPNOTSUPP;
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
+	case TCP_CORK:
+		return mptcp_setsockopt_sol_tcp_cork(msk, optval, optlen);
+	case TCP_NODELAY:
+		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -1078,6 +1142,10 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 						      optval, optlen);
 	case TCP_INQ:
 		return mptcp_put_int_option(msk, optval, optlen, msk->recvmsg_inq);
+	case TCP_CORK:
+		return mptcp_put_int_option(msk, optval, optlen, msk->cork);
+	case TCP_NODELAY:
+		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
 	}
 	return -EOPNOTSUPP;
 }
@@ -1165,6 +1233,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	if (inet_csk(sk)->icsk_ca_ops != inet_csk(ssk)->icsk_ca_ops)
 		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
+	__tcp_sock_set_cork(ssk, !!msk->cork);
+	__tcp_sock_set_nodelay(ssk, !!msk->nodelay);
 
 	inet_sk(ssk)->transparent = inet_sk(sk)->transparent;
 	inet_sk(ssk)->freebind = inet_sk(sk)->freebind;
-- 
2.33.1

