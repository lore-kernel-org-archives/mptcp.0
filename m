Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92303C1F
	for <mptcp@lists.linux.dev>; Sun, 12 Jan 2025 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685494; cv=none; b=DQIwyjK16D0q26dh9DWYKCb7mwzE6S0f8ydGHKOgmQoDRTogO73FSKC9dwV7QJNXpDzNM6hus+8PQcgyK4H/YDBjzFM0yItvT6AjT3lVwxnZYAlmhEdbdDKs8uHAoK2MNwCIURTdSwkF3F8Ceod6N5GrViMnzkjTwUfyBii/55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685494; c=relaxed/simple;
	bh=hRUpOe2jdC18GBVPYJQLw7YW+3gwpDCUtT0QftpCOhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=LunNuH5Icf2DJRv9WZLzJQ01DH01DvpIhAcDkueGtG8GeWbauPynmBqiq2bfO8dKZVvicRx3EaakzvUapppUyXus93q5cn+NEjnCbWb1Cb040MZ00l78B4vOuTmdcEu2I95VGSoptlna2nj74wuutBgexyvm5KvVEdpghVaX75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBOalyS/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBOalyS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AF4C4CEDF;
	Sun, 12 Jan 2025 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736685494;
	bh=hRUpOe2jdC18GBVPYJQLw7YW+3gwpDCUtT0QftpCOhQ=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=UBOalyS/dxFBCcoNS9pX090e3oD6S9SV2t1+cCk6ZGaW4Sre1d9M0Q7kwqiMlSPwd
	 L0gwKU3dcbvfMN38zeghZns8I0yE1tXlXrtGH39wePLz5K+KdEvHByPQqT7+fu5uSa
	 2eITSAObWPkvaFqcHTEeOAXv8eIwjQVuRv65iT0LBwT/HkGEcTwUB/t3sUSyXuTTBD
	 eenjvsfG27G4NO903qKe8HzopwN/xFXg7ocor3HtYGyCwCo5Ns34Yqu5T/aIdpP9J1
	 J19bnEg+RajwFJKdgZ2jJrqDtjt3B7RdePBiTF9S8HB0zGjRrC9VDhytLzDvBxHhVB
	 BCKORUjMJ+E2A==
Message-ID: <7c6de0fc-5af3-41f0-8ac1-b4816ab7575d@kernel.org>
Date: Sun, 12 Jan 2025 13:38:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/5] selftests: mptcp: more info in case of
 errors
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>
References: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 08/01/2025 19:40, Matthieu Baerts (NGI0) wrote:
> Here are just a bunch of small improvements:
> 
> - MIB and 'ss -Me' in simult_flows.sh
> - move common code to lib.sh
> - use 'ss' with '-m'
> - remove unused variable
> - show only the size instead of size + filename
> 
> Nothing exiting, but the 3rd one can help investigating some issues like
> https://github.com/multipath-tcp/mptcp_net-next/issues/499

Now in our tree (feat. for net-next) with Geliang's RvB tag (I hope
that's OK),

New patches for t/upstream:
- 5731da7ccbbf: selftests: mptcp: simult_flows: unify errors msgs
- 668a6c97c2b1: selftests: mptcp: sockopt: save nstat infos
- 1cb853be929c: selftests: mptcp: move stats info in case of errors to
lib.sh
- a97277439285: selftests: mptcp: add -m with ss in case of errors
- 70019b947cf7: selftests: mptcp: connect: remove unused variable
- c94beebdce72: selftests: mptcp: connect: better display the files size
- Results: 17aabfa75062..632bb7330ffe (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/3d444e3a3d41f6228c9bcdc5dbf649cc6857c7d3/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

