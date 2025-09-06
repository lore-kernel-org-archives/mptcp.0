Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAFE1A073F
	for <mptcp@lists.linux.dev>; Sat,  6 Sep 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757168345; cv=none; b=HOIikR3xk2qIYEC+CDiaDMCiKW4ibxit2GpAf1Kv60mdyav6dHzcNX/gKbiHw2yvQ4ThQSckf3ThuM5P7hAnzOtLKYee15oYPNMD3Et5EfbhqJZYMJk56E9Q3jr9/5l+l4l8v/mA0TyXxI2fzGj2UgszYAocueBWdT7i/PR8hVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757168345; c=relaxed/simple;
	bh=GUVUgsKv27kBK0BBmbsWM42DRHB3S/0Xjz2Tb9o5aLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cVkyaUg5IYLx9HyBBMPjGpGlmYyuelbLTKvfIaLxP+NehoZflkoTphbRiwkq+plfnQWM///2eiPU27/OPprp0q1PqVLKqL4JrvR0ZbVWJKEXEBwkp2W+aJ5VCT398/PyOmCcvhwbiCx1bhXkq1v4tuhvtyesqT9Q2cGUEnIGdaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsKPp2ZQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsKPp2ZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EC9C4CEE7;
	Sat,  6 Sep 2025 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757168345;
	bh=GUVUgsKv27kBK0BBmbsWM42DRHB3S/0Xjz2Tb9o5aLY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=AsKPp2ZQxfDQO2SdEplT0mwt8ZuJRZXvfPn8BuSeJUs78hoZUYC7zJBcKF7+ZCpKy
	 2Wgv1DnvlOs3bqFTiyfAXyHbERXEerzRtvDCz3sdI0AH5ZLqRomyaAZQK2ekhsNLK5
	 HQeQDGJG5rEIkCUI2/xmyxCLQErzSXgIpZmGA3zCv4THgHv1mHGKF1OVdM7VI0KjLh
	 XMq2TmX/UsxK4hIW7MkLqHneB9P/XgHwk+kQEcunj12WKCm+wgGzwQvA7tmROLNi2G
	 h5LLVruB75896tGYvnuxf63oypM52ZBgLotJul0fTi7CRmny1QWkd+dzW4Srgtniw3
	 NSjRWyGiHN3+A==
Message-ID: <570aca1d-3c15-4b75-a55a-61396a74eaa0@kernel.org>
Date: Sat, 6 Sep 2025 16:19:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 3/7] mptcp: tfo: record 'deny join id0' info
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
 <20250829-mptcp-pm-user-c-flag-v1-3-78b25dda7708@kernel.org>
 <1cdace482b0f833e68c95fad171e4323c1d1925e.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1cdace482b0f833e68c95fad171e4323c1d1925e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 06/09/2025 16:05, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for this fix.
> 
> On Fri, 2025-08-29 at 22:33 +0200, Matthieu Baerts (NGI0) wrote:
>> When TFO is used, the check to see if the 'C' flag (deny join id0)
>> was
>> set was bypassed.
>>
>> This flag can be set when TFO is used, so the check should also be
>> done
>> when TFO is used.
>>
>> Fixes: dfc8d0603033 ("mptcp: implement delayed seq generation for
>> passive fastopen")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/options.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index
>> d47b8a9bc2df2f14645b1b3d3e10fea1b38567b1..cf531f2d815cdfbc772b837def6
>> e7d558e64d558 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -985,14 +985,14 @@ static bool check_fully_established(struct
>> mptcp_sock *msk, struct sock *ssk,
>>  		return false;
>>  	}
>>  
>> -	if (mp_opt->deny_join_id0)
>> -		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
>> -
>>  	if (unlikely(!READ_ONCE(msk->pm.server_side)))
>>  		/* DO-NOT-MERGE: use WARN i/o pr_warn: only for
>> MPTCP export */
>>  		WARN_ONCE(1, "bogus mpc option on established client
>> sk");
>>  
>>  set_fully_established:
>> +	if (mp_opt->deny_join_id0)
>> +		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
>> +
> 
> This set_fully_established label is not only jumped to during TFO but
> also in several other scenarios. I think maybe instead of relocating
> the deny_join_id0 check code after this label, we should add a new
> label before the deny_join_id0 check and jump to the new label only in
> the case of TFO.

I don't think that's needed: if I'm not mistaken, the only other
scenario is when a 4th ACK is received. In this case, deny_join_id0 will
not be set.

I don't think we need to add another branch: it is then fine to add this
extra check in the slow path. No?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

