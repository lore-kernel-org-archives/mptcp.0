Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F31D416E
	for <mptcp@lists.linux.dev>; Thu,  8 May 2025 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746670513; cv=none; b=rFPZPSfiv0qyOoefIDpl68pag/Bo1v8hDM3vCBgnxF3jfiBg0XmbgLDaRFj7w0KdJ5cWJ7vR5+D+gImSH4Pzd4wQ2VS07iiIaFMQqkJeBE2T8GIu5iwMiM+EdqHPcch+6E5yOCpPYeKgcxNRPRaUuTyJv8nRTd5InFl6DAZdJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746670513; c=relaxed/simple;
	bh=Xe71o3NwB4Jh0TFWAYLmp8xOREtAMxdCI+4weerDoiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5oKrtaQsIGXmMbCYF5JeRmkh3HnpTviFjRr7uDNNv4MQL5pWZWX6jCjOA74+t3b49e0IGOCGGY6+TDvQqFpTXZ1YOj9QgsK1inHBJEJNhEcVgDHdWmj/KyliT+GObDe2Z+LlAR6E4h8Z35DzZzEvo+0wIjHZxKXoMwUejeAUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuYTTzcd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuYTTzcd"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227d6b530d8so5363325ad.3
        for <mptcp@lists.linux.dev>; Wed, 07 May 2025 19:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746670511; x=1747275311; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkADO5RX5LKak5ParSAdhE3hkIpyJGjVDD86j8FGyjI=;
        b=NuYTTzcdvgGDQip93tumemr1mExzLdhi3p582fL3kMY4ifvf2IKqS/pQdu7VUhR7fU
         7DT21sl5kXjz+eo9yR2f1jqAJ9Dzg4VsRwIvQISJryhSjuU9nf8y+cLeL/amw80a2j9Z
         pfsOaUs6D0rmzzVvcEJMjTozDF0l14bgpWj8eNe8FRHUPr2h3CxgcqLwtMiGpoxLQ7i7
         1kLGjFLWLjhAS1mZZzCt7nxi7z27U3RiD6mB93R+PynnSHkLovUkdzxvHw1tiIhQCuMv
         yH6sh8R2De+/Zvgd0wW/6LNfKZvo3tg6f8ro2LMlVro3F10jR5OBx91AUSVB/LcSVJYQ
         mbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746670511; x=1747275311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkADO5RX5LKak5ParSAdhE3hkIpyJGjVDD86j8FGyjI=;
        b=pTHw4TLqT5G90xoi+zlnjAF1miDLO9Yh/xSVzMv5zUzDfaiwyRWMBNakEWru5IGELT
         ilsFWFoWNF/eqOdYQH8JJ//sEyXwYU+989l1tldz6Msl+i1Gj+E3c24uc9zBhtUZnp9s
         h5gaJc8jz99woZ3FninoUY3frtwDWdlDFYR5e1jXnSRiMQk7nT5QIi+piQmltbNXVE7a
         KTeYAypgocHylZ3O1GJrnDQNb/mTu7vQkAZ7TvY/1yYVOtHMd3Q4Do5Ot+zyOBkR8/+N
         4v6NCV9U9HePp9gb/z+ZQ7Xk2TZouDxckC2JQKxy8ktkSzw19S5mucJ9WayFdZRQvNHQ
         bogA==
X-Forwarded-Encrypted: i=1; AJvYcCWdTVcPvtvYx2LFEqngVVUMZxTzbJ3siMU7EB4qcSslti9YZAvJOJ6DUzGuYIe7TPK0AFp+kA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaUJinEzycnA4Ttj4W1kuB5y4LNRSoufVLAPe0Mr4G5YP0kPUC
	UzgVJBB6y6UrggR/2xF00TmGkWtV3VFlvy0ovBws4XLHN8gG03V6
X-Gm-Gg: ASbGncudPjCyO/RU4fZltlHxcVS0/KBY6qxBpK4rOXDWTIluYRB62ohpflulm4veeCX
	HFmL97498x+zViAEM48ZtkRFzeb4J711/1rsu4j9w85OkylV77jzq0GzvfeJ3mRGjebqm9m0h33
	yW6CZP2BgK7jXP/GWsUGtsM8DZDL4LmqgsJH3TetWMyF5+2RuX90tzuFR8YDDGsutq7WU4V9sux
	TWwkcD5h9O+a9JIw16PBe2puCJkU8vScO6PTEzhKpb2KWY53EUPYpihMC2xtaSuSWQyLEw7w8x7
	SW3LG9ctYUwQIZ/mZQhdPxakDwV3+NFArTrHBNTXswo90wzCRAyDZJvB
X-Google-Smtp-Source: AGHT+IF/g58dTcMUT9OqqraHwKir4gOqXcqsH7utlmYFK5Z6ygF7IDHvIjdM+rEucmwSxjt46URo7A==
X-Received: by 2002:a17:903:2ec3:b0:224:910:23f6 with SMTP id d9443c01a7336-22e5ee17734mr76937385ad.45.1746670511089;
        Wed, 07 May 2025 19:15:11 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fa7bsm102582835ad.141.2025.05.07.19.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 19:15:10 -0700 (PDT)
Date: Thu, 8 May 2025 02:15:01 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH net-next 4/6] selftests: net: use setup_ns for SRv6 tests
 and remove rp_filter configuration
Message-ID: <aBwTpWOovuXghcRd@fedora>
References: <20250507131856.78393-1-liuhangbin@gmail.com>
 <20250507131856.78393-5-liuhangbin@gmail.com>
 <20250507163904.0cf86c59@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507163904.0cf86c59@kernel.org>

On Wed, May 07, 2025 at 04:39:04PM -0700, Jakub Kicinski wrote:
> On Wed,  7 May 2025 13:18:54 +0000 Hangbin Liu wrote:
> > Some SRv6 tests manually set up network namespaces and disable rp_filter.
> > Since the setup_ns library function already handles rp_filter configuration,
> > convert these SRv6 tests to use setup_ns and remove the redundant rp_filter
> > settings.
> 
> Missed some get_nodename calls, I think?
> 
> # ./srv6_hl2encap_red_l2vpn_test.sh: line 470: get_nodename: command not found
> # SKIP: Setting up the testing environment failed
> ok 1 selftests: net: srv6_hl2encap_red_l2vpn_test.sh # SKIP

Hmm, somehow I missed testing this one before posting the patch...

I will fix it and post a v2 patch. Sorry for taking up your time.

Thanks
Hangbin
