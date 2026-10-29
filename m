Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293666;
	b=v0hAXv42EHp8qlZzzacLoaJCcq9ucQDQgU3bUKlMWR++QuOeWegf7b5W3milkJiy1/Lf
	 ftPqzaQ+hQ+qhqEN/9uOZPQyZyCjWsHA2v/An9Taculh3Sxt60h+xc8z90RsdQKwIYJwo
	 8cTTTBqkI0dGbJ2moE+kpm0KI6KIuhOCsX8SM3neZT9C1k7GRcMlwCrQQEKL/kQSLIBUx
	 kIj4QOBqflIuq3xSL51W7d+4dEgPFv2bCXP8wnqKz3PXiTVkk2IwIp9EIZhB1inR/dWjZ
	 bfWP2I+dcJB0Q3nGt+ecFHjfoIrDkyu+OpNzyuEUY3N3NO0aoavLUfYk4Ywh2t1e6UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YrIvLuA1wyST/7aXpQifCmPyW3zDPCfgAxFq045oxok=;
	b=q4QkiadyhBymt5O8ctmdS4X1v110t4FAnVtaNc5OD/w63bxmjACzPm9tpR4qbTGkDYmh
	 YU5w0yVBMgOv0/hyuBFXRNfJmws4zlKTN5QULS9/5hh72jTlJoXRc+wLQcvPiH4/nIJ1F
	 R6zbhvR+mvdlsODSYZXC/XNZA1o/Sasz7MhPjnyaHGe/iKfNWYq6u/a5wP7syv+ORN+0V
	 nMJVvEM5injyIaqibSUu1rTYiv76qj/CiQUKQp/mImnkx3Q5wj8JQzut/ZpgjJ5ITeBPy
	 mVv0nfFloZP1Kezh32taHpi3l8hAB2dZ9nno3B13oXN/RKjSNBTfGeYM/DMu76wunHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VKhEJTjh;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43C7606A31D
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 17:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A43C7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VKhEJTjh
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso1027652a12.1
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793293665; x=1793898465; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YrIvLuA1wyST/7aXpQifCmPyW3zDPCfgAxFq045oxok=;
        b=VKhEJTjhts8BbMluANNdejHVSeug4deyBRvVmlfY6Om+uh5wbDEbynei5U7jHtO7Lu
         s/syxBeQN5vWr4uz8jBvftnCWdy1nWlvVZrrIKS6WIgQcRu5DuKkuEf/6pp9GD+erjD+
         4Rj5j04hK0p/Q0tSGXhjwd7MHHVCXqTgjhbGesuuCLWLu7N/bf9JgjoxxuxWRrQG4iiV
         MX4hTMHPLywnskGkVssowsdjDlbuT7ORSWuVFnKN0CJBScTZaNvXcBfhGvalS3lRCVIT
         KS9SHoBfO9Xh8C8XBL+h1dGMozSU1AuoVWt/6XHfGHqPIYzC4bTa9fFyEjW8pSsPh9xN
         Rgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293665; x=1793898465;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YrIvLuA1wyST/7aXpQifCmPyW3zDPCfgAxFq045oxok=;
        b=WrhHNHcXa4hzxFBuuAQ+hTGyJ+3iISVieU/Rei6gdRZ/BbI3h73KF2vKjWLVH8/i6M
         lVOldb1iLGvazjBfRHSEUFwwTGyo4aNHTnqY5tG1EoYUFskEG+YL3iPhkK7SIuCH6tiI
         e7zszN/No52nsCGu5aZIRYYONk0FYaWw8jhoUttlV/Svc13kK0rUqMhmctKKDxe4LfNf
         Jp25JGNIaqTZhNnmFO9WA4jj0h1NpjI7+smVsCzBOVVIEOVkEjPUOy8TgMC7ZUwGwqAS
         PBbMdyvBtYa8FtB4dZfDj6YuIklMBCDrhZWSaytzgZ9XrL6nhmdQIpquucGysYPs5l2f
         zDCg==
X-Forwarded-Encrypted: i=1; AKwUvBxlSSA+NXveniFlUWP18aJTbnmyEIei/xwuR0XqrurcV9++E+1L2orYIyISJd0hUeDtgDUiIQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKBXF/KnHDqiPU0Dj6yCqfWoWapI86/SuULkZVvBKKdb2+OWa0m
	FoQacu8J3WkVquqo+11FSlYKSyhLSrtn1mF6qD02HxmOlGxXEcRevtCV4T1vz2zfk74=
X-Gm-Gg: AYBFou1kI5eWLJQNlhU+P6u/wN8WwxP5R0Pg7DGx6CjroptZLzBk6BeVkqJqW4UsMgu
	C+RaV1E++ukenPLA8OrI96Uqwels96f6eMSfz7zDZcPAj4tUqM0rSP37iQqoI/DSOtoe0C+fBKy
	jTCNTvzgsToKk4XkfVXYVZ2IcpYePlSE9FNIY/D5hyEqYfHA0+pH5O0FYm4+RqTZJ0cC0EDa8qH
	jaA3bBp2jEiGwob4W95NW18VBJ3gzjVe74xc8JSfVQCNpvQJJWpPY+I2ygCwX6cDuRYY7h/LGvh
	gnC3f3lZmrsbpj246iQ6HW1MBDQ7rOCsDSNMWXleyamlOwknpKSN2XlrqYa3curKhMkTAq4eJ/Z
	b02qz0lVCgfwXPXZBKRjth5tMVpA/uLHkfgMMe9JR06XVjGxMwLbRaUeMT6cSqgfyGXS63VIdxW
	ihfiA8RoX9um8sQnAqpvM5mqmQp56NnZ/2xiWE1XOqg5+B6RsOo8Uqhwu65mz5a3/t6P9Gg5xY3
	YmNjoqZUxi3yxWAd8dH7Xs6u4bFD5wQO4FOCSil2eBbH8DpfFNvn/o4y/0EJb9HQSglOw/o4els
	ymF+uTIO88FFcQnAdqvzkXERnds410tQF7sEXnnbiYoaPIB1ozLSpmBso4GbRDl6N/kIVHQ=
X-Received: by 2002:a17:90b:1c01:b0:3ac:7842:bd50 with SMTP id 98e67ed59e1d1-3ae57f63826mr4385204a91.15.1793293664880;
        Thu, 29 Oct 2026 10:07:44 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8441a6f0sm465323a91.1.2026.10.29.10.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:07:44 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:07:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-net] mptcp: limits: fix JSON support
Message-ID: <20261029100741.3cd38216@phoenix.local>
In-Reply-To: <20261029-mptcp-limits-json-v1-1-7ac73cdab054@kernel.org>
References: <20261029-mptcp-limits-json-v1-1-7ac73cdab054@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 14:17:42 +0100
"Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:

> print_mptcp_limit() was trying to open a JSON sub-object and closing it,
> but no JSON object was actually created before.
> 
> Because of that, JSON support was working with the MPTCP limits:
> 
>   $ ip -j mptcp limits show
>   add_addr_accepted 0 subflows 2
> 
> Create a plain object before calling print_mptcp_limit: an array is not
> needed here because all limits have a different name.
> 
> After this modification, we now have:
> 
>   $ ip -j mptcp limits show | jq
>   {
>     "add_addr_accepted": 0,
>     "subflows": 2
>   }
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

Should be the regular json_obj variants, not the _plain ones
here.

The AI response was:

On Thu, 29 Oct 2026 14:17:42 +0100, Matthieu Baerts (NGI0) wrote:
> print_mptcp_limit() was trying to open a JSON sub-object and closing it,
> but no JSON object was actually created before.

Right, and that part of the diagnosis is correct -- the open_json_object()
and close_json_object() calls in print_mptcp_limit() were silent no-ops
because no writer existed. Thanks for catching it.

> Create a plain object before calling print_mptcp_limit: an array is not
> needed here because all limits have a different name.

This is where I'd push back. An array isn't needed in the sense that there
is only ever one object, but it is what every other "ip" subcommand emits,
including the other three JSON sites in this same file:

	ip/ipmptcp.c:317	new_json_obj(json)	mptcp_addr_dump()
	ip/ipmptcp.c:345	new_json_obj(json)	mptcp_addr_show()
	ip/ipmptcp.c:611	new_json_obj(json)	mptcp_monitor()

So after this patch "ip mptcp" is inconsistent with itself:

	$ ip -j mptcp endpoint show
	[]
	$ ip -j mptcp limits show
	{"add_addr_accepted":0,"subflows":2}

The _plain variant exists for the standalone utilities that have their own
output conventions -- dcb, devlink, dpll, nstat, ifstat, lnstat, vdpa. It
is not used anywhere else under ip/, and I'd rather it stayed that way.

> +		new_json_obj_plain(json);
>  		ret = print_mptcp_limit(answer, stdout);
> +		delete_json_obj_plain();

Please use the regular pair instead:

		new_json_obj(json);
		ret = print_mptcp_limit(answer, stdout);
		delete_json_obj();

which gives

	$ ip -j mptcp limits show
	[{"add_addr_accepted":0,"subflows":2}]
	$ ip -j -p mptcp limits show
	[
	    {
	        "add_addr_accepted": 0,
	        "subflows": 2
	    }
	]

No other change is needed: print_mptcp_limit() already calls
open_json_object(NULL), which is required either way -- under an array it
creates the element object, under _plain it created the root object. Plain
text output is unchanged in both versions.

Worth doing now rather than later: JSON output for the limits never worked,
so nothing can be depending on the current shape yet. I checked the mptcp
selftests as the likely consumer and they parse text only --
pm_netlink.sh:71 does

	ip -n "${ns1}" mptcp limits | awk '{ print $2" "$4 }'

with no -j or --json use anywhere under selftests/net/mptcp/ (the only jq
there parses nft output in mptcp_sockopt.sh). So the shape is still free to
change; once it ships in a release it isn't.

One nit in the commit message while you're respinning:

> Because of that, JSON support was working with the MPTCP limits:

Missing a negation -- "was not working". The example output just below makes
the intent clear, so this alone wouldn't be worth a v2.
