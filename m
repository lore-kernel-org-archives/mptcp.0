Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F212C21FF
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428431; cv=none; b=u2PJJyb2N4BuYQOdsvQfaqruK/OboG8XOy+7IOASwJngBBDrFRT1dNpEEsDZiqKxX09SDU/O6I2wiHJbqTw+AtDqqoBWUMYPWrtF9JAO7DMyKcUOd55THUSH75X5k29g8SExsmgd5JJCyf/Lw56fJ3qnCNsF2kgz9tAEhGnjnVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428431; c=relaxed/simple;
	bh=n3NvB1/oCYwRv4fdx1OBSDzeShF5o+D/t1XDTGmBupE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZ0pmGL6oMkfV2B1HHmM50afRvA1UZ80pIjU3tLRvuY4IpnF44Vr0eOIvW/a2KOeAZPNT0Ro2Pc6sbLb5g9he4FrbFBE8KYy3uCcx5FotUVGyMezn3P9a+JJCoqh8m9nnBBFQjBfm683ZpZYBFaCmO0oMQMtqC1YzixAOx+yH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbcE35Gk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbcE35Gk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3DAC4CEFA;
	Tue,  9 Sep 2025 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757428431;
	bh=n3NvB1/oCYwRv4fdx1OBSDzeShF5o+D/t1XDTGmBupE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KbcE35Gk49nWHSpAD8Jvo4IxJlJH5Qgup6hGykK0LmXmDVGLK1S3C1wmivivJAOfr
	 ve6O8r3+H6yXXuNBxyTpKmEVrn1w3Vtqh5UMhoO5yIVlK4yisX2WWmN6C8Rkw/BVfJ
	 Pk7z9quLXoWRhBbbOctMzpV82lHYfQJaimAH/P/PaSYlXB7MfxEFCmWyYaCaBeAaFZ
	 9itJaFhaOn5nCB3tLuaruBNOWJGKAcmhRMC3TBvYWPjGjpa+Wra9foOZYWn9gHp5HI
	 4cXBgXpqbBZupob2B46YvrqV84iBCdd2PbdaS173DhltR0ZXP3EIZFbRi1PZuNXIeL
	 umaFKfAKLmcGg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 16:33:30 +0200
Subject: [PATCH mptcp-net v2 1/5] mptcp: pm: netlink: fix if-idx type
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mptcp-pm-user-c-flag-v2-1-a6f9542481c5@kernel.org>
References: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
In-Reply-To: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=n3NvB1/oCYwRv4fdx1OBSDzeShF5o+D/t1XDTGmBupE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOWB3PPDj1Dm+QzPLtHX3nZsiIL77Hafy8hPGmvXN/S
 tONzu8+HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABP5MYeR4R/P2b8HI3la7hsI
 cfr6rnCNi6xsX3x13uSeI02RPtpzDzH80xZhepfo92XXmQWNK76c2+drfHTHlQSZvhuhjj9uG6Y
 d4gMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As pointed out by Donald, when parsing an entry, the wrong type was set
for the temp value: this value is signed.

There are no real issues here, because the intermediate variable was
only wrong for the sign, not for the size, and the final variable had
the right sign. But this feels wrong, and is confusing.

Fixes: ef0da3b8a2f1 ("mptcp: move address attribute into mptcp_addr_info")
Reported-by: Donald Hunter <donald.hunter@gmail.com>
Closes: https://lore.kernel.org/m2plc0ui9z.fsf@gmail.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 50aaf259959aeaf36e7ab954c6f7957eaf2bc390..2225b1c5b96666cd4121854c967a7f3a79824047 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -113,7 +113,7 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 		return err;
 
 	if (tb[MPTCP_PM_ADDR_ATTR_IF_IDX]) {
-		u32 val = nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
+		s32 val = nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
 
 		entry->ifindex = val;
 	}

-- 
2.51.0

