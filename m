Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E8D17E9
	for <mptcp@lists.linux.dev>; Mon,  3 Oct 2022 16:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664815908; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Opax6JQ2JW1fibIloZzbRv8RHFQRPq1u+w86Ro+nVVEsLDYGr1E3CnX7i+h0NpDU+Qb5LvUP/goaTWgyfkRY9ygyO6LPhUf7rcn7royeY/vyqRNTlR8KEFInNsqn2tYn9p2hOsRYIYrbtd65Gt+KvwHl6LcP9DfJIODEc7uQv6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664815908; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=VWxPfUtAm6Ms+4Lm94SOSuXtixFTx+XDQ85vpwXUDEQ=; 
	b=e9TezrDddkkVZiYdSJaRHDOPe8UmsX8qM4gH/fo+FO+3aenbHfOedY5hqb6EJ4eEDYYm7dseOjYeY0yN3yVamr+VAIAGKzfX7KdSLxFJJg2pCw9jhMwv0oFfsheNMsxPwrkFhQMoZaNxQz2v2VAd09WUVVM+UlITW1t3lyigsno=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664815908;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=VWxPfUtAm6Ms+4Lm94SOSuXtixFTx+XDQ85vpwXUDEQ=;
	b=ejnrL9PH+9VAJn36m7N+3tn6ypveHeE5mdidtgLr/VhQSuKce+IUIwdePC3J6+jn
	6/ApTAB6F4G9MxYxLlOW5RPP7U+XxGAkq8Rc6+Br/phjH6HRmcmkpSlbRLXJbRLcCu/
	QkQ7sfSEoLOBjInIfxEc6euaF5Tns5cizJgYzFEo=
Received: from [10.8.0.6] (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1664815904401689.2060673037407; Mon, 3 Oct 2022 18:51:44 +0200 (CEST)
Message-ID: <880ac00c-e38a-0676-6139-3c60a84b19ca@shytyi.net>
Date: Mon, 3 Oct 2022 18:51:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp-next] mptcp: factor out mptcp_connect()
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <ddbb4cae497ea3df00bb82b238fdef63b8924fad.1664812609.git.pabeni@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <ddbb4cae497ea3df00bb82b238fdef63b8924fad.1664812609.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Thank you, Paolo!


I will rebase Fast Open Mechanism patches, after these patches will be 
merged to the tree.


Best,

Dmytro.

On 10/3/2022 5:59 PM, Paolo Abeni wrote:
> not fit the upcoming fastopen implementation.
>
> Refactor such implementation to use the common helper, moving the
> MPTCP-specific bits into mptcp_connect(). Additionally, avoid an
> indirect call to the subflow connect callback.
>
> Note that the fastopen call-path invokes mptcp_connect() while already
> holding the subflow socket lock. Explicitly keep track of such path
> via a new MPTCP-level flag and handle the locking accordingly.
