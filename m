Received: from mta0.migadu.com (out-86.mta0.migadu.com [91.218.175.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDAE38CFE8
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610930; cv=none; b=sXV6Onb2/6QMJ2QEmYI8dNY2LqVuYDTkdi8TBjWvJ3eDdGGWRsOzLrYEDHhUT4zFKhFzhWEkwfQ/RrhbvGMcB6i7B5J3rOHSdMyRB9R0JYjOGmVWYfM9rmurmoYQaL+4EN/VBhpQoNk36VilL/ZCudb7Ej1OhETZGYPfsfUZO0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610930; c=relaxed/simple;
	bh=XgDfiOo2ohz8Z4zAUBYlKs1F3o0RfhifAQA/OEjhOfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeLILzSaDM42S9HzfXSaBsfMLRQO31hlJMUmBjxjXeojWImWh1z5Go7QP5D6AUIXqfZqVXrWhEHKNmoFPKAr3nfuzcZsV/9Hx3SXEeJl+T8oE8pm2pKm6GiXO4cxPMJsAavKrc8g82z6h00tfYyFYRZ6XySj4fkqHLTz13BLbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pmev7URj; arc=none smtp.client-ip=91.218.175.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pmev7URj"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=XgDfiOo2ohz8Z4zAUBYlKs1F3o0RfhifAQA/OEjhOfo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786610926; v=1; x=1787215726;
 b=Pmev7URjtESi9zTvvURFxUSp76FT6e7gYitr/UxWpBpEYX/v8YnHkL7CLArDzWmBvc9OSnSw
 5JaOZrIILGb9Wpx60LHYuCCVsgWXSUm8GlxgC8JUIL6/3kNOVZYmf6mNBAGp+OMODxZDC/qmx3P
 un3/JRzmNDkpY8Hmfo7MuMb8=
X-Envelope-To: mptcp@lists.linux.dev
Received: from [192.168.109.30] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 9ea24743117974b0;
	Thu, 13 Aug 2026 08:48:46 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <3f33eda1-f02a-45f2-bd61-bbc0e4fa52dc@linux.dev>
Date: Thu, 13 Aug 2026 16:48:55 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH export v3 4/4] mptcp: fallback to TCP on MP_FAIL with a
 single subflow
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-5-chenguang.zhao@linux.dev>
 <7edf1313-be99-41d8-9f5e-3842b9b6c75b@redhat.com>
Content-Language: en-US
From: Chenguang Zhao <chenguang.zhao@linux.dev>
In-Reply-To: <7edf1313-be99-41d8-9f5e-3842b9b6c75b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/8/12 18:43, Paolo Abeni 写道:
>
> On 8/12/26 7:46 AM, Chenguang Zhao wrote:
>> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>
>> Fall back immediately via mptcp_try_fallback() after accepting MP_FAIL
>> on a single contiguous subflow, as required by RFC8684 §3.7.
>>
>> Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
>> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
>> ---
>>  net/mptcp/pm.c       | 9 ++++++---
>>  net/mptcp/protocol.c | 4 +++-
>>  2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 8c263084db7b..cb85caf1df43 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -876,7 +876,6 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>>  
>>  	pr_debug("fail_seq=%llu\n", fail_seq);
>>  
>> -	/* After accepting the fail, we can't create any other subflows */
>>  	spin_lock_bh(&msk->fallback_lock);
>>  	if (!msk->allow_infinite_fallback) {
>>  		spin_unlock_bh(&msk->fallback_lock);
>> @@ -891,8 +890,6 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>>  		mptcp_subflow_reset(sk);
>>  		return;
>>  	}
>> -
>> -	msk->allow_subflows = false;
>>  	spin_unlock_bh(&msk->fallback_lock);
> At this point another subflow can complete the join, and set
> allow_infinite_fallback = false ...
Agreed. I should not have dropped the allow_subflows = false update
under fallback_lock. Join completion already checks that flag under
the same lock, so clearing it before unlocking is what prevents a

concurrent join from sneaking in.

I plan to keep that assignment, then send the MP_FAIL ACK and call
mptcp_try_fallback(). FALLBACK_DONE still has to come after
tcp_send_ack(), otherwise mptcp_established_options() would drop the
MPTCP options on that ACK.

>>  
>>  	if (!subflow->fail_tout) {
>> @@ -901,6 +898,12 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>>  		subflow->send_mp_fail = 1;
>>  		subflow->send_infinite_map = 1;
>>  		tcp_send_ack(sk);
> ... so the this mp_fail processing will be bogus [1].
>
>> +
>> +		/* RFC8684 §3.7: fallback with a single subflow */
>> +		if (!mptcp_try_fallback(sk, MPTCP_MIB_MPFAILFALLBACK)) {
>> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
>> +			mptcp_subflow_reset(sk);
>> +		}
>>  	} else {
>>  		pr_debug("MP_FAIL response received\n");
>>  		WRITE_ONCE(subflow->fail_tout, 0);
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index f879b1061f2d..519e8d9c3164 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1418,7 +1418,9 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
>>  	mpext->infinite_map = 1;
>>  	mpext->data_len = 0;
>>  
>> -	if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
>> +	if (__mptcp_check_fallback(msk)) {
>> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
>> +	} else if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
>>  		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
>>  		mptcp_subflow_reset(ssk);
>>  		return;
> I don't understand this change. Can we ever enter the
>
> `if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {`
>
> branch? The msk already tried to fallback in
> mptcp_pm_mp_fail_received(). If the fallback was successful, the code
> will enter the `if (__mptcp_check_fallback(msk)) {` branch and not this one.
>
> Otherwise the fallback will fail again (AFAICS nothing resets
> `allow_infinite_fallback` once in become false).
>
> /P
No. After moving the fallback to mptcp_pm_mp_fail_received(), that
failure path in mptcp_update_infinite_map() is not reachable in the
normal case: either FALLBACK_DONE is already set, or the earlier
try_fallback() already failed and reset the subflow.
allow_infinite_fallback is not set back to true on that connection.

try_fallback(INFINITEMAPTX) also cannot be used just to account for
the map: __mptcp_try_fallback() returns true immediately when
fallback is already done and does not increment the MIB.

I would drop that second try_fallback(). Fallback would be counted as
MPFailFallback when MP_FAIL is accepted; InfiniteMapTx would be
incremented when the infinite mapping is actually transmitted later.
