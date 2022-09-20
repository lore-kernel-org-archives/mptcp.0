Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB51C34
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 13:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663680784; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZNKzxDU2pFC1InC10X0BJDXFNIztG0SlhIcQ6UaONfIOt3K1ubgaPJ2BrznYMCGRPBafEZRFQhLJxPkf8SJSf1h14xMF4ke6Cnt2xYHGeT5s5W5TlOr11Cmf/oik3muIVFSQ9Q0CYld4ajMbyeOqbY9IkIcnWQuDip0PeWpJzIc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663680784; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=Jrlck7McepSf7BvyWO6zqcfn6iH8g4v6aC/jH4MdI9Y=; 
	b=b2dhytP5m3kZAKx0soSzKqtEUXcY0NO4sWkYnqqf043iscvVhgJ3COvIHfv1C3mwRw2a+IqS9PGV7agzAH3H2XOoWx8tec8XyJYX5XwqfLQEbXjUIqqGDxjVdNCWMovYxWqCMdH1qap3QcBPVbqSPlg2A24z7FU/QewQFLrsx/g=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663680784;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=Jrlck7McepSf7BvyWO6zqcfn6iH8g4v6aC/jH4MdI9Y=;
	b=JxhBPYkIdOQcjdKUjj5n8gB9K1eaG9OmJ1SMETr1ehwkfRL2nugX82Vux34Mbnnk
	sW4+hXvNWP8y1++sG26q/DG4INXNwGa+PLnP5IT2cadl9FmT8ZDPYvnHFd0KjwoLVw6
	/7HP6FjrmOENUM62ar4Gn1wlLeC3rHSG1klYcKzE=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663680781839829.0356537162525; Tue, 20 Sep 2022 15:33:01 +0200 (CEST)
Message-ID: <ed90da1f-141e-e797-e155-1f4b0529f739@shytyi.net>
Date: Tue, 20 Sep 2022 15:33:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v7 05/11] Initiator: add locks() to
 mptcp_sendmsg_fastopen.
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220917222853.2406-1-dmytro@shytyi.net>
 <20220917222853.2406-6-dmytro@shytyi.net>
 <71bf3761af14f71496b297cc31c0cdab047e1aa1.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <71bf3761af14f71496b297cc31c0cdab047e1aa1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello Paolo,

In v8 this is avoided.

Best,
Dmytro

On 9/19/2022 12:46 PM, Paolo Abeni wrote:
> On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
>> Suggestion of @mmartineau : 'add locks' is implemented in this patch
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> This should be likely squashed into patch 3/11. It's better to avoid
> leaving broken code in the middle of the series. Incomplete
> functionalitly would be ok for a mid-series patch, but not corrupting
> the internal sock state.
>
> Cheers,
>
> Paolo
>
