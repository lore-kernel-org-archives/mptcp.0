Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161437;
	b=soKK/SqGFpS/JUukzT0zRS4Ab+oPgoGTg9pwgyviJ2njXvd5sknHSIMH6Y7PtU9oq3xi
	 wXaI6j+aMNdKoYA8f5cE9mXlYgUZGgc3WIxag09w3PzKHXdeqiVkoqgQr+Q0CCX7ksdNi
	 xajZK2aYyRatCUYu7IIIBpKvJVYd700eL/ra9oZtIk0jJRJRvjuTXnH3v5VK3+hYO2qAI
	 8cFqz1sg2T53D3VdkY97x3jLiDZhJuyh9phqBv0rpZJIbe4nDI0MkR7de3AaMxE4EUqwp
	 J62Shkdmzs/dkVaFpGgylid6IrDU14qz1p0EM+A/EJsJ43zvL5QBKxhjY8RSHaQOEfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161437;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=MB+36gmuk//f+DNvQ7i0un7mHs0ELO0cJLFj7OJlAkV5xSdPBw3h+q2i8XhZpwI/ZKQm
	 9fYUUADys8sDFJu10dTQfbbmRdUY1sd4L2h+e3fLv4y3eaU5RJtgB6fy7OhqgSYu0pOl5
	 qn86lGercSm6UC4xN7KeVM1TVtTi7XywUBOjWBel2bcmoqFNml4Q1ylORwoJEElt+/0IT
	 bPQAYWGYhBs3ilT4nayaVMlT/uaGZizSTPwx+Z/bHmCQERr4ocpNNm1KaFL+Aki5j6jv2
	 nyfupAeh6JWRrbdANrZrUFAC3QN44jClfO+2ayd3bCJbhemp/z+LEtlKOUJ7ukrGyyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEEzWA64;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217BA60A2617;
	Fri, 20 Nov 2026 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEEzWA64
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E4A1F000CF;
	Fri, 20 Nov 2026 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795161436;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lEEzWA643/o03Kus8Gw9gMsuB/XJ6aR+ZX12lmR5aoJnGbxGPLbhRQvh5gtmev/8U
	 Jsk27piuk5OKhOdS8SL13irbj4aA9AzztdKwthembX1f7/XRCoLt11PICcQHK/rNQS
	 cU3r948ECn1xVGcZRFwCeotgkBw42BBv4DtOmmkcj91kMneQYnyZMBkhPoPUmICsiT
	 RF9ToBb3+q21BS5C8Wt0Tkgz9+t/Md3cFCospRa7uyK3tbZGQsre5uYAB0FlrMIh7M
	 GraZqw+XrW+iO8YTb9/CkdinRi8p7i8DDTAcUx7HwcG+NrjA+9b7u5wN+oADGBQgoT
	 uHMiGmr5WQMDw==
From: netdev-bot+sinfo@kernel.org
To: Lin Lei <llleigoing@gmail.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 horms@kernel.org
Subject: 
 Re: [PATCH net v2] mptcp: exclude MSG_PEEK from receive buffer autotuning
Date: Fri, 20 Nov 2026 07:57:15 +0000
Message-ID: <179516143562.3291.17266753897945843390@kernel.org>
In-Reply-To: <20261120075459.2862977-1-llleigoing@gmail.com>
References: <20261120075459.2862977-1-llleigoing@gmail.com>
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
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
