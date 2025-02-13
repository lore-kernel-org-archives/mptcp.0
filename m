Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989223F42D;
	Thu, 13 Feb 2025 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452469; cv=none; b=IZWRoObmxtpIZPU5myd0N6ga3D/e6oFY6XW2h+BCEsLc3b4Yd8jNueEle/c/+fRlFuvpTl/k5kKpzmKNNhnaNxKH6aml9QNaWWEkprvMAXnhZ89XlDQurv/CvWeVO2Wfp0vulajBBu5NFnXRjSRMVBvmHOtu+KheGQvgMj2MjtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452469; c=relaxed/simple;
	bh=FAjFwxF9K13eFisHh9T2OfDNXVsHou33iNDV4dCCtiw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=rmwKpTaUfL3deDmFJye2LJMshtaTuuje1AenJ+JIC9yhGELNYHI8u5KHozFZEpiKsIpGiIHIDrD38PnVC2BeaPk+ST3JmRoPywYj4GW7u0C/N59tfx7xdWUPCdxKanniDJ/E3hOuq9XU5P5sQqB9AdTvb8XVqtmWOVCTZZFPJ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WJGPx1Al; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WJGPx1Al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F288C4CED1;
	Thu, 13 Feb 2025 13:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739452468;
	bh=FAjFwxF9K13eFisHh9T2OfDNXVsHou33iNDV4dCCtiw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=WJGPx1AlWyt67V2zMZLindGePWa4mtt9Y1/cvhIsIWevYP8EeIdECeWC6UaWxQoEt
	 n0xEpM1sioXdk3JYxjc5PMhtY9HF9mNnejNd7TE5gwlKbjQI8OU9wQiSEeUeQ6pDqu
	 aNJ42WT6QPQt5dU7+llFFVazB92kwxkk7cwDhA0I=
Subject: Patch "mptcp: prevent excessive coalescing on receive" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Feb 2025 14:13:47 +0100
In-Reply-To: <20250209174153.3388802-7-matttbe@kernel.org>
Message-ID: <2025021347-saucy-revival-24c7@gregkh>
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

    mptcp: prevent excessive coalescing on receive

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-prevent-excessive-coalescing-on-receive.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-114456-greg=kroah.com@vger.kernel.org Sun Feb  9 18:42:14 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun,  9 Feb 2025 18:41:56 +0100
Subject: mptcp: prevent excessive coalescing on receive
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250209174153.3388802-7-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 56b824eb49d6258aa0bad09a406ceac3f643cdae upstream.

Currently the skb size after coalescing is only limited by the skb
layout (the skb must not carry frag_list). A single coalesced skb
covering several MSS can potentially fill completely the receive
buffer. In such a case, the snd win will zero until the receive buffer
will be empty again, affecting tput badly.

Fixes: 8268ed4c9d19 ("mptcp: introduce and use mptcp_try_coalesce()")
Cc: stable@vger.kernel.org # please delay 2 weeks after 6.13-final release
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241230-net-mptcp-rbuf-fixes-v1-3-8608af434ceb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -138,6 +138,7 @@ static bool mptcp_try_coalesce(struct so
 	int delta;
 
 	if (MPTCP_SKB_CB(from)->offset ||
+	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/mm-kmemleak-fix-upper-boundary-check-for-physical-address-objects.patch
queue-6.6/mptcp-prevent-excessive-coalescing-on-receive.patch
queue-6.6/selftests-mptcp-connect-f-no-reconnect.patch
queue-6.6/selftests-mptcp-join-fix-af_inet6-variable.patch
queue-6.6/mptcp-pm-only-set-fullmesh-for-subflow-endp.patch
