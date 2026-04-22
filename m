Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4F7306D2A
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846758; cv=none; b=MGNVBExEnpA1cEzjrvvSW3vCSEa48AQfCfeQfXC+0wO/P2Uf+J5s3aciFHikfilcSMuWGw3Fwu/2HVktaaHRDglSsF08ju//S0+TOzXBE5Nmh4Nn1pVNSdOQkllosM/M+NiAqdcmbLdmbCSz9m24CjODGMqIHR5tzTHWu2mPAx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846758; c=relaxed/simple;
	bh=eZNEuoARZGfbua23XABSA2qZe8PALF3VGkiSVUxPJkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpvCRl3W/tLllA+xzD+PFaMpw3TIxw/TUEVuJv3L80XdP1xD7NUg/Zr2jDGhmugkZYwlf57Bg7qqMXxvUV/AAU+kb7vwYd3qIp7gS81/hf7oaWodFmGpib50rk3hYAz97Y0/v96HfBzMmML2eAWQpGSfjAdNzrFcXS0aFf3714I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iboG37/3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iboG37/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3C0C19425;
	Wed, 22 Apr 2026 08:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776846757;
	bh=eZNEuoARZGfbua23XABSA2qZe8PALF3VGkiSVUxPJkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iboG37/3V1516NxZCX9g9V0+yUT0sccU+TPFrQYrAqQOnwS/UNhwjfceu0nP5jKjR
	 MWv5GzL9TKWE7IF6AItSvMVDzCtVFoWO0k5EHk7HxiHXLUxrZtJKBlVvpjA7RKw+ny
	 Jh6NO5fzId4UIPZlLikW+CRylI12ezr195oVjMmiSgBZOSqo2QBdCTAx3yLUjhLARu
	 BtYzZPYo/5w3i50MkVBL7zUuNYrNCystqDk3Yu4AkXU5OCe1M3uvH39Rv+cgQu3lmG
	 ma/rzRIhd3ZVGHf/WbUUt1h37EpMWey9L5oG4JWl8uLKlsivJLI2m2Zkr+40L5JS06
	 30TWG0uYgQkKw==
Message-ID: <88df3189-4aa0-41fa-9a58-0d17fb736c87@kernel.org>
Date: Wed, 22 Apr 2026 10:32:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 1/3] mptcp: propagate RECVERR sockopts to
 subflows
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, David Carlier <devnexen@gmail.com>,
 mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20260421223338.52743-1-devnexen@gmail.com>
 <20260421223338.52743-2-devnexen@gmail.com>
 <e5dbdb08-f666-47d6-83b6-c157c7e9036c@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e5dbdb08-f666-47d6-83b6-c157c7e9036c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for the review!

On 22/04/2026 10:05, Paolo Abeni wrote:
> On 4/22/26 12:33 AM, David Carlier wrote:
>> Propagate IP_RECVERR/IP_RECVERR_RFC4884 and
>> IPV6_RECVERR/IPV6_RECVERR_RFC4884 from the MPTCP socket to
>> existing and future subflows.
>>
>> Apply the matching sockopt according to the subflow family so mixed-
>> family subflows stay aligned with the parent socket configuration,
>> including disable-time errqueue purge semantics.

(...)

>> +static int mptcp_setsockopt_v6_recverr(struct mptcp_sock *msk, int optname,
>> +				       sockptr_t optval, unsigned int optlen)
>> +{
>> +	struct mptcp_subflow_context *subflow;
>> +	struct sock *sk = (struct sock *)msk;
>> +	int ret;
>> +
>> +	ret = ipv6_setsockopt(sk, SOL_IPV6, optname, optval, optlen);
>> +	if (ret)
>> +		return ret;
>> +
>> +	lock_sock(sk);
>> +	sockopt_seq_inc(msk);
>> +	mptcp_for_each_subflow(msk, subflow) {
>> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>> +		bool rfc4884 = optname == IPV6_RECVERR_RFC4884;
>> +
>> +		ret = mptcp_subflow_set_recverr(sk, ssk, rfc4884);
> 
> The above looks a bit overcomplicated?!? It looks like you could
> leverage mptcp_setsockopt_all_sf() in  and drop the
> mptcp_subflow_set_recverr() and mptcp_recverr_enabled() helpers.
> 
> @Mattbe: it's not clear to me why mptcp_setsockopt_all_sf() does not
> call sockopt_seq_inc(msk) or sync the setsockopt_seq, possibly an
> unrelated bug?

Oh yes, good catch! And a lock of the sk (msk) before iterating the
subflows, no? Same in __mptcp_setsockopt_set_val()?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

