Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBBA388378
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302465; cv=none; b=TLPLzjkCo1fRREnFWK/qWMXlPDLoWtNi0emcyhO80Zd1YfQIIonub8xa+RMP9D4vbJzP6gOBUMG2/ngwUwHxhCu33zLS98rhZ+JEtHe+2kDMW7uDWNQhrM7ytxmw460J1W/QNi5+Bfu0PEOPWpAVbs7Uoj10/a9RYtrdEkwNbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302465; c=relaxed/simple;
	bh=qh7qj3RAs0JwBQ4nLmQxGyzSwP4FNFD5VJoKwvOFlkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DF8vlrWqvYWuNDqphf+l3oa0Bs8nPFFUQ3rW2u7FFrbc0xigpV0AobEeBrF6p5n04ifgAiWKuNdEJxy7L1xy6H+0F0LrfXQ8XkDALlghmrhxUan3OLijAypxartFVYhVw6X6+Lapw0an03lDGRPrvSza1k2bIFm8zQwBNl1Fbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj7WF7/L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj7WF7/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509A81F00899;
	Mon,  1 Jun 2026 08:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780302464;
	bh=U26wbtZRhO6FRZYic6xCfl4ZIiTcaekd9VPCV7+Ruag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Sj7WF7/LrKponiPQvP/+aBLgs7hCenr8pluhXKzXaQlankZFNAN5Z8Vq3426YcaN7
	 m/GAGDVTH0PeX/L9ttDtSIeFlA/u4kiMuD6Z+y6e2rRs+kUyylM7FskT4gAhYCe8sT
	 JUMVXwVVWD2IHirQL86/v2m4lPVe5g6bMfF1gQmQ3rBvscf883oEtOqWOsX+TohKbu
	 59aQBjNSProyzOTzdf9DfWNZRB2BNMP/oLm+E4V8MKkeEbZfAYzn0rtJE4KkcISkuB
	 3/R9rndlgawO+v6w6tD8XkctJoAa5XghUlUjaRQQu3VpUFTtFfdB5bRpcJ91rp14Or
	 E5nYutgvkQJzA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 18:27:28 +1000
Subject: [PATCH mptcp-next 1/4] Squash to: "mptcp: introduce
 add_addr_v6_port_drop_ts sysctl knob"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-1-d7c842e80446@kernel.org>
References: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
In-Reply-To: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=830; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qh7qj3RAs0JwBQ4nLmQxGyzSwP4FNFD5VJoKwvOFlkA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHUJ9hRqFeQaWHw9uBKEKSF4ez20ee9T2CkYPx
 JPIJl4xvxmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah1CfQAKCRD2t4JPQmmg
 c+VfEADEk3Riy/63N23rI9W8ujnVAmWC8DOqnTve1nbO3vt8Pd7U4AUrf01zsWjwznNLRRf35Tt
 GEOIvJPY/IKlXVuzsDAW3ecVyeWaYJGjzdewnB/6zYsZsgJTJfWqXx2MG7KS4RvzA8jrUMAhEft
 zWviDzOfOSgh8sFAGfkzWOtIYD2DGSoanrpDjAEgjrbXNjN3j/XiZ9dAEHRBmmgtqWe97NEyaOi
 QmR+HTihk/kTmY9JTmjUgcgv6aatZhm62WVnNTPKfGAviQa91OacxFCbCHXSCAJiKX0YcNgTMnV
 602bdcIx9CztKl18AqVGetgvfISUjkkrOBy7TY0SfsZrV4DzhhWgPKSF35iZXB5TK6hY3n10eAY
 jlAdrw6/18TG2hF0xTcq8aX0MQv+YuC+RtSxtezImggjKHCp2iGp6/faxTCNRdcD5EbnBhi5Oc/
 rU8kWZ0C3vsI/MUaTB2s9pT5EF16WXlfE2MuQf6pstyYJtdiVyApcVQM+5jjpnqc6S606NvAQAv
 YPMXr3nRCfWxl1X+L64zkZ0x3fLtADIn+AkMpzmeudvSjUwcYD4/jFsjbtA8l+AOAr/CPkwWunI
 5WYdOgZ9O0hB8cCFYww1BKQEauMR1GV3n37TJWWTrZ6JaMIztSzoie30xxJCPHOqt7b+cff2Vjb
 yd5JJugNs5Bnlow==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Use READ_ONCE() over sysctls. This will avoid future patches from KCSAN
bots.

Link: https://lore.kernel.org/CANn89iL=os-60kDKqMDdyiXuPF5CG=eejS0vmthwpDGXz_Bp8A@mail.gmail.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index c94a192f4118..63c5747f0f63 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -97,7 +97,7 @@ const char *mptcp_get_scheduler(const struct net *net)
 
 unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net)
 {
-	return mptcp_get_pernet(net)->add_addr_v6_port_drop_ts;
+	return READ_ONCE(mptcp_get_pernet(net)->add_addr_v6_port_drop_ts);
 }
 
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)

-- 
2.53.0

