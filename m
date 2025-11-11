Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8B347BA7
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828319; cv=none; b=ml0+IJoWyaqrnyjGEAvxln0NRXWtkQGzFwe3gRibzmjx0Zu0k5PeDFB6QzzMPpzl93XE4jXlzt+b2QlKwiBgeinf5SiryfklyxnW1YJj7i8HSoxAJkLawXjUg3zfq00PmaAfmlnqxgRsmwQQCQmy4vqYWcYEtm9hJ2ih5tbpaWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828319; c=relaxed/simple;
	bh=jfnB+KfwIo8Bh9sgHjGi9sMKKDqdjeK7cpER0wZo87c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C93H/t6xTiNDFdd0+V+GoVU1B3OX6D+axrMAivzuOdp2UXyMgYR1IOWXQDPKIdLghRsrs608oiwgfHpEkhxeDl35qbLEP14pY4/OXtbcPr1iOBT0NBZfm9e85C67L8D2iSVye9EKCKtPl4QqXApdVuBjsdoFM1r8YQOhLZBjzy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIHPEQN/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIHPEQN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65472C113D0;
	Tue, 11 Nov 2025 02:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762828319;
	bh=jfnB+KfwIo8Bh9sgHjGi9sMKKDqdjeK7cpER0wZo87c=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=uIHPEQN/N01Fv3f/symbRXIC0pDIJxx7avr/IHLaOs3x80AnLSvYI8b+DzwYRgnq2
	 E34ftB/kwXBqk4KojRQ94+2bOQJtGsEuHWaOTxD71N1bRNhZPlWBQQyqAUK9pvShpK
	 eQBOhL4xswf3zcOrLfafcyRQ8c89sxNW3G/xnVi3rqtzCEtDecXW13greg7SkHfPXS
	 JmXUr3Av6ddq8nxKijghsmxXDs315uBAGi9SmcVIKWpIouC4GnONZ5xj23bWzxNmM1
	 tzqvdm3f8v7QsA1ZB3MC46v6A0mBFTDe0dOMyiUrwl5DEGPLKLBU+akhXSG0RSz+xa
	 WDa941dfDDtqw==
Message-ID: <290d95bf919a3f0dac7c50d934bf6aef0790b597.camel@kernel.org>
Subject: Re: [PATCH v2 mptcp-net 0/2] mptcp: fix duplicate reset
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Tue, 11 Nov 2025 10:31:55 +0800
In-Reply-To: <cover.1762500073.git.pabeni@redhat.com>
References: <cover.1762500073.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Fri, 2025-11-07 at 08:23 +0100, Paolo Abeni wrote:
> The actual fix is in patch 2/2, while patch 1/2 is there just to make
> the change tidy/more easily reviewable.
> ---
> v1 -> v2:
>   - drop FASTCLOSE flag entirely

Apart from a nit in patch 2, this set looks good to me.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Note: As discussed in v1, with this set, "selftests: mptcp: join:
fastclose: drop plain RST" should be reverted.

Thanks,
-Geliang

> 
> Paolo Abeni (2):
>   mptcp: decouple mptcp fastclose from tcp close
>   mptcp: fix duplicate reset on fastclose
> 
>  net/mptcp/protocol.c | 50 ++++++++++++++++++++++++++++--------------
> --
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 

