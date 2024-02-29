Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433437CF30
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209380; cv=none; b=WBkkvaPlL8DZ/KxGM1Vlo2+8wqf/MO4LZjOSBP0Xu1q7wwzLAMWdd41JWbdgTkMtPaQRaPAeEZga1ZuocXUSYgBte2oUE3wE0G0kja6IXWliTCdd7lTCdpR+uZO8XcioIEolTnpvhMbZi4x3GSJS0PL9Yt3OOB09OFEK+ec229s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209380; c=relaxed/simple;
	bh=CiPry8EzVY2a8Yda6ZroxNbvqG9SySibU7XM3Zp0hEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1XFxyDhjYxKDnMwzkCu8QFsRvhp+gSYWaMUaG3tr/WYS06YKPtpzHRNehwW+P3VxsveWZNU1dJkkCdqbdCaXUe1tVBO0uuvVspZKg5xudflOW5znbuwjIZCqXMD3senxvogiW2TIqq1/8D7cJmKBWhU1OBmNKNasaSRIOxB9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luiOD1jr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luiOD1jr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47854C433F1;
	Thu, 29 Feb 2024 12:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709209379;
	bh=CiPry8EzVY2a8Yda6ZroxNbvqG9SySibU7XM3Zp0hEc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=luiOD1jrJnP9TFEE6HMGI37fD4uuaGzgIBTYMat6dew1zlJJ07xtPPHct0Rmw9l1t
	 c5pfcoJvf9NKzOWqGpXpxGLERLXuMd/L5PNQUtoWLUCBTGKQv+SBnySxR8mkXMBBdn
	 Oscp3BGy/VgXJu35I8pZFy7ZsG0YgCsgqStQwEdXenliNYUCR0rhh3eFg4GKcesROl
	 7hY+w1Px3nCgMWEHXMxtkyHPXi/6bqSyz3smPi0U7D8y1hp60badhiK0hvgIL4pSkN
	 vYl7/DeyLcXBIpooFF8REnPbQSvHsjHK2XjkSJ+ql45GaseLtmTI6T4OdMuN9d2CRe
	 CSVSZ/o72vJ2g==
Message-ID: <ac16a5a7-9eb1-4670-b466-4b5a43ee5455@kernel.org>
Date: Thu, 29 Feb 2024 13:22:57 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v7 2/8] selftests: mptcp: connect: add
 dedicated port counter
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
 <dea8ab3b33e331083ef740bb385bad314dc321db.1709200070.git.tanggeliang@kylinos.cn>
 <fff83de1-97fc-4cd9-ad4c-7c785256bc2b@kernel.org> <ZeB2KFQQjouqrOu9@t480>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ZeB2KFQQjouqrOu9@t480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 13:18, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, Feb 29, 2024 at 12:23:54PM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 29/02/2024 10:51, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> This patch adds a new dedicated counter 'PORT' instead of TEST_COUNT to
>>> increase port numbers in mptcp_connect.sh.
>>>
>>> This can avoid outputting discontinuous test counters.
>>>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>> index 0ca2960c9099..4f40221a86cb 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>> @@ -33,6 +33,7 @@ do_tcp=0
>>>  checksum=false
>>>  filesize=0
>>>  connect_per_transfer=1
>>> +PORT=0
>>
>> Sorry, I forgot to comment on the previous patch: I didn't get why you
>> cannot use TEST_COUNT for the increment?
>>
>> So have here:
>>
>>   PORT=10000
>>
>> (Or 'PORT_BASE', or even 'port_base' like most "global" variables used
>> in this file)
>>
>>>  if [ $tc_loss -eq 100 ];then
>>>  	tc_loss=1%
>>> @@ -314,7 +315,7 @@ do_transfer()
>>>  	local extra_args="$7"
>>>  
>>>  	local port
>>> -	port=$((10000+TEST_COUNT))
>>> +	port=$((10000+PORT++))
>>
>> Here:
>>
>>   port=$((PORT + TEST_COUNT))
> 
> The first time here TEST_COUNT is 2, so all ports begin with 10002, not
> 10000. The values of port are changed.

This then?

   port=$((port_base + TEST_COUNT - 2))

Or port_base=9998, but it looks strange.

> 
> Thanks,
> -Geliang
> 
>>
>>>  	TEST_COUNT=$((TEST_COUNT+1))
>>>  
>>>  	if [ "$rcvbuf" -gt 0 ]; then
>>> @@ -710,7 +711,7 @@ EOF
>>>  
>>>  	echo "INFO: test $msg"
>>>  
>>> -	TEST_COUNT=10000
>>> +	PORT=10000
>>
>> And here:
>>
>>   PORT=20000

Here you can also do something like this:

  port_base=$((port_base + 10000 - TEST_COUNT))

Up to you.

>>
>> So there is only one counter, not 2. Would that not work?
>>
>>>  	local extra_args="-o TRANSPARENT"
>>>  	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
>>>  		    ${connect_addr} ${local_addr} "${extra_args}"
>>
>> Cheers,
>> Matt
>> -- 
>> Sponsored by the NGI0 Core fund.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
