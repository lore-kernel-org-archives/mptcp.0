Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090847F786
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549071; cv=none; b=Z0QkaT+vlE5k44YhrX6BO5rnVQn6PG++Pp6PNWjS98t72McbzT0eywjJSUXRXprMIkdvFh/TBBcWHXLSMYJnaEQJ1AV92G08ov3G98mtRfrF2oSDQ5ASrofv+mvXnLWzLYXVmG7M5/BvhL+kkgKYlQ/9vkzoxO+pLkrRme4d9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549071; c=relaxed/simple;
	bh=waGxua2xApfvPoUayiCDnxHjNzXplmcc9yCIQKnTRTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U49Nzh75749rYjKaXZ7x2OXK0LEmWHsqvIlHClBngkK7itlmeXIvoLNYbFI+25yYTUanWpaeiWLBYjRgbLSXPZ9Ft9yDHqOalFc77sapPPVibIRD6YShXreB20bnaIlKTPkdn74jQgmhBsnYTcKABE22iS+945erHEhgC46mIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB+P+5Gd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB+P+5Gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D211F0155A;
	Wed, 12 Aug 2026 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549056;
	bh=/x6vU+NPcg+wHDtF2NYqCV0oSAtaAAEmryxqzGYtUzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nB+P+5GdBMLYlX450TeXnMKPBbtOQr85TiKX1SIuUvE0M3cUMtTSaohqeYsIorfkp
	 ILonwOVewDgZ+9OTRvAioWLVd2PdldRaIyFhrI9g4pxOrZl7S/a/LBst4VJqtNeJln
	 oZ4lNLnksCCpIYWm7OQcU21sQk8rRUgBOov1PKWoYym+yWrDy21cf43ihHhE9tipFl
	 voOcFslf6psO7fcLg8g4t3Ivh5GnlqxFgcVWYJ2nPXzWHNZlZ4OprKleh+DCqJ2KY2
	 JTA0bhAxc/gPtp00OLHmrDZdPdJwEUUIziHpU3SOwzPiYHOMbXHvqfhL3GFc1zkfvI
	 wtB77taD7p9WA==
Message-ID: <bd156a3c-2ec9-40db-b929-8f40dd9eb0aa@kernel.org>
Date: Wed, 12 Aug 2026 17:37:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 mptcp-next 7/7] mptcp: implemented OoO queue pruning
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1786026372.git.pabeni@redhat.com>
 <be9dcbef291a424fdd54d19fc72f9f28fb239b81.1786026372.git.pabeni@redhat.com>
 <80572775-6e76-4c79-83e2-efdedbd3f3b8@redhat.com>
 <b0d961b3-7a06-4237-92b2-67d8ab2ff28b@kernel.org>
 <a8cf012f365d1885f773d5959829cb42298477bb.camel@kernel.org>
 <eb437699-4e3a-422d-93fa-3efde2985189@kernel.org>
 <b268a8d3-aa21-48e4-a6ea-92e98fa506c0@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b268a8d3-aa21-48e4-a6ea-92e98fa506c0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 12/08/2026 13:28, Paolo Abeni wrote:
> On 8/8/26 6:34 PM, Matthieu Baerts wrote:
>> On 08/08/2026 04:31, Geliang Tang wrote:
>>> It seems you forgot to update this on the export branch.
>>
>> Arf, indeed I did, my bad... good catch!
>>
>> I just fixed it in our tree (and the alignment of the next line), but I
>> will wait for Paolo's feedback to know if he judges that a new version
>> is needed for upstream, or if that can be done in follow-up patches.
> Could you please revert the export branch to match upstream, so I can
> send follow-up patches?
Sorry, I wasn't available this morning, and the auto-sync job failed
because it got confused by the "Can't drop packets for fallback socket
this late, or the stream" chunk introduced in patch 4/7, but dropped in
7/7 :)

Just fixed.


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

