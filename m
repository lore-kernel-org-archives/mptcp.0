Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC81FBA
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 03:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664593387; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=UvJZb1yzvu6arSn7eQtnHYdctr0jx/YlLvLOmURAaUyZbsVc6IVWJCW9YUVKEl2Eu4xK15qW4bmB1i5xwwtEnlD1ikQA9CXSst7+xykjo1uK41iFHpeRp6PjCjDFtfrEsbjGDpVOXD2wf7pdmhEABjpaxUKjKt7nQk4dysgn2Qo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664593387; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=xGVJx8dOObOrgwokfjZa611mKPDkyj+u5m/QaXIrDwY=; 
	b=DFNV5hBkXJW0cB6Gv4HyILPJj1In9kT8M74nsyxhR+1iOVLbvk2WbxuqUdD1GAvGYI/alqOP7Lm7shzqDXorz3NMuZSdtXOAu/iQC/UaQYPkqAa2gU74a0bW55vLBtuUkiCXjeatpc1VCELbZGyIcJvWei5Jvfyh23vzj3uygjM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664593387;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=xGVJx8dOObOrgwokfjZa611mKPDkyj+u5m/QaXIrDwY=;
	b=PsXbG2VUx/iP9mGlJ8WJb48TwVvSZg60fayz7u3MeHuSBGmXdEf9bveGObO02b6j
	adkNiCc6HH2GJHXhT3iAaGixd74PyvhE1xYXp6j2QFqGPSPdC2KYlkx97PpzTku/VCD
	+lkPQ2NwXcs4VtAqnp5WiPLkB/Qn5SJPUoxfxMo8=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 166459338658518.19447936025381; Sat, 1 Oct 2022 05:03:06 +0200 (CEST)
Message-ID: <04007982-1066-5099-852e-580de8d3cf9c@shytyi.net>
Date: Sat, 1 Oct 2022 05:03:06 +0200
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
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220927225341.14165-1-dmytro@shytyi.net>
 <20220927225341.14165-8-dmytro@shytyi.net>
 <3ee71fb92a93914ab8c6bacc063731a1870d0a6e.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <3ee71fb92a93914ab8c6bacc063731a1870d0a6e.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello,

Thank you for this comment. I keep it in my notebook for the moment. I 
will come back to tests, when I will see the proper result of Initiator 
and Listener, if you don't mind?

Best,

Dmytro

On 9/28/2022 11:45 AM, Paolo Abeni wrote:
> On Tue, 2022-09-27 at 22:53 +0000, Dmytro Shytyi wrote:
>> MPTFO tests: these are examples of initiator (sendto) and listener,
>> probably are going to be integrated to the mptcp_connect.* selftests
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> This must be integrated into the current self-tests suite:
>
> - update the Makefile to build the helper program
>    (or consider extending the exiting mptcp_connect program instead,
> adding TCP_FASTOPEN support to the '-o' command line option)
> - the script must be
>    * listed in the Makefile TEST_PROGS
>    * fully run the tests, executing the client and server program,
>      collecting the result and showing them in a clear way
>    (or consider adding a new section to the mptcp_join.sh script
> instead, see commit 5ac1d2d6345190907e260daedd980ab3be512cf0 for a
> relevant example. You would need to use mptcp_connect to do this with a
> reasonable amount of changes)
>
> Additionally we need testcases for both sendmsg(MSG_FASTOPEN) and for
> setsockopt(TCP_FASTOPEN), possibly in the positive (fastopen is
> succesful) case and the negative one (switch to plain
> connect/msg_fastopen fails).
>
> /P
>
