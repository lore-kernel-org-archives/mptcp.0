Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9C15EFC5
	for <mptcp@lists.linux.dev>; Wed,  5 Jun 2024 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619910; cv=none; b=JaNI+TIctLXyMVX2bR0dFNrfKollpN5iXBw0b6V4Guz/Q7Ee6JO6luAWHxWqu2YmfOMVJdOcnvf98XyCQje+Nd3yRFLJKMARYJocNa5R17OuPQ5wJQmGuHGrdy42EnFV7vij8jEJS9oJ5cjL7Ix/avE5S6dmTcHCDx68k91Iq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619910; c=relaxed/simple;
	bh=BWMq+oDy/UN7idzfUsedbp6K0Qowp7KBxhOLnbaAnwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V5ib7iGhJTknnLMeB8pblq+Eaax0G+U/PT6OrIdTcDkmTGgi95IOh6dgHcbvopUpYZC1z2kKwqKCbf7KbjkqJYS676GzccBnU7d0UYUUVKElwDzOzVopX4z+kmVv27wHOol00njRa0CuoI8WR7LSG8xtO2JWDaBLBn/AFgCfa/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roLpn+WV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roLpn+WV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02732C2BD11;
	Wed,  5 Jun 2024 20:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717619909;
	bh=BWMq+oDy/UN7idzfUsedbp6K0Qowp7KBxhOLnbaAnwM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=roLpn+WV6xK2b+Dte0rp0qDiOkprjuHPBxLwmiVrcgRThBMDE2La/NfECCAxViu7k
	 SEa/1nn4/O2KJkoOswobkpJfG80tu+nzRdb3owicmWnPEXmmnfpO7z2pmox5UugrJ0
	 IFquHpWu307QWdreIdrDM/DGNmd2ctf+kOMpchbrDu+Yj8HT4IEnIOCVU9F5ks8ZuR
	 kGBvhXcvwg0nW1px4qPGSMcS/CG9wkbKEGk0/u5pvzv7gW8BVAmjxoY7NvKM+kRBSk
	 Hg/1sJT9fu+Oh7Rmvxkj4+uTup6MNE7DIV4BgF+fGDvBwfg4H6waGi6imgjbcYsfmt
	 qJrSiiJ7H0aXg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Jun 2024 22:38:15 +0200
Subject: [PATCH mptcp-iproute 4/4] mptcp: warn if 'signal' or 'subflow'
 flag is not set
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-mptcp-user-feedback-v1-4-d2dc3b399643@kernel.org>
References: <20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org>
In-Reply-To: <20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BWMq+oDy/UN7idzfUsedbp6K0Qowp7KBxhOLnbaAnwM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYMy9P7NzymWCBfPRTg0VONhLfONEb+KTrP+gy
 x/E93mxOvWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmDMvQAKCRD2t4JPQmmg
 c2a6D/9NRXa87kIIp3eDGgtwgMa0CNl+MnuBbp+ZIANGyJ9AFoapoh5fWFPmw49HklZRQy6Lx1H
 BxbervX5WQUXVgqVD+URG/HkiI8J7WrfO+qde1saEhRtUuvdRQNSumjW5Qn6GlOLfpuZLPIMH7/
 Bo1eWG2QBoehAPSDp/uw1Pha0cByreqHy9BYiE1wU9NbLpMq1r1kVbbq1z+GXQ4jGTohYnGHQAG
 X5BcStJm3oisa6nx1QYuH23+l1k9ClHDod2nDtiYF0N5w4rJjnLtQ41ckSP5wDmNdDCccJVFOvN
 fpzzPKs6ujaQdgmnD+1nQKIAqVyc1EHI+rJ/YxregBqFrNDKsVoq3Is1PS6JOWiih9QDBxIeUpN
 0zsG1+6WFUGZfRcLjhAdPMBUw7hUJM1gTVIssrdFKRvvsz9Z3QdaGEXH0NiMY0pUhdhRRp+KkKh
 ZWRqQ1z/duxTXFZ/WdLrczzyWmi4dhgVqQ/Jp6tV2ES9TVNdd01riEAHq4Cy9R1d5hdWmrQjGq5
 WxmS76HcA+FpGWZr0ZTkhHMf41Dchagr58TBuON5zkJgGEexcgSacjPd11pJ4tVYyuNdiKUh2rF
 GcVdNIUtQUrdplr5ZOe2wksI1zBNO4tIfGp+p+fgUPqE/oM+RU05AuNjZe5zd9oYp5geVPFruDV
 ieijv5lwH3Gi/wA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to the previous commit, not setting either the 'signal' or
'subflow' flag is usually a mistake from the user. This would bring
unexpected behaviours as mentioned in some bug reports on the MPTCP
project.

It is then important to guide the users by printing a warning on stderr.
Users can ignore this message if they have an atypical environment where
it is required to reserve an ID for some obscure reasons.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 0f09cf75..d40a50d5 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -188,6 +188,15 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
 		    "         for the client side. It is not typical to both initiate, and accept\n"
 		    "         new connections with the same peer. Continuing as requested.\n");
 
+	if (adding && !(flags & (MPTCP_PM_ADDR_FLAG_SIGNAL |
+	                         MPTCP_PM_ADDR_FLAG_SUBFLOW)))
+		fprintf(stderr,
+		    "Warning: Not setting either the 'signal' or 'subflow' flag is usually a mistake:\n"
+		    "         'signal' is used to announce additional addresses, typically for the\n"
+		    "         server side, while 'subflow' is used to create new paths, typically\n"
+		    "         for the client side. Not setting either of these flags will reserve\n"
+		    "         the endpoint ID, but that's it. Continuing as requested.\n");
+
 	if (setting && id_set && port)
 		invarg("port can't be used with id", "port");
 

-- 
2.43.0

