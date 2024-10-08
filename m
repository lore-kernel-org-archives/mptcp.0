Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAE1684A4
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380545; cv=none; b=H/ssUP96i3aSbAjKC6SweC1WQpbginHXNfj2fDGt2DuDy6A3iMfplpacz85GMWFqHKypmZZ2tC0kg+wq4mk9fJWwIa0PO5RkJojjN1tRL3aIgfYXG9O18zl1dnNCViQ0hOpBGInjjDv1d5F23lKoiF8HdPi/HbCp6IrrnBY6kEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380545; c=relaxed/simple;
	bh=CmN6GPKduiUZdyBMnOqiifgeKtyUXcKu2ZIsvS9uvM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=uHziCHu5YQUt/4Lt+VqNP8dFRJ16NGYS6nE2mA/qiRaQFO1QikfFqIboKkhmCvpoJ0mq6EynkpTM1Ux3EQC8QoNsHu5mZIwmXzJH5rdQ/HIVF6ldQNUkNVKj6PQc9kkGbW0RvzE0R7a/ulvMJvgrNkHjEMP2ZlYDeVbzrRsw4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIFmvWb4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIFmvWb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B66C4CEC7;
	Tue,  8 Oct 2024 09:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728380544;
	bh=CmN6GPKduiUZdyBMnOqiifgeKtyUXcKu2ZIsvS9uvM4=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=lIFmvWb4i8BFYRAwB00Soeoj+1ADJuha9PU7cVo0LfvL0bprVowDJJ//ad9VImNcK
	 3omkqLFf3xWYygf19wRzEVwzHEauA2PY3w3MKQEAcFsbZtTMzJo/w4FOY2dYY9PLI5
	 bvYazPsrjhIp7mE2Pn4PzRfvasEjm1BXyfPa3O72CUEzjit9dIxNyL5h9SONGjVnlJ
	 nvenanM9pyYbYMS3bveRSo3/8e92xlYjOhU+g9g7EItSgWNFV60UemHrxiIe+NWGEZ
	 F1jqwoM/pm+KPw7PypuTirFJIsH/tlnHjgrNKUDnjoiUdpLeMhcqd7OGrDy4smxkBj
	 qvesrPLJWHkmg==
Message-ID: <2cf1db4f-bb8c-4674-b31e-1bd6217301a7@kernel.org>
Date: Tue, 8 Oct 2024 11:42:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: add test-case
 for MPC attempt towards signl ep
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <20241007-mpc-hs-port-v2-0-0c9e7827bd0f@kernel.org>
 <20241007-mpc-hs-port-v2-2-0c9e7827bd0f@kernel.org>
 <dcf6cbb3-7521-4969-88d9-7f98c1afe292@redhat.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <dcf6cbb3-7521-4969-88d9-7f98c1afe292@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

(I guess you dropped the MPTCP ML from Cc by mistake, re-adding it)

On 08/10/2024 08:47, Paolo Abeni wrote:
> On 10/7/24 20:22, Matthieu Baerts (NGI0) wrote:
>> From: Paolo Abeni <pabeni@redhat.com>
>>
>> Explicitly verify that MPC connection attempts towards a port-based
>> signal endpoint fail with a reset.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Please put your co-dev tag above.

Sure, thank you, I can add that when applying the patch.

> [...]
>> @@ -895,32 +933,16 @@ do_transfer()
>>       local srv_proto="$4"
>>       local connect_addr="$5"
>>   -    local port=$((10000 + MPTCP_LIB_TEST_COUNTER - 1))
>> -    local cappid
>>       local FAILING_LINKS=${FAILING_LINKS:-""}
>>       local fastclose=${fastclose:-""}
>>       local speed=${speed:-"fast"}
>> +    local port
>> +    port=$(get_port)
> 
> At this point I would respect the reverse xmas tree order ;)

:)

Yes, probably best to move 'local port' above. Just to fix a
non-interesting warning from shellcheck.

> @@ -2963,6 +3008,25 @@ add_addr_ports_tests()
>>           chk_join_nr 2 2 2
>>           chk_add_nr 2 2 2
>>       fi
>> +
>> +    if reset "port-based signal endpoint must not accept mpc"; then
>> +        local port ret count
>> +        port=$(get_port)
>> +
>> +        cond_start_capture ${ns1}
>> +
>> +        pm_nl_add_endpoint ${ns1} 10.0.2.1 flags signal port ${port}
>> +        mptcp_lib_wait_local_port_listen ${ns1} ${port}
>> +
>> +        timeout 1 ip netns exec ${ns2} \
>> +            ./mptcp_connect -t ${timeout_poll} -p $port -s MPTCP
>> 10.0.2.1 >/dev/null 2>&1
>> +        ret=$?
>> +
>> +        cond_stop_capture
>> +        cat "$capout"
> 
> Perhaps worthy to move cat "$capout" into cond_stop_capture()

I should have mentioned that in the changelog: I wanted to, but then it
would change the behaviour for the other cases in do_transfer() where
'cat "$capout"' is used in 3 different places. I can suggest a patch for
net-next, not to add more complexity in this patch if that's OK.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

