Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C81BC23
	for <mptcp@lists.linux.dev>; Thu,  4 Jul 2024 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108069; cv=none; b=W/nyVNBnepNyuohMWWMWFOE8ZNITdK3MsyoUq1rinU1ZjeA5+OL273YHN5fJRy4PN1NPa8rAPNeSHeoDt38fmz/ZAR0G6PpEl4okVY+35/d/mI3yd9Q3X6UQWAvGZkuB1XYSZt0D5R9FRW/eD6vlRCbBmPZvih1p1hBOQhAUjCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108069; c=relaxed/simple;
	bh=x3q7KozFjJb72jStzdWoZgxJ3k3TTgAz6+5Xxm8ZNaU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikQ5o0THKA7Xs8PouIqqWZ5DAQl5dPaQK4YEN9t1oRc/iig6y7zh2WXym4gtjVxORLqxIKfwrY45jeG2SQ2qGsc6UbU8Hx7zB9KuWa0hh2LgbMgYxsbkF0RY3CgoQ1N1JolImW1k6bF9IhlvcHiXbzGsFGNKsJSfKTwKZpSXwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMwC5jC/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMwC5jC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720108065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x3q7KozFjJb72jStzdWoZgxJ3k3TTgAz6+5Xxm8ZNaU=;
	b=JMwC5jC/WDOHWfesRKUSF6uOFO+q0Lu2RDhzTwO4PCzMp4QyIGnqDlOFDTbQVaNJ5Lv7zq
	+TiJJkqy24fpyzO3jBq4D/swm/+JdtgXww4uG+115C6M3ZNJJEPW/rmR3yWhl9yfG8gmzh
	FhHr9zsTeUf0DSuaXik2sw48ZqlpXvA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-bTmRsoCpN9C3U2dapML-wg-1; Thu, 04 Jul 2024 11:47:44 -0400
X-MC-Unique: bTmRsoCpN9C3U2dapML-wg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee9115fce4so365721fa.2
        for <mptcp@lists.linux.dev>; Thu, 04 Jul 2024 08:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720108062; x=1720712862;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3q7KozFjJb72jStzdWoZgxJ3k3TTgAz6+5Xxm8ZNaU=;
        b=wosi3s6zU6CsLXrCM3OPkThI85X9g+3WF0+Cjb1M+hJXA8DmE8OWPBQd0jhyFnUNaS
         +fnOqglL5Pw9DIEsRLx9tCPsLgJKVd7g+jcC3z4awXD1YoVCN3wsc6U41aa6k671hvRE
         pUcBsPwPB2CqKDhbaDQyZc3BWJvDW28iTCNOd5eMpL3SUFPwF61W5ndT3zgbhxLSRnDo
         C5QtPWIMIRJoR3ql1nVeMqzA9cssp6rgNBB444KDx4Y9BBpv9EOPSk/y+RwyabWn2BaJ
         9W9GiIe7YV0aa7cLiB4AQYlNztn/pvqUTnlKl5LK3iBd+2juv2CGkogqtMrFZuIB5doo
         GVPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvWQr5UAeF5AwsghEfw+M2XIx1zhCQNETreW28Wj9V4UOZuwZDZPHGXAJ5NNS2jWVNI+fXt53OT5IRYp406HSu3stqiKs=
X-Gm-Message-State: AOJu0YyImq2/sQtdELJx8QvXg0YgHt+B5mwOpvERLmtPnFMgkQQqNlnU
	+GsrpU46uFUefklrUewFRNUbsBiLPbMEuc0/3mXZUWvqCtK98T0tX6APhx+txKOXw0idljS0u9o
	IlRf0kfV91xNiA5ZOnJDsoqfxg1g5U2gc0zA++58bQupgzyvEjHUtERVJwtuw
X-Received: by 2002:a2e:2e08:0:b0:2ec:5258:e89b with SMTP id 38308e7fff4ca-2ee8eded7d0mr13562841fa.3.1720108062324;
        Thu, 04 Jul 2024 08:47:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAeV5WK1gHLXJ0KtsgFuNFmUuhP+rz8LjtNPZSLFRdleYmSF1NSovXk5LvW/gCGllcWq59VA==
X-Received: by 2002:a2e:2e08:0:b0:2ec:5258:e89b with SMTP id 38308e7fff4ca-2ee8eded7d0mr13562731fa.3.1720108061844;
        Thu, 04 Jul 2024 08:47:41 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172b:1510::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2518f9sm29097205e9.31.2024.07.04.08.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:47:41 -0700 (PDT)
Message-ID: <39995512b9a2240114fc1a1cd65bbaba2ca996c8.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/4] mptcp: fix endpoints with 'signal' and
 'subflow' flags
From: Paolo Abeni <pabeni@redhat.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Thu, 04 Jul 2024 17:47:40 +0200
In-Reply-To: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2024-06-21 at 13:39 +0200, Matthieu Baerts (NGI0) wrote:
> When looking at improving the user experience around the MPTCP endpoints
> setup, I noticed that setting an endpoint with both the 'signal' and the
> 'subflow' flags -- as it has been done in the past by users according to
> bug reports we got -- were resulting on only announcing the endpoint,
> but not using it to create subflows: the 'subflow' flag was then
> ignored.
>=20
> My initial thought was to modify IPRoute2 to warn the user when the two
> flags were set, but it doesn't sound normal to ignore one of them. I
> then looked at modifying the kernel not to allow having the two flags
> set, but when discussing about that with Mat, we thought it was maybe
> not ideal to do that, as there might be use-cases, we might break some
> configs, and it was working before apparently. So instead, I fixed the
> support by splitting the previously shared 'available IDs' bitmap.
>=20
> While at it, I added a new selftest (patch 4) to validate this case --
> including a modification of the chk_add_nr helper to inverse the sides
> were the counters are checked (patch 3) -- and allowed ADD_ADDR echo
> just after the MP_JOIN 3WHS.
>=20
> The selftests modification don't have a Fixes tag, because backporting
> will not be easy: on some versions, the backport will not generate
> conflicts, but the test will fail because some helpers are not
> available. That's OK, many CIs will use the selftests from the last
> stable version to validate previous stable releases.

I'm sorry for the large latency.=20

I think the above is more a new feature than a fix, I would avoid
including fixes tag, to prevent stable backports.

I am a bit doubtful about having endpoint with both subflow | signal,
do we want encourage such bogus setup? What if the endpoint specify a
port, too?=C2=A0

AFAICS it can not work, as the port-based signal endpoint will create a
listener on <IP>:<port> and later on the 'subflow' flag will try to
bind on the same <IP>:<port>, failing, while creating the outgoing
connection.

What about just documenting the existing behavior?

Thanks,

Paolo

