Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4837783CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391875; cv=none; b=gWpKMzRm9TO/Eb4der4Kyo4B9jcQVssik8zHKa3eD7pfZ01+0hPjJxDCudD4uORhKWGwqLHtPy4m5UI057de421kbrxxyivKb/qnqB+YefcrSJLdaNS4M5S6XNCOFJgu2TEqp1oyz2iko7PNp5hadPNp6i4mxkQgcLGTBJSnl60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391875; c=relaxed/simple;
	bh=lVYzLe5JrCLEvvxaysYG3kgQy2v6ncdEAEe/A6edulI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZjb1uX9kSN09hIESpsI2dlQR7CnOg/vh8pxA5UWbSOyuObhrb2CNUG8RGAYV1W6mdFykkreI9a7rOx/sBIp0dUGg6yRc02CD48BcJdLThesT1JC8wEQkfLHKzfQMCdqmNu1+OPp+QsLEsULkvHn5v3VVMFkQDaCipPHUgIA6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0+hsY0+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0+hsY0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5FCC4AF0A;
	Fri, 19 Jul 2024 12:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391874;
	bh=lVYzLe5JrCLEvvxaysYG3kgQy2v6ncdEAEe/A6edulI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t0+hsY0+lPtKQBZVBmM1DeYHiEpkBceAz4phE2USjVrwOp4qtDwqq6lmttt/HxJ3f
	 QPLFxSsfJvsVB7j/3XFJiBhmAboweMKWNeBMOQkj8tk3m53RxRSFR5jdCarpanppiN
	 dEkgGbg4w3rNAs6GkHyNwesaGdOJkhBeYGsOuVDYD6ZRKzwJGrUTcstlW2FCHNn2wr
	 jP+BY0faNE87zqz5NurCwbO8ovfcVINLJ9jnphAsq9JRjB+cVTndh5oVjCVa0HoWfs
	 ltqtMILGJ9K5RplqSiKmhin325MirTmmlue1aztsNyBcSZfwVu5Z4evOqLv1PvgK6S
	 35P3uD9hB/OLw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:12 +0200
Subject: [PATCH mptcp-net v3 01/20] mptcp: fully established after ADD_ADDR
 echo on MPJ
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-1-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lVYzLe5JrCLEvvxaysYG3kgQy2v6ncdEAEe/A6edulI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlr/nt3aaCrUKmYcSue0ILOjyygt7FhRftky7
 CKjXYDo/vKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppa/wAKCRD2t4JPQmmg
 c9ZqEACYdUYZcZmqQLszOTcHZiCf5qQ20eo3fE+/s/nVsQJA+w8Q/VFzqYb3T9Dr/HGTvk8k2bd
 mJOFPqP/sTZlEQne5aFwFY59C+Tx7sUoJZ68vYFDiHe0QptlQNSuwFTFrtcSfUdcgcQ553f24py
 Dk1bIFxVErsRNSdzluBZpC4xOTXk+VaUB1uNMTa6MJL2YAng+aQ+6cyDtaKnyPriaKkXV7rRIHV
 aNSpsOOxLJhReKcT+W4QXaMjReKXzbNh8faKmNgMVrXdUSod8UazzHGuVzQfKB3nvAH2LcyONqu
 Ohp0mTtsYbV0E6s0qsxkgawARr+1NGy9hLd/GwMnmvrAuoQ8vn967Masecg3F636Ep7M1glpK+6
 x//Z1xxRPjdN1MG31gcLavMFqGA27CKJ2KRuOi+IwlROGU8+YGcbCo8HkxmXCj86jKTh8HrnPQc
 FV5lMoErv3Q8KAbkF5/DTmchfWScZdzSML9kA3bC6Bgk+B1FaXgqsaWp64wPsPcGL3rJuSW6aOw
 R/pMma5xHTUwgMrokW6A4YGEnNohKPLhcNAWGvHDYt27/OGLtkFbtIYd2jGCpSBMcFcVc92cKip
 Z/yLjWvQs6xSILlOfXW4SO5Spe2cityPVs3iq7Uxsob0/BEbVBc+3HMOb7LvSKAVAlHyYKDitxz
 ksweRU6FrRNpLDQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this patch, receiving an ADD_ADDR echo on the just connected
MP_JOIN subflow -- initiator side, after the MP_JOIN 3WHS -- was
resulting in an MP_RESET. That's because only ACKs with a DSS or
ADD_ADDRs without the echo bit were allowed.

Not allowing the ADD_ADDR echo after an MP_CAPABLE 3WHS makes sense, as
we are not supposed to send an ADD_ADDR before because it requires to be
in full established mode first. For the MP_JOIN 3WHS, that's different:
the ADD_ADDR can be sent on a previous subflow, and the ADD_ADDR echo
can be received on the recently created one. The other peer will already
be in fully established, so it is allowed to send that.

We can then relax the conditions here to accept the ADD_ADDR echo for
MPJ subflows.

Fixes: 67b12f792d5e ("mptcp: full fully established support after ADD_ADDR")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c0832df3b0a3..4ee2e3605f5b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -958,7 +958,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	if (subflow->remote_key_valid &&
 	    (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
-	     ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo))) {
+	     ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) &&
+	      (!mp_opt->echo || subflow->mp_join)))) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */

-- 
2.45.2

