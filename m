Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F67E
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 03:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664249027; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZL9T6aO8YKIaChAHbIPUdBryvmJDnOHMvUP8FbuB8BMleLyaEIXaclrkkb+Wz2VHmkDF0G66GA+rJpXu3vwU+NHXpvHAIWe/P6c2zjUQyDEjTPB6TgsSL/SUlXAFfRr1dwjCP9NlIs86IT/eX4CmT2l2SBjqOQ5Hoby9iAuQ3qk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664249027; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=0Jcq9FGBKFGv/l2m4eg3iS5s9i2+uVpawzCNiP58f48=; 
	b=Elov3H2OL1hO4mK5JMYA7m83FIPmc2nmBIETB5ticCbj+RBlGrm8UGfj2ZzfjQV5QMhWGgGs62h9RezCZlPEuoP67yzONonTmt0WZPDAt9RxdVHqt5CbPPXbFSPQXjKo+U/OO9yQHEPGCY11IL4Jc3KHYFG7O71ilCLJ7O7HHhs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664249027;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=0Jcq9FGBKFGv/l2m4eg3iS5s9i2+uVpawzCNiP58f48=;
	b=WGX4sXWn8z+qPWY2eIr9K2Ak9afVOQ5X4hu8WvYJXc+3+UN34ESieNrT23GaVrCy
	H0XhWI6N1C+fWG3TDhvHQzYVL8wI5XfmequETU6s6gBZBQxfC5bkJw0O66sHRuNo3OM
	1jKV7jRXmngrAARpVChc8nPADsAY+Fog6HX4rIL0=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 166424896826383.18017110968606; Tue, 27 Sep 2022 05:22:48 +0200 (CEST)
Message-ID: <2775bf12-c6e4-07c7-d620-97136c19479d@shytyi.net>
Date: Tue, 27 Sep 2022 05:22:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v11 0/4] mptcp: Fast Open: Initiator
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220925232601.25252-1-dmytro@shytyi.net>
 <8a9daf89c1df988d86eac05a37c357f1a837d455.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <8a9daf89c1df988d86eac05a37c357f1a837d455.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello Paolo,

I added the patches 4,5,6 from v9 and fixes based on the feedback. Will 
be present in the next version.

On 9/26/2022 4:52 PM, Paolo Abeni wrote:
> On Mon, 2022-09-26 at 01:25 +0200, Dmytro Shytyi wrote:
>> These patches focus on the Initiator side.
>> These patches implement: sendto(..., ..., ..., MSG_FASTOPEN, ..., ...);
>> We would like to credit Paulo Abeni, Mat Martineau, Matthieu Baerts and
>> Benjamin Hesmans for advices and ideas that improved these patches.
>> Without this collaboration this state of work would not be presented.
>>
>> Origins of these patches were in the root of discovery of the
>> possibility to _reuse the TCP FASTOPEN option in the linux
>> upstream MPTCP_ (First commit was sent to the mailing list on 22 OCT
>> 2021: see https://lore.kernel.org/mptcp/
>> 17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net/').
>>
>> Dmytro Shytyi (4):
>>    mptcp: add mptcp_setsockopt_fastopen
>>    mptcp: add mptcp_stream_connect to *.h
>>    mptcp: add mptcp_subflow_conn_sock()
>>    mptcp: reuse tcp_sendmsg_fastopen()
>>
>>   include/net/mptcp.h  |  9 +++++++++
>>   include/net/tcp.h    |  3 +++
>>   net/ipv4/tcp.c       | 21 ++++++++++++++++-----
>>   net/mptcp/Makefile   |  2 +-
>>   net/mptcp/fastopen.c | 37 +++++++++++++++++++++++++++++++++++++
>>   net/mptcp/protocol.c | 35 +++++++++++++++++++++++++++++++----
>>   net/mptcp/protocol.h |  5 +++++
>>   net/mptcp/sockopt.c  |  3 +++
>>   8 files changed, 105 insertions(+), 10 deletions(-)
>>   create mode 100644 net/mptcp/fastopen.c
>>
> Plase, on the next iteration include the rx-path-related patches (e.g.
> patches 4, 5 and 6 from v9, updated with the relevant feedback).
>
> Thanks,
>
> Paolo
>
>
