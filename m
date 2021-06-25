Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102FF177
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 09:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=7bhD8
	HOwCRlor/8hh1jng0nsWweUfxmNywHn6AIFdpo=; b=fRtVz8B+mSIcHWolNKpCa
	NkIaCOhRtQgI8CA66UxeWf/vpjFarvpPuRkl+t0TF2NjpdV7IhiAzLmeuQjiDoeJ
	scJMPNogjQWrJzhabeAYewf2ew/+30opHh64jHw6vK1f7LTD3jFyI2z+W9XcRVPE
	uyXD8+Hgp5304QoUxdCa/I=
Received: from [10.8.0.206] (unknown [36.111.140.26])
	by smtp14 (Coremail) with SMTP id EsCowABHSuLhpdVgZ2qcrQ--.56372S2;
	Fri, 25 Jun 2021 17:46:10 +0800 (CST)
Subject: Re: [PATCH mptcp-net v7 4/5] mptcp: avoid processing packet if a
 subflow reset
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: pabeni@redhat.com, mathew.j.martineau@linux.intel.com,
 Geliang Tang <geliangtang@gmail.com>
References: <1624609559-6786-1-git-send-email-wujianguo106@163.com>
 <1624609559-6786-5-git-send-email-wujianguo106@163.com>
 <a3caa434-2e3a-3370-c3d5-466023923436@tessares.net>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <e8085dfd-9151-049e-cc1e-3267236a1b2d@163.com>
Date: Fri, 25 Jun 2021 17:46:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a3caa434-2e3a-3370-c3d5-466023923436@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:EsCowABHSuLhpdVgZ2qcrQ--.56372S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZr4fZF13Gw1kCw4UKw48WFg_yoW8JryDpr
	WUGayUAwsYvF1xtrWUAF48ZryrurZxXrs8J3Z8X3Z2yanxWrsavr1jg3s0gFyrCFn7C3WU
	Xr4xJa95ZFy5KFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jLBM_UUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBSQK8kFaD-Bi7hwAAsq



On 2021/6/25 17:07, Matthieu Baerts wrote:
> Hi Jianguo,
> 
> Thank you for working on that!
> 
> On 25/06/2021 10:25, wujianguo106@163.com wrote:
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> If check_fully_established() causes a subflow reset, it should not
>> continue to process the packet in tcp_data_queue().
>> Add a return value to mptcp_incoming_options(), and return 0 if a
>> subflow has been reset, else return 1.
> 
> A small detail but it looks strange to me to return +1.
> Maybe clearer to return -1 in case of error or return a boolean?
> 

Hi Mat and Geliang,

Based on your comments, I will use boolean type as return value, return false if a subflow has been reset.
Thanks for your review!

> If you decide to return -1, please check for '< 0':
> 
>   if (mptcp_incoming_options(...) < 0) // error: we discard
>       goto discard;
> 
> and not:
> 
>   if (mptcp_incoming_options(...)) // no error but we discard??
>       goto discard;
> 
> (Or replace subflow_is_rst by subflow_is_accepted and return this
> variable but it might be strange to return that if you don't have a DSS,
> etc.)
> 
> But if it is only me who find "strange" to return 0/+1, fine not to
> change but it looks uncommon and maybe a source of misinterpretation :)
> 
> Cheers,
> Matt
> 

