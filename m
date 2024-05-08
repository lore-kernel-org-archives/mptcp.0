Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595D757F7
	for <mptcp@lists.linux.dev>; Wed,  8 May 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161502; cv=none; b=Dv681E7pndyvDqIUmT62Pn2ByFNhpHHIru0hy5OPnoNfnBlrR/60vhkRNPQp4gZ7Mp+WVCL/HbqlGJQyNpOuNu6hL+9A9nqx/74FzuBzDd1ZbkeY1Hvm3sMWPPU//fAacnaGPnmVAgf0NGl4eL1HhjofYfOLZUpYuIawZV45Slw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161502; c=relaxed/simple;
	bh=Cnu4tmvCs2Y1wi6KNdfzkOGfCsGacWmjwyCjZfGa1s4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wnz+G+D9wWdVeHQJG1DOoj41ja25IiOdVAJ/pAPoQ+YX/L9xK0UCVnRL3oCKQC61TVb3zwDZo80nSAEeDW6VMtbiVFpR0bVLXcebz76USTUjrKLuQ2h09keBj+vBIpEjlzAVJkGjRIJdPynHJih2y1SwAQ4ppguijmEnqFMeRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeDdTDcb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeDdTDcb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC301C113CC;
	Wed,  8 May 2024 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715161501;
	bh=Cnu4tmvCs2Y1wi6KNdfzkOGfCsGacWmjwyCjZfGa1s4=;
	h=From:Subject:Date:To:Cc:From;
	b=oeDdTDcbaGKyk5I0igE9H1JpyiZ6AzApPFKtFvac9r5InvrOFVrOPOTs5zwt9DvnW
	 qm1Kp2LPtq7I6SPB86oavg+qSbY87o1bZ9vbdph1GmGdsMBfiE1BUS/uUKGanrVn4f
	 ktQLFYc6gPpMS3OARKPE79E0v+efrEhj/Elp9tIBRF1gAztTCE6yeMLiBolIbMruON
	 b3Bj5SshjYnw1h3towTDRvqpu/kY3ryKkdJZpToqFVQph8P5RdevYuwOiCjnkclFG+
	 HNTWJDhd7UocfKHH8HPsXN5tUwI4EoTvFTezDmLAEfASFF2IK0Vs3C5SA8ufHFTiCb
	 wxS7UVAKNnTDw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] mptcp: getsockopt(SO_KEEPALIVE) and
 TCP_KEEP* sockopts
Date: Wed, 08 May 2024 11:44:54 +0200
Message-Id: <20240508-mptcp-tcp-keepalive-sockopts-v1-0-fdf7e03e14c4@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJZJO2YC/yWMQQqDMBAAvyJ77kKMxoJfkR5sXHWxTZZsEEH8e
 9P2MIc5zJyglJgU+uqERDsrx1CkvlXg1zEshDwVB2tsa5y541uyF/yyEcn44p1Qo9+iZEXXdlP
 zrOfGug7KQhLNfPz2A/zLQBke1/UBCkPsHHkAAAA=
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Cnu4tmvCs2Y1wi6KNdfzkOGfCsGacWmjwyCjZfGa1s4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmO0mc7MeqPKn1/H1mtg7IMounOIcJT3zHjt3t0
 EkQjWmfFhiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjtJnAAKCRD2t4JPQmmg
 c3wDEAChwqRt8UjgIgGgtCucnsSz1Na5Sqldg9YxcqzSX67Z7ApS3eHwyI6HXLfgzJN38tI9or+
 O2QJXQS1eAJr4oYbZE+cV8YuUvBzARAlUPUAPrHI/ZiStYruDq49bkUOL+O3ZGm5PLsB0H3H7/l
 +uaf54TADG1e9fEAwSgJm9LrlvElNPZV2IMVB+2AMQit49fpJIul3qs0rNYJXP34J6uB7iTQKy0
 bZ4IQAoyYX/tTcmd5lltGz3+QWdOtHSKjaTaO3nUeqU51RtIiEMAubyqsIkHpN3OvjNUaBRBgLe
 dbqcRtJOvkeAwcI258jJHxfSCvK6+OArNHYe6Ucw9RMtfkkO7deKEkMzQKe6A/Exv4JY9Ims4z/
 hjoKlWXNgKSICl86YxYW2WI4skgPXeJzDtK9cF5OL6n4dsimalK9HqcuNd/pAxN+QU2RQbOB3/m
 hJ8KCMRtP3sM2uFQPmjQwuyctOaBGqG7MELMevjI5oerBMSSO23AoEzufya8XL+i0EIeU6cl+yO
 /RZ4qUG7cnO5VIwYxQMTaaY8y841FmsoXI+HFPsMvauCITY8Xy7ztSghXkLkeKK4+4NE+OdKIja
 7oq3aHgd8ss5t3FwhaT2eyKTA4uACnYvqXlRhAFdu6qJzJmg2U7bW8gtfWmNWS1eUqknJwdrxW+
 tP9VbTy4HhyfHHg==
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
Matthieu Baerts (NGI0) (2):
      mptcp: SO_KEEPALIVE: fix getsockopt support
      mptcp: fix full TCP keep-alive support

 net/mptcp/protocol.h |  3 +++
 net/mptcp/sockopt.c  | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 2 deletions(-)
---
base-commit: a64044939fd33676d7098eb08397e65e83d278ed
change-id: 20240507-mptcp-tcp-keepalive-sockopts-546d3b1f3256

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

