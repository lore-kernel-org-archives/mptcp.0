Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7C358BD
	for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+0WXIMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53720C433C8;
	Fri, 15 Dec 2023 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702651571;
	bh=QCO6N9HG3FavyqI+tvaL7m1LkOhALp6KdpopNqOvYIE=;
	h=From:Date:Subject:To:Cc:From;
	b=J+0WXIMbB994cN04dbX5qBSpyohJUmU/rI11GqEpYielcboNa9ILha43DelL4i1L7
	 hmGLWYMgo7j50jyx0J3oATuvz4YIZE1ydnECkSwnFjGvHCKWdV6uTVUDZq9vIUrVWp
	 nj2y0Kbm2n2ILw9N5swzFG+Yz6OD4oF5BZzjSu7wCkkeJ6SRkomXk8TYTKF7iQUo3O
	 Pe222XoZNT9wg7HgxMDkGnP98OszUmgfJ1MrSEuNCdTdUI8tjV7Ac9wrfcUBD2ilyi
	 F2zNM/U/BAIlZbNj1CwTRhXjdOeO/5W3YVTBEucF8D1UtsDw8dXhh7Yx1tfJWZMlV+
	 o7xESKpTOyMQQ==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Fri, 15 Dec 2023 15:45:50 +0100
Subject: [PATCH mptcp-net] MAINTAINERS: add Geliang as reviewer for MPTCP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-mptcp-reviewers-geliang-v1-1-3fec5a0f8eac@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJ1mfGUC/yWMzQqDMBAGX0X23AUTf5C+SumhJl90QdOQSBXEd
 zfV48DM7JQQBYmexU4RP0ny9RnUoyAzfvwAFpuZdKkrpVXDc1hM4L+KFTHxgEmyx7XtdIveOds
 ZynWIcLJd5xfdkcdC7+M4Af/IAX10AAAA
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QCO6N9HG3FavyqI+tvaL7m1LkOhALp6KdpopNqOvYIE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlfGayCl5FGBtM/0J1MNkw5zLAnYHL849iusBRh
 cJWWL2/uwWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZXxmsgAKCRD2t4JPQmmg
 czB+D/9JI2ndRuEgwvMcgjrlQViyYFOLCp9tC/doDOrRQB+SNw4OcCvv09OiSt9mzbVXWMYcoFk
 1jN1wTk9OiEqGEtsPkOXmGdyOewqW7T/VmLjTCDwQmNnxIw/VoiOHhXYwFcHiJa5mtWcT9p8LI2
 N5YEa9MzsTGzA2biodcUiHQnTjAAb/3WQMACCZA3piEO3mcQhtEFKMspBGp31puskJ5w0pfZ77b
 sgM2BBD67n3WMCkAybagSghJIzBWdQ28OkWGwjE7fdz3scsJuTQBD5aZP1C1VRhYUmlHIBe+qoD
 CGhXhf1Ewc253XgZ1tce8Zp5qke2VpBrZQ0CLUoPQoBEnzpC9lPzPWRumBCtGGCpQb3gjG0CgG4
 gfDY0VTxahbGfMxMzbkTZStzxAH6NgTuypa7zYg9+4YgDzTWo3IMrk85oxd8Xc/q3Y6wWdJeZOn
 2XH5NdRd2AFHPRjgwK8UtFWlXyiJfxiwZt34xPU8k1iuPy7h3Q4g0sZ6QOp29W3teifnBDBvtwS
 OGuIZ9THvYh4BgCnnjT0SMFjGy0R/5OR0VdIidRdUIKVJZJ8d3zhl3WA0S57dhaopPgiVZNLvcB
 nGGAkSjEoDPtUutWsgh8dIwRwAXTpfMpzgcR0RsqhrquU0gw8L4o3ws8lk8sGZdOZMser5EhVoP
 NopSqMD1xtB0oOg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

For a long time now, Geliang has contributed to a lot of code and
reviews related to MPTCP. So let's reflect that in the MAINTAINERS file.

This should also encourage patch submitters to add him to the CC list.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---

@Geliang: do you mind publicly acking this patch if you are still OK
with that?
Cc: Geliang Tang <geliang.tang@linux.dev>

@Mat: can I also add your Acked-by as discussed this week?
Cc: Mat Martineau <martineau@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 49c1caad5d99..b7e51b7b8760 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15076,6 +15076,7 @@ K:	\bmdo_
 NETWORKING [MPTCP]
 M:	Matthieu Baerts <matttbe@kernel.org>
 M:	Mat Martineau <martineau@kernel.org>
+R:	Geliang Tang <geliang.tang@linux.dev>
 L:	netdev@vger.kernel.org
 L:	mptcp@lists.linux.dev
 S:	Maintained

---
base-commit: 84d8fb414b2a78b32e97b1e4888688bca82aecf5
change-id: 20231215-mptcp-reviewers-geliang-4d826ebffd8c

Best regards,
-- 
Matthieu Baerts <matttbe@kernel.org>

