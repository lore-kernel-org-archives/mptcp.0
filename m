Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04517C1
	for <mptcp@lists.linux.dev>; Mon,  3 Oct 2022 10:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664794130; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=fuzzYMn8Er+84sguPbAKgDlSiail6WOfA2ud8mPT1s9pgo5zqDbLolTxU9PhqCYEGTkW5GBarXkg6l7xD8ZcNGGIO3TWnnHYbFQL6ZMQPdWIsQClBFx08HN9JRDf359xd4r5NWUc7+iUIQvfjKwjvE/XTU9pT9Mh8BO1oJ5EU4o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664794130; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=BFbm2ebhYBTa4LiyN+OJtnia4o2M8yeYI2Q5z4pQfGE=; 
	b=VZwKhjuVSHnGBw+Vxu5AmKZ8fXKrs0WPiH/xOUqSCSCnViimJwpyW4LToKcm1My8Kjh4mARYnhvCewnC7E26OGltnxXI30vFqSGsM9PVpfmmT2cHz1/B2Wv3ctdlcVTqJsIBdlcynY/6+Z36BRy9b12QMKf0+vd1QOrUrRPu8yI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664794130;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=BFbm2ebhYBTa4LiyN+OJtnia4o2M8yeYI2Q5z4pQfGE=;
	b=R0uibSZawkEaAVf48kl1CJ72/l4gBFnS6zJNlVi3KaOpdy/gWbHOltOPDuSCfEBr
	EI5Sj8jEacGtJjk4g5nsYdZKGcVHMfa5iSSwQuH4zhDarJ5dr6yt3JyudlvCW2I6TQC
	vGQuSuQutXUbteZWspisalzHGYknSoAYyJzUlP64=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664794128389311.45766313847605; Mon, 3 Oct 2022 12:48:48 +0200 (CEST)
Message-ID: <f3e40efe-df90-1526-c639-09c9cb369b2b@shytyi.net>
Date: Mon, 3 Oct 2022 12:48:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v12 7/7] selftests: mptfo
 initiator/listener
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220927225341.14165-1-dmytro@shytyi.net>
 <20220927225341.14165-8-dmytro@shytyi.net>
 <3ee71fb92a93914ab8c6bacc063731a1870d0a6e.camel@redhat.com>
 <04007982-1066-5099-852e-580de8d3cf9c@shytyi.net>
 <965056bb46f0d3172d5436889b0849c5795caef6.camel@redhat.com>
Content-Language: fr
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <965056bb46f0d3172d5436889b0849c5795caef6.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Thank your for response.

I started looking at self tests.


P.S. Packet drill was also was suggested by Matthieu.

On 10/3/2022 10:31 AM, Paolo Abeni wrote:
> On Sat, 2022-10-01 at 05:03 +0200, Dmytro Shytyi wrote:
>> Thank you for this comment. I keep it in my notebook for the moment. I
>> will come back to tests, when I will see the proper result of Initiator
>> and Listener, if you don't mind?
> Better self-tests will allow you to more easily validates your patches,
> and a complete self-test is required for merging. I suggest to not
> postpone this.
>
> Thanks,
>
> Paolo
>
> p.s. to validate this code, thanks to Mat, there are a few packetdrill
> available:
>
> https://github.com/multipath-tcp/packetdrill/tree/mptcp-net-next/gtests/net/mptcp/fastopen
>
> you just need to remote the '.TODO' suffix.
>
>
