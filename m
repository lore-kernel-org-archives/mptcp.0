Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC073217
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 17:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1670522056; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=EOAVCY0WSM1KJXwcWIlAE5tPu0MjSU4uRL8ooMm7IE+HSFOOd2y+KvNNcJHtFcHAsJNYKqNk4Dubm0JROkKDMvS+PcvNA1qc0pJCmEJuga2BmBaZxLCCfk9CZzJQw86cN75ibiDUeG0Uj3kHI7hyFk2dWNY8SBHh9Q5BbK4v9qE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1670522056; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=DSZZkJ+U0QfV6vZlQL87LQ78n25wI8ep3ZcAhCcMQGo=; 
	b=HWia2MWnPN0pnvmKb5BiHKeti9Jyf/hqbjwQ9Bln3QjRxxi6Doi/UUuMGiRBntlLiUV9VoeShPPFZgmgYrb3JonjMIV5Z6sjg9bt32Jl6pfByhQt9WY01qVtA4LLwIyafOBhWR/4FitRfynRf9aygXk45zb3j7fNtb5e/ne+xI8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670522056;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DSZZkJ+U0QfV6vZlQL87LQ78n25wI8ep3ZcAhCcMQGo=;
	b=bBqvq73+mmM3vruHlRr7Z/Rzuux0TJAzrkfhL4Lg07V4h9hk3l+xBEC9W46XvAXj
	lSRjibiX6NS/H653fYzcD+IBFQ5tZpjt0psVbvymsq+cM11FlWOat9Duyp9JXmVCaya
	Gbqqbt4o6Oo0AQL4IyB8JRb3veK6qBBQZUuDCDsY=
Received: from [10.85.0.2] (185.13.181.2 [185.13.181.2]) by mx.zoho.eu
	with SMTPS id 1670522052711454.12693382843474; Thu, 8 Dec 2022 18:54:12 +0100 (CET)
Message-ID: <4097df42-95ce-e535-429d-502233f484e5@shytyi.net>
Date: Thu, 8 Dec 2022 18:54:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [Weekly meetings] Change day/hour?
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Ossama Othman <ossama.othman@intel.com>,
 Davide Caratti <dcaratti@redhat.com>, Florian Westphal <fw@strlen.de>,
 Benjamin Hesmans <benjamin.hesmans@tessares.net>,
 Christoph Paasch <cpaasch@apple.com>, Geliang Tang <geliang.tang@suse.com>
References: <40149ef8-5ec6-f1de-45c0-038e42245b33@tessares.net>
Content-Language: fr
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <40149ef8-5ec6-f1de-45c0-038e42245b33@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello,


It is okay for me to changing the meeting day to Tuesday.

Thanks.


Dmytro.


On 12/8/2022 6:51 PM, Matthieu Baerts wrote:
> Hello,
>
> At the last meeting, we discussed the idea of re-scheduling the weekly
> meetings we have because some people might not be able to join or prefer
> another moment.
>
> But because we were exceptionally only 3 today because of the feast of
> the Immaculate Conception, we didn't take any decision. Instead, we
> would then like to hear from people who want to participate to know what
> they think about eventually:
>
> - Changing the day to Tuesday?
>    - It might be better to avoid Monday (morning) and Friday (evening).
>    - Wednesday was not OK for today's participants
>
> - Changing the time to have it one hour later?
>    - It means 17:00 UTC (9am PST, 6pm CET, 1am CST)
>    - This is late for people in China but midnight is late anyway
>    - Maybe we can also schedule less frequent meetings at a different
> time (or on request), e.g. morning in Europe, afternoon in China?
>    - (the BPF weekly meetings are on Thursdays at 17:00 UTC)
>
> What would be OK or not OK for you? Tuesday or Thursday, same time or
> one hour later?
>
> Thanks,
> Matt
