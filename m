Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EBC13AD1D
	for <mptcp@lists.linux.dev>; Tue,  9 Apr 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676025; cv=none; b=Rs5Ke4G/Yw+1GJg/MXmsBBi0CKznGOJqEPJXwFtqH+rHvrdFpGy7dHQr3ZsJfQiuPbpYgsL4IvcUIXD867cvsgu5AQMYJxJH6mQNUT7INcWBClQc4/9c/mHFKZZakEA95VcAgLVDVDTzwU3b+FuG6Dtlb8ERIdhZAIr5/I68AWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676025; c=relaxed/simple;
	bh=Hjce7FwlKRyxdLNbsNpI/SJE8/3vPHP8YEw6Y6W+90o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U9nuNZkiFVwXLm7m5lfgf3CPxMIL3AE394uW/7ABekFWqB5YDO1UwBKnr5Lo6jACU3KIhCWiEMvSyf7vBrFRSWGBYxZPTR4pJLtzWDID9BZv1DoWt5KT4watx9VJRrX3X+jmaNq+WvDuszKScCADlWWI/4Uj/6vVr6WdpBxlAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rROG4XQO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rROG4XQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB05C433A6;
	Tue,  9 Apr 2024 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712676025;
	bh=Hjce7FwlKRyxdLNbsNpI/SJE8/3vPHP8YEw6Y6W+90o=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rROG4XQOzu3gl3CuKR4hlm0fWxGHwo4St7Qi7dlUduxGPm3OIAuYdNJDx6S7xf846
	 c5uxWEoyZ+ygqZz0uCOOldAsqjzIf2HR3qQjLVQuWyQ5X5/DnmnTckoZ41zRAn2JKA
	 SNpuKaZ0IR2p9CwAMIfeTm9StboOjGfr+BillbGzTUQ0gUtLG8w7R/oaOG4kyOVvYg
	 UmS140o0PEzSzd5JLRzJzniPzmWqyL5XJIXm9c0rPWeXQXRS9YSA85Oy9zAmsNaNcP
	 Vj/l5D8N5U03hIEEcS1p/6k5BFqo882PQaFXpo16ZcrR9tZBwqbQCvStxzv1bcf/YE
	 LHqzqpFhNG2bw==
Message-ID: <604bdd6d-3385-45f2-8729-a1633e699af7@kernel.org>
Date: Tue, 9 Apr 2024 17:20:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 2/9] Squash to "selftests/bpf: Add bpf
 scheduler test" 1 verify
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1712544986.git.tanggeliang@kylinos.cn>
 <05269e97e219cc51b59173f05ab3a3b622a3ca1a.1712544986.git.tanggeliang@kylinos.cn>
 <6ced2a3c-42da-4728-a36f-5cedf459dff0@kernel.org>
 <a7ad092db6bdc19ecc7fb911db4bed7101bf39f7.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a7ad092db6bdc19ecc7fb911db4bed7101bf39f7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 09/04/2024 14:42, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2024-04-08 at 21:58 +0200, Matthieu Baerts wrote:
>>> Hi Geliang,
>>>
>>> On 08/04/2024 05:01, Geliang Tang wrote:
>>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>>
>>>>> Add send_data_and_verify helper to avoid duplicated code.
>>>>>
>>>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>>>> ---
>>>>>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 40
>>>>> ++++++++++++++-----
>>>>>  1 file changed, 30 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>>> b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>>> index c29c81239603..5080e680fbe0 100644
>>>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>>> @@ -457,23 +457,44 @@ static int has_bytes_sent(char *addr)
>>>>>   return system(cmd);
>>>>>  }
>>>>>  
>>>>> -static void test_default(void)
>>>>> +static void send_data_and_verify(char *sched, char *addr1,
>>>>> char
>>>>> *addr2)
>>>>>  {
>>>>>   int server_fd, client_fd;
>>>>> - struct nstoken *nstoken;
>>>>>  
>>>>> - nstoken = sched_init("subflow", "default");
>>>>> - if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
>>>>> - goto fail;
>>>>>   server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
>>>>> + if (CHECK(server_fd < 0, sched, "start_mptcp_server: %d\n",
>>>>> errno))
>>>>> + return;
>>>>> +
>>>>>   client_fd = connect_to_fd(server_fd, 0);
>>>>> + if (CHECK(client_fd < 0, sched, "connect_to_fd: %d\n",
>>>>> errno))
>>>>> + goto close_server;
>>>>>  
>>>>> - send_data(server_fd, client_fd, "default");
>>>>> - ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
>>>>> - ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
>>>>> + send_data(server_fd, client_fd, sched);
>>>>> +
>>>>> + if (!strcmp(addr1, "WITH_DATA"))
>>>
>>> Out of curiosity, why did you use strings? Why not using booleans?
>>> (or a
>>> bitmask)
>>>
> 
> Since arguments addr1 and addr2 of macro MPTCP_SCHED_TEST are strings:

They are strings because you asked the preprocessor to convert them as
string ...

> #define MPTCP_SCHED_TEST(sched, addr1, addr2)                   \
> static void test_##sched(void)                                  \
> {                                                               \
> ...
>         send_data_and_verify(#sched, #addr1, #addr2);           \

... here, by using "#addr1" and "#addr2".

Why not simply removing the "#" not to do any conversion?

e.g.

================================= 8< =================================
#include <stdio.h>
#include <stdbool.h>

static void send_data_and_verify(char *sched, bool addr1, bool addr2)
{
	printf("%s: %d %d\n", sched, addr1, addr2);
}

#define MPTCP_SCHED_TEST(sched, addr1, addr2)		\
static void test_##sched(void)				\
{							\
	send_data_and_verify(#sched, addr1, addr2);	\
}

#define WITH_DATA true
MPTCP_SCHED_TEST(first, WITH_DATA, !WITH_DATA);

int main()
{
	test_first();
}
================================= 8< =================================

This prints 'first: 1 0', what you want, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

