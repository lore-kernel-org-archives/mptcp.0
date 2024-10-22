Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9C1CC174
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630187; cv=none; b=E+3cqCcghvMxEge4dZhKg1jpfs0QvF5v/Fgig/KJCvl9hAq+Ae5gtbs0jZ+THfZbjAuD3YRa+qamEJkx/ORwd6ja5GOZx1SfFsRdpMtQrqEqXc8RMse/aJnxlosj1ie/ip3yQzxVPDHc6fEH/XpSmEMj9FsklRCgO92qUfpIsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630187; c=relaxed/simple;
	bh=s0Lj2J8fpOE2ALtf7wwLU6JGv5ZQ/Gcjdhq6ewfbtJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ATaJA109hMS304rOO3K253AySI0zOC6nbYJ6JMf2nnfmrRahJsdCWKpPYdfQNT47eREpUHcvlH1iRvJj7ANla6e88+n0skwE+RbVhD9zqfIZJ7u1YbQbSohLwr0IuM+hz0+7kCCu4EUwAkvPukWqMcdIYMA8s3XoQx5qw2JjKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u21PAhys; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u21PAhys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2AEC4CEC3;
	Tue, 22 Oct 2024 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729630186;
	bh=s0Lj2J8fpOE2ALtf7wwLU6JGv5ZQ/Gcjdhq6ewfbtJ0=;
	h=From:Date:Subject:To:Cc:From;
	b=u21PAhysKMmWFRrtcL3Pyva0PWJhAo75va1O4+yDQS9nVp37PT4wB18C5Cl0weUxz
	 kglfybz9kCWWyWsBUvOuwXQTZiyYTuOVEUm4hwyIpGz39WbHYytupQ6P8pntm4mJUc
	 C/U1nlZqZBRUqxJsZJMXl28LF+0F7NmFRL7Z7wjf++MgUN6e/jK3Aqcp6ie05ExK63
	 LktDr3B6gD/I4pB54nxcFyJ/gF7WreWhtvI0frqHbD2X1+1S+8v+BmO9b/x6qnZKuI
	 xiVcSxMkdmeHMsYC+bmXwDlMkzCr0RNzPvR3j6Mi19UBPPNF+sJ9/vz+WOMYQ0e6by
	 ii1zdop+js3tA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 22 Oct 2024 22:49:42 +0200
Subject: [PATCH mptcp-net] mptcp: pm: use _rcu variant under rcu_read_lock
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-mptcp-pm-lookup_addr_rcu-v1-1-19d45f26c872@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOUPGGcC/yXMQQrCMBBA0auUWTuQpAbUq4iUkEx10CbDpC1C6
 d0NdvkX729QSZkq3LoNlFauXHILe+ogvkJ+EnJqDc64szXO4SRzFJQJP6W8FxlCSjpoXNDYS99
 TuHrrPTQuSiN//+s7HCrTDI99/wGaHAEudQAAAA==
X-Change-ID: 20241022-mptcp-pm-lookup_addr_rcu-01833ea95155
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=s0Lj2J8fpOE2ALtf7wwLU6JGv5ZQ/Gcjdhq6ewfbtJ0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnGA/peSJmIDjoUmxmZjo4+NvgHaYl5ycCZxyr8
 VWKI1ZyUe6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxgP6QAKCRD2t4JPQmmg
 czteD/0b+wmbG3QRLLVzcMpSBYJ8E5WwWBRvQTPqcQ+BntUM/3jbNK2SH8uyxTXU42g4nP75l5E
 XNOWNHiG8qbl5ai9k+30JiAslEoYONsSVmiIwqCOILyZslltMZ3YEo8YTkFAoMjzWNLYjU2YeFn
 +tFUAUCOUhUxKG/NhN58df9AaU8c7nCyBV3JJyLwE+sG7xWVBOo7LPzZjpAYpGtAxToUZtmY9kI
 1RfjqMZO2qNPHaklX7hVrUoMQ7Zz5glWrcaZavc1rD3dBCPNOsfZfLas6XRLz3jwOE24+lVY7ba
 TYcO+E1PNtleC5IH7OJINYY3T+xPpTj5DodfvpTJ2HQdrsfABSEDM6p7ebsVPvM3nJVQmQ8fgbh
 ltJIdkbS9cxIUzqgIYFTdxxAjL2yHx1MyyApM7RiGOd42IbGf/tD5r65zuR34t22Ca2fMgpKFmd
 5cx6ZXLI35gYPtgkbhXwRTiujhG3r3wbmtQp1BEbtl+JW4gcF56GDsaC7xbEf2AUIV0zvin7337
 3JGXht0nXohXIDmRRziU+bgdiudli6DQn5I9nBnL/IApkKuHNkw2xuF8NTo3yOGNWNLszzB8e8m
 nJRcUNDqbegjwrfOIgL9tfYM9JW4QSJtJR5fKjpklyeZXRmT1Aw39HJtdCBw8F3XpuYIOeBvIRI
 pHf6zHpejCPjeog==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In mptcp_pm_create_subflow_or_signal_addr(), rcu_read_(un)lock() are
used as expected to iterate over the list of local addresses, but
list_for_each_entry() was used instead of list_for_each_entry_rcu() in
__lookup_addr() (and lookup_id_by_addr() before). It is important to use
this variant which adds the required READ_ONCE() (and diagnostic checks
if enabled).

Because __lookup_addr() is also used in mptcp_pm_nl_set_flags() where it
is called under the pernet->lock because the returned entry might be
modified, the _rcu variant cannot be used in all cases. It is then
required to create a new helper. Note that this new helper can be reused
later to reduce some duplicated code elsewhere in this file.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 618289aac0ab7f558d55d8b2ebb00dc62fc72f88..fe84a11cfbab1afa34ee3586ecc29658931e9a4c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -531,6 +531,18 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 	return NULL;
 }
 
+static struct mptcp_pm_addr_entry *
+__lookup_addr_rcu(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
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
@@ -556,7 +568,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr);
+		entry = __lookup_addr_rcu(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;

---
base-commit: 66bee427d4db76bd1afbf0184a2fd1f238a4ee27
change-id: 20241022-mptcp-pm-lookup_addr_rcu-01833ea95155

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

