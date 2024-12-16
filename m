Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9431FF60C
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340952; cv=none; b=Nz1FJdP9FjwstZmPT/yWwb/GNKocBihXLdTpH6oSd6BcDtfN81LSGJzIaPCBXIKa/MHSr2wwauC1LhpYUUJUaKkVHXeIfu+c5DXgojxRXTf+gIsY2SLK1kzyJRXWTHBqI7VzivGtIg7+g8TzCyeaPb22uczv3hm7YAbG/oFxF8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340952; c=relaxed/simple;
	bh=F9tcvxshNVZBGx1/k4zF8pE+OVwDFE44T5MRDwcstUE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZBoHVEGzTF8/9F7xHEK7y1GUXG0mMGmTahA4b5NogyJH/PPBf/9YZWaKBe5NDOycc4RCjADwfCj13ZcTvrFjQfN7pWKokw/Be1Xzye/9rHZcQtZR1NySEylmhtXIOEr0ynKDi0JyM9NMBGDRXmLzgg4zZmFqLguH2osci4WL5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEfAN4GY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEfAN4GY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9380EC4CED0;
	Mon, 16 Dec 2024 09:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734340951;
	bh=F9tcvxshNVZBGx1/k4zF8pE+OVwDFE44T5MRDwcstUE=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=eEfAN4GYtDwWcrAgRYSbKjsDmIozqNMkkA7lWsV9cHiy6qpLovcBMUzmvK/wapn8k
	 QfUox2oOLR76YzJo1VOrCXyqN1IIHSJhxZlFbbtQgKJMl03PwMrO8UvuhyzSm3E48z
	 MxJZXgBtP2lLmK4ifFPyLVVhs6kXxQZackGUFcKADGyxeZyQJ1HTtn39q3zGPqciam
	 Z7WeSz5saTHpilH1eJNn2tWfP8hf8kKzVgvuEVhtEofCLT8wUllqUwiOUUu5EqTBgm
	 O9DoAVybubCRSXcLJKVZMWpFqnkOFboX66mihPrX0fT/VSSP7cFXgOHXRXUsfFNB5E
	 xycaIKMeqAUog==
Message-ID: <8f52bcf88666a0ef05df372d48e0132790aab90f.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] netlink: specs: mptcp: events: missing
 and clearer attr
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 16 Dec 2024 17:22:26 +0800
In-Reply-To: <20241213-mptcp-pm-nl-spec-doc-attr-v1-0-e43165c94e81@kernel.org>
References: 
	<20241213-mptcp-pm-nl-spec-doc-attr-v1-0-e43165c94e81@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this set.

On Fri, 2024-12-13 at 18:55 +0100, Matthieu Baerts (NGI0) wrote:
> Two small fixes for the documentation:
> 
> - The 'server-side' attribute was missing for two events
> 
> - Attributes were written at the beginning, but without explaining
> what
>   they were.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (2):
>       netlink: specs: mptcp: add missing 'server-side' attr
>       netlink: specs: mptcp: clearly mention attributes

I think we should swap the positions of these two patches, first move
these attributes to the end, then add missing 'server-side' attribute.
WDYT?

Thanks,
-Geliang

> 
>  Documentation/netlink/specs/mptcp_pm.yaml | 29 ++++++++++++++++-----
> --------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> ---
> base-commit: abd143d0ceebde7465127242f5eeef1e9ea4e253
> change-id: 20241213-mptcp-pm-nl-spec-doc-attr-663cc79843cf
> 
> Best regards,

