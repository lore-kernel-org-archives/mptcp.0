Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37C2D9EF3
	for <mptcp@lists.linux.dev>; Wed, 18 Feb 2026 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771418620; cv=none; b=GF7etl3lYleJUwT57aVz3PC4HUXzeCyfoI2bBYEnHOWa8+fMXuv37zDa1YOtBC7N23WzEmBH+uM4Qv2M2ftSOTPGoa8wL4qg3DnPEhP8DHTLJkKh4wDz5Xcc0sniFhwO2MVF/l38yrfX2eB2tuZMI75npHOFImX4K4c8UVqdKOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771418620; c=relaxed/simple;
	bh=soyCwoBZeLjFBw4oPPcQYdz0vqXiUsh+8UCGczPU1Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GpBIKnf41bP93puhIMG4Xiu9HEHDJJEGWp05vkSP7HXz1cTHhDn5z4CesgSlbrgIR388kZHLPYul4N/viPDr5msjxft5ZlReRhTpj4LjnzF77ywHhe1ILenWIdI38/jeUa0OHGKIfKa3BhoQzA6WCPz2PXl00N3NBCG3ZFAm8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLfdZLeK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLfdZLeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A288AC19421;
	Wed, 18 Feb 2026 12:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771418620;
	bh=soyCwoBZeLjFBw4oPPcQYdz0vqXiUsh+8UCGczPU1Z0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qLfdZLeKW/OOZaAQlQKmJ9kag9j94walyvzBcAzmDiy/goqKxyOmPbCp4ns1fln9d
	 evXvVN7EjTo+brXUhuWCwP07oo99xOZIfh1KUkDWbjq8mxN3F1DH7BqpKwBacmHFvL
	 ZWRpoK+ZzdOrWRQDEFHK3nDfd69/Jy3L5RcMmOCTPGt5i+2KBWC6WIi0NdGctaH1cU
	 GFE2h29CukTL3xxqtPjjZh9LzrNHm4yco0uwpguNroIuZs/CNTcIYmeNf2zD0MfHdy
	 GUQu1IoXix3ADtDZIjNGUboOxog9P2JOQTauzjJHW7CdBRwuL7jkke6N3DjQGpFbSk
	 d0L+sMo9yYSnw==
Message-ID: <033cc315-9ac6-4b65-ba2c-a58779a39e20@kernel.org>
Date: Wed, 18 Feb 2026 13:43:37 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] selftests: mptcp: more stable simult_flows
 tests
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <ec938f018aed693c624c7a61366b28c863a1d56d.1771276854.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ec938f018aed693c624c7a61366b28c863a1d56d.1771276854.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 16/02/2026 22:20, Paolo Abeni wrote:
> By default, the netem qdisc can keep up to 1000 packets under its belly
> to deal with the configured rate and delay. The simult flows test-case
> simulates very low speed links, to avoid problems due to slow CPUs and
> the TCP stack tend to transmit at a slightly higher rate than the
> (virtual) link constraints.
> 
> All the above causes a relatively large amount of packets being enqueued
> in the netem qdiscs - the longer the transfer, the longer the queue -
> producing increasingly high TCP RTT samples and consequently increasingly
> larger receive buffer size due to DRS.
> 
> When the receive buffer size becomes considerably larger than the needed
> size, the tests results can flake, i.e. because minimal inaccuracy in the
> pacing rate can lead to a single subflow usage towards the end of the
> connection for a considerable amount of data.
> 
> Address the issue explicitly setting netem limits suitable for the
> configured link speeds and unflake all the affected tests.

Now in our tree:

New patches for t/upstream-net and t/upstream:
- d4a47ee7f8da: selftests: mptcp: more stable simult_flows tests
- Results: cf97a02cb523..656b5899eb47 (export-net)
- Results: 40e2b2255e42..683fca3ca9ae (export)

New patches for t/upstream:
- 86c0019571dc: tg: revert 'mark some simult flows tests as flaky'
- Results: 683fca3ca9ae..eb01783b4b05 (export)


Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/ea2e74b9a2b44abc3e5e102cb25cf415b3eb3727/checks
- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/abb26bf620660fa96804166f9452ad49d6b14c18/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

