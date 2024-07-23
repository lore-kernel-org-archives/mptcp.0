Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583AC13C3EE
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752295; cv=none; b=ddN+JdpRFbuvGpt4mHzGvdRbGQyMBPCD6f3Q/MHdC9UXrYtaCY/p0k1vZnUw7g5ZSIh4txIx1/d6A0+mPA5tcfOTmXO+Lci8gHGgw/jGxARiWBwiyUic2W0eHIB501XxghjsGYL8NNTlMQJOqpR+lifYqYJS6jks4InElr0DKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752295; c=relaxed/simple;
	bh=FCNZhogJAqUc+dw4wheAd0YWaIlnlTPCs4r+lUGfi20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=euT+ZL6cGvIAbd3RUsRrUnFGXQiyY54hav5acBd7oXY/gbDyn5MsD8BWT6orlnSjbm+Ca7LWqzQv2If8qdO0OZYAmR9TtMnqHxdS6WVkLa6EJ3xpghzgfXa0ZUPVqfun3X9vaIP7ZwxkRZRWpd1GcOL8NBYCCfG3G4jUiZ34Czs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYdAlxvE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYdAlxvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20428C4AF0A;
	Tue, 23 Jul 2024 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721752294;
	bh=FCNZhogJAqUc+dw4wheAd0YWaIlnlTPCs4r+lUGfi20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KYdAlxvEx/ZgfQT+TdWd+cd21Uus+fR4UMqc1HhvLszbS22tYNH7AbGz6U8ujkXyx
	 8We/IbOWIiI8VIkctpvIcblQALHXI3Dx/9rIhLHRNeEGjPgJuehxxOLSh4CsjnHvkH
	 4kZA1q7BZYUhSBfNueaJHbyo9IEdWh6CaD+yGji/7+ctAgYTEjjR2mbzfnuLRHdnqv
	 N2cLby6qVT4f/eugr3edn1wowgq5CR27JFcjxtYWENYI+FG5SpaC+nObrPOIYg64XS
	 NdKqGbLeIYniZ1x/LnqfOTmos9zBHpWUq64XUjqfPo0+t03+o1GuZ2jUtEoL92fO5w
	 hxLXHXDvImupQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Jul 2024 18:31:07 +0200
Subject: [PATCH mptcp-iproute v2 4/7] man: mptcp: 'backup' flag also
 affects outgoing data
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-mptcp-user-feedback-v2-4-59f18975401c@kernel.org>
References: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
In-Reply-To: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FCNZhogJAqUc+dw4wheAd0YWaIlnlTPCs4r+lUGfi20=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmn9rgOElzZrmLEgD3HNEsNUYUHcZR6m4c7lDI7
 JRO3vq8wrmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp/a4AAKCRD2t4JPQmmg
 c3jIEADeKAdAn3jmgwDjjtuVhICEQMQvsN0xrBNrCKO1m3yqbhe98orlsxPpPw28zib033XJ/4J
 ywnFH4SDzVY0upMp8hpRSeJpujVuRRx505at0cBCGVG7QIljXrqas6EdLyWEPFvonjbOJARzfjZ
 q1w5Jlv8HRqWZTENfuWybENesSPMw/5GPlwOofQANYlNA+VjwL45fXYfXeyAmzaet1g49CMQrv8
 YNWIf4sQxbVZk9YDxgWZlfbpXwxbuLtkpeD94JDckovzEvyHdfBv4KjQKOr/uPdxjqJGUYnc0El
 ao/OSFI8vgf/24qbQKsMcjODcUIXNGGkd7AM4HOUVgKwlU7Az1KkCmmkrTnzzZLjBIsEyPY1ksG
 mgYDpRc3BIiiYqvkY55XoXaDV/arNhpZtghxI9qwZNWamm3NM//loeABGvA9pHKVHAOZMjypqCx
 ho/0I2iiPOSH1zgiXXObm3yneW7TL79NHb+Gk5DZHKG3KsIWy9tOkG1u333wKVwabFonPCACjIa
 X0EpXSG+TpiEMPXZGilm90thYX/vRP81OMQGSWM2eplglt03hm9NoASbt/nxfQAKe7esbQSOQ48
 KdgnzU2HoCulO4ijJsoQOR3b61JG7DnlHp7s1ED3vu0kx9uWKyjlqXpnTuWd4rqrmlh/lzhyQDe
 Iu9q1ujWzgq033w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

That's the behaviour with the default packet scheduler.

In some early design, the default scheduler was supposed to take into
account only the received backup flags, but it ended up not being the
case, and setting the flag would also affect outgoing data.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 11df43ce..4d4c879b 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -172,8 +172,9 @@ If this is a
 endpoint, the subflows created using this endpoint will have the backup
 flag set during the connection process. This flag instructs the peer to
 only send data on a given subflow when all non-backup subflows are
-unavailable. This does not affect outgoing data, where subflow priority
-is determined by the backup/non-backup flag received from the peer
+unavailable. This does also affect outgoing data when the default packets
+scheduler is used. With it, the subflow priority is determined by the
+backup/non-backup flag sent to or received from the peer.
 
 .TP
 .BR fullmesh

-- 
2.45.2

