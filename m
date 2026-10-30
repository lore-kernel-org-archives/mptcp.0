Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334590;
	b=iZamBZ0h6Tcek2rq+YhpLLUnQorBdNCNTaudjfPMXmDXX6zZvhUYD+p0tnQOpArl+7JO
	 QCf7+fyFtMhcX22S/tNhdsIYhsp/GKtbpcmFET3HaxmB0EMKKE5MhTO3yYJ7EM/osUOld
	 /zQ0akKx/wXldtXsZluQqPQu3seVd1rvMZeSfClQXYLzGQdb3z1Bt3gQSwDtbvoEGbbZX
	 3ytwJ3+SelZ6iIAPkRepjZm1B/gG3ayjLOzt7rTkNFaCjPRrcXkGg7AEiSRiue8JPiDDj
	 GwmVQj3yJ5L1V3snYHOwAjsPWzspZtaifcjTqfGWRiJUX3MEZZSpzrrzV1c8dZNBrkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334590;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=n/r/OOEN9b+G0ZtBZMMJxNN3Maq1TLqq/r57PV8r8wHW83l3BObuvRSgTHnaxnVB5Bge
	 LUPAdj958PtK2Zgx6FscBAbRz0gh7+LXE7icDsG/VqaA6lEq+gI+yCgOxSwxoH1eNGISZ
	 5PexHnZgEcfyjCaRFyBIJwRQ+V++jLNENdvBoRIkfPsshLI91WBeZOfsDi7nbkSCXVJFC
	 ZkpLDdXOckdV/1LAvw9+EQwMcfJJrKUDU6huwQHO1ekdsjCnUbDhqcXgOiP751nZs1EUv
	 rRRt3AYnlR+KZHVNvda8KJdbfCCGRnW/YF97u4uceRmG8WsMv4Xk2csxnJQNhwXpAKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoJ+pgRW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24B6606A31E;
	Fri, 30 Oct 2026 04:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoJ+pgRW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F269B1F00A02;
	Fri, 30 Oct 2026 04:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793334589;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DoJ+pgRWgsNbaTvcpAklHyfb03QLKPxKKVpqLLdw/8bzWJLtED4//uDzjHBCY0hsS
	 pPmheJkcKGdQtE92+gVv8HkHfH/d82MYHPFLDltY0Vp70B6ThabWX0IKhim7QO0LHV
	 L1pELHvetxCF1eGe3ylnnlDIc2Z2FvtZQ6AKaiF+xTt48YnmjqxGgnwesJ+L6McY9S
	 vKQaKu3D3Ao6m5hyNrn04l68rsJPBKHtMnNd/gzz/hVEauG8QVj+iUNo9tLrAWfwqN
	 EcdOMEHdDUFQQlz1k0UG5orUq/Jd3fdGFIS6REdega2OfabdE3u/bHeMJ2TiZOaA3V
	 P9c/8Z95t8LOA==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, outbounddisclosures@openai.com
Subject: Re: [PATCH] mptcp: pm: kernel: use RCU to free endpoint listeners
Date: Fri, 30 Oct 2026 04:29:48 +0000
Message-ID: <179333458853.3327.8665162337871121477@kernel.org>
In-Reply-To: <20261030042255.74216-1-kylebot@openai.com>
References: <20261030042255.74216-1-kylebot@openai.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
