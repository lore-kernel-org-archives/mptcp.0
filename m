Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330982;
	b=Wme7JLxmKqa519RAwuIjLVyLPujUczV2MbHi0eKvsHrUVSAjwr5VuecjQYjzPALmKt4V
	 ADtpVnTy4x6YYAehIP++OKesNyEX7UTtH1j3K3Pw+MRigVd4LS2i7dN5x1FB7CB3z7ce1
	 mOJZzT5lISylfgItpwKSYhsYJTSuxLg/Io1ASBnVKy6gLsqGLO070BOiSdt8PvU1eowA6
	 v3DRyjR1HUZ0Qc5BPvB+e+VAPwiqNfe5K29SZLai1I9wlGxMzegrfeWrg+FJIWQwFJvpT
	 FCw9+2Z5BhA/Pc22MjHTg41VrRX2iOMRuCCnkkHW9ZXJlFlbIY+hSfO1PZKo08blJ8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330982;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=bmm23ncerky5gmfp8Yu8ywVTzgXle91nrI6gF0mAulOrv81kQPAiMikIOikaFJbVfdCX
	 VUvbckEuBGOuBjFXThBfBVAE6ulf9uxEL/pS1ItqWIkZjaf3DyzAnwSxWsryivIrchLHX
	 llWH+hsZdpjnx6xB6pG/kKdPwf9jo+bvDKjZcB5kFV5PDsbUHbxx4lTkFTeL7sU7g6E7o
	 p5rSIaID1hWdegsx/0Q1wSauUhLki1lUpJXsCcucygRh239a5Y/Vj6R9Pk+NmW/5G7IS0
	 yokU3wx9uwNTKl7NuCRmGPh4xu3LEmA6uMUt/0ROdHEkMZ9bsFvgkYVb5wcbpqTIfcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSSvmtu6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541E606A31E;
	Fri, 30 Oct 2026 03:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSSvmtu6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05411F00A18;
	Fri, 30 Oct 2026 03:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793330981;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mSSvmtu6eHVxFg0ZfMRB9mHWisxwTZIQwsXshb2+9Lj0xF3OsXcfmJkHhvFWVWFC7
	 xU3nrISdxAvry+x7iqYmu+BRrCXqS9bTej7B1BEmmhB3LA79q0XcDTU1lcykfuMUnc
	 LjbLaE7rQ8zfZ8+67gHIbpMRd7nrVgNl3QhP9R2AiNu1eUdO/XwVojo9ceSWUe1Qsf
	 O6L9TSEstXcox2aPaKTSR6yizvbJRp24nwmPN/cBwcPqUHl15HA/1qvrIrNOe+5yeq
	 Ejt41anE0T7SveJ35e/O8xMHR4+gmRuPf9/LcvSMqfjkfaEDErs9fCLLyMiIX9oqDG
	 ULWwTRVwx4URg==
From: netdev-bot+sinfo@kernel.org
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 Tong Liu <lyutoon@gmail.com>, Qi Tang <tpluszz77@gmail.com>
Subject: 
 Re: [PATCH net] tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket
Date: Fri, 30 Oct 2026 03:29:40 +0000
Message-ID: <179333098042.3327.6001182207228154005@kernel.org>
In-Reply-To: <20261030032314.1978575-1-zhiyuzhang999@gmail.com>
References: <20261030032314.1978575-1-zhiyuzhang999@gmail.com>
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
