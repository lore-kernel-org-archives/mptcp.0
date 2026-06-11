Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFD409E01
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198313; cv=none; b=X2iEvFnsUJ/OSI5VgSeHhQXtvjzN2KHcpcTgedZWmdwefyKyVgYQbGQZSjw1+8B1iEKLp9vwFcFo9L5RKpyiGX08YWQXSMibTYpt4OoE4WBYywofyDXhxit2dBDRezw01fW8mI6n1LnyiMO+TC+447uZOdLYAHVlYqzinLxLb/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198313; c=relaxed/simple;
	bh=kAobYEkJDMjkUITJUMNyBriLzXiAe6UXFHqVuVHGqxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE83Q93KH2sR/9RFLce7zUFPKSz2M+LEB2+EiHosIL5fmY1HpZSJWaZKM82WfU/yxVx1SbqkABnOSYZF/15IOMPCtg0yCA28X3CUoeyZmyjJPi/MijOTvwj4eI/JbO2Y0T5h5h9+rL/hkMYJhvf1tx+A5jpB6fohAta1B6Ish4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9IXq1t5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9IXq1t5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso548265e9.2
        for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781198305; x=1781803105; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AoP+cy2ffp1XgHOvwchIi8ndfKfAxNydtkxTWle4y9Q=;
        b=F9IXq1t5ta6wF04WmYzmV704mpJOzEzD19t/csr9F0gHN1T9p9EQnYpVUIgiXUzCIs
         G40qu/UUg7MOYLZhqKp/9ot2sBOuKikdtdugPlzSS4EtrcYnCigu4oK3OLrDZMih8xSZ
         HL98gICaZ+sxm+TYWwFV+LhukA9H1z+Zajma5EqJUnZkFknjQTEX6dfhwbXsAM0Ngb+b
         T1l8raDM9f+2nuP9zLwnrWWsghbMDaaQFv7EYGCHB5rsNxcDJy0QG2bVgu039dzXNDTN
         QDgLPOUmUcCVHy5PNv2AqTxTtP4Zpks9F98G0DxC9ZfMQUF71Cyod0dfew0NrNg54Wu+
         hEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198305; x=1781803105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoP+cy2ffp1XgHOvwchIi8ndfKfAxNydtkxTWle4y9Q=;
        b=eyxcKOuIILChAKxhVr7NrpPZkxq9D6ul32s5MxXQw9jQgHIqZ2rxJ/q54DFg0x+ucQ
         MCN0+CMmVPc/7Q6GsBwuMIdHU3RRDdOuItXMqzzlRPtSVUwvksU0cDUFvJ1ng9ZDWBbn
         y29pCmKu+2L8E3xj8sDcFTBIfmZSt4C50vLn6K1ecFajoMFLyxKfiJG8u9pcwZ6ayYee
         mX20FNOZgXBGhdSA36zMUP9GnTm2cmpgAgwyQqlV1NI7xlkNXfyUmEmKzFY9MIlJCdRL
         rp+VvCRMCXuDos2tkTABWYhpWXBvnc1xLKz/GmU5tOqXjtK+leMCqH2myn5Gb15G2NLz
         G7fQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DZLeDHCskWTNpSw6SogzDmP3gBVZuDWWLjwKQMIeOVGyXEK8K/gXXXgzy4ot4JsardHWjZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7YGGkZoS/gba9yBqLTpiFnblxL9aPPg+4/zr/j4QKqtbv6ckJ
	xb6XnRdkD8Z2xy1eu2UQw+yMQbl3Do3aFLmOT4EYUlVNk91zxkILUo5D
X-Gm-Gg: Acq92OH/afAZocTkiekmFwYIolkmWUX74OcJr3ATrFMW6EZar4+5+Y7A7/OhvZvFkuz
	Hnj9uV5nswVYAjAMM3FCLa0JSE/JKRsqEa/HJZvj4hys3Q2S1DumZnSk+URYNWyVcPQeahgmef+
	sglR5DGn9mE29Eo/77ZXhCJLffNvJAZB5HJVzP3qlXQwC8fTCQCw08fEqUR//MAxpeZQwPr14ZW
	F9IGTgTDAoPz/KiHIJ51nvJTWJiNKPTu3sBRfWPs/hrGlR4xDYlcPAKxaHJy/So1pwDHfUylEt+
	PJJ/us4kcgtkFUxAYFRC8FcvUlyeEg1GQ2fVLixhv8UQGQ8DWkBsfnJy2pTn171MP1Z15ZZCCRk
	0WpogIOGy6fSEu4G6htEEvDd1bzkAE6IeNx2kdOAH59WOWqfVLxP0+jE67skne+AJgKKUKHO7kg
	d1/VkdhMsEGgZIVBnySa176sQOmZEvBkVklhvyTJH3W1hd25mvCggLd4hsIWE=
X-Received: by 2002:a05:600c:4e04:b0:490:b9d3:a9ce with SMTP id 5b1f17b1804b1-490e5640aa8mr56905655e9.30.1781198305135;
        Thu, 11 Jun 2026 10:18:25 -0700 (PDT)
Received: from gandalf.schnuecks.de (p5b2e2404.dip0.t-ipconnect.de. [91.46.36.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606c10435dsm335137f8f.35.2026.06.11.10.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:18:24 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 0C018319F7E6; Thu, 11 Jun 2026 19:18:24 +0200 (CEST)
Date: Thu, 11 Jun 2026 19:18:23 +0200
From: Simon Baatz <gmbnomis@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net-next v2 05/15] tcp: allow mptcp to drop TS for some
 packets
Message-ID: <airt3_dPSfV54Aph@gandalf.schnuecks.de>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
 <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>

Hi Matt,

On Fri, Jun 05, 2026 at 07:21:49PM +1000, Matthieu Baerts (NGI0) wrote:
> With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
> taking 30 bytes, the 40-byte limit for the TCP options is reached. In
> this case, it is then not possible to send the address signal.
> 
> The idea is to let MPTCP dropping the TCP-timestamps option for some
> specific packets, to be able to send some specific pure ACK carrying >28
> bytes of MPTCP options, like with this specific ADD_ADDR. A new
> parameter is passed from tcp_established_options to the MPTCP side to
> indicate if the TCP TS option is used, and if it should be dropped. The
> next commit implements the part on MPTCP side, but split into two
> patches to help TCP maintainers to identify the modifications on TCP
> side. This feature will be controlled by a new add_addr_v6_port_drop_ts
> MPTCP sysctl knob.
> 
> It is important to keep in mind that dropping the TCP timestamps option
> for one packet of the connection could eventually disrupt some
> middleboxes: even if it should be unlikely, they could drop the packet
> or even block the connection. That's why this new feature will be
> controlled by a sysctl knob.

RFC 7323 (which obsoletes RFC 1323) specifies an "all or nothing"
approach for the TS option.  Section 3.2 states:

   Once TSopt has been successfully negotiated, that is both <SYN> and
   <SYN,ACK> contain TSopt, the TSopt MUST be sent in every non-<RST>
   segment for the duration of the connection, [...] If a
   non-<RST> segment is received without a TSopt, a TCP SHOULD silently
   drop the segment.

So, selectively omitting the TS option on established subflows
appears to go against RFC 7323 at the TCP level.  Do we consider that
an acceptable deviation for MPTCP subflows?

(Maybe I am missing something obvious here, but I couldn't find any
prior discussion on this aspect.)

 
-- 
Simon Baatz <gmbnomis@gmail.com>
