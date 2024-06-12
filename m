Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5016C85B;
	Wed, 12 Jun 2024 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196946; cv=none; b=Md3iWcA1AaItzdTIpbSaIMBpLdu08RroM91D2VIH/8eRiUI5n9ixEqbi9goZLtUasrdXfOXOSFmbYvxIapIHoc/FIFnmh9yDL7/JhlvbXbIyFwBWo5iKWDT2XArNITGeTkD1KZQcMnZhMT4EtmrojCsCp1DeNjPUPzgFgbk2+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196946; c=relaxed/simple;
	bh=qokV2qFlQIvx6XtVkvMHxxy/7D3qgf8sPjDUpk1C4jc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=G3t9wbSa+CKpIDIJlib6Ird2wR/CSDU0TJHOHkryGI31PWFWusPXhQ9YGsIzePkvNjju8BFaigFzVe6mx2pV5hdki4GL/Ewlag/40eKEfV5myvxU1byaLQRy265odMcvcE+Ia1UhuQlAMhCsIElj0DACV5P07xr3nM9p987SvjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XKnilGIY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XKnilGIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA98C3277B;
	Wed, 12 Jun 2024 12:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718196945;
	bh=qokV2qFlQIvx6XtVkvMHxxy/7D3qgf8sPjDUpk1C4jc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=XKnilGIYJ7qYE3H5Fpthjz2lbfA9se+FdbcmdAOAW/xVUcIQUoQuTWP/SVV/XCaPu
	 GiCdqI+fVeUQv6/I2VI+OzsIkyD3jSQyn9VQgHA0QVLvdTS47Toz8zGTGbr5SivOHo
	 Ktev9dDNbryRxIg2XvlwOinSVr9H9fK8XLuddKkA=
Subject: Patch "mptcp: cleanup SOL_TCP handling" has been added to the 6.1-stable tree
To: davem@davemloft.net,gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 14:55:32 +0200
In-Reply-To: <20240529100022.3373664-7-matttbe@kernel.org>
Message-ID: <2024061231-reaffirm-prelaunch-4f7d@gregkh>
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

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-cleanup-sol_tcp-handling.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-47628-greg=kroah.com@vger.kernel.org Wed May 29 12:00:39 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 29 May 2024 12:00:25 +0200
Subject: mptcp: cleanup SOL_TCP handling
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, "David S . Miller" <davem@davemloft.net>
Message-ID: <20240529100022.3373664-7-matttbe@kernel.org>

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
@@ -616,18 +616,11 @@ static int mptcp_setsockopt_sol_tcp_cong
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
@@ -639,23 +632,15 @@ static int mptcp_setsockopt_sol_tcp_cork
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
@@ -667,8 +652,6 @@ static int mptcp_setsockopt_sol_tcp_node
 	}
 	if (val)
 		mptcp_check_and_set_pending(sk);
-	release_sock(sk);
-
 	return 0;
 }
 
@@ -793,25 +776,10 @@ static int mptcp_setsockopt_sol_tcp(stru
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
 		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
 	case TCP_FASTOPEN_CONNECT:
@@ -819,7 +787,30 @@ static int mptcp_setsockopt_sol_tcp(stru
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

queue-6.1/mptcp-fix-full-tcp-keep-alive-support.patch
queue-6.1/mptcp-cleanup-sol_tcp-handling.patch
queue-6.1/mptcp-avoid-some-duplicate-code-in-socket-option-handling.patch
