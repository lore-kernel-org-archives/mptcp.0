Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9262C9E
	for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 21:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1642453724; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HAj5rtoEV2FepDOIMVbTT5PiktHDYr/37Td4I0PW35NkYjFnuiScWmyogwHXsCD6lHXCKWGjIgLU7Ho3W0eI6w9VP5COlA2N/aMYQ54osnlweadnVsyJ136RhvuXekhaDgwscHZAfLe5qrayjpkId+B228OcKnrlxe+lt+QijYA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1642453724; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=JC360UWy2adT7OMHTnOoXY+Q0tGPjM5XUwoG9wTfLQg=; 
	b=OVe5l+RKx4nTxKFYcT0V6NBNAhBUbBtEzsreD5jnhIGq6pphui95p+fn05R4HXCEIRiGEbuO0qRxaH73ryE8Sxr0CQ224x05NA5KsTqkujYWthilA40k6gmoKrrqycSAKgbMwWA+Rznym2HOBG26tp4Zc3RJoXkdd7N/w5ybmB8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642453724;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=JC360UWy2adT7OMHTnOoXY+Q0tGPjM5XUwoG9wTfLQg=;
	b=EUn9E6uT6cbcu7KGKAE2e0mnHbjWP7DqRzkRCNRelovfwR8bMk3pvin348pw8yne
	M4zcgHWnMO7QAHOur3HRaXZHzpvL4S1turOrRbSOo3XXRjfWKuW0OvjMaOx+lT+pomi
	v3k5bnuczMIjfwyYbdcUbpkI+ZVCOZ3TuAmowR44=
Received: from [192.168.100.116] (vps-f3afed4e.vps.ovh.net [198.244.151.99]) by mx.zoho.eu
	with SMTPS id 1642453720424553.4346629213071; Mon, 17 Jan 2022 22:08:40 +0100 (CET)
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
References: <20220116001259.203319-1-dmytro@shytyi.net>
 <202201162148.bSZpItDM-lkp@intel.com>
 <5c970a8d-008c-059f-b263-c46ee9f1a29c@shytyi.net>
 <7138d0a4-7118-481b-a88e-5232e9f951ec@tessares.net>
From: Dmytro SHYTYI <dmytro@shytyi.net>
Message-ID: <20283dd8-68ba-e81e-7d31-481588f42342@shytyi.net>
Date: Mon, 17 Jan 2022 21:08:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7138d0a4-7118-481b-a88e-5232e9f951ec@tessares.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello Matthieu,

Thanks for pointing me the Git branch that should be used.
OK, i will add "RFC" next to "PATCH" in the title.

Dmytro.

On 17/01/2022 09:01, Matthieu Baerts wrote:
> Hi Dmytro,
> 
> Thank you for sharing this new version.
> 
> On 16/01/2022 22:24, Dmytro SHYTYI wrote:
>> Hello,
>>
>> I think i fixed this locally but I'm not going to submit a new patch
>> with a correction to avoid CI resource wasting. I wait until major change.
>> If you think it might be interesting to upload a new patch with this
>> minor change, please let me know.
> 
> Up to you. It is fine to submit a new version if you want more feedback
> from the CI. It can also help for the reviews if people can apply the
> patch on top of our "export" branch, please see below.
> 
> Just if you do re-submit, please add "RFC" next to "PATCH" in the title.
> 
> 
>> sk_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
>> | ^~~~~~~~~~~~~~~~~~~
>> | tcp_stream_alloc_skb
>>
>> Also I'm curious as this patch is failed to apply to current master, but
>> I don't know the reason (which conflict do I have?)... ...locally I
>> successfully build this patch against: 5.16.0-rc8 met-next
>> Auto-merging net/mptcp/subflow.cCONFLICT (content): Merge conflict in
>> net/mptcp/subflow.c
>> Auto-merging net/mptcp/sockopt.cCONFLICT (content): Merge conflict in
>> net/mptcp/sockopt.c
> 
> Your patch should be on top of our "export" branch -- or the
> 'for-review' one, same content but a continuous Git history -- from our
> repository on Github.
> 
> https://github.com/multipath-tcp/mptcp_net-next/wiki/Git-Branches
> 
> You can also see on Patchew it was not possible to apply your patch:
> 
> https://patchew.org/MPTCP/20220116001259.203319-1-dmytro@shytyi.net/
> 
> Cheers,
> Matt
> 
