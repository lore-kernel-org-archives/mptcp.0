Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A851D3181
	for <mptcp@lists.linux.dev>; Fri, 25 Oct 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848772; cv=none; b=sVpkBk9HocZCOyAZf1urt+PfQI9KxQyCmX0K1c/9I0q5uI7cNXAk3jzDyOtLx0UfZg5VilPfY8UaibiFNJMfQOd3Jqs7NR1DJ6IlSpwj4uwR5DpiNVj7+w2qJm6A4w9Zqw1nK+hqAME6w12qexhLJ10DJL1N/OtlE2iCAnHKXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848772; c=relaxed/simple;
	bh=6CH6R/0MYwydTa8UUGZfyxnfCVdt8K9KwpjZfmcxRS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMLuYJkOETk3eH52wEG0p8jwhxQUKh75Ccm6QdpG6qHfuJ3aPs6p5fRelnXnzraZibbOKPAcfWkUGdCOQIN/ZEKMe849ffwW8AHxTlV4gi7mmp1V5oD3D5JIM3cLyPCz2BFPEXGPDPAxK/VoV5IjsGNUIsy8/UCc4645trkzXL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o87DOaP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o87DOaP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DB0C4CEE4;
	Fri, 25 Oct 2024 09:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729848772;
	bh=6CH6R/0MYwydTa8UUGZfyxnfCVdt8K9KwpjZfmcxRS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o87DOaP9BApOxATeJ8X8dUDJPu58fHRaT68U7WntDfCrbZfB07EqFF6oRzwzqPUiM
	 sX2UTAXSjqWoLKwbU5kGHjNTQW22fTNWDvKAVUxNnsak+t4+B0O1LMgKCXvgGwQKXk
	 OiTVEfEtxqLJiraQYS1aXSZWCfNN99ceP/HWELok92Qx22xArBmAw3bWT+ztn10hVV
	 td4/RWX57Ig9mSt6CsJW6uY1WUc2GoCGF7pWme9/+gWCbiLSt1wsu/B8UyMIx/V6YS
	 /kUQu2Zz2uX2G7rSbByfOjUcpyBhZT8388uNQjrGi+78h+LIeGuCW+mxIWHwR0j2z+
	 EEWNLOJcLJPKQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 25 Oct 2024 11:32:29 +0200
Subject: [PATCH mptcp-net v2 1/3] mptcp: pm: use _rcu variant under
 rcu_read_lock
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-mptcp-pm-lookup_addr_rcu-v2-1-1478f6c4b205@kernel.org>
References: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
In-Reply-To: <20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2353; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6CH6R/0MYwydTa8UUGZfyxnfCVdt8K9KwpjZfmcxRS4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnG2XC0PeqSOubGGNdT6oEIEJKLei13OdrY2Nvy
 1cSdRq/F8aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxtlwgAKCRD2t4JPQmmg
 cwW3D/0bM4iC9/RPgBSEUkVJyrrtkW9mvWPbAXNxxQnroD6NUVbwCgPxe6+Wq/zMZRIDtTyhVJY
 64xEtQAqL/YZ9VNfKw76qBzh1lMTEqXpuOSzT/1u1MuTF3q0ZVLHzvUaQ7m6nyjyaIYIuN+iTTD
 +pvSjdJ0/uCpEweXp748op/uf3nYmfcoQbXsPfy85BNiwDjc6n1jCoM/2S+vATSB76msuQQCdcg
 gd8cbaJY/l1ysl77o0Y0hSvfENyIt62Lg5XbDbbVou80Q9K5RHaADjS8SYHsk7Mn4scGbEToaM5
 RQd1MmDWNB1QYrH41CwAocoqeagYqPoOeHo/5Lac/gVyB1TogvDZtb234u/SpK60pYOHZ4ulI6m
 XFneAxnTAx+TA4HSQvPk0CTgHNzR0GHlWVywHwwsKE23Z6XoLW1sKvCdSfIhjrfiPI5ILk9yROk
 r4TBR34dOGo+45o9Y2MHIRbrhXRjugkFXPuoP9RDZ4K1sgJFbXWImuYhdsk93OPXcSfElsispmy
 6WkyDYDilFdyBuMwOBTYtMrDmNUS6dCI/OIj6PEJreoCArApmXjzswLi92PeoaS30YniYIqDIqf
 lafvfHNMqOeGbg2p+fUFMZ7CBMCzpRHDjr3ZInpQwZ6+Q2ijoJkgnW5XAyarcCpjy/pvFTU6fxq
 dEgphODVzWJD/ng==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In mptcp_pm_create_subflow_or_signal_addr(), rcu_read_(un)lock() are
used as expected to iterate over the list of local addresses, but
list_for_each_entry() was used instead of list_for_each_entry_rcu() in
__lookup_addr() (and lookup_id_by_addr() before). It is important to use
this variant which adds the required READ_ONCE() (and diagnostic checks
if enabled).

Because __lookup_addr() is also used in mptcp_pm_nl_set_flags() where it
is called under the pernet->lock, the _rcu variant cannot be used in all
cases. A new helper is then created.

Note that this new helper can be reused later to reduce some duplicated
code elsewhere in this file, and some sections could be used lockless,
also using this new helper then. But all of these extra modifications
should probably be better considered as new improvements, and not as
fixes.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 618289aac0ab7f558d55d8b2ebb00dc62fc72f88..a93b9b7776b48781a883673fe5fd521a978487ff 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -531,6 +531,19 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 	return NULL;
 }
 
+static struct mptcp_pm_addr_entry *
+__lookup_addr_rcu(struct pm_nl_pernet *pernet,
+		  const struct mptcp_addr_info *info)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
+			return entry;
+	}
+	return NULL;
+}
+
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
@@ -556,7 +569,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr);
+		entry = __lookup_addr_rcu(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;

-- 
2.45.2

