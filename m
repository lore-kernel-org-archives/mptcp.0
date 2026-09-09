Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0270542810
	for <mptcp@lists.linux.dev>; Wed,  9 Sep 2026 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953052; cv=none; b=WU65MsgLgPEx1P+6XC01o8TNUxg7SrDaJlADOvN8BlIfzafkFLc1juigwSdpcGhjJRtY9GDbfNrgMDl/wQILM69ampfxtg5xVRSsppZ9x03U5LexlBJd05p7o27yGVlvElGWw3GUA37w5GvgZ2KTOapSaHvMSW4bu5Zhht+Tbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953052; c=relaxed/simple;
	bh=FdFzuiUwwHO6s7diAVcaAa3hXgEWPQE8Qe3uiKYScas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgwZjJhONO8Wo4O2cd32LsXEbU5A/EbQwnsR0JBcIgo0v5DpdrPaCO6SZjfI/IOaPkIaG6XfGqS+uMVTpRuYFRk4WVvXzIxlWhuNpp3GSzgGghcgzfUmYsEymGh4HTH31laxo3T7cYCzsQghLKDSp16RFLFw5+ahTflWOviSjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdmBHrPh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdmBHrPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8D41F00AC4;
	Wed,  9 Sep 2026 11:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953050;
	bh=ctjDPzzLcTGykPcTT971wXNlr2YPKK+jqKJEgFzmGQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kdmBHrPhsBHJ4Ifji7ZOyAQoTeAR4yY1zzupmsomA+JDMpBtyVKl7qmcLR1GQtk/d
	 AsWDj3FytjsIMb3pc9NN7Nzjyo8W7oecQGyFD8aIOOhv7MXKYxr5pPrigTRFgYuJev
	 Ow6LVUE8s//LfBToViEdwsU34z7AEI2/OmDRNNIRpCFrYPQzMloZ/SOSGDvKBWxBC5
	 xR4ZlqCLJiPjeMXv3av3aWSFCEWqRy3HJE/TCXo5/CIYf3MAS2XKifz3umrTUOOeKV
	 CY46T7c8snLF+j49rsieGJnbs2TqLHkfRxOk++cl84rBWs2XIBz14XEKuP/qThpOls
	 hKUi+Gjnguwug==
Message-ID: <8bda50ef-a62b-4ad4-81c8-ca95d92da57f@kernel.org>
Date: Wed, 9 Sep 2026 13:24:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH mptcp-next v4 0/2] selftests: mptcp: convert iptables to
 nftables
Content-Language: fr
To: Hangbin Liu <hangbin.liu@linux.dev>, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260908-mptcp_nft-v4-0-af0a6120240b@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260908-mptcp_nft-v4-0-af0a6120240b@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hangbin,

On 08/09/2026 13:36, Hangbin Liu wrote:
> iptables has been deprecated for years. The Linux kernel has included
> nftables as the successor to iptables since 2014, and every major
> distribution uses nftables as the default packet filtering framework.
> The iptables command we run on modern systems is actually iptables‑nft,
> a compatibility layer that translates iptables syntax to nftables rules
> behind the scenes.
> 
> There are also some features that can be set easily with nft, while we need
> to convert to BPF code under iptables, such as MPTCP add‑addr and
> remove‑addr suboptions. To make future work easier, convert iptables usage
> in mptcp to nftables.
Thank you for the new version. It looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Now in our tree (I just fixed the indentation after 'if .* nft' lines
not to align the rest of the nft commands with the conditional code):

New patches for t/upstream:
- 23ac116ea2c4: selftests: mptcp: convert iptables to nftables for
mptcp_sockopt.sh
- 0ae33af3f73f: selftests: mptcp: convert iptables to nftables for
mptcp_join.sh
- Results: ca7966735328..2dc29b34b99a (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/b49aa4201a14e200297db9adcde3495e5a778517/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

