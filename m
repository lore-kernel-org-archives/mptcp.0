Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644A27C
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 04:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663733561; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=gY1tN3I+EEIeLq03Q0V5AHuwtb0RqdxtSd7mret4mGhnaSQ/KH/QJJOTRhfEq3yF/8qHBzEc7JUEHJY9wS8Cm7IGgQbvqLBol3+DS7pQesCYUB9ttHiAx42Ven0sefCJCBveFfk46I1ehapaJxl9FghWeFk4wJaXWtXsi9NJFf0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663733561; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=vJl1tphoYtoCLi9JRPLt3FN0OmrFWcR5KVVLVmIyQC4=; 
	b=VaDvntbMSKjiWx+y6HHS3H/g4Fgps2nrUUWciTMdzjD8J/wLZwCM6H5YC4mMokTd5KfJ2Vx2RIJz+pu1UufWoMPALP9Ia1tPsoy6qijSsX8QPAqQ5zNFRAHwA+pFVQ192DQ28WbnLveh+LqVP0TyAiTbIesbFoOR4LHAyCRq9Go=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663733561;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=vJl1tphoYtoCLi9JRPLt3FN0OmrFWcR5KVVLVmIyQC4=;
	b=ME44TuaQG7ZlAe8XqizGZMqRb7pR1zlrPTfR/C4/H0FbLq+1Yia3ad32s5Idy3bo
	y2/AJm/X9Qi5Ixjq6syTp7xr8d6oX+heUNv+CZSLu0Fd4pItmsnKyjn0LVdKt2r60p5
	uzn3iNJpdAaBqwWh4GxbWfa2x5lLMOEKD4zSFEnQ=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663733559725684.0934737487066; Wed, 21 Sep 2022 06:12:39 +0200 (CEST)
Message-ID: <bb03157a-be10-6060-9b42-f93e5ae3e665@shytyi.net>
Date: Wed, 21 Sep 2022 06:12:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v8 5/7] Fix unxpctd val of
 subflow->map_seq(dscrd packet)
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220920125243.2880-1-dmytro@shytyi.net>
 <20220920125243.2880-6-dmytro@shytyi.net>
 <82941fcc7bb1ad0fcb98c56551d7e126a6dcfc20.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <82941fcc7bb1ad0fcb98c56551d7e126a6dcfc20.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

In v9 I dropped the previous patch and keep only this. I propose to have 
a look at v9 when I will submit it.

Thanks,

Dmytro.

On 9/20/2022 6:04 PM, Paolo Abeni wrote:
> On Tue, 2022-09-20 at 14:52 +0200, Dmytro Shytyi wrote:
>> Fix unexpected value of subflow->map_seq (discarded and after
>> retransmitted 2nd packet(1st after TFO)).
> The above is confusing, it looks like the previous patches
> intentionally added a bug that is fixed here. If so it's better re-
> order the series, moving this one early-on.
>
>> We use mptcp_gen_msk_ackseq_fasopen()
>> when we know this is the first chunk of data after TFO.
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   net/mptcp/options.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 8852a13cfe62..8e937a422909 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -1212,6 +1212,11 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>>   			mpext->dsn64 = 1;
>>   			mpext->mpc_map = 1;
>>   			mpext->data_fin = 0;
>> +			
>> +			if (msk->is_mptfo) {
>> +				mptcp_gen_msk_ackseq_fastopen(msk, subflow, mp_opt);
>> +				mpext->data_seq = READ_ONCE(msk->ack_seq);
>> +			}
> With the changes suggested on the next patch the above chunk should not
> be needed.
>
> In any case I think it's better to properly keep msk->ack_seq unchanged
> after that the TFO syn data landed into the msk receive queue, instead
> of resetting it later.
>
> Cheers,
>
> Paolo
>
