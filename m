Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20543229
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 11:54:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663847638; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=V06LzBDnolDohO6m4vq5PK7LvOeiZQgNXnHMg+dbJVn/6T1Wn0u6/4WksKtRpUHuHYzVvNQA5tnue6AyfCtiPXpKvP3N9ig65S4gZXhCiDqtxdrXHBt1b5ZsTxmsTGSKajnqnENMuIcoyhMGW3MRcxzp5jfiKUpzOdxRnpQ3xw4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663847638; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=5MWyazHFUYUDDb5qyicotH5+Rnhg1MS49mN9cyr32cU=; 
	b=VLgeNyOetzE1SLq7i5aL/zkrJ0OvH/WH7Sehz2haZEy5lhqp90nl5ApoEFglQ60nNEncH/nuS1d2EZ7ZNQDjlGSEZfs6d5WDpVxw5BlIfK3dABfNDyVfKmytS+GlnLh6t4kKDB87BzaSiHG5DBwW2AAtBmQF7j68NVsiRCCk85Q=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663847638;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=5MWyazHFUYUDDb5qyicotH5+Rnhg1MS49mN9cyr32cU=;
	b=SxXdBEMHn2RSFtsIle7ZVcAJ1+B2tufgsxT8WG0/YQyF7AgGITHozvcRXu7P/8eL
	KfGCwhg3L/oFKok2cdEMoJKp3X9dWE9bGXSjpL251pnLk7Ev4dfF78yHG1I7km6VILI
	+rwcWFEbBGlJEgqaQQuN/wjp//xQqWHjhe0Qh/AQ=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663847599743799.4346153530346; Thu, 22 Sep 2022 13:53:19 +0200 (CEST)
Message-ID: <82db88f2-a32c-f266-1442-b006980958db@shytyi.net>
Date: Thu, 22 Sep 2022 13:53:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v9 4/6] mptcp: fix retrans., add mptfo vars
 to msk
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220921125558.19483-1-dmytro@shytyi.net>
 <20220921125558.19483-5-dmytro@shytyi.net>
 <3f896828c24c388e84c0f7577af3d24b55599e1d.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <3f896828c24c388e84c0f7577af3d24b55599e1d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External


On 9/21/2022 8:02 PM, Paolo Abeni wrote:
> With fastopen in place the first subflow socket is created
> before the MPC handshake completes, and we need to properly initialize
> the sequence numbers at MPC ACK reception.

Thanks.


FIxed locally, will be present in next v10 patch.


Best,

Dmytro

