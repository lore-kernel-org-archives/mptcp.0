Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128112F582
	for <mptcp@lists.linux.dev>; Thu,  9 May 2024 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251725; cv=none; b=lh9RQbgKV/ohgeBpM8CXmj70VoQoetf1IIM9pjVJmt4DWOXg50Z3If7W/qk/PSoXlSZmyoiiFe0n3gHNjrn5uWq40rzqHQ5BsMLXn1YY4xTli9ZIrSx9Zk5IfBshgI+FfS8Jre3EWTVgZTtTq6s0Y4l82q97booZP8f0Djz+R40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251725; c=relaxed/simple;
	bh=3OxqexqPSWsx9JLoFWgT2nvWiAO99ZscR2/I/7xcUJ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DaW0p2TP/s8QEAu2f+w2uO6CUKII1yRFVM02g3VsLZHvw8W1G7gETP7d4luvZsrggf8/AvL+h75hg3y7f7wvAFYyZw+f0NvptmNLiiRJXGUU7kgKdod5uuZneEd7M0zzLYE2fMrgCVeWbmsjGz88BwlfEzWGUMR7RgKPeIBMfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBsqFTWS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBsqFTWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E80C116B1;
	Thu,  9 May 2024 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715251724;
	bh=3OxqexqPSWsx9JLoFWgT2nvWiAO99ZscR2/I/7xcUJ4=;
	h=From:Subject:Date:To:Cc:From;
	b=FBsqFTWS4kl3Wm7KSs7GQTnnl5/Out+CTWXg/1qS0fZCgD7Uy1RAvEt2zzq0FFODm
	 qDtyOCTM9WPHRVU6U5eHXwdJeH4BqCY4OerSTdtxhANjtQAsXimls+rDGXKplGwEGV
	 92rQC4Oeeke0NORdJFaCpPikOWMe7UFfpJjJD6bbXY4GCki6xyKMbDCaAkj/a1MAA7
	 fi9HicSfDrvxhM55GCf4NK78moyD0H/OzjQTwCp0kYA9x1TDLpZvQ9txCYuXoxClR9
	 vnFPFTF7yn7nCvJAcxZDoZr7uUOJ361QRIJLEQtjnjALWsm8Ke//0r3a+hTJ1aLD34
	 qzKMLZetzbCqg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/2] mptcp: getsockopt(SO_KEEPALIVE) and
 TCP_KEEP* sockopts
Date: Thu, 09 May 2024 12:48:20 +0200
Message-Id: <20240509-mptcp-tcp-keepalive-sockopts-v2-0-5f97067847a2@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPSpPGYC/32NTQ7CIBCFr2JmLQYobY0r72G6qHRoJ61AgBBN0
 7uL1bWLt3h5P98KEQNhhMthhYCZIjlbjDweQE+9HZHRUDxILhWvecsePmnPPpoRfb9QRhadnp1
 PkdWqGaq7MJWsGygXPqCh535/g+/SYoKuRBPF5MJrB2exF36M839GFowzM5gWeYVCaXWdMVhcT
 i6M0G3b9gaMCAHC1AAAAA==
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2995; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3OxqexqPSWsx9JLoFWgT2nvWiAO99ZscR2/I/7xcUJ4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPKoLi1onLO1z1omBQ+BH+GHrXsLgKqE6IcUdg
 cX3TzOB/TeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjyqCwAKCRD2t4JPQmmg
 c5+xEADfP50iGffUsozxFNcgdSOQAEWb1Hmt3Xu6N6G5hFeyB8gfIq7/0ZcXL2TnZv7cR44cbXs
 C9j3mbfl1Qxv06OaQcEXI8bEVKAAEYiooUpsYoK/MBaDhD54nVajLT4YpCpFiEjj88gBfb0VvGT
 VK74jE0oAo/Z5hjg/F2IwwVAEJgbmsNA5MAsUG7utMurydCYxFbqGlg/XzrGgtoxbJA5AEsO0+B
 A96vPcN4jTSqTTIlWoQWPRRcg2/KynJTg3qUF29KRAKAK2vJ5lnKTCzqaBZrSzurI4twuvstWyL
 utFZw6m/xvrOIz3tVDfYCkPS4+9+14tpfxhHgcDzQ1CmpTJrTENQPGSeErwaVVU+nWQBdYM6MM2
 md0Ai2C4uZ6Jgdh951PybhqdFGfM8D5iLSSY3Meff2a0mpRpTe8/EwsimKCCRQge21kpsiTTi1A
 C5Rv5K+eVgfMSyGhzk/CbzWApV7JhrjYbWzGhR8fGl56/6HcfQE4f0NEmQ8Nq4pi4qT6bROV34I
 jux3G7aHmIEl8WnHPCvRoNI58GYQ0ARs1OkXp5k4Rie5aMXEWyGoqD7I730eKuqDVikjOXWSbzn
 RQyYa6vF8yOwWS4u5fYA0EVZLPOrtzg1HrLnoWbEe9WqwQK9DokLK0vgAIS88TF961wtUPZNI69
 SCq2LePT2yjcq5Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is linked to a discussion we had a few weeks ago: not supporting
TCP_KEEP* socket options is preventing MPTCP to be used in some apps or
libraries like it was the case in GoLang recently.

Supporting them is not difficult, it should have probably done before,
when SO_KEEPALIVE support has been added. Supporting them is easy and
isolated from the rest, it sounds safe enough to add a Fixes tag, and
check with the stable team to backport them. I understand it can be a
bit controversial, but it would unnecessary delay (1 or 2 years?) some
deployments, for something that simple.

While at it, getsockopt(SO_KEEPALIVE) is now returning the expected
value.

The manipulation of these different socket options can be verified with
this simple packetdrill test:

  --tolerance_usecs=100000
  `../common/defaults.sh`

  0.0    socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
  +0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
  +0     bind(3, ..., ...) = 0
  +0     listen(3, 1) = 0

  +0       <  S   0:0(0)         win 8000  <mss 1024, sackOK, nop, nop, nop, wscale 0, mpcapable v1 flags[flag_h] nokey>
  +0       >  S.  0:0(0)  ack 1            <mss 1460, nop, nop, sackOK, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
  +0.01    <   .  1:1(0)  ack 1  win 8000                                             <mpcapable v1 flags[flag_h] key[ckey=2, skey]>
  +0     accept(3, ..., ...) = 4

  // Set and check the different Keep-Alive options.
  +0     getsockopt(4, SOL_SOCKET, SO_KEEPALIVE, [0], [4]) = 0
  +0     setsockopt(4, SOL_SOCKET, SO_KEEPALIVE, [1], 4) = 0
  +0     getsockopt(4, SOL_SOCKET, SO_KEEPALIVE, [1], [4]) = 0

  +0     getsockopt(4, SOL_TCP, TCP_KEEPIDLE, [7200], [4]) = 0
  +0     setsockopt(4, SOL_TCP, TCP_KEEPIDLE, [7200], 4) = 0
  +0     getsockopt(4, SOL_TCP, TCP_KEEPIDLE, [7200], [4]) = 0

  +0     getsockopt(4, SOL_TCP, TCP_KEEPINTVL, [75], [4]) = 0
  +0     setsockopt(4, SOL_TCP, TCP_KEEPINTVL, [10], 4) = 0
  +0     getsockopt(4, SOL_TCP, TCP_KEEPINTVL, [10], [4]) = 0

  +0     getsockopt(4, SOL_TCP, TCP_KEEPCNT, [9], [4]) = 0
  +0     setsockopt(4, SOL_TCP, TCP_KEEPCNT, [2], 4) = 0
  +0     getsockopt(4, SOL_TCP, TCP_KEEPCNT, [2], [4]) = 0

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Addressed Paolo's comments in patch 2/2, see the individual changelog.
- Link to v1: https://lore.kernel.org/r/20240508-mptcp-tcp-keepalive-sockopts-v1-0-fdf7e03e14c4@kernel.org

---
Matthieu Baerts (NGI0) (2):
      mptcp: SO_KEEPALIVE: fix getsockopt support
      mptcp: fix full TCP keep-alive support

 net/mptcp/protocol.h |  3 +++
 net/mptcp/sockopt.c  | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 2 deletions(-)
---
base-commit: a64044939fd33676d7098eb08397e65e83d278ed
change-id: 20240507-mptcp-tcp-keepalive-sockopts-546d3b1f3256

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

