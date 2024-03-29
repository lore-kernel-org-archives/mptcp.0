Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B2D2577B
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733281; cv=none; b=ehTNtSEJyjjvNUGNSj8ZD/bqlVFmuwSBQF6KuxWzhuwrMI+uHwj7RmekEkA/Rk26M1GLGFL3ZRilbH9BKNwRe/kyFN+LQIFA1aW7dGwaxqjKXnZbrXGuLoYgkZ7eCVvrYTlKNE3XvNlX8b+JoEX0jSKr02KWJ4c92Z2LVMjhbOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733281; c=relaxed/simple;
	bh=nQTMBVM9h3P6SRxuduu9kPwM2tvWrP784jEAFtEhKvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r18RXBDOuCDcAUjnZCIqNoBAXeAHyLzXXbaahAp8JnfX9oAhKBz9l3ZJltFQX8cmwMr9tkn8w/YnOrgB/jw1ZHJVs8A0t6jUPHp8dhZHGdTmAM5+T473fO7q3HSWZzGEZ2JBvQobb9Fm15CieQ1PySnedebxpfHOD106Uza3Vm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DNfsq31B; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DNfsq31B"
Message-ID: <4cb1511c-c623-497f-818e-a4d4614548ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711733277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8PYHc7MlwNpEUgHmQDP0uqH3An6HOXRxolOUYaG+n6U=;
	b=DNfsq31BKgJvFZgJeeXKf1F/Nnko0zkOnUY+XeoX1WUHD7dtDPAKJQSYb3QoaE4qvolM1E
	8yl1/gRJlk9X4wsUyXCz0XkH8dzOneGIQnIdT1t1UQDAGLgsAJNpO7ZI8NDnyO6ztwKSfQ
	jEvEppRZEk8G41WOjJmMsXQDju+1SAs=
Date: Fri, 29 Mar 2024 10:27:47 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Handle EAGAIN in bpf_tcp_ca
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>
Cc: bpf@vger.kernel.org, mptcp@lists.linux.dev,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <78a17486bd12d7afb4cce565d58dac3f15e55c49.1711620349.git.tanggeliang@kylinos.cn>
 <e6074193-7530-4c85-9429-9393e24c172d@linux.dev>
 <59b0295363548c115b65b4555d0f7484738f5bda.camel@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <59b0295363548c115b65b4555d0f7484738f5bda.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/28/24 10:57 PM, Geliang Tang wrote:
> Hi Martin,
> 
> On Thu, 2024-03-28 at 09:55 -0700, Martin KaFai Lau wrote:
>> On 3/28/24 3:23 AM, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> bpf_tcp_ca tests may emit EAGAIN sometimes. In that case, tests
>>> fail with
>>> "bytes != total_bytes" errors. Sending should continue, not break
>>> when
>>> errno is EAGAIN. This patch can make bpf_tcp_ca tests stable.
>>>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>>    tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>>> b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>>> index 077b107130f6..fbc219c2d53b 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
>>> @@ -56,7 +56,7 @@ static void *server(void *arg)
>>>    	while (bytes < total_bytes && !READ_ONCE(stop)) {
>>>    		nr_sent = send(fd, &batch,
>>>    			       MIN(total_bytes - bytes,
>>> sizeof(batch)), 0);
>>> -		if (nr_sent == -1 && errno == EINTR)
>>> +		if (nr_sent == -1 && (errno == EINTR || errno ==
>>> EAGAIN))
>>
>> This is a non blocking socket. EAGAIN is hitting the timeout
>> situation?
>>
>> The default timeout is 3s and it has not been changed after the
>> recent
>> connect_fd_to_fd and start_server simplifications. I don't find bpf
>> CI failing
>> in this test in the last month also.
>>
>> I would prefer to fail after timeout instead of keep retrying. Do you
>> really hit
>> that in your environment for this specific bpf_tcp_ca test? There are
>> many tests
>> using this timeout value also.
> 
> This is the 2nd patch of "refactor mptcp bpf tests" series:
> 
> https://patchwork.kernel.org/project/mptcp/cover/cover.1711688054.git.tanggeliang@kylinos.cn/ >
> I didn't get the mentioned EAGAIN errors in bpf_tcp_ca tests, but got
> them in MPTCP BPF sched tests (see patch 1). MPTCP BPF sched tests (not
> upstream yet) use the same sending and receiving functions as
> bpf_tcp_ca tests (patch 15). So it makes sense to add this fix for
> bpf_tcp_ca tests too.

It sounds like the EAGAIN is specific to mptcp sched test and is not due to a 
timeout? Did you try to increase the timeout and see if it resolves the issue?

afaik, there is no fix needed for the bpf_tcp_ca test. bpf CI expects the test 
to finish. If the default 3s turns out to be too flaky for most tests, it could 
be increased instead of loop testing EAGAIN because the bpf CI expects the test 
to finish. However, so far I don't see this (i.e. 3s is too short) to be the 
case from looking at one month old data in bpf CI.


> And here's another reason. I want to move these functions from
> bpf_tcp_ca into network_helpers as public ones (patch 4), which can be
> used by both bpf_tcp_ca and MPTCP BPF sched tests. So we must add this
> fix to the public ones too.

Lets understand why mptcp sched test hits EAGAIN first.

> 
> Maybe the commit log of this patch needs to be updated. Or I should
> send patches 2, 3 and 4 together to bpf-next?

All selftests/bpf changes have to pass bpf CI. It is always a good idea to 
target bpf-next to kick off the bpf CI to bar any surprise later when it got 
merged into bpf-next.

Unrelated, since we are in the mptcp bpf test, one thing needs to fix in 
test_mptcpify(). The mptcpify test is upgrading a IPPROTO_TCP socket to 
IPPROTO_MPTCP socket. This could break other tests when the test_progs is run in 
parallel (test_progs "-j" which fork() to run prog_tests/* in parallel). It 
could unexpectedly upgrade the tcp socket of another test. One option is to 
limit the upgrade by checking the pid in the mptcpify.c bpf prog.


