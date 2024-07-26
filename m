Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F61F951
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984513; cv=none; b=CC9F50ajh+fikSHPZKblOchdA0Jq4XyI2D9UU0KIeFBpJTKqsz9ja8khcKo4lbWGHvw2ynXSjqGGQf1xxtQVd4eH32mQ0hJPF+LSoZTAJqh1LEycoKg013cX5xfCPq0vC2/ZGmndbDCpLnjXfX7IM0aNKhXZ1X2Td1E14uAP0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984513; c=relaxed/simple;
	bh=g+6jj3ecIUY7f4kZO95pei5W83/MT0hJxTpUSoOGufI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qO2k3UnWrMti1T5OgPltTcJASghxDOkt2vevVTAv8t1FBhnXmc+GbWJE4ZMYrvcRpu2b2Mi/1fD8I0yg3Bsd+bRXnJ7FCYdJ8+hrX8yxqlMUKYBALAcVAAjcXyzyrcJ+/Etu8i1GoxWKEoPSUeH3M+hz76DVUN2O4y/QhaJtZQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw6vZYwl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw6vZYwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08B2C4AF0B;
	Fri, 26 Jul 2024 09:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721984512;
	bh=g+6jj3ecIUY7f4kZO95pei5W83/MT0hJxTpUSoOGufI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kw6vZYwl6UiKyfz6RwNNN3tlyKQMz0DUoho5GU8i1xpffLm3tnjEtDVXNJAjToAVo
	 Q+yOcTBZ/1OO3ZMSg2+g6FGnUs9aqvTeOdB2w212Cs+BlzHsykNTSmNEUcNW/QNtXL
	 txnN62Y0axIeXEX2B2HfROMYkdsmYal6ygEK34tlGY1REn48kofnp+tVy745mC8R3B
	 xtdoaOjBGTYm58lQKZJkmpNJMdzGrQxU3+hKN3LHpyn8/VjblAG3PX3Dgd588MNUzg
	 ZhWo78Q605ZcRgx4oj/7MSpTlpgcciyYGeTn3AnRHUqeNIPdWkfnPUupyRJJhlC09f
	 50DX2dvx1vuWg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 11:01:39 +0200
Subject: [PATCH mptcp-iproute v3 4/7] man: mptcp: 'backup' flag also
 affects outgoing data
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-user-feedback-v3-4-c6ba1f5fa13e@kernel.org>
References: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
In-Reply-To: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=g+6jj3ecIUY7f4kZO95pei5W83/MT0hJxTpUSoOGufI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo2X6qPy08wALt4tb5el07tjAQyAedAAQy5yC/
 1KMv6srxZSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqNl+gAKCRD2t4JPQmmg
 c2qPEADqVNJMvGbtvKSblRiR9qat1IS8Ng3agCfRiecB/CxzZ6NwY8k5dP7iYL6w/LDWf2Q77cb
 0k0CSBDQRchavvUtdWEeOl5QUkWAyaEs2e0HMrQDPzLrsrX8fpHcciueBrB4ZfWXhAi5Q0l+30t
 ueTx8KnZ/vlbZ7pgU/tmmHJDwOzIjcvmlBoiWVQT3DgBbW2Sow3JIKE6pIpLCK34XaQ0cF0Q1Fp
 ikw4211W03dI9YoGis2ia5eRJ47nqFkkMdpoAhC2d4I2WmvSNJVQeNO+docFyG88X/i7YZJ8aDk
 7pihsPGTko/L/LCKpBUsMd9tsE2TjU6LEbylDteKKG1Effl6wYb4Nn/dGZfmeLNQHNZ4McYiE4w
 kBy7aM3j27X02vFZyE/MFm9/6G25BsGZQpNAseTV5TzG5nA+If59M6XuUZ9d7uugJrY3Ur2OsdS
 d3Z+7G2XZuAtxQ3n6eySTNnHHGuX80rsp5f/F0SUH6eOdaF8y8dUURNOi3Hi5QrD8J7GQ5K8Thq
 KSSdNf0Bjyq5Z443aRl8cj4htHhRA0NfzC7uSMOr9zho3qjA02LGL4RKWKGJwKJQm8lCNVzE2M1
 pY8E4E/Ziw9E+29FA4eqR9Cg349w6D+/9+x2rr2F9cY+wTqFB3tDKY0X/IpoqYCpXY4+HjsQPOH
 +nHxo5350GXQsFA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

That's the behaviour with the default packet scheduler.

In some early design, the default scheduler was supposed to take into
account only the received backup flags, but it ended up not being the
case, and setting the flag would also affect outgoing data.

Suggested-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2: Reword (Mat)
---
 man/man8/ip-mptcp.8 | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 11df43ce..f3d09bab 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -170,10 +170,12 @@ typically do this.
 If this is a
 .BR subflow
 endpoint, the subflows created using this endpoint will have the backup
-flag set during the connection process. This flag instructs the peer to
-only send data on a given subflow when all non-backup subflows are
-unavailable. This does not affect outgoing data, where subflow priority
-is determined by the backup/non-backup flag received from the peer
+flag set during the connection process. This flag instructs the remote
+peer to only send data on a given subflow when all non-backup subflows
+are unavailable. When using the default packet scheduler with a 'backup'
+endpoint, outgoing data from the local peer is also affected: packets
+will only be sent from this endpoint when all non-backup subflows are
+unavailable.
 
 .TP
 .BR fullmesh

-- 
2.45.2

