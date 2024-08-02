Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A071AE029
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622682; cv=none; b=GtKRnD4iB9cgyFh8ALJVP6wLRgrI+L+WwqKNcZxlSSzQPRj1ZreBFaNBgYlYZD7e+R4dT/AGJLt8b9Hy0zPEVt2kjV4Ri/v8gCYIU7xksedgqqqF8dYepxi731t+sE1GhlByKJRnewyOROeLA4N04MvJdqzadjkpXZYtGtwvxTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622682; c=relaxed/simple;
	bh=scOGkgJGBTFh7fVjXdqeNLUnqIdqxrEK67EcsA7/1Wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DdCFicLTusM2eWImPH3Xe8usOFSh9kF7eK+VkMwiIC97Q7kKSUDY42RllKXQeJmpCPeJeRf0Mqr0/agMgBJfADhbfTB1awzRnIonj31GrY455D3635f+TTNpD7h3zL20ZL7HvoomRv6SskrP59RyL13BzRjo9tJdLqL+r7XxQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr5YRniC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr5YRniC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6282C4AF0A;
	Fri,  2 Aug 2024 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622682;
	bh=scOGkgJGBTFh7fVjXdqeNLUnqIdqxrEK67EcsA7/1Wk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zr5YRniCVRQYJhgoosBJB+XVamdUVCko19IslhMghigrofck6wczNxxI8ak+52B19
	 kbA7sVX2nZ4Eey6DawbzdUkiaNhl0EpHMhIrRDmLPORydJ6J52CBLh6FDTTZ0r+2EF
	 N27dg4Uzv03Qqoalx1l8mOJIf7sLnUNQ13j9uB9EmoeVJjfs6AXSoPV/X3y8rC+FYj
	 ULX+MgdOhHfy4oe7EACOvxMP/VdMrfT/RMDE1+Nd3rc1APISG3szQcvweDgYVCmbNx
	 /zZzFnBWvSbcWUkpywTXfrrzepSv2xKbc+pzhjIwio0jaDhqhjqo+Nhy5esgxUSGfn
	 q23EhTPSuWoig==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Aug 2024 20:17:48 +0200
Subject: [PATCH mptcp-net v6 11/11] mptcp: pm: send ACK on non stale
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-mptcp-pm-avail-v6-11-964ba9ce279f@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
In-Reply-To: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=scOGkgJGBTFh7fVjXdqeNLUnqIdqxrEK67EcsA7/1Wk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmrSLLZx+BSexKEZCOtYF7Ryp92EKWk/JeZAk8E
 G2F6a1llSSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZq0iywAKCRD2t4JPQmmg
 c3pvEAC7+kXYnxWKU86hHb1BRl1wtI0Ueh9+lewn0qG/BWRgQwNwj5JI55i1BCRUTysYe56oION
 TeER8CRXcOZyz+opsaAKeiCOCwxVR1cO4zYbyh4r/609DidrhJBZBcime4E0d60xfn17i/dGcOR
 aSN+DfrrJf32jBC3p9z/b401uZqwXbM7AzdadCbew5Qj7la5hI0QkvcFtL5l9wi+hwNWLBksUO7
 5Z8wlBXGy3xLZYHSnQae8gAsmhMShB+VdSfQXS1+hoQvDmkAo+gZs9+gpSvWrPY4l+qrl4cihjk
 aSW0mhOOSNyWxM+a6q/idVmQkP3nNgrCZUU0L//cJ1d3jf+F96YdRuytMJJDvAux/pYo2j6SKwW
 YRmjdlC6t7jW9wuk2S4zI04s/kB7WABtGJJVmf+GPo/OIHS1DUroHLianIXI2nhnXW5QuZavy2L
 uHkTqEP4MhvZxA1H92mbV7RLrvTrtD7DvA+iE3uk56iF6cN/mWU6NyKCgOYFq5HGvlVB9+UNfRY
 P3LhSsXFOv/F7e4TvGmeYhJn9pN8RdYa6yvlgI82mTtas0sWIBCK7Ka9lmA/P91ZJBsNzinJg+G
 3KgWKP22KqDGuK9kAPO4jROa/dRIWCoBAc+FkPrQxxlOWQfJZv5lDxtr3bTnd125tDZPmCe7yg4
 79ep0doGMe175cg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If the subflow is considered as "staled", it is better to avoid it to
send an ACK carrying an ADD_ADDR or RM_ADDR. Another subflow, if any,
will then be selected.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - It sounds safer to do this modification in -next. I also wonder if
    we should not add more check, e.g. not on backup flow except if
    there are no other non-backup ones, or still pick a staled one if
    there are no others, etc. But maybe we don't need to care for an
    ACK? And we can always improve that later!
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d3b1b459e6f3..cb8f7de7ed6c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -772,7 +772,7 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 		return;
 
 	mptcp_for_each_subflow(msk, subflow) {
-		if (__mptcp_subflow_active(subflow)) {
+		if (!subflow->stale && __mptcp_subflow_active(subflow)) {
 			mptcp_pm_send_ack(msk, subflow, false, false);
 			break;
 		}

-- 
2.45.2

