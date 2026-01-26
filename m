Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB27252904
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453976; cv=none; b=flhTZmXc+JweePm1D+4UbQrZNW+hTq3Y3EAal7L9Jb3ZRvaG/Dq7ONGomHAg5Rm+Y2ZSCGhzwnKYRDsBDxdb6/1Dm+NBa0II15DftvUfJy3CsDeV9jvdKVn5wXLl9kc70V9WxK9y6OMj2cpJ4PssgBCHI96oaujRI9XL3R4Ud+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453976; c=relaxed/simple;
	bh=t9xDtqAcOHYgoxUL19Vfm00W5jiq6mmyJ3JVXszrZ4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=e0lEr49cNNwQRREnNyhVyn+h6VOxb5K49GiBXr9S4JjZNrBWmFzQ0fQUf0181hMMZZBXf4rv/ycFLlmWzgB/81XADzYTT6J27C3UOZEhZLPpJUCz4d3/rigyD1afXhAcQhbKZhVevfvJ3Cb5wdjmPR7W4r6gRdYcDBkHvwduVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnS6Um9/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnS6Um9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0F0C116C6;
	Mon, 26 Jan 2026 18:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769453976;
	bh=t9xDtqAcOHYgoxUL19Vfm00W5jiq6mmyJ3JVXszrZ4Q=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=JnS6Um9/lbCs3ov9r0cK9xvNH6kUfJAZ0EaD1H1ANF4cW4ayl+IzOzFTIQs+PlqTO
	 HCwYM4Hy8+/IMdAg0iBtfqLcoR3mM0LW2SLfMuPbhkmj/0rrD+lpv3ApAym7irKfUm
	 aKyh2Ul+HJLQI5Yswhe/QxvlJx49ulvFRz/3ZbXGwn969DzhnxIZ6zy0uFP3FnItc7
	 xgJJUONNHCqnpk/3ldUNThbL3XH22BbjKcGEkUSglP1esKra4PKo3j8tIhoo1bUod7
	 KexEP/yXMMV3XemunCPnnF/tB151YQhXacP/jRXmTN9tRMm61HpkOcZA677nRHqkDt
	 WD6C3dhS8kQTw==
Message-ID: <8549f814-a0f2-4858-8308-f13b478548b9@kernel.org>
Date: Mon, 26 Jan 2026 19:59:33 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 07/11] selftests: mptcp: join: userspace: wait
 for new events
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
 <20251226-mptcp-issue-603-v1-7-bb30e331b839@kernel.org>
 <bf6e805ec8310f0814db3b05d51cc78f0bf77a92.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <bf6e805ec8310f0814db3b05d51cc78f0bf77a92.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for the reviews!

On 28/12/2025 03:48, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for this patch.
> 
> On Fri, 2025-12-26 at 07:40 +0100, Matthieu Baerts (NGI0) wrote:
>> Instead of waiting for a random amount of time (1 second), wait for
>> an
>> event to be received on the other side.
>>
>> To do that, when an address is announced (userspace_pm_add_addr), the
>> ANNOUNCED is expected. When a new subflow is created
>> (userspace_pm_add_sf), the SUB_ESTABLISHED event is expected.
>>
>> With this, the tests can finish quicker.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index cf28537b71f7..63a84a4d43a6 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -3717,7 +3717,6 @@ userspace_pm_add_addr()
>>  	tk=$(mptcp_lib_evts_get_info token "$evts")
>>  
>>  	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
>> -	sleep 1
>>  }
>>  
>>  # $1: ns ; $2: id
>> @@ -3748,7 +3747,6 @@ userspace_pm_add_sf()
>>  
>>  	ip netns exec $1 ./pm_nl_ctl csf lip $2 lid $3 \
>>  				rip $da rport $dp token $tk
>> -	sleep 1
>>  }
>>  
>>  # $1: ns ; $2: addr $3: event type
>> @@ -4000,7 +3998,9 @@ userspace_tests()
>>  		local tests_pid=$!
>>  		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
>>  		userspace_pm_add_addr $ns1 10.0.2.1 10
>> +		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 1
>>  		userspace_pm_add_addr $ns1 10.0.3.1 20
>> +		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 2
> 
> This has been changed to wait for 2 seconds. Can it revert to waiting
> for only 1 second like before?

The last parameter (2) is the min expected number of such events. Here,
two ADD_ADDR are expected to be seen on the other host, because
userspace_pm_add_addr has been called twice from ns1.

We could only keep the second "wait_event ANNOUNCED", maybe clearer and
faster?

  userspace_pm_add_addr $ns1 10.0.2.1 10
  userspace_pm_add_addr $ns1 10.0.3.1 20
  wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 2

WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

