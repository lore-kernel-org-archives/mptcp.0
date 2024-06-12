Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8336AF2;
	Wed, 12 Jun 2024 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196951; cv=none; b=gK7cM8EPkVeiQTFkP/WkXo5fGdExfRiM5HBD3OS1t6c+HB9PFAAuXU/M4EWJ2iAyqycbphZD4UtsKp1Ygb4X7O1c6H4i5jSa/dkEZejROoPVyWyAA+hGh0EuqJKx8hjsFgb3v2nV81rSL9ab1q74RsTeDJrW91g5pSmJ2+j0qnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196951; c=relaxed/simple;
	bh=hGN2BNKyyhWlHBmg/3ScRILfbsj70e00zLONch06Qrg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Q/aFwuPhFOPiEQkREApd7r+FmhHL8CsbqRQ33XA/XSnzaROpdUYKBMYhovZ2VyHtBhvqHmswMBJVUsITytBRBQ8lLN3DXY7hvQWiPN6re4FFhn7oeyZx34XYXKcogqKrpRwERoRUS6gkGFXMEbq1tI5B5zs5+HKz/961mIyi/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lAb+pWqM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lAb+pWqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B10C3277B;
	Wed, 12 Jun 2024 12:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718196950;
	bh=hGN2BNKyyhWlHBmg/3ScRILfbsj70e00zLONch06Qrg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=lAb+pWqMTYHrRGwTRp8InpWBP7bHnda43PGGRmqnW0VsW4E7NcRml0ZuChypxU54/
	 JJyds0hnK0EzQ6XQutOLu7KghY8sMa7HyiLYM+i61OmjtyVkK+fkDU3rzaOtsYYV5R
	 SE0bOUxnOxkQtjrILQfrxosV90SANpbg9xX0+lVA=
Subject: Patch "mptcp: avoid some duplicate code in socket option handling" has been added to the 6.6-stable tree
To: davem@davemloft.net,gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 14:55:41 +0200
In-Reply-To: <20240529095817.3370953-6-matttbe@kernel.org>
Message-ID: <2024061241-grub-slider-b482@gregkh>
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

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-avoid-some-duplicate-code-in-socket-option-handling.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-47623-greg=kroah.com@vger.kernel.org Wed May 29 11:58:36 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 29 May 2024 11:58:19 +0200
Subject: mptcp: avoid some duplicate code in socket option handling
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, "David S . Miller" <davem@davemloft.net>
Message-ID: <20240529095817.3370953-6-matttbe@kernel.org>

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
@@ -626,13 +626,11 @@ static int mptcp_setsockopt_sol_tcp_cork
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
@@ -656,13 +654,11 @@ static int mptcp_setsockopt_sol_tcp_node
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

queue-6.6/mptcp-fix-full-tcp-keep-alive-support.patch
queue-6.6/mptcp-cleanup-sol_tcp-handling.patch
queue-6.6/mptcp-avoid-some-duplicate-code-in-socket-option-handling.patch
