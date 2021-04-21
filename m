Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C071
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 08:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=eE/QN
	fiwIE+RAVaE5ng1Cp3QfNpugVAbD3iHTfMR+Dw=; b=fwxR1g/muBOUPseuHIJNv
	qRraW5M81vadmj6Ry/G1UGywvv7PWPgaXPmsU5UNnKk7yhO6Tz1AnpgSqwsRA3U3
	S37H8WgTRa3BEiiCiuT8rKaLPPi7S3kqW3gVPxTXPt3vKndJocuImEQo0xBvtJNf
	dvNEc5RJ/cQ9uMiAaHdIZ4=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp13 (Coremail) with SMTP id EcCowAC3to6e539gtEtnwg--.25351S2;
	Wed, 21 Apr 2021 16:51:43 +0800 (CST)
Subject: Re: [PATCH] mptcp: using TOKEN_MAX_RETRIES instead of magic number
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>, pabeni@redhat.com
References: <8f1cc82d-a4a1-ef5e-0430-8e3632e378d0@163.com>
 <23678d46-1c6f-268a-a8a9-c63c3d4e5677@tessares.net>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <285a9309-3596-35ca-edc8-f6f72a870d81@163.com>
Date: Wed, 21 Apr 2021 16:51:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <23678d46-1c6f-268a-a8a9-c63c3d4e5677@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:EcCowAC3to6e539gtEtnwg--.25351S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4kXw17CF1kAryrJr17GFg_yoW8JFW8pF
	4qga4Ygr4ftrZrGrySqw1UXrnrWFW3JFnYkrZYqwn2qrs0gr1vqFy8Kw45ua9rWw48KrZa
	qF4UXas8GasFvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bOv3nUUUUU=
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB+Ad7kF2MYmHy3QAAsp



On 2021/4/21 16:23, Matthieu Baerts wrote:
> Hi Jianguo,
> 
> Thank you for the patch!
> 
> On 21/04/2021 09:36, Jianguo Wu wrote:
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> We have macro TOKEN_MAX_RETRIES for the number of token generate retries,
>> so using TOKEN_MAX_RETRIES in subflow_check_req().
>>
>> Fixes: 535fb8152f31 ("mptcp: token: move retry to caller")
>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>> ---
>>  net/mptcp/protocol.h | 2 ++
>>  net/mptcp/subflow.c  | 2 +-
>>  net/mptcp/token.c    | 1 -
>>  3 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index abd8e31..88f1e2b 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -14,6 +14,8 @@
>>
>>  #define MPTCP_SUPPORTED_VERSION	1
>>
>> +#define TOKEN_MAX_RETRIES	4
> 
> Now that this is "exposed" in a header file, probably best to rename it
> to add "MPTCP_" suffix like (most of) the others here.
> 
> Also maybe best to declare it around where the token related functions
> are declared, no? In other words, just before mptcp_token_init().
> 
> Or after the other "#define" we have here but it looks strange to put
> this at before them.
> 

Hi Matt, I will send v2 as your suggestion, Thanks!

> Cheers,
> Matt
> 

