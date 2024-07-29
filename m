Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1871EEE4
	for <mptcp@lists.linux.dev>; Mon, 29 Jul 2024 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242247; cv=none; b=m/m9QafOXoDTFnwKRkHkDMUS/NuUW0wAUnXjUDtEcSeGfhzeuBXlQaGcSBf9g3D/alzU4mqBr4/gItPD/1pCLq+5SucpAiejrX+HhxP5NecBdMfPU6lfvuDOkJcDBB7aXrAV41iSnBZPuTOn0iXFOjnqBsMiPDdr2cWIaE0Oeiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242247; c=relaxed/simple;
	bh=d5oHstfXTUkj5BP1POshuI1ENSVpT1oUb9gCtEzlaKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2DwdufPm28P3hbqh0jVTTpHrRATYw3tJWUPeuJfJlfSDf1gCTdAhSTE/0OvysbnchzKcOW5SlENZYDG3GZ2tdHiog2/A3o6drhCdn+XtUbeWHInHUydo39GxRugoYsaU1IOSTYhacNQc3QsraIdgbZ6Ha9O53hl4uZ1G25i37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbRnTYdb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbRnTYdb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6417AC32786;
	Mon, 29 Jul 2024 08:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722242247;
	bh=d5oHstfXTUkj5BP1POshuI1ENSVpT1oUb9gCtEzlaKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WbRnTYdbcOlUaeoGt2lWy5QI+hMDwPwW01JvwlX60+wM5qegTI07NOcv1z1OaNUHR
	 2gtP5gw7NqBT2bHi3MdFymFYwGdpEIKEFjfekgUnwuvMk6xSCXZXeLnP7TSbozFSjE
	 sDHdecXKptXdmvKt165gyrfRgxmJGfQzd4MIqtuPhDbOx2m1zEkq0eQXBMB6+3JjOw
	 NLPaF4ss+sx3COHe59FwuO/PKJNZedo8HNg6haaghzSoYLdMXRX3rrQNF0QxHGQ2le
	 KZX6PGvAcGuO6ZA8woeIbb3JwvT06dO8WAi+RtQVTtaiEr5UedRfzpkIoKlPE6LMPw
	 tRnmRdDO/tOHQ==
Message-ID: <a5007929-9ffd-4bf0-92df-33d327c91368@kernel.org>
Date: Mon, 29 Jul 2024 10:37:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v5 04/13] mptcp: pm: only mark 'subflow' endp as
 available
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
 <20240726-mptcp-pm-avail-v5-4-fb1117ddeef6@kernel.org>
 <6b0f7eff5552b0b0e45813e12f397b71fce54098.camel@kernel.org>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6b0f7eff5552b0b0e45813e12f397b71fce54098.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for the review.

On 29/07/2024 03:09, Geliang Tang wrote:
> Hi Matt,
> 
> On Fri, 2024-07-26 at 16:28 +0200, Matthieu Baerts (NGI0) wrote:
>> Adding the following warning ...
>>
>>   WARN_ON_ONCE(msk->pm.local_addr_used == 0)
>>
>> ... before decrementing the local_addr_used counter helped to find a
>> bug
>> when running the "remove single address" subtest from the
>> mptcp_join.sh
>> selftests.
>>
>> Removing a 'signal' endpoint will trigger the removal of all subflows
>> linked to this endpoint via mptcp_pm_nl_rm_addr_or_subflow() with
>> rm_type == MPTCP_MIB_RMSUBFLOW. This will decrement the
>> local_addr_used
>> counter, which is wrong in this case because this counter is linked
>> to
>> 'subflow' endpoints, and here it is a 'signal' endpoint that is being
>> removed.
>>
>> Now, the counter is decremented, only if the ID is being used outside
>> of mptcp_pm_nl_rm_addr_or_subflow(), only for 'subflow' endpoints,
>> and
>> if the ID is not 0 -- local_addr_used is not taking into account
>> these
>> ones. This marking of the ID as being available, and the decrement is
>> done no matter if a subflow using this ID is currently available,
>> because the subflow could have been closed before.
>>
>> Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in
>> PM")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/pm_netlink.c | 26 +++++++++++++++++---------
>>  1 file changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 8a28fdaf3bb6..3ea417b52ff4 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -833,10 +833,10 @@ static void
>> mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
>>  			if (rm_type == MPTCP_MIB_RMSUBFLOW)
>>  				__MPTCP_INC_STATS(sock_net(sk),
>> rm_type);
>>  		}
>> -		if (rm_type == MPTCP_MIB_RMSUBFLOW)
>> -			__set_bit(rm_id ? rm_id : msk-
>>> mpc_endpoint_id, msk->pm.id_avail_bitmap);
>> -		else if (rm_type == MPTCP_MIB_RMADDR)
>> +
>> +		if (rm_type == MPTCP_MIB_RMADDR)
>>  			__MPTCP_INC_STATS(sock_net(sk), rm_type);
>> +
>>  		if (!removed)
>>  			continue;
>>  
>> @@ -846,8 +846,6 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct
>> mptcp_sock *msk,
>>  		if (rm_type == MPTCP_MIB_RMADDR) {
>>  			msk->pm.add_addr_accepted--;
>>  			WRITE_ONCE(msk->pm.accept_addr, true);
>> -		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
>> -			msk->pm.local_addr_used--;
> 
> 
> Is it necessary to call __mark_subflow_endp_available() here? I'm not
> sure.

No, because mptcp_pm_nl_rm_addr_or_subflow(MPTCP_MIB_RMSUBFLOW) will be
called when removing an endpoint, to delete all linked subflows. That
can be a 'signal' endpoint as well, while 'local_addr_used' is only
linked to 'subflow' endpoint. There are more details about that in the
commit message, but in short, that why I moved this to functions calling
this helper, where there are more info about the endpoint type.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

