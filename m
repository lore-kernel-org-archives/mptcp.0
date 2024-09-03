Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D513E41A
	for <mptcp@lists.linux.dev>; Tue,  3 Sep 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377494; cv=none; b=IG1P++CbE6n82Fw74qFuw18AeZI0tjfMsnQOqAew64J+1EFnB5p2QrAiBs+YbItHfWjL9qaHKQQb72Matb7uO69anUqatHVHMWEQzS5qzj+nhXyzjR+uWCPhQB9XtqlaeqfDYSnv6IMtH1z78+UcMiS5/fuJa5QS0WOiWGESZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377494; c=relaxed/simple;
	bh=zuLonVHxboAtSIY7jn7BjPPvHE4IAffY5HeXdcem7fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=couYzluPX9+0wZlCp4L+4Ty32SfWelXz1skNvRJixDlIEDfv0cHPZ04n99n6yXsYvVqLJWyAQwBE1tZWxTvYTXQXG5WDBy6vnMc/7TU0R0/CxU/t8SV9Fw3dMgC7EhSGdgWUmIREvuaMTdrt5CRtpkDTDAhVl/i0BjYXFxeP8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndJNxewC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndJNxewC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA4DC4CEC4;
	Tue,  3 Sep 2024 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725377493;
	bh=zuLonVHxboAtSIY7jn7BjPPvHE4IAffY5HeXdcem7fg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ndJNxewCtfrOzz192hB3p3A5r/oSQJv41QIGBqpfDMdoTdNavPInK4BSsz+9dABRd
	 nGXBoKBTytsbqNfidnCCo1ulSEJ3UqcTpKKRPtzMkeBxtxESnlMld8LifX9Jd+KpVo
	 AwkiHsjXMFYs5Vl38wW9JIr1nznBcnMXx+8aIGMifXsDy9y4KwtSnp+9+V7Q2NnOB+
	 7f+8EQtH3eowkQGd1II+iWXE/53GJfNMQNAxzqt6iJfVSw8ifj4ZsXNPbZ5N5UWcPf
	 yATdCK5UshACp3Krtxzql/z6xf8IYJhRITJ77ZYErAJ3CSAF9UOG3Agrhkg5zQMHGp
	 waRsnx6WITHDw==
Message-ID: <8f355da2-5667-412b-b3fd-1ce8f7571fa8@kernel.org>
Date: Tue, 3 Sep 2024 17:31:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: mptcpd Usersapce PM
Content-Language: en-GB
To: ROSHITH SEBASTIAN <roshith.sebastian@student.unisi.it>
Cc: mptcp@lists.linux.dev
References: <CAOU6Dw9xnP2ha8Csj47_zQQEHg7_FUrgVRW+CrTon-aPLokKog@mail.gmail.com>
 <45634fda-f0d0-4bc7-99a3-97bb979d0494@kernel.org>
 <CAOU6Dw9doa_aH8bzLmUxQjFrxn3ThHunDKEzXFmdEcE1w+5CmA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAOU6Dw9doa_aH8bzLmUxQjFrxn3ThHunDKEzXFmdEcE1w+5CmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2024 17:21, ROSHITH SEBASTIAN wrote:

(...)

> I am trying to implement userspace PM, because different rules have to
> be set for each suflow based on different conditions (these are still
> being defined). For example, 75% of the data should flow through one
> and the rest through the other subflow based on the delay or the cost
> of the link. The fraction in which the traffic is split might not be
> known beforehand and can vary during simulation.
> So my objective is to divide the traffic unevenly across the links
> based on certain rules.
> Is it possible to accomplish this with a PM or is a custom scheduler
> needed? Although I have seen references to shedulers in previous
> versions, it has not been mentioned in mptcpd.

The PM is in charge of subflows, from creation to deletion, and also
address announcements. From what I understand, you don't need to have
custom rules for that: you just want to create 2 paths using two
different networks, no?

  https://www.mptcp.dev/#path-manager

mptcpd can only control the path-managers.

The packet scheduler is in charge of selecting which available
subflow(s) to use to send the next data packet.

  https://www.mptcp.dev/#packet-scheduler

For the moment, it is not possible to control the packet scheduler. It
might be possible to do that in the future with BPF, the work is in
progress, e.g.

  https://github.com/multipath-tcp/mptcp_net-next/issues/75

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

