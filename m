Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55264E235C
	for <mptcp@lists.linux.dev>; Tue,  8 Sep 2026 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887241; cv=none; b=ronNl1DVQzB4n/xiDyHXDFFi+P7TdNH/n7kYYRZx8qVPVfRsfhwne+j0pno78NOPy9BBJu+pnV81a5yj8BoS+06rwKJnY1Td6MzJNrm7g+5UPTnbtCf18xard9DBCh5Tk93oRae0CF5VtM078rLo4Qj9qYuj52DLJ0ipkTkM+No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887241; c=relaxed/simple;
	bh=9OYFEQliPzJH1CiStKc2WD+RJRn908EyrxC9twngvW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjGx+Q9uAytku+PKEshKO8z/sGgh1EBTp0/P572zdQqTlTHL6ixZGTFByjQkvPwx3aWsynUqBRPipQ8xBunJsGM1wD+0FTWyvfurRUHGDA+PxqOa0UM0IICpg2KaeHK6TWzzeEQFz6i9n9Wm4J1sxSdrseUhegljUk+/PjXX3OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYoh9KKs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYoh9KKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369981F00A3F;
	Tue,  8 Sep 2026 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788887239;
	bh=rB4kxC4vwZfc5AhUe558Feqt8lqoczPbjPOPn7U4KrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JYoh9KKsQCavProw5QjMBYa+/rotnM1Fy90J8sJSm4pUz3kzP99vc2hPTv602GlnW
	 ZGY3PLVPK7jckhMtip55iV3kvZ9/kX0gNZ3sOnayqz2FLzzTz2CtfFtdt+xt6bNtzd
	 xwvghn2WysXPd6RgE6KbP1w1j8fSAS2S2gb0S8woQ8/XMNb+Pf0AJwXg5kiwV7EykY
	 FVu1HLxN5UtryuyzpJiw3HnJJcbJUNeCgdGFNF4AtfIAo8hBUeettfCIfH5lgYQsE+
	 Ug47eBr1lQvzQzNNi7DbiHKwsNH21n8AWHns6zaYQ01lCuznd3bB5vYUE4wbuUSE9H
	 jV54jKnVmnj/w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 19:07:12 +0200
Subject: [PATCH mptcp-net 2/2] mptcp: options: dss: avoid printing uninit
 csum
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-mptcp-opt-read-debug-v1-2-b3e74549b6f6@kernel.org>
References: <20260908-mptcp-opt-read-debug-v1-0-b3e74549b6f6@kernel.org>
In-Reply-To: <20260908-mptcp-opt-read-debug-v1-0-b3e74549b6f6@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9OYFEQliPzJH1CiStKc2WD+RJRn908EyrxC9twngvW4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWOBw99StOsc5O4zKv3UWL6tC7S6KexsUuMb3e5FbZf
 njByqmsHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABN5dIGR4WmlaK6Sy+Y1G5M+
 bUoK14zetvZADctVN4MLkfP/cD+d+5aR4UhL28SJ24+lJ6euv71Bqm5psf6PnS/Lrrr5n7EX/PR
 bjhkA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When parsing the DSS suboption, this pr_debug() might read and print
uninit checksum value.

That's mostly harmless, but that's also confusing. Fixing that also
avoids some tools to complain about accessing unint data.

So read this csum field only if it has been set.

Fixes: 390b95a5fb84 ("mptcp: receive checksum for DSS")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7f7ed4753100..20490410fa22 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -259,7 +259,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%d:%u\n",
 				 mp_opt->data_seq, mp_opt->subflow_seq,
 				 mp_opt->data_len, !!(mp_opt->suboptions & OPTION_MPTCP_CSUMREQD),
-				 mp_opt->csum);
+				 (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD) ? mp_opt->csum : 0);
 		}
 
 		break;

-- 
2.55.0

