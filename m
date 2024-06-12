Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A616C85B;
	Wed, 12 Jun 2024 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196934; cv=none; b=tiHdJHJMV0jFu4Dia/4t8HCpe4efYSetvzEWXs9uI7lpJ+KLouIsrNgaDIcxdqWDvwXBFAVngdWgRDO1inyGXpQba5RWrogQPIP5qfhlOYIoCEK5VeGg2S9PUfNC1Z47YkfoWvXaG2vTXmE1EOycKBcVyqxLY/lRjVXOFnpLD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196934; c=relaxed/simple;
	bh=h2xJkU4x+5A0Eio0ZdlsU8PCd/1w4URyqTMYLElaL6E=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=BThmnuHXNGYdO4sx6NJwIIl8T+7TfxBr1dGF2Qj5K1kXukrI3SkmsVSER/f36AMLBix+8VH2POn3FEY+VhLiERwlF7hAta7/v5iuSzOUYXNiZ7wgTP1iTnygsuJmvhvQIiosEgBiGOs+oIsVhkpTIwjucgXJIesYrFnocU0OQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DjgWrHLW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DjgWrHLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE438C3277B;
	Wed, 12 Jun 2024 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718196934;
	bh=h2xJkU4x+5A0Eio0ZdlsU8PCd/1w4URyqTMYLElaL6E=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=DjgWrHLWyg9BfYyDeLDryV6X8FTvF7FOeXUA5HXx+PNmbUsog5YupJLknhe4BK3QL
	 Mav+xqMBJ9+dplCXdWnJXV1PF+R65oGRYEexM6ZpTUyi0O2EkvbuBoBDc63b7LGAj4
	 p5Dq08ODPi/Vb6nGtmbMuZww19PQ55SbgWLAyB1E=
Subject: Patch "mptcp: avoid some duplicate code in socket option handling" has been added to the 6.1-stable tree
To: davem@davemloft.net,gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 14:55:31 +0200
In-Reply-To: <20240529100022.3373664-6-matttbe@kernel.org>
Message-ID: <2024061231-urchin-dizzy-ce86@gregkh>
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

    mptcp: avoid some duplicate code in socket option handling

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-avoid-some-duplicate-code-in-socket-option-handling.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-47627-greg=kroah.com@vger.kernel.org Wed May 29 12:00:37 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 29 May 2024 12:00:24 +0200
Subject: mptcp: avoid some duplicate code in socket option handling
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, "David S . Miller" <davem@davemloft.net>
Message-ID: <20240529100022.3373664-6-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit a74762675f700a5473ebe54a671a0788a5b23cc9 upstream.

The mptcp_get_int_option() helper is needless open-coded in a
couple of places, replace the duplicate code with the helper
call.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: bd11dc4fb969 ("mptcp: fix full TCP keep-alive support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/sockopt.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -621,13 +621,11 @@ static int mptcp_setsockopt_sol_tcp_cork
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val;
+	int val, ret;
 
-	if (optlen < sizeof(int))
-		return -EINVAL;
-
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
 
 	lock_sock(sk);
 	sockopt_seq_inc(msk);
@@ -651,13 +649,11 @@ static int mptcp_setsockopt_sol_tcp_node
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
-	int val;
-
-	if (optlen < sizeof(int))
-		return -EINVAL;
+	int val, ret;
 
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+	ret = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (ret)
+		return ret;
 
 	lock_sock(sk);
 	sockopt_seq_inc(msk);


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.1/mptcp-fix-full-tcp-keep-alive-support.patch
queue-6.1/mptcp-cleanup-sol_tcp-handling.patch
queue-6.1/mptcp-avoid-some-duplicate-code-in-socket-option-handling.patch
