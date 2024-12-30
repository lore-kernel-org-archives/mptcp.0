Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1101A3031
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735565069; cv=none; b=Twu8rbpw6QVXAX/+kaKipD2rV09SnyXdvORirQsaAW6FLlinySg2P5Q/onixL9C+Z9c+KAbzPF+5KsGcAkjyDrmZFcLJ9SkxW3Itx5kK5fr53HB7tVcpr5mDhD3tpi25mC1H5In/PvtSLg7o5LAbmMpx+JHHGg612O0ooWW4rZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735565069; c=relaxed/simple;
	bh=+yEsBe/bkX0Z2vEd3NoAFa3ayX8jZXlA8naKMkwogqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMK/XLEPahnNVZ6RspzucTuymtF+fnXfId/W7qHkxi34HIDWoyyM4mBo3RLkZqlRYpCU5nNgjNr3w0RPZO+pKEPJIjifcuCIt9djrAHdvXvmgBK3G0GvFTOnuSqfCdIt7YaLak8n4FDLsbSHicvftsuX0Ii0hLLDX6DrFcLEVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5Ex7r3H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5Ex7r3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A94EC4AF0C;
	Mon, 30 Dec 2024 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735565069;
	bh=+yEsBe/bkX0Z2vEd3NoAFa3ayX8jZXlA8naKMkwogqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i5Ex7r3HtfkBXLF6ePUicSAltdiOnSluVvxiveNiMXN1t8xrgBqvrhv4sfNLbvqbV
	 MgetcZ/Xr16rD6AodBnOP7f9dvvyWve0kPrkK5cyLWVhODm7uLUXoajLbl5D4fl5U2
	 MY0MXptD2Qe57Hp45TszBqJkthbT/E0RbWeg1ToPUoORS9JyZP6WufxjNZPBagl5FZ
	 6jmsK4985La1pLknQZQVJVbvOj0SJlkLPcyljGgqpSvp/dg7ZOtKwoBF0O9DDyk39/
	 mxKfl8zQ36Cfs/CkOuJLBlTbqNPlpOMZd4sOc6151+niHz4LaB92Q4z+rmkEw7NG32
	 fHSaRYRg8bhvw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 30 Dec 2024 14:24:11 +0100
Subject: [PATCH mptcp-next v6 4/7] mptcp: pm: userspace: flags: clearer msg
 if no remote addr
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-genl_req_attr_check-v6-4-3ec9103559e7@kernel.org>
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
In-Reply-To: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+yEsBe/bkX0Z2vEd3NoAFa3ayX8jZXlA8naKMkwogqA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBncp8KAqzlOzQiMxw27bPlYFhLZclZZ0PEnAIH0
 s42tPx9jwSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ3KfCgAKCRD2t4JPQmmg
 cyCgEACph6SVbIfBke3xxyZqewjIMU2lCBW8WbJFr+uPzRtCJwWpvyEbgN0GGUsxKXFxl/OpECp
 tW2F1Skk3bSmT1nWIgwWuBACM+rzc7kSpAQHyOmzRw5ZZVDvfyVJNRY2F9KXh1CZUCueRutUKDk
 KuLTOKH97Mys/gjKAJP61xzVBGRrKG0Ss8qPjDAJA2Emu7o5RtElH1eql5FuVa5Qxzb21FvoN/B
 2owKsRqJmRw6WDxs9WEe0LuCSuT+FCfZc3t6Obp+JxFNYnH+xpgQP3F5GPkMP5682NYJl0NO1gK
 3C/+ScTD1UOlS/pZ9dn9bIIDeU6QSkyPY/ZKBArt2PyZpz+7+SOGXYN8k3DIiafBo4mR90a+5ce
 2t2N4JrCulmoAHiPH7T9AUidS2cgzNyErbJSY3bybkYm3WcJTZM6BiXXAabbvCHQeznSTpf3y4r
 zdO6QeFma104g2JXbS2uc1FcTPOhP/dTG7Ps5yXbXmbUQEAGDCJAZ+BgjFKAvNmZwWsDuZYuF0z
 TMhBRfpO19Qtk3w5UonhI0mzVmLWaFlvewhfZ/MIxC7L1hh3wZZ+C3kiorSZeKbp5kqkdAQdGnQ
 SFnqgpT0J1U8n5mZu+endkPAflEAuR6wml3fLi4lUX+QPPFTQZVfFgVJrEy7KNtzuIs6v/lsyZc
 UOLInmBE5SrSUPw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since its introduction in commit 892f396c8e68 ("mptcp: netlink: issue
MP_PRIO signals from userspace PMs"), it was mandatory to specify the
remote address, because of the 'if (rem->addr.family == AF_UNSPEC)'
check done later one.

In theory, this attribute can be optional, but it sounds better to be
precise to avoid sending the MP_PRIO on the wrong subflow, e.g. if there
are multiple subflows attached to the same local ID. This can be relaxed
later on if there is a need to act on multiple subflows with one
command.

For the moment, the check to see if attr_rem is NULL can be removed,
because mptcp_pm_parse_entry() will do this check as well, no need to do
that differently here.

While at it, move the parsing after the check linked to the local
attribute.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a8f73b082460ba00f7fa998cf7646368f8201e2e..2f82ac49db35ec34dcc0b9208f4ac12edc6ab254 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -601,12 +601,6 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
-		if (ret < 0)
-			goto set_flags_err;
-	}
-
 	if (loc.addr.family == AF_UNSPEC) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr,
 				    "invalid local address family");
@@ -614,6 +608,10 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		goto set_flags_err;
 	}
 
+	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+	if (ret < 0)
+		goto set_flags_err;
+
 	if (rem.addr.family == AF_UNSPEC) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
 				    "invalid remote address family");

-- 
2.47.1

