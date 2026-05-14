Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D03321BD;
	Thu, 14 May 2026 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779806; cv=none; b=Vy4AdofXbQbntoEZRMMjCGb6BZsh4LOvqZFmjkyP8F/JxFDWLJZP+BYjW+f8vUqELwvwhk0Q6IJWH7x0D1lKafRLOpDPHAfQleW1HxMezwhckOnsdBnn5BR1PkngWlWgZJV6JNOm0gHUScLdrfMTXGTVHrCiMUBV5OV0jzDLGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779806; c=relaxed/simple;
	bh=MFQILT0u9XWoTRgH8VpTaoh6jLLK5ospPUm4XmguTHM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VkUWt2vt0bqYqIsCNbrevd4CH7TyqFe92XM1HhgWuHk4q18fpZ6taA+9FdRgJVy+43mkExU9ohs3xuB6/6nENNI8FjO6nLgjYJySWT+JLA/Y+cX+1V16cpXJUJQo2p7OXrgIw9OEkVJjFP17fOfad01TsnXNDs6aXE4mbVnrUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7Qs1ebn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7Qs1ebn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D535C2BCB3;
	Thu, 14 May 2026 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778779805;
	bh=MFQILT0u9XWoTRgH8VpTaoh6jLLK5ospPUm4XmguTHM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=M7Qs1ebn4+VPixZeqQYJfApnsv5BfXHMEGMHqOA4DuUT7kpcE2HJHhnkxRySrKDFN
	 /PzVisPPWg2JF3buHkv0F59taCIC6EBMuEs/rpaJrC/45K5Dcd9gc7fVY8fLmHkNQ2
	 1RAzBHfM70or8iq+TJEIHOu4e1EVk2ils3yTkk13EYaCxE3FNSSP6EiJdjbJR5MX2J
	 eqx7Hb9eEQSVbWspOxQot7V+J6xDfueZlSm/Nuxb+l0oWX+857RfcqpDQmeU3DKX8d
	 vuoEuWMI5IFMlwOUfyp6tMJdZtucxxhZQE75H6GVhUlzCV63+xmdf508EjcPr4wk9O
	 vBC3bn+A/r6kQ==
Date: Thu, 14 May 2026 20:29:22 +0300
From: Matthieu Baerts <matttbe@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
	Gang Yan <yangang@kylinos.cn>, stable@vger.kernel.org
Message-ID: <d9bcbb76-a046-4223-b106-ddd1ab106614@kernel.org>
In-Reply-To: <20260512182925.4b4b9082@kernel.org>
References: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-0-5ee57cb2b7eb@kernel.org> <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-5-5ee57cb2b7eb@kernel.org> <03ad4927-6bde-45c4-a90c-92ecfa0a680f@kernel.org> <20260512182611.7bfbebe5@kernel.org> <20260512182925.4b4b9082@kernel.org>
Subject: Re: [PATCH net 5/5] mptcp: update window_clamp on subflows when
 SO_RCVBUF is set
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d9bcbb76-a046-4223-b106-ddd1ab106614@kernel.org>

Hi Jakub,

13 May 2026 04:29:26 Jakub Kicinski <kuba@kernel.org>:

> On Tue, 12 May 2026 18:26:11 -0700 Jakub Kicinski wrote:
>> On Tue, 12 May 2026 15:02:20 +0200 Matthieu Baerts wrote:
>>> Arf, I missed that when reviewing this patch: the 'inline' keyword
>>> should be dropped here.=C2=A0
>>
>> I'll drop when applying
>
> Let me take that back, IDK why the Fixes tag points to the commit that
> fixes the issue for TCP. I don't think that commit broke MPTCP did it?

Indeed, it doesn't break MPTCP, but it fixes TCP without fixing MPTCP :-P

More seriously, this patch needs to be applied everywhere the TCP fix is.
In the v2, I can add the same Fixes tag as the fix for TCP.

> Also there's a review in netdev's patchwork for patch 2.

Thank you, I missed that one. Nothing to change there, but I can add a
note in the commit message in the v2.

Cheers,
Matt
