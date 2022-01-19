Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CDB2C80
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 17:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1642613849; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=LgL++dpA2FaMyuauZj/GKkzDi1I3ejFTDREKw6uaTo1f8tLZieBdGvG52rDUM2Cmx3YFB8lHcodnTm07KQtjbxEC85hwxqtQgQUIRJ+znGkxa83Psu44hXyE4u0WurHDGouTJF6a37PZMjRqeyEqDeHtEiT4PDF1+C92vqPEG4Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1642613849; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=9JrvvdYifanSS5ZgIHQvGIpLQA2tUDipFRPjhwvcn5o=; 
	b=Ktku/e/UhM3O3Z3TSuH98GrzxP7uc/rzWnBDiXMPgvrtKRjvgof6su1NDxh3vjbE7IC+VCvEn8pPpvMH5B+eWF4OIFzPGnklFPeVzIDSFJSvALFRt3YHlkIcipf5u2Ty0l6PLSAHt8Tq43Ptvl0mGB9JXXLbfdhAcKlyoNYdA+o=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642613849;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9JrvvdYifanSS5ZgIHQvGIpLQA2tUDipFRPjhwvcn5o=;
	b=QJGq0k3dR18iL7uKYQs+IirlaWsSC89ms0JlVHK1OggXg8QPZvf4zA/llEIlRj3P
	7u/EZwkSer8u6o5Oo0YX3pQNfZZbZHhQYqmkhX0dExyjuDfww7Jqk0s0GXEUbf86AEN
	jua+1cLgaKIYaRwUe0J1/w7OSNszDQQyg3YQsZ5s=
Received: from [192.168.100.116] (vps-f3afed4e.vps.ovh.net [198.244.151.99]) by mx.zoho.eu
	with SMTPS id 1642613848604695.6906048015634; Wed, 19 Jan 2022 18:37:28 +0100 (CET)
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
To: Dan Carpenter <dan.carpenter@oracle.com>, mptcp@lists.linux.dev
References: <202201170247.BMTU5XYy-lkp@intel.com>
From: Dmytro SHYTYI <dmytro@shytyi.net>
Message-ID: <7d9e6fa3-ad23-b098-8f20-9b90e67ab76e@shytyi.net>
Date: Wed, 19 Jan 2022 17:37:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <202201170247.BMTU5XYy-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Dan,


On 18/01/2022 14:28, Dan Carpenter wrote:
> Hi Dmytro,
> 
> url:    https://github.com/0day-ci/linux/commits/Dmytro-SHYTYI/net-mptcp-Fast-Open-Mechanism/20220116-081430
> base:    df0cc57e057f18e44dac8e6c18aba47ab53202f9
> config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220117/202201170247.BMTU5XYy-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> net/ipv4/tcp_input.c:6960 tcp_conn_request() warn: ignoring unreachable code.
> 
> vim +6960 net/ipv4/tcp_input.c
> 
> 9caad864151e52 Eric Dumazet          2016-04-01  6951  		if (want_cookie) {
> 9caad864151e52 Eric Dumazet          2016-04-01  6952  			reqsk_free(req);
> 9caad864151e52 Eric Dumazet          2016-04-01  6953  			return 0;
> 9caad864151e52 Eric Dumazet          2016-04-01  6954  		}
> 1fb6f159fd21c6 Octavian Purdila      2014-06-25  6955  	}
> ca6fb06518836e Eric Dumazet          2015-10-02  6956  	reqsk_put(req);
> 1fb6f159fd21c6 Octavian Purdila      2014-06-25  6957  	return 0;
>                                                          ^^^^^^^^
> 
> 1fb6f159fd21c6 Octavian Purdila      2014-06-25  6958
> 52c7bf82e2e91e Dmytro SHYTYI         2022-01-16  6959  //drop_and_release:
> 1fb6f159fd21c6 Octavian Purdila      2014-06-25 @6960  	dst_release(dst);
>                                                          ^^^^^^^^^^^^^^^^
> Unreachable code.

Indeed. It is going to be fixed in next version of PATCH.

Thanks.

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
