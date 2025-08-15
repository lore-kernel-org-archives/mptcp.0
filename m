Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3100E3176E2
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279569; cv=none; b=UoTNG6VE4aJD4CurUlINENAG/2oMe0RCsP7dE3YNEJQwPzLz5QXZgAjWZsVvTUa6xjOF4XPVC+a3ROBYRpYSLzfvNe2hhRq66ZJa4jzTDKP7b5ZGmLSHVpzNV/2cONXyDhteZObzzq1Yb4il9tNjXjA+v4wTHkBngt5lJ+0mNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279569; c=relaxed/simple;
	bh=DzG0LZlHGH3bOOtZ8yuLvRlkiHDfO2BsTKY54JW4yq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LL6MmEGPKz/VErEWyZ8i9BWZ6fPhVMvkBVQWyh2ZbvHTj41dWuVT+JCP4zGBG0c7mbv3c+HfjyahVIhk6s1QjqaaJYBSSWpZmri81iuDc4VnQS2yE2qZKiEmhAP6WDyxhqeDO9B8aGlqkugIJ2meO9rcwuCdBZ//WKQnLzMBC3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dK1tDxdR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dK1tDxdR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso15808515e9.3
        for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 10:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755279565; x=1755884365; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DzG0LZlHGH3bOOtZ8yuLvRlkiHDfO2BsTKY54JW4yq4=;
        b=dK1tDxdRIP6J87fC/HM55XRLgAgTXlg44ztN+gwpV1ih8vvTDZ2WUVwvOFDMgy+Udh
         XVda3ooIEBlACPLaVuGHMfW84gPC2hWJml+5NpuW2kuA1Jn2xYVKRsZOO3jbPkW0QISE
         ozHDq9RbXdK64Bn47j4dr4J1/ry0fiRUAOKg2c4eE7KZ2qKXDx/T47BdMQ6vhRxlVkcg
         gtQBYNWBHBHbycFtzsmJT66kMZUMQJbtjfh20aMrO83rDLxc3V/Ghat+X6ZVHxZYf3nD
         +KsGoaxXWJRAB2PByN2+GPyCIEILk85MrvSgIxIsF5omh6cdceo1+d9f+l16WGZO/Tse
         XaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755279565; x=1755884365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzG0LZlHGH3bOOtZ8yuLvRlkiHDfO2BsTKY54JW4yq4=;
        b=pdOr8pvnpocb37NavgwBPW+oR0Rm7aQdB+1NwYj3JmnN+jzS8MVxLgZNbKfagvkND8
         VWXRa6CpmMAqNnNGjW1v/yusFUMRYDP1Fdgzrp0qApi+PkMr2ogfPjcxZhMoIjaaEq9Z
         reAIAsUnJYBSZA83CMmuWYCDy0979bV6MODpRnwRojukjaZn7vY2BXZu/rDCyb+LHj0m
         c079rupODI/EA+DXkP46P3O8KNWVaTpmIUT/8+yM/6dwYuJZopApLPt28ul4X4QEP2jc
         dzPqn9XNM0vx0wHeoL1cstFPhnmKFijdBBy1zbfDdsnmGX8x3smKsj0VfjQJS7BoS+cQ
         gw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9Qk+Wx5leOw6xdkpikU+VjVc/stOiacpiqz9W3hP8uBi9IjHNmwvp2NWoWqqPq3eGlQQh6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YypRya0p4XFKpgvvsfS+q+++JqDqlxOZepkCh/TMLPVvtWoNTuS
	pVwnydQPAn1egUI34CAR6j4Q+yN2qwhW7dUSJ9udd+nMmq92Xqn1JB7C5Hq1gXDfZk4=
X-Gm-Gg: ASbGncu89WEn95ehMZit7fR8DXDFkWYZQrU2QHylfwO2euVky+ceuVQSa6IlF3cu3Jf
	5Duzk0NwdNQe1ok/ABwCX6KujJu+5hCsJ7AYGPwN6A/FG6eKfJFz0lIWbuRtki2O9tiHeZPkEWr
	dmkHF5zff6zIsBsPpetQ4raDgLNUDiNNj7AxOHb9BlQkn4+i/46Bkso+7QYNauzeLtKZS+6R3rd
	KnVEyv6EWzLzeDPXpL6aMWNAx6AKk088L3SGO6+EcMocW4WHZ+rPiwUriooMbRQYvV/W2JiCxAy
	ne8f2WzpG19KvEbi3Uyhc+oxNG3cmea/VXQqldFm5pA6KTzrpSMb7ZWxx9/9/GQ93AaHt6VA+qB
	/EQaHXdUd5XCJEtuO9mAEZZzxQ7szbYFoLvCEk+eS8A==
X-Google-Smtp-Source: AGHT+IEQtqoj7OJMpPUFnt1ji9bSa+u38yG5PGpHc7mF3c26ryzthKx7wFt40yjy8HfsIxTJ4Rr5hA==
X-Received: by 2002:a05:6000:2289:b0:3b8:d0bb:7541 with SMTP id ffacd0b85a97d-3bb68fdd5efmr2396919f8f.40.1755279565547;
        Fri, 15 Aug 2025 10:39:25 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323311233cdsm4872522a91.21.2025.08.15.10.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:39:24 -0700 (PDT)
Date: Fri, 15 Aug 2025 19:39:06 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 net-next 01/10] mptcp: Fix up subflow's memcg when
 CONFIG_SOCK_CGROUP_DATA=n.
Message-ID: <gmiwpzpgcnnzg2jjhonfcchkbv7zrzgbawvgfgfwrjmvvihqdc@gaq7bbe4ktwc>
References: <20250814200912.1040628-1-kuniyu@google.com>
 <20250814200912.1040628-2-kuniyu@google.com>
 <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
 <CAAVpQUDyy9f7=LNZc2ka2RiOhR3_eOhEb+Nih37HnF0_cdrJqA@mail.gmail.com>
 <r3czpatkdegf7aoo3ezvrvzuqkixsb557okybueig4fcuknku3@jkgzexpt7dnq>
 <CAAVpQUAx9SyA96b_UYofbhM2TPgAGSqq_=-g6ERqmbCZP04-PA@mail.gmail.com>
 <kr6cv3njfdjzc2wcrixudszd2szzcso7ikpm6d5xsxe7rfppjs@5bvfwpelgj6f>
 <CAAVpQUCMcm8sKbNqW9o6Ov1MtC67Z--NTv9me1xcYgCkbJxK5g@mail.gmail.com>
 <CAAVpQUBO8TXjjtt++kF0R-qs-Utn-eY5o321NyAALEYTfq0xGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y4wp3wkqhrel3mvn"
Content-Disposition: inline
In-Reply-To: <CAAVpQUBO8TXjjtt++kF0R-qs-Utn-eY5o321NyAALEYTfq0xGw@mail.gmail.com>


--y4wp3wkqhrel3mvn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 net-next 01/10] mptcp: Fix up subflow's memcg when
 CONFIG_SOCK_CGROUP_DATA=n.
MIME-Version: 1.0

On Fri, Aug 15, 2025 at 10:24:12AM -0700, Kuniyuki Iwashima <kuniyu@google.com> wrote:
> and we need to manually copy the memcg anyway..

(Is that in a later patch?)

But fair enough :-/


Michal

--y4wp3wkqhrel3mvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ9wuAAKCRB+PQLnlNv4
CH4YAQC8zojrNNQgYpmFJQUBnZHfg4T+IF01Rw6OCepycZuaVgD8Cfgdr1bVXJly
2vehjqtlGG8wN1oo3l6EVENniEd0yAo=
=/lQI
-----END PGP SIGNATURE-----

--y4wp3wkqhrel3mvn--
