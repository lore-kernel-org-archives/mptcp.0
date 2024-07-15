Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10C18629E
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038208; cv=none; b=k3Co5pr92Eer2oc5eDBsl5nJt0Mmaerc2XDPNrF7q4l7c/OBi9eF2K/d6b8ilXzFwcxs5KP1pc0hKjwnYYwncxmnYCco/gCOLxSMGnUioP60Qe8js5N0lmU0Jbw3zOh5Lx+eyp+RJVIk8yYE2tGAX6IxxWVPQWv8L94wEovjbWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038208; c=relaxed/simple;
	bh=i77z9tOTtHs5P1x2DEPDtVt0aXpXalQv5SfvpCPktr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lqwL5hM2/Nh9nuEThL5KasIGhuSOPMK/0+PZR7LzR2yCj5BAiwmu63C0tD+kDDc/tQi+CITuz5mXg75X6vunwsof6Lh3wfbHbkL2/3JNrcARAYwU4l5e4c99nmvvbpFtq/+865tvQqYdcMGhEGxHsiNQh12IdAcUsTUY8HvO9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbudBK4i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbudBK4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124AAC4AF0A;
	Mon, 15 Jul 2024 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038207;
	bh=i77z9tOTtHs5P1x2DEPDtVt0aXpXalQv5SfvpCPktr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BbudBK4idMDr5gQd8vNjh2EfFv4aMXxi0UCcQxJOYK4JUs5tNKV5BrBx1PUZVcYBT
	 HRDS+e7GdQr68WO/BME6InPefRCP7MTIX1gatnFGNOA3VYJwEsBLjx8kOG9DwAL9BO
	 kAEnD/lg74tlhGjRqImqNO8mLC1vXoAAXtaIF7DV7tuTL2YugJ31gnE2IW0MxOVy0F
	 lKoxykY6LijArswVGlvvbiJZF7h1sDw8j3GdRqcYuLqTkqIdWWh7JuEzZ5h6PASmNZ
	 p+D8rAvqIwXFb0xgKLAoZYCay9HYDWiiP5CtWGzTEJWic7NKfoliG/Ztt2bz02TzJY
	 Xv8gQdseI5+IA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:43 +0200
Subject: [PATCH mptcp-net v2 05/17] mptcp: pm: do not ignore 'subflow' if
 'signal' flag is also set
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-5-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3907; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=i77z9tOTtHs5P1x2DEPDtVt0aXpXalQv5SfvpCPktr0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV3zgr8+EEw4ePqcEYRNl2dascz5u2dmBIXX
 142NmbjN4OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 c9QrEADhdpUmzqhhNaGsv732aZljVLMDqbcsAcjvh4Vo9ZfO6W1//c7Opq4queasf1sj+u+GkaV
 tEJSMgSxf1h+vnJN1ba/cUwHmrexjmf4q3PB7ye+CU9OjUL6QmLhs19ZLuEFXa72AypAfqyHDa4
 WKJ2qjtoZq5v1LiyWwnzG8xthkNoq82yUMp37LIiPezcxi1TkektEVzPvWVcZEbCX1jcChdZNzY
 +9gcfYf4ybgc7wtM2K/0T1oEp/CnqXv92XFqVs2wZqotq4miqKPw+W5UXzNBTkJf2Jfds68Q3iB
 6Bteh7yJb4mLx1ri3MveCHV3tAZrWUFPPKUksPTeO0MCqmQJuL0VAvEctB8WulgM5YQcqmXug7b
 2JOyEOqH7Vo6NTKj3fIHr0mudQfqM295fVbmKo4+syH1ETkFScbnkA3V2eLCRZZ9AqOxFayDnv9
 RyHJ7p5bNS8cp8RNvpFXcD2v1YLnL2UX3WUkmV10aC+r4NiMpPa8j5S9QA4ZPCD1okMAI+vdbIK
 VtOoa66Pvam5nKQ2TO4+XGJ/7VEYvNTp04zDXvMvkKGj+81ZJ1LTp2nQCY+4YoMnB6oxF1WfNrM
 Dzv/gJlXacQ/VvFl1WaPc8K2wwcQGHvuQEgoiScmrSgvKgyV6qwlpJr3WbPDA6kHmdjfLaMPNby
 7VfCm/+8X1/WObg==
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

