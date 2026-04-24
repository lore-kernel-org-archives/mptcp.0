Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F9C314D05
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060485; cv=none; b=OMdK9NvMKWMb+2CNO9KbR/odBclsxUnxhx+1Z72ZbHE6Qvn7DLB6nD/AcCFWPC1/l8wITiL6EXFW6GAqvOvzLnRsrILGgzLpfrWq9JvsLofZ02C3ZBiuhvkIvNwhkd/Hsipo64yT68SmvjCz5CeFx9cyWF5P3tgKnYbiTLODFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060485; c=relaxed/simple;
	bh=6VldtCcU2GhNoc/ooRHqE5DWpkXelAwME68jH1SI9N4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pyIl/A2VsllNu7lYgD+z5koyALUF0CR4GMCVPqj2jFvizTgUqxTEICwixn233FLE5I8+xOvBh9Njtj7NVvP5lpKDinX7tDsP81+hWJyaUFTgdBD8KwfFOpXJE3nKMLtqzfqQR2/kuJubCF1zzGMc/flVrjHChdwrUTolZi5Nu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGn1lVM5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGn1lVM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9849C19425;
	Fri, 24 Apr 2026 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777060485;
	bh=6VldtCcU2GhNoc/ooRHqE5DWpkXelAwME68jH1SI9N4=;
	h=From:Date:Subject:To:Cc:From;
	b=pGn1lVM5cnh7Mgpb0Py4XMpUgTVxHD8RmzYVOA7RKK9jYGK7GogkD4lO/pJGJB/il
	 4nHLEYSSzDMTlo7wv+47CNcfoYkD2AYNMAMaT7QDAANb2WsKFYKH+JO/mjo0YzsGI7
	 g2jkolE0mIbuDPh/+sATmd6k7Zt9iejawUBflQJa3dTCLINJvsX99QxjDS8echlPQR
	 y0Rw73kEnjSZ7L5V5AHdmLDarqYOuADEeEZpEVQ3Aa2kFNqgGR3/MjTJLmOoev5mQm
	 tWwFJp8edRR5zqnaLeNVQsm61/+zgF+Ctb+lvazMunCU7SA66C5Yc7xFWu9SRc5dJV
	 ATbfNe5TVSFAQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 Apr 2026 21:54:39 +0200
Subject: [PATCH mptcp-net] mptcp: sockopt: increase seq in
 mptcp_setsockopt_all_sf
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-mptcp-pm-sockopt-set-all-sf-v1-1-38e7023822f8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QrCMAyF4VcZuTawhqLMVxEvti7T6NaWJoow9
 u5Wd/lzON8KykVY4dysUPgtKinWcIcGwr2PN0YZawO1dGw9eVyyhYx5QU3hmbKhsmE/z6gTjs6
 HjjryfHJQhVx4ks9fv8B+jGxw3Sd9DQ8O9tNh2768zVREigAAAA==
X-Change-ID: 20260424-mptcp-pm-sockopt-set-all-sf-d14c92924e71
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6VldtCcU2GhNoc/ooRHqE5DWpkXelAwME68jH1SI9N4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJfn2p2sH17NnyLx+1D7h2Xdkw9o5SdIn7L4/KRqd+91
 1zZ63PyakcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEZN0YGRYWuYSciVNQalE5
 PDlbiH+eTeOraUwmhTHXLzu7TtvSuYGR4ZnRKdZ2r9S62Zaa21/u0ZM/q39MV5mr8oHnZec4zel
 G/AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_setsockopt_all_sf() was missing a call to sockopt_seq_inc(). This
is required not to cause missing synchronization for newer subflows
created later on.

This helper is called each time a socket option is set on subflows, and
future ones will need to inherit this option after their creation.

Fixes: 51c5fd09e1b4 ("mptcp: add TCP_MAXSEG sockopt support")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 79db15903e7a..30b45d2ab38c 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -812,6 +812,10 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 		if (ret)
 			break;
 	}
+
+	if (!ret)
+		sockopt_seq_inc(msk);
+
 	return ret;
 }
 

---
base-commit: 2b52586ab2905a2e2546a2fcd28448c86677306d
change-id: 20260424-mptcp-pm-sockopt-set-all-sf-d14c92924e71

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

