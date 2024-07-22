Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F974171075
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676958; cv=none; b=jdEsXuxDA8JCmgVXX7Z0MvpvpPx7dgR6oFOJGYg4Ojm0RxEt2jWtduVTSo1MXeynKjmbIIkVViSGU596ZSqrrzfPnzsKCiuoX/SLZwEMH5mfc4SLnrSzb5f6BdUqzg6dMCxvDxGs3PSm9LVRNnHlC7boItbKH7ST5tlbo6hCf1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676958; c=relaxed/simple;
	bh=i77z9tOTtHs5P1x2DEPDtVt0aXpXalQv5SfvpCPktr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PH9sYvk9bKYZZO5UWqNCOUdha6dbU5w7s78OoK3eAcqo3cVvqPN497GYgB643V1qFlcEORSZCGkX9VqUgw/s5PB2ZO8bcAjaACn+3KFgCs9aC3tQsvNwLUGeeNboKmgTmDn6W6kBY4P6fHLXjbLmNiJswS+cK+xLrk875v6OMTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nURdAtAu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nURdAtAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878DFC32782;
	Mon, 22 Jul 2024 19:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676958;
	bh=i77z9tOTtHs5P1x2DEPDtVt0aXpXalQv5SfvpCPktr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nURdAtAut6tqYlOyvulkH89MvPeJIHdTY4ZjXHej1c+1VK6ixAi5ETdGodo6LwDxU
	 MBKAIyxFxfb/Reg444Sr92AgPLWt09Q9KqyJsYzJ+yJ1h0P172FDbZb4scZ6XajeBh
	 GiUiXhe/P/yjQQN59dzXcwtVUKdOd5jZZxxaG7GFjrypeqgoDVYD2zDVayWEEuqkDy
	 1AVmstsoJBK3gX0k8sK6W44Y+/PtitdiqgIiSGxhZAvFIlupETSqJtQvrKzTfwVVsK
	 2WS63SUt5BDGibznPbgnFomgsrzYeHZLDuS7/bUqCXKRTOwWU5GIuRhnHK3YfS89nP
	 H+vMX+iP96BUg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:43 +0200
Subject: [PATCH mptcp-net v4 05/23] mptcp: pm: do not ignore 'subflow' if
 'signal' flag is also set
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-5-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3907; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=i77z9tOTtHs5P1x2DEPDtVt0aXpXalQv5SfvpCPktr0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSWaSlbtn4B5z6prUN7sJ2CH6mZoWIJU/IYS
 uG3LKyk302JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 c1e0D/95JNZBoby9qYG8gSt8HQHshyFSIG9b4FfwY4HTPRNV07dFzn/FWZtlqzbdWEq08zanPIC
 sbIkjLfpCRC4X6uqndcofJac8tbbA3iiHaSgt7QcQFZqK1D5WVQ6sBjmy/ZUbX3C/7GvsctKnav
 pvecYgARTkKRurCJcwH+SodwYY9PaSb4C+GP5S6Nt54sxtZ7qQpGfrUwIUR1dOH8AhnoVDqtimP
 uIPwKd8SN2XONMGFoYeK5f+ZhvqxkTJGbjQgWcpkfWX3zI9pDq/yb3njuxB+Xo7q2wIORf9eu5X
 CykZxREKAIZoRFRR2FbVBgOIC5oLtMbyDuZ5yz2uQCXvp9sBG9slz1BfJka4lX5AepWiRu5GF8g
 0AywlMyJzZ66fhqFUoBhIbMxAYY52LWXO/NDZMAYkTamqgMHscTRSbwWZpY+6wVfYVkkA2W+p9q
 68tysdWAD3UqUAw1u05Fj2MDsuEJDf6slwc+s3FauspeQGA55lFOC5vPh/ou6czjbbN0z2XxgHA
 P4lg6ME04vlkC2ZFNsBEKU+xTJ36FNFbumnkOPGTuljnkeeOcyIrCS5A0dWp5PiciPUNTBDIIYo
 mJQtXFPWPtWkTSG9hNiBviQPkzb3cbUEe/jya9U03vEAVTxorDb2pNC14f8S3KebqcipKm52PHB
 XNG+cL0N6L4f6yg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

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
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2: re-use the same bitmap instead of duplicating it for each target
   (Paolo)
---
 net/mptcp/pm_netlink.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0ca6b358ab51..2e94f2a9f2a6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -513,8 +513,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *local;
 	unsigned int add_addr_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
@@ -580,6 +580,9 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &local->addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
+
+		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = local;
 	}
 
 subflow:
@@ -590,9 +593,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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
 

-- 
2.45.2

