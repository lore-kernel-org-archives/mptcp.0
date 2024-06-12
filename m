Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07B36AF2;
	Wed, 12 Jun 2024 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196960; cv=none; b=VpDb9ssfajF0ffoy+Ge4ZHVjXX2zArWwH27pzJmEp/dAG0M3847YIZIs9fqd8Hx/qzm6ZWW9S3T+UVp/KS/a1+DIheGTMPALkTx/DdUTCK3svW6tcJru6oj5cn/iwxACc7GH1gJVD2wZK6uPXpwR1umL8+8EjIECYejKcCPK3FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196960; c=relaxed/simple;
	bh=V/Noe/XGcHkwNbGTe0jTUTJnGxzdzzV3U8aCvQhdyR8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=npIsNJFwYpmk7UfO86YxUjVU+EUxJvCpc8yHOqdMC6Dhl/E/wRUv3KguAHtep6spsxsDISBGRTuHjsXXpBvhxsg27jvRcJt5qCJ7VJvXfLO23673OBI8Ym4SDehH9JabOfAyNTfPrQKfPKM59jxUBLFIJbVuErumb3+aNCjZK9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sR8IVczk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sR8IVczk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1AFC3277B;
	Wed, 12 Jun 2024 12:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718196959;
	bh=V/Noe/XGcHkwNbGTe0jTUTJnGxzdzzV3U8aCvQhdyR8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=sR8IVczks21RQ6udT9gsp4fh3/uxLwGvwTiVls7/7Qu4RSTB4se9HaUg3iKff1art
	 1B/UbPB7xHsmRnAm3/26UStzNRYOqzHgOjZ23B0DorwVmip87Uyz9AnqQiz7DtJsqV
	 Shdhj/ztIOzeozQhX1f7XGBFdKtFUSj0uG8kySnI=
Subject: Patch "mptcp: cleanup SOL_TCP handling" has been added to the 6.6-stable tree
To: davem@davemloft.net,gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 14:55:42 +0200
In-Reply-To: <20240529095817.3370953-7-matttbe@kernel.org>
Message-ID: <2024061241-jaybird-diabolic-eb56@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    mptcp: cleanup SOL_TCP handling

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-cleanup-sol_tcp-handling.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-47624-greg=kroah.com@vger.kernel.org Wed May 29 11:58:39 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 29 May 2024 11:58:20 +0200
Subject: mptcp: cleanup SOL_TCP handling
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, "David S . Miller" <davem@davemloft.net>
Message-ID: <20240529095817.3370953-7-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 7f71a337b5152ea0e7bef408d1af53778a919316 upstream.

Most TCP-level socket options get an integer from user space, and
set the corresponding field under the msk-level socket lock.

Reduce the code duplication moving such operations in the common code.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: bd11dc4fb969 ("mptcp: fix full TCP keep-alive support")
[ Without TCP_NOTSENT_LOWAT support, as it is not in this version, see
  commit 29b5e5ef8739 ("mptcp: implement TCP_NOTSENT_LOWAT support") ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/sockopt.c |   61 ++++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -621,18 +621,11 @@ static int mptcp_setsockopt_sol_tcp_cong
 	return ret;
 }
 
-static int mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, sockptr_t optval,
-					 unsigned int optlen)
+static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val, ret;
 
-	ret = mptcp_get_int_option(msk, optval, optlen, &val);
-	if (ret)
-		return ret;
-
-	lock_sock(sk);
 	sockopt_seq_inc(msk);
 	msk->cork = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -644,23 +637,15 @@ static int mptcp_setsockopt_sol_tcp_cork
 	}
 	if (!val)
 		mptcp_check_and_set_pending(sk);
-	release_sock(sk);
 
 	return 0;
 }
 
-static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t optval,
-					    unsigned int optlen)
+static int __mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, int val)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val, ret;
-
-	ret = mptcp_get_int_option(msk, optval, optlen, &val);
-	if (ret)
-		return ret;
 
-	lock_sock(sk);
 	sockopt_seq_inc(msk);
 	msk->nodelay = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -672,8 +657,6 @@ static int mptcp_setsockopt_sol_tcp_node
 	}
 	if (val)
 		mptcp_check_and_set_pending(sk);
-	release_sock(sk);
-
 	return 0;
 }
 
@@ -786,25 +769,10 @@ static int mptcp_setsockopt_sol_tcp(stru
 	int ret, val;
 
 	switch (optname) {
-	case TCP_INQ:
-		ret = mptcp_get_int_option(msk, optval, optlen, &val);
-		if (ret)
-			return ret;
-		if (val < 0 || val > 1)
-			return -EINVAL;
-
-		lock_sock(sk);
-		msk->recvmsg_inq = !!val;
-		release_sock(sk);
-		return 0;
 	case TCP_ULP:
 		return -EOPNOTSUPP;
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
-	case TCP_CORK:
-		return mptcp_setsockopt_sol_tcp_cork(msk, optval, optlen);
-	case TCP_NODELAY:
-		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
 		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
 		mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen);
@@ -817,7 +785,30 @@ static int mptcp_setsockopt_sol_tcp(stru
 						      optval, optlen);
 	}
 
-	return -EOPNOTSUPP;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	switch (optname) {
+	case TCP_INQ:
+		if (val < 0 || val > 1)
+			ret = -EINVAL;
+		else
+			msk->recvmsg_inq = !!val;
+		break;
+	case TCP_CORK:
+		ret = __mptcp_setsockopt_sol_tcp_cork(msk, val);
+		break;
+	case TCP_NODELAY:
+		ret = __mptcp_setsockopt_sol_tcp_nodelay(msk, val);
+		break;
+	default:
+		ret = -ENOPROTOOPT;
+	}
+
+	release_sock(sk);
+	return ret;
 }
 
 int mptcp_setsockopt(struct sock *sk, int level, int optname,


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.6/mptcp-fix-full-tcp-keep-alive-support.patch
queue-6.6/mptcp-cleanup-sol_tcp-handling.patch
queue-6.6/mptcp-avoid-some-duplicate-code-in-socket-option-handling.patch
