Received: from mail-m9763.mail.163.com (mail-m9763.mail.163.com [123.126.97.63])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E170
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 07:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=TNrvm
	qj6ek0tVATR04bIUH8+oIiqRq7SZX1WOjXEP7k=; b=Gq6Uc02ldmFWW6bvRjHo2
	wdT+ZD/aBy7E1iUkm1s4D8wQzPlbncyiUJBEHmckKXqUnzQbvsyFVJoOpEoxm3v0
	OxknN76mvBZWLhKmX0mlWt1dzz2+4RGtdS8oZbbjn3mv6g090W7n2IWXUpVCwrWF
	JkbZybEEY9CdRLn26T4n8M=
Received: from [10.8.0.166] (unknown [36.111.140.26])
	by smtp9 (Coremail) with SMTP id DcCowAD3_X0EoslgEq+qGg--.1137S2;
	Wed, 16 Jun 2021 15:02:30 +0800 (CST)
Subject: Re: [PATCH v4 4/4] mptcp: avoid processing packet if a subflow reset
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev, pabeni@redhat.com
References: <1623726146-5911-1-git-send-email-wujianguo106@163.com>
 <1623726146-5911-5-git-send-email-wujianguo106@163.com>
 <20210615151924.GD1425@breakpoint.cc>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <3af9aff0-8abf-4f54-f4ac-1b4740a6b5da@163.com>
Date: Wed, 16 Jun 2021 15:02:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210615151924.GD1425@breakpoint.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:DcCowAD3_X0EoslgEq+qGg--.1137S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-SoGDUUUU
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBiB2zkFaD-T9GxwACsi

Hi Florian,

On 2021/6/15 23:19, Florian Westphal wrote:
> wujianguo106@163.com <wujianguo106@163.com> wrote:
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 1aec01686c1a..01a1bf60b187 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -926,6 +926,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>  	return true;
>>  
>>  reset:
>> +	TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
> 
> Magic.  Please at least add a comment here.
> 

Ok, will add a comment, thanks!

