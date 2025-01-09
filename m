Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE912206A1
	for <mptcp@lists.linux.dev>; Thu,  9 Jan 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436616; cv=none; b=KnV2sHd0Jx1A2QvAkLdn1Swm67GDMSNkteJUCCedi8cZU8vmidiEvFBLJTTMPLY7DK6uE8JsMgg049Ef8GaZ2BhQdUGOfyA1+UWJCviI/facOhMNBF6Zls3RMvnXkPmopu46d6Mjlx/s/jLy0D9tM9Q1LpN2MEjBNHdT2C4gRL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436616; c=relaxed/simple;
	bh=favc8Tgm8F/kOOdtmjog+lqXmBGQjtc0miEdN35hRl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qlcFg9QXi38r9WvdoetI7hcZ4Bya6qxTFnjJRAZQKLOvgG/smn2pptX7p7GTOGTJQNAHqMwNLk9+I6QqvziUuuY5EUaMUMj2u7onh2x60wKKhNLt/JqPKHEM3+bGz6FnjzJNmvYH39RzUpPMP9M9erZdPaWLGdlXgJ7W5x8TxKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqqqxtlB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqqqxtlB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7365C4CED2;
	Thu,  9 Jan 2025 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736436616;
	bh=favc8Tgm8F/kOOdtmjog+lqXmBGQjtc0miEdN35hRl0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=TqqqxtlB0MhTc6pcBkpzgb4Rz9EejYGprXBhvrAMfPwG9Tx+vRG0Y9ykSNbylm1SZ
	 Na6Twn6edqqHxBuEiV7pcmd4ndNc3as4e+Xky3qaI/+vLmfsnig0l4QbuY2cKfYyOT
	 KzfF7bd4HrO1aj88mGWNMh05n1XRDQtc98NSNbND6Yve5xn/3iLLyvpGQTrjBRAuIZ
	 ywC77c+B9zCKK/FnJ6UxNMIeUF0TponAOaICNG1KkXS7AQtDUu19K6ssq4XTzomRsW
	 6iyCv9VgjVR4JKBYVvf/YLE944cskGE2LB4o4W5Mq1mOiF7hUgOrMjty9RklJLvfaz
	 UANEWkPthgIYQ==
Message-ID: <a8575ecc-5602-464b-acf4-2e44d5489066@kernel.org>
Date: Thu, 9 Jan 2025 16:30:13 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/5] selftests: mptcp: move stats info in case
 of errors to lib.sh
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
 <20250108-slft-mptcp-conn-misc-impr-v1-2-bdfbdba48a1f@kernel.org>
 <29b3e04b00e3d1dcaa59f589d43eed7e0c107a96.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <29b3e04b00e3d1dcaa59f589d43eed7e0c107a96.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for your review!

On 09/01/2025 10:24, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for this set.
> 
> On Wed, 2025-01-08 at 19:40 +0100, Matthieu Baerts (NGI0) wrote:
>> A few MPTCP selftests are using the same code to print stats in case
>> of
>> error. This code can then be moved to mptcp_lib.sh.
>>
>> No behaviour changes intended, except to print the error in red and
>> to
>> stderr, like most error messages.

(...)

>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> index
>> 975d4d4c862afff2e685e86dc08a892dbd09d783..50ca64357053b14cd4989e6647d
>> 825337978fdba 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> @@ -107,6 +107,27 @@ mptcp_lib_pr_info() {
>>  	mptcp_lib_print_info "INFO: ${*}"
>>  }
>>  
>> +# $1-2: listener/connector ns ; $3 port ; [ $4-5 listener/connector
>> stat file ]
>> +mptcp_lib_pr_err_stats() {
>> +	local lns="${1}"
>> +	local cns="${2}"
>> +	local port="${3}"
>> +	local lstat="${4:-}"
>> +	local cstat="${5:-}"
> 
> I think it's better to add a separate patch to add
> 
> 	cat /tmp/${listener_ns}.out
> 
> and
> 
> 	cat /tmp/${connector_ns}.out
> 
> in mptcp_sockopt.sh,

mptcp_sockopt.sh currently doesn't have such file. I hesitated to add
them using the content of nstat like in the other ones, but I didn't
really see how it would help to fix issues with socket options. Or do
you have something in mind?

I guess we could add them "just in case", but...

> then we can drop the last two arguments "lstat"
> and "cstat" of this helper.

... sorry, I'm not sure to understand what you meant here. We still want
to print the content of these files if available.


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

