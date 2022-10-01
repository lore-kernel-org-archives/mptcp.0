Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25901FBA
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 02:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664592582; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HtAtyKaIiR8RFOcPomcB99bNl/Tj0NS1qMFf/NrT/VsMvu33E+cLD8eS87ieKAYIzpRIJPSJZ2mzavZ7cwBUbiZwXMX6xMv0PFYIhszubtobdtQdFn5rW4sTZ/Z1wKsDgvxqhnCvIeR3ctfK1gj86ZGMOFSlBjfZKBTs2/yq8H8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664592582; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=+mkDNN+lyT6nzTTSK8/fhZurezXab2gVirxXERDFltM=; 
	b=CjWvjfkEkA7KjDy4d1/+GsWL80msldj1GD0ryq4HXO/Hbn/jpa4CUCwRR4qgetf43IYFctKNeXTi+FilA9pMhZlUH5yWckUsLWV+2ZNhuqfpUc5rW3OAWjpX0WH5yikxgkJ5U6krRjkgqnp6gsXkDY7CaEqgLbIAo05cJUGzBh4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664592582;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=+mkDNN+lyT6nzTTSK8/fhZurezXab2gVirxXERDFltM=;
	b=QdqFCeHtqKY/m8f7TrggvEqneqHL3aMD22A0+PwH+K0c4B8N4PzvuECr/I6/sOgp
	dAxfXJPHXsWdOVoPB+AWGSDxozh3oYr3wMi69+5Sli/iFmXsVG9/DIQqG64Hal+BV1d
	IAkjxKpTujRNIW1LadY8w+GQ5RFgxMAeGwNQinJE=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664592580869315.41407144439324; Sat, 1 Oct 2022 04:49:40 +0200 (CEST)
Message-ID: <1507b32c-0d2e-a26c-2d83-e64582117549@shytyi.net>
Date: Sat, 1 Oct 2022 04:49:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v12 6/7] mptcp: add TCP_FASTOPEN option
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220927225341.14165-1-dmytro@shytyi.net>
 <20220927225341.14165-7-dmytro@shytyi.net>
 <5777f26811d8cb04da21512763907702a421bf5c.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <5777f26811d8cb04da21512763907702a421bf5c.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello,

Updated in v13.

Dmytro

On 9/28/2022 11:28 AM, Paolo Abeni wrote:
> On Tue, 2022-09-27 at 22:53 +0000, Dmytro Shytyi wrote:
>> We add the TCP_FASTOPEN socket option in this patch that is going to
>>   be set by the listener side.
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   net/mptcp/sockopt.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>> index 1857281a0dd5..ab3ba8558efd 100644
>> --- a/net/mptcp/sockopt.c
>> +++ b/net/mptcp/sockopt.c
>> @@ -559,6 +559,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
>>   		case TCP_NOTSENT_LOWAT:
>>   		case TCP_TX_DELAY:
>>   		case TCP_INQ:
>> +		case TCP_FASTOPEN:
>>   		case TCP_FASTOPEN_CONNECT:
>>   		case TCP_FASTOPEN_NO_COOKIE:
>>   			return true;
> You should additionally update the comment below that describe
> TCP_FASTOPEN as not supported.
>
> /P
>
>
