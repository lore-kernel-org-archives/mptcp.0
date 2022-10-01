Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE21FC1
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 03:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664593275; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=h3O3hIKFyUmEj0dlVfAia4CuQG+iK7kg4JvTUV0XC/NaMoAp5mlZknB+zJevi62jAckI0nLEarkzB1rdTMbNsNUu7ywipgE+tMKP5A1xsj7SwTj4tK0fut+SZffntD+ojUBvioAc7z28gdCz76AWvNa5ojoVQehd3BNmvvqL348=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664593275; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=rZqs8bn2wYc06MWSaTA/BUlB8Xmh0FEpeaJyTvdwTIQ=; 
	b=E77rgOD6+IU0+DaZTVDSVBwXsuEGNniE6aRSH5wraUAcVqSflDCjPtdEynLpVO1zydU5MzVNQ5yt8LunpUAKF+JNVmWLS9FAAqlz72uowZqUXrIa6yynMsNfzVY25PM5PHiNRZU7avyVbVG/N4WUXD8wlD7wDNn4PUewE/JlvBA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664593275;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=rZqs8bn2wYc06MWSaTA/BUlB8Xmh0FEpeaJyTvdwTIQ=;
	b=dXVJGy6oT1CUlPluKYkisTAia62vZhoum03it5DDBR+unLxN2F9bgXdkmXXo01zb
	XE2PJueom+hHmwlowXhr7hoeZfRtF1qxfWN0ZErpBGr74jhNYGtTyzG3M7vkijnU0k7
	sU4phTTimSx4IJ4NiUengO+guwJLUoN/ZTVBmsqA=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664593273835208.98069557379517; Sat, 1 Oct 2022 05:01:13 +0200 (CEST)
Message-ID: <49e45557-5c75-c8a7-4a95-2f40d5d17065@shytyi.net>
Date: Sat, 1 Oct 2022 05:01:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v12 2/7] mptcp: fix retrans., add mptfo
 vars to msk
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220927225341.14165-1-dmytro@shytyi.net>
 <20220927225341.14165-3-dmytro@shytyi.net>
 <b56f6e1787e3532afbb91c97cab97a6e06011f24.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <b56f6e1787e3532afbb91c97cab97a6e06011f24.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello,

On 9/28/2022 11:05 AM, Paolo Abeni wrote:
> On Tue, 2022-09-27 at 22:53 +0000, Dmytro Shytyi wrote:
>> With fastopen in place the first subflow socket is created
>> before the MPC handshake completes, and we need to properly initialize
>> the sequence numbers at MPC ACK reception.
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> Nit picking: I think this patch subj should be changed to something
> alike:
>
> mptcp: implement delayed seq generation for passive fastopen
>
> The main point is that reading the current subject, this looks like a
> bugfix, while instead is adding (a piece of) a new feature.
>
> Thanks,
>
> Paolo
>
Thank you for suggestion. Fixed in v13
