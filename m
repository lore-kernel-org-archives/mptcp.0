Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A61FBA
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 02:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664592623; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HH8SQHciSEalX34u7WQbCRsa0oQtdvxGaB/33iY3RTDJ3HG33XWZZTcEZJt2TFzSV6SnaCl3/98j51X7agQ8TAzOR3GF0SO0kz9wVsXVNGVQWj0wqKoa8cllewvBEvrK0QckU/74BxppojTi4qyD1inqJd8ThT7miW9PRjKeUcc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664592623; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=EL7AiYh3mcFm0jmoXPzhfAe1aRtRBzqq+IekCPLY9wk=; 
	b=fxURKeetczkHh/FRJdCRy5XxKFkb7ZhqkR0L6K6Wyu2COPN9H2V+MaDrXxyh8tt9akHL178n4IlwPFkKmdYclkTlkZES1Uq4ePdQ5cW6/sU51hsi+P3UJ7E3HwheBttHue3yortV1VwzEncvkXbuNHxBsar4eDcEHNvzNOBl/3s=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664592623;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EL7AiYh3mcFm0jmoXPzhfAe1aRtRBzqq+IekCPLY9wk=;
	b=Ty9h9rog/uAvS6wAcZnTgya1TNoolHi/bBeVrp78Pzuw8d03KWW3m+qT/Dz0riTj
	ZgkLaKRnFc19TNJmhd7VQ9ad4HRMfvyJpQDiiY8BVuJUp8DTyOmAAW13jjGAWrvCf4W
	B6RuuMBh6LUUTdiQgMJu8kSbqrjKqz8GDsFdMND8=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664592620796484.1362442527018; Sat, 1 Oct 2022 04:50:20 +0200 (CEST)
Message-ID: <3b2e187c-f775-c97b-0cb2-eb299915e529@shytyi.net>
Date: Sat, 1 Oct 2022 04:50:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v12 4/7] mptcp: sockopt: make
 'tcp_fastopen_connect' generic
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
References: <20220927225341.14165-1-dmytro@shytyi.net>
 <20220927225341.14165-5-dmytro@shytyi.net>
 <c6834954d5e8de9ebbd6281b144abf55b7ce2752.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <c6834954d5e8de9ebbd6281b144abf55b7ce2752.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello,

Rebased on top of Mat patches.

On 9/28/2022 11:26 AM, Paolo Abeni wrote:
> On Tue, 2022-09-27 at 22:53 +0000, Dmytro Shytyi wrote:
>> From: Matthieu Baerts <matthieu.baerts@tessares.net>
>>
>> This is patch provided by Matthieu. As it seems it not yet merged I
>> temprorarly integrated in into my series for compilation.
>> 'https://lore.kernel.org/mptcp/
>> 20220927150306.1552795-1-matthieu.baerts@tessares.net/T/'
>> When it will be merged I will delete it from this set of patches.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> You don't need to include this patch into this series, just rebase the
> series on top of Mat patches.
>
>
> Cheers,
>
> Paolo
>
>
