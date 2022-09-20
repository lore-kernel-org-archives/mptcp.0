Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04F1C14
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 13:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663680587; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ipLo9Az3iVuZHi88qyCX/AdcSEHq7vb8u6bbLRY/E8WCLmxIajeYTyyNJ/hKO/5ysStjSOS4lcnKurLzSTRHHJYaKN32oURFgk3Y9JANGkuYmJI1F7iZaXWfTVn9RdohNlYisxwuv10eceZpc1Zk2096U28X1W6K94gRTAb7LNA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663680587; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=h3c3gMy3iY7IMFzwnZOouJhHBSTi4Us2R7p0bp8Qn5E=; 
	b=ag3lsDb7Mf4c4cxOXIUmbkqhjhg0FrqnxA7ujhMRxl7+wQAIBuaAnYxXoCvIPuwRl5xuqWXEzYiEZDx4KDoaXS/RQQd9p7iU7tgGnRgJrhnvqbw/c6Hpl8cy7emqFMeJtJ72AJgURrgLia+Feik2v4q+s4+kc/poLutog+hmblA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663680587;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=h3c3gMy3iY7IMFzwnZOouJhHBSTi4Us2R7p0bp8Qn5E=;
	b=PJ1v6bjrdnXnYC+D/+BKYuuhkFkqvdGZyDPo5QKeihiIRv/Gvu9eyySH8ZPWLIna
	8PYEp5hCnO7h2A/CeciB2dS73XvjxMpX8W0u1+7ESslpPh17pOs8xbArfuQvd2528fu
	TTBnvTw69xEwXDjEoc1p71fOghyMli4+ApodmvlU=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663680585754896.6741233675374; Tue, 20 Sep 2022 15:29:45 +0200 (CEST)
Message-ID: <feff145e-6234-dba6-3e0c-6b8a2f292e21@shytyi.net>
Date: Tue, 20 Sep 2022 15:29:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v7 01/11] Add separate fastopen.c file.
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220917222853.2406-1-dmytro@shytyi.net>
 <20220917222853.2406-2-dmytro@shytyi.net>
 <5a7fe64e44c689a4cdc8c9f12895b06d5736d7f4.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <5a7fe64e44c689a4cdc8c9f12895b06d5736d7f4.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello,

It is done in v8.

Thanks,

Dmytro

On 9/19/2022 12:21 PM, Paolo Abeni wrote:
> On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
>> Add separate *.c file. Function prototypes are coming to protocol.h
>> (Suggestion of @palbeni (JUN 17))
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> It's probaly better to squash this patch in 3/11, so fastopen.c will
> not be a completelly empty skelethon.
>
> Thanks,
>
> Paolo
>
