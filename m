Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7751C34
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 13:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663681012; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Hnszd+csddHAKLNGztSFbvWjE7JOvSGkOg5PedmMeSaZgAIYxhBXLIUicBlA1vve3f7rYcsGtY4K9CDH+kBortcWINb6dWi+wpzFPW32ypEGM7HCKFNnuqAimCRRzvVRCnu89drtpPYmNgi6ctzjbq/hQxPo1mJeeimmqW5spnU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663681012; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=Bs0TeWp6JsJ9JONigN/eTfbmQn+IF7zZPFB3I+h81bU=; 
	b=cyJzHcp5niPLWrHtvySdBXiypOlAchQU3/0Am9EjaAfXNV57gk2S9DIgtZFWhKDLSxsk6zdmxkaVyzsZGy6KI86jiIrWJWSqSDwvCe3o04PoDK1rP2P1peFtCO52pgEN4WVaDj+CueYJMCOEbKgtGOdrkkJydZjrQB1Y5Xy3AAk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663681012;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=Bs0TeWp6JsJ9JONigN/eTfbmQn+IF7zZPFB3I+h81bU=;
	b=D1XuWaAA8vADdCzj8MHU/CqbqOwCi7mvFQ3C7FlB7ciawJ1lofPt70tnaN2l8+RS
	9AWLv31sVSjDwwTsU2wrcUYI/XsyyEgFj7PdU3A+LZQiDHUBJlcjsl052YdEmBpDkyP
	0FRkc49xo5m2bKTcHklaZy5iDLQpOacnRh3mQo0s=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663681010671670.0650574563963; Tue, 20 Sep 2022 15:36:50 +0200 (CEST)
Date: Tue, 20 Sep 2022 15:36:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v7 10/11] mptcp_fastopen_add_skb() helpers
 (skb to msk)
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220917222853.2406-1-dmytro@shytyi.net>
 <20220917222853.2406-11-dmytro@shytyi.net>
 <30a517a1b28201dc53d3008d5903542342df7c4b.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <599aadec-720b-13b2-7db9-667c440959a3@shytyi.net>
In-Reply-To: <30a517a1b28201dc53d3008d5903542342df7c4b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

This is fixed in v8.

We fully reuse the existing linux kernel code.

Best,
Dmytro

On 9/19/2022 4:06 PM, Paolo Abeni wrote:
> On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
>> Set of helpers for mptcp_skb_add(). Some functions are inspired from tcp
>> fastopen.c file. This chain helps to add =E2=80=9Cskb=E2=80=9D to
>> =E2=80=9C&msk->sk_receive_queue=E2=80=9D
>> Example: =E2=80=9Csubflow_v4_conn_request=E2=80=9D->=E2=80=9Dmptcp_conn_=
request=E2=80=9D->
>> =E2=80=9Dmptcp_try_fastopen=E2=80=9D->=E2=80=9Dmptcp_fastopen_create_chi=
ld=E2=80=9D->
>> =E2=80=9Dmptcp_fastopen_add_skb=E2=80=9D
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> I think this hooking is not necessary. Leveraging the existing TFO
> implementation and doing delayed ack_seq initialization, as in Benjamin
> series should suffice.
>
> Thanks,
>
> Paolo
>

