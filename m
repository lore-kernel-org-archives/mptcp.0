Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CB311C3F
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964721; cv=none; b=SqTVE+aXIQctW6hRi6jhwPtEZ7DQb877+7E7yYQTN9ScEQDEr8tbKdhsmAiAeyabIFC0w8qU6PE8EmrkBkx2tCtFvPgyFfajXEuG9aG63InMjfiLjdw6UsB2dbBS42uUolKmLvb6DlyIEctKn/7p0lSGqM/oPDjUejC8hDycIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964721; c=relaxed/simple;
	bh=C/4LF05n4+oEdELeQ5klZ3Zm0v1aNAXbUWk4Z8AZxn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLeiBkGpMU/Zz4qQuJH2rEqf3AlA5Db70Q6s5HJ7JkVh2BVe1h8+FPtWvwalcVBt76ky/P5J54CTZ9iARaXY0/pzrgLExlVjsBrurnhUnVnivEJa5/HbMFN+hsV7e6kx08A49bPVUHpUzB/1HGGp+NSz3rLPdQuHY8owvQCVvzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWX7TNtz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWX7TNtz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0495C19421;
	Wed, 12 Nov 2025 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964721;
	bh=C/4LF05n4+oEdELeQ5klZ3Zm0v1aNAXbUWk4Z8AZxn8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hWX7TNtzOWe48++zw4sUqfGE3APw2laMRHFoIbWnTmwcGcrvRB6ueD+BdNNgNP3Na
	 USxwJuY6HnAqTYdV7wL2J8Z0u1AZQwsW5yhLs/K1GcAUlFhcYMeKfHTRNOfVyfSHqw
	 o0hZgO7D894oL2ke6jWSwf9QT6bD7QnMITjL5ayX5s6g4VRwxhapagy0fVskGHg46G
	 MIP7t/MFQGaM/Ch6YUBqbzTg1EocEDbVM+upD1PMZQNUr4437Pj2WLueGVRlvaUVRa
	 7fEqBD+lr0GInhOm0wbt41y+r546eeuUiSqrljBow3DmQVcJG0kZdUG0XT8J4EQ8t5
	 zvoB5yDJIUr7w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Nov 2025 17:24:44 +0100
Subject: [PATCH iproute-mptcp 1/6] MAINTAINERS: add entry for mptcp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-laminar-v1-1-e23dbf584aa4@kernel.org>
References: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
In-Reply-To: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=742; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=C/4LF05n4+oEdELeQ5klZ3Zm0v1aNAXbUWk4Z8AZxn8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJFtrz4ludYmBupxWd/PnFmp4l0d7fWg3uaJo+0Ti9V7
 27i4M/rKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmEh3PSPDur27NmTVB3jUX5Pa
 v3ba/Wnu63d8nnLz9oJki4CEm/emZDD8U9DruyF5csdbLdX6t5mHmVNjbL/tVd311y7ilsihzxd
 +8QIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Add Matthieu as main maintainer, but also the MPTCP Linux mailing list
to reach more people interested by MPTCP when submitting patches on this
subject.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51833ec1..2d13c752 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -42,6 +42,13 @@ devlink
 M: Jiri Pirko <jiri@resnulli.us>
 F: devlink/*
 
+Multipath TCP - mptcp
+M: Matthieu Baerts <matttbe@kernel.org>
+L: mptcp@lists.linux.dev
+F: ip/ipmptcp.c
+F: man/man8/ip-mptcp.8
+K: mptcp
+
 netkit
 M: Daniel Borkmann <daniel@iogearbox.net>
 M: Nikolay Aleksandrov <razor@blackwall.org>

-- 
2.51.0

