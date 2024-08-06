Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09215F3EC
	for <mptcp@lists.linux.dev>; Tue,  6 Aug 2024 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930193; cv=none; b=n0Ss9N6mlXT+KVGKBtWX+4c0fvU+oYEh93mV2QHAL+wdSeeT2fqGUuZ23y9AhEPX2FfwZYGjoqyOm+R2GVaYwJOc1ERi3233kC4HWGaSL5vcncfDPZPTjam3uVXwrNQGh0U3iR1mGJGNRRfwBCacVXQgaojcSpssbWcQ0EoMA5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930193; c=relaxed/simple;
	bh=+deQU/+B1AjRrv11XvuT0gsy2OgIy3SbbiTfKh0NFVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rc1qqXpcgAanukByzV5akOZB8v43v9eXU6HfcCluRAIsYpOVhTWo1Zf0RjsQgCuw09ckHtMkbtxRBSLnMjqJr+4kcOfXdwNzXfSaDVDnmQSWmGc8vfv17gyQ5rEC0CFf5YhC9cl+2GvyvU4IDyLIUp2hMl5QC7Aber5XeIB+dNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzEBzaDu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzEBzaDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C0CC32786;
	Tue,  6 Aug 2024 07:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722930192;
	bh=+deQU/+B1AjRrv11XvuT0gsy2OgIy3SbbiTfKh0NFVo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=LzEBzaDu0za96wcAuaCWA869Cb/KVJruNnZpE2vyjsCc1MPCoHt5N3MdiORzVmXQj
	 RcsNe3+cxKTWSoNMOSAV8l70EPWxhz+piwUQ65QYUVHTtKyZnJbZNZE4xnJpapni3R
	 KWEfC6TZl1oaR/pxh+OEmNo1Tjlfe6MoBEjdntC8k4TzhZWuiuW6AHg00irtgQlVhZ
	 B60zMq2E5SPIR2tJo0fmg3SKLrto0dMOLMcZ1++5kL/SRv2rqZCA3MtwBDxa25Hp6r
	 Zov0LAEsHRhhXhH4hoOTwP5040GzY1NIZ+FurBnAVKB7VfIwXgrCp8fOs2RTvzXe5v
	 eMv7P19YAGvew==
Message-ID: <bad8a740-93b0-415f-a343-2768dbc8efd0@kernel.org>
Date: Tue, 6 Aug 2024 09:43:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 2/2] selftests: mptcp: join: validate MPJ
 SYN TX MIB counters
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org>
 <20240729-mptcp-join-tx-mib-v2-2-8ace70fd407a@kernel.org>
 <54fe0a426f00ad7c6d4b2c639da7bb5925b408f7.camel@kernel.org>
 <9a05b63f-5f09-4a46-9c41-5d9c0a0d5318@kernel.org>
 <8494622fb0378abf6f83964f72bb752f57dc0292.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8494622fb0378abf6f83964f72bb752f57dc0292.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 01/08/2024 03:36, Geliang Tang wrote:
> Hi Matt,
> 
> On Wed, 2024-07-31 at 17:02 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for the review!
>>
>> On 31/07/2024 04:59, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> Thanks for these patches.
>>>
>>> On Mon, 2024-07-29 at 12:18 +0200, Matthieu Baerts (NGI0) wrote:
>>>> A few new MIB counters have been added. They are being validated
>>>> here.
>>>>
>>>> Most of the time, there are no errors, but sometimes, more MPJ
>>>> SYN
>>>> are
>>>> queued compared to the numbers that are received.
>>>>
>>>> Only one test has an error, the one to connect to a broadcast IP
>>>> address.
>>>>
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 63
>>>> +++++++++++++++++++++++++
>>>>  1 file changed, 63 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> index fbb0174145ad..c1f1ebd2340c 100755
>>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> @@ -1372,6 +1372,66 @@ chk_join_nr()
>>>>  	fi
>>>>  }
>>>>  
>>>> +chk_join_tx_nr()
>>>> +{
>>>> +	local syn_nr=$1
>>>> +	local festab=$2
>>>> +	local create=$3
>>>> +	local bind=$4
>>>> +	local connect=$5
>>>> +	local count
>>>> +
>>>> +	print_check "syn TX"
>>>> +	count=$(mptcp_lib_get_counter ${ns2}
>>>> "MPTcpExtMPJoinSynTx")
>>>> +	if [ -z "$count" ]; then
>>>> +		print_skip
>>>> +	elif [ "$count" != "$syn_nr" ]; then
>>>> +		fail_test "got $count JOIN[s] syn TX expected
>>>> $syn_nr"
>>>> +	else
>>>> +		print_ok
>>>> +	fi
>>>
>>> Do you think it is necessary to check MPTcpExtMPJoinSynTx in
>>> chk_join_nr()?
>>
>> I thought about that, then I realised some tests were sending more
>> MP_JOIN than the received ones (e.g. when using "invalid addresses").
>> We
>> would then need to change the default counters, but chk_join_nr() can
>> already optionally check the checksum, making it difficult to read
>> when
>> we have to pass 14 parameters:
>>
>>   chk_join_nr 1 1 1 0 0 0 0 0 0 2 0 0 0 1
>>
>> It looks simpler with a dedicated helper, and checking this only in
>> some
>> places. WDYT?
> 
> We can handle this like "addr_nr_ns1". In chk_join_nr(), the default
> value of this "syn_tx_nr" is the same as "syn_nr". If we need a
> specific value, we can pass it to run_tests() through a "syn_tx_nr"
> variable:
> 
> 	syn_tx_nr=1 \
> 		run_tests $ns1 $ns2 10.0.1.1

Yes, I can. But if we do that, we might want to reduce the number of
checks being displayed, not to display 5 more lines per test.

Maybe we can have two "Join [RT]x: OK" in case of success, and a detail
of the failures if not? I can look at that.

>>>> +
>>>> +	print_check "syn TX Fully Estab Error"
>>>> +	count=$(mptcp_lib_get_counter ${ns2}
>>>> "MPTcpExtMPJoinSynTxFEstabErr")
>>>> +	if [ -z "$count" ]; then
>>>> +		print_skip
>>>> +	elif [ "$count" != "$festab" ]; then
>>>> +		fail_test "got $count JOIN[s] syn TX Fully Estab
>>>> Error expected $festab"
>>>> +	else
>>>> +		print_ok
>>>> +	fi
>>>> +
>>>> +	print_check "syn TX Create Socket Error"
>>>> +	count=$(mptcp_lib_get_counter ${ns2}
>>>> "MPTcpExtMPJoinSynTxCreatSkErr")
>>>> +	if [ -z "$count" ]; then
>>>> +		print_skip
>>>> +	elif [ "$count" != "$create" ]; then
>>>> +		fail_test "got $count JOIN[s] syn TX Create
>>>> Socket
>>>> Error expected $create"
>>>> +	else
>>>> +		print_ok
>>>> +	fi
>>>
>>> There is no test that can trigger MPTcpExtMPJoinSynTxFEstabErr and
>>> MPTcpExtMPJoinSynTxCreatSkErr. Does this mean that there is no need
>>> to
>>> add these two MIBs? Maybe adding pr_debug logs is enough? WDYT?
>>
>> MPTcpExtMPJoinSynTxFEstabErr can be easily triggered by the userspace
>> PM. Maybe we don't need the counter for this case then? We could also
>> do
>> the check in the userspace PM side, and return a netlink message
>> instead, but I don't think it is needed. Not sure what's best here. I
>> can remove it or leave it.
> 
> If so I think it's better to remove it, since too many MIBs are added
> in this function.

For this one, it looks like only the userspace PM can cause it, and the
userspace daemon will get feedback in this case. So OK for me to remove it.

>> For MPTcpExtMPJoinSynTxCreatSkErr, it can be triggered if it cannot
>> allocate memory, if the socket limit has been reached out, if a
>> security
>> module blocked it, etc. I think we should keep it, and we don't need
>> to
>> validate it in the tests.
> 
> These errors are not related to MPTCP protocol. I think we can remove
> this MIB but keep its pr_debug log. WDYT?

I think we should keep it, otherwise it will be difficult to debug this
issue if we don't cover all cases. The other ones should mainly be due
to a wrong config from the user, but theyu could also fail due to
security restrictions. The pr_debug()'s don't work for everybody, they
require CONFIG_DEBUG=y or CONFIG_DYNAMIC_DEBUG=y, or a specific build
per file, etc.

In other words, it sounds safer to me to keep this one to cover all
cases. Otherwise, we might struggle during to help users, and ending up
asking the users to compile a modified kernel.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

