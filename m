Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AF21D0495;
	Wed,  4 Sep 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460607; cv=none; b=MLWbYqkjc9Alo++DYXSzGgRgh8GD0HVLARkyYoK6SmgNTiZrtmyJEkY6nHGb4axQFTgZuGWLrfcxKdckoPh5fj9tFXl/mWuiCeDSA8/1QOKvSCP2wGNPYH/xo76e+9ZRaolyGOBNeqBgy+rLW03aWewHVPRRyBz4ukOGfz2C9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460607; c=relaxed/simple;
	bh=ZSQ+fFTt1Xg6UsfKS3WG55DFQpVJ8iy86NY9IBxeFfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5o8UhANc0fHzAsmmEHIGrpWVFH3daZLxKJ5lKdhyKpMI8sOhuRn8qUuQtSYFUnvNLds++2E2WsL3N8gnqpG1/kcOuCFndRglk4ReePR5HQmVrgD0tiveINlJe473fUX1z3smaPgvBcXumcB/ZIsAkFnfpPTcX2PabgEE2Rw8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nt1e2n4X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nt1e2n4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF808C4CEC2;
	Wed,  4 Sep 2024 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460606;
	bh=ZSQ+fFTt1Xg6UsfKS3WG55DFQpVJ8iy86NY9IBxeFfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nt1e2n4XSwMGITTLWowaujub2IY4B8Md1pWF9bqNPEFnsX3zeu55oIFCnyNDemuPw
	 hZO84OUyhJjKzs1Hkwfuyf18NiZJpv2D8l13BtQMLZNLHpo6HLWtrel+BoOKoN+qAT
	 nFrUnUiBiccluRp6tXmwxo/jCc3vTUtdlg2snH9o=
Date: Wed, 4 Sep 2024 16:36:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: check re-re-adding ID 0
 endp
Message-ID: <2024090439-kiln-sharper-d4a7@gregkh>
References: <2024083056-curable-silencer-80fc@gregkh>
 <20240904111302.4095059-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904111302.4095059-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:13:02PM +0200, Matthieu Baerts (NGI0) wrote:
> commit d397d7246c11ca36c33c932bc36d38e3a79e9aa0 upstream.

Applied
