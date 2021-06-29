Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F148D177
	for <mptcp@lists.linux.dev>; Tue, 29 Jun 2021 02:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=dyCcl
	j0Alt3VTHiD0CjxfNgwxfSqh1YDqRsBRYRcmtA=; b=HUUq0IfXoXTFfHXgZyGRD
	F3dATwggJXpruqlmPgMV++F+pYx6FBWEbCdUyts/Bo9mTvSrHfdyc+J9IVH8VWDX
	UWInX3ZiX713wTJzTn+6+RnHmUvUE3szVNn5+1locwWTyUzQPg/sCbodp12MYC2n
	q/9fCVLNAPAII8O6CWY8BM=
Received: from [10.8.2.126] (unknown [36.111.140.26])
	by smtp11 (Coremail) with SMTP id D8CowADn6k55i9pgcqLRAg--.28S2;
	Tue, 29 Jun 2021 10:56:22 +0800 (CST)
Subject: Re: [PATCH mptcp-net v8 4/5] mptcp: avoid processing packet if a
 subflow reset
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <1624698998-9029-1-git-send-email-wujianguo106@163.com>
 <1624698998-9029-5-git-send-email-wujianguo106@163.com>
 <CA+WQbwuJ64zQcCnOAwqw9_Mxud6BRJu300sP4pWFOeU7FH8nEA@mail.gmail.com>
 <02fdfd28-812d-0242-e354-9cd629288bcd@tessares.net>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <8d1bd111-4e44-8097-b53d-e3146530068d@163.com>
Date: Tue, 29 Jun 2021 10:54:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <02fdfd28-812d-0242-e354-9cd629288bcd@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:D8CowADn6k55i9pgcqLRAg--.28S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWfCFyftF4kuw1kXw4kXrb_yoW8XF1rpF
	WxtryY9F4FqF93CF17ua1xuF4F9r1rtrn8Ca45K3srAwnxXFy3Ar1ftr4YyFs3Wrs3Kry3
	Kw1xZ3WDXwn7AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jGnmiUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB9xfAkF2MZas-3gAAsO



On 2021/6/29 0:45, Matthieu Baerts wrote:
> Hi Jianguo, Geliang,
> 
> On 28/06/2021 10:35, Geliang Tang wrote:
>> Thank you for this new patch set!
>>
>> There are three checkpatch.pl warnings in this patch set, please fix them.
>> And a minor comment below.
> 
> As pointed out by Paolo on IRC, these modifications are required but
> they are minor. Because it is already your v8 and your first major
> series, we did these small modifications for you ;)
> 
> Note that we didn't change the "goto" just to return "true".
> Also, I didn't add any Acked-by or RvB tags because none were given but
> I can easily add them later if I get any but I guess Mat will send these
> patches later to netdev with his SoB.
> 

Hi Matt,

Thanks for all your work :)

> - 6bb69e9b2123: mptcp: fix warning in __skb_flow_dissect() when do syn
> cookie for subflow join
> 
> - ee4bcc0a7a64: mptcp: remove redundant req destruct in subflow_check_req()
> 
> - f0056198a479: mptcp: fix syncookie process if mptcp can not_accept new
> subflow
> 
> - b65e3f889d44: mptcp: avoid processing packet if a subflow reset
> 
> - fc66a740c7c7: selftests: mptcp: fix case multiple subflows limited by
> server
> 
> - Results: 31aa314277b1..60851d13158d
> 
> Builds and tests are now in progress:
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210628T164431
> https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210628T164431
> 
> Cheers,
> Matt
> 

