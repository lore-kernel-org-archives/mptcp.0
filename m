Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A473671
	for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 06:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=FlfHy
	SB0SDGKzrVT/uKrz1DhKW5hIOoLuuAnoTJqh58=; b=ftvxI067jG9Ljp0J2TFO2
	4U1P1siB1/su7nAi6QiOSRlSARovM0uu0n/vieWrXmX8dXXc8O7uM5OAW/0xPSZj
	bUFPvdC7yRuZGXwj7uolz614zXN/hk7HISCJDpD0Nyx3dBjlA8bbrdEgCobGG4+c
	qyW6s7gsyHaFb78cRU+eEU=
Received: from [10.8.1.202] (unknown [36.111.140.26])
	by smtp7 (Coremail) with SMTP id C8CowACXpWULNNBgncyOjA--.99S2;
	Mon, 21 Jun 2021 14:39:10 +0800 (CST)
Subject: Re: [PATCH v5 0/4] Fix some mptcp syncookie process bugs
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, fw@strlen.de
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
 <74d34b28-f071-2825-af55-d39952959e4@linux.intel.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <d3c1f32b-806a-bf19-d6a2-324b80d4c387@163.com>
Date: Mon, 21 Jun 2021 14:39:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <74d34b28-f071-2825-af55-d39952959e4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:C8CowACXpWULNNBgncyOjA--.99S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1ktr1Uuw4fAw48Jw17trb_yoW8CFy7p3
	9Y9F45Jr4kJas3GF12yw48XryFv34rt3s8XF45K3s5Zr1q9Fn3ArWIqw4jka45Grs3WrW7
	tF47Xa4fX3WUZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jHXdbUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBSQ64kFaD++PP7AAAsB

Hi Mat,

On 2021/6/19 8:26, Mat Martineau wrote:
> On Wed, 16 Jun 2021, wujianguo106@163.com wrote:
> 
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> v4->v5:
>> patch1: no changes
>> patch2: no changes
>> patch3: no changes
>> patch4: add comment
> 
> Hi Jianguo -
> 
> One other thing that's helpful for reviewers on the list is to use the patch prefixes listed at https://github.com/multipath-tcp/mptcp_net-next/wiki/Patch-prefixes
> when emailing patches to mptcp@lists.linux.dev
> 

Thanks for your reminding!

> For example, if these patches are intended for net-next they should be sent with [PATCH mptcp-next] in the subject line, or for the net tree they should have [PATCH mptcp-net]. If you're unsure where the patches belong, please ask!
> 

and this patchset should use [PATCH mptcp-next]?

> Thanks,
> 
> Mat
> 
> 
>>
>> v3->v4:
>> patch1: using seq and sport/dport for hashing, and ignore network headers altogether,
>>        as suggest by Florian
>> patch2: no changes
>> patch3: no changes
>> patch4: no changes
>>
>> v2->v3:
>> patch1: directly use inet6_ehashfn() for IPv6
>> patch2: no changes
>> patch3: no changes
>> patch4: add Fixes tag.
>>
>> v1->v2:
>> patch1: handle ipv6 sockets/addresses,
>>        always use 4-tuple drived hash and never look at skb->hash
>> patch2: no changes
>> patch3: split into 2 patches.
>> patch4: new added.
>>
>> Jianguo Wu (4):
>>  mptcp: fix warning in __skb_flow_dissect() when do syn cookie for
>>    subflow join
>>  mptcp: remove redundant req destruct in subflow_check_req()
>>  mptcp: fix syncookie process if mptcp can not_accept new subflow
>>  mptcp: avoid processing packet if a subflow reset
>>
>> net/mptcp/options.c    |  6 ++++++
>> net/mptcp/subflow.c    | 11 +++--------
>> net/mptcp/syncookies.c | 16 +++++++++++++++-
>> 3 files changed, 24 insertions(+), 9 deletions(-)
>>
>> -- 
>> 1.8.3.1
>>
>>
>>
> 
> -- 
> Mat Martineau
> Intel

