Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A23180032;
	Mon, 12 Aug 2024 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475472; cv=none; b=HmzqhFZKMAJndd+mworVleX/ICvQLjy4Lb1ZmxA3YPzUqdJUr0H+ZXnSi98ykkjaxbyEhKaKx9yaITV/KWzZ2OdH2Qb4nLVicCQyErvWu553rPBdC9IAA/GcDZWG1+CwLr+FTNeJ8m3LsKWX6fTaqEj2Z+YTTjEqIOv76yE3vmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475472; c=relaxed/simple;
	bh=U1p/t4PoGvOk6cECWNcBXpyb66+RyNKfJs2Z1z4erEE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=vDHxzuO2Fwlqsp9m0GFi0kKRn27SpVy8W3FR4C3+rx6+nC6KBGOwfxXjhzrNb/EOl7FXUtto6P3lrWFdSq/g4g6ypexL38rfzQiCoTcbPmHzlqizxB8ahU3ZZekAhAFopoz1xPwa3/fr6ZCfD4vB3lIipPdlGRm1d0+jRqd/lnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XVekEYlV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XVekEYlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1E9C32782;
	Mon, 12 Aug 2024 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723475471;
	bh=U1p/t4PoGvOk6cECWNcBXpyb66+RyNKfJs2Z1z4erEE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=XVekEYlV9ZpcUQGioUpPWvToMLzYsi9QB3/bFzRXcueNspY5o8semrwb4OwfrpDbp
	 FXTc0m2jro7lcTrgjzpLtempcNurrrjVErekrTAAuHiSsaaw7eWm2DKEZdlNxOKNdr
	 mqfuPoykxuW2xooBX5CSgG64qkmI6fQUIHiecGfg=
Subject: Patch "mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set" has been added to the 6.10-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 17:11:08 +0200
In-Reply-To: <20240812150213.489098-10-matttbe@kernel.org>
Message-ID: <2024081208-uncombed-dangling-bf75@gregkh>
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

    mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set

to the 6.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-do-not-ignore-subflow-if-signal-flag-is-also-set.patch
and it can be found in the queue-6.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66732-greg=kroah.com@vger.kernel.org Mon Aug 12 17:03:00 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 12 Aug 2024 17:02:17 +0200
Subject: mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240812150213.489098-10-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 85df533a787bf07bf4367ce2a02b822ff1fba1a3 upstream.

Up to the 'Fixes' commit, having an endpoint with both the 'signal' and
'subflow' flags, resulted in the creation of a subflow and an address
announcement using the address linked to this endpoint. After this
commit, only the address announcement was done, ignoring the 'subflow'
flag.

That's because the same bitmap is used for the two flags. It is OK to
keep this single bitmap, the already selected local endpoint simply have
to be re-used, but not via select_local_address() not to look at the
just modified bitmap.

Note that it is unusual to set the two flags together: creating a new
subflow using a new local address will implicitly advertise it to the
other peer. So in theory, no need to advertise it explicitly as well.
Maybe there are use-cases -- the subflow might not reach the other peer
that way, we can ask the other peer to try initiating the new subflow
without delay -- or very likely the user is confused, and put both flags
"just to be sure at least the right one is set". Still, if it is
allowed, the kernel should do what has been asked: using this endpoint
to announce the address and to create a new subflow from it.

An alternative is to forbid the use of the two flags together, but
that's probably too late, there are maybe use-cases, and it was working
before. This patch will avoid people complaining subflows are not
created using the endpoint they added with the 'subflow' and 'signal'
flag.

Note that with the current patch, the subflow might not be created in
some corner cases, e.g. if the 'subflows' limit was reached when sending
the ADD_ADDR, but changed later on. It is probably not worth splitting
id_avail_bitmap per target ('signal', 'subflow'), which will add another
large field to the msk "just" to track (again) endpoints. Anyway,
currently when the limits are changed, the kernel doesn't check if new
subflows can be created or removed, because we would need to keep track
of the received ADD_ADDR, and more. It sounds OK to assume that the
limits should be properly configured before establishing new
connections.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-5-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -512,8 +512,8 @@ __lookup_addr(struct pm_nl_pernet *perne
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *local;
 	unsigned int add_addr_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
@@ -579,6 +579,9 @@ static void mptcp_pm_create_subflow_or_s
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &local->addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
+
+		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = local;
 	}
 
 subflow:
@@ -589,9 +592,14 @@ subflow:
 		bool fullmesh;
 		int i, nr;
 
-		local = select_local_address(pernet, msk);
-		if (!local)
-			break;
+		if (signal_and_subflow) {
+			local = signal_and_subflow;
+			signal_and_subflow = NULL;
+		} else {
+			local = select_local_address(pernet, msk);
+			if (!local)
+				break;
+		}
 
 		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.10/mptcp-pm-don-t-try-to-create-sf-if-alloc-failed.patch
queue-6.10/selftests-mptcp-join-ability-to-invert-add_addr-check.patch
queue-6.10/mptcp-pm-do-not-ignore-subflow-if-signal-flag-is-also-set.patch
queue-6.10/selftests-mptcp-join-test-both-signal-subflow.patch
queue-6.10/mptcp-pm-reduce-indentation-blocks.patch
