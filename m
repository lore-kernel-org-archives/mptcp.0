Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087723DD855
	for <mptcp@lists.linux.dev>; Sat, 13 Jun 2026 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349389; cv=none; b=o9EV4Hai3nTqIU2hMrC3mHTcDRfKs5Fs4JfsKl2BYAfmzXrHqONoRkjoFa6NiGmdzHt+iMLPrw++EGqsdV3+MCTyPv4GPTNrIhiGY0zqh5UIfemSVmmgNXc7YA9n1jLGaQ0DtUcaUAvJJp1gRfVTxup+GX1QdMQ2aWNyS25G3es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349389; c=relaxed/simple;
	bh=mbelUA9ampyYa4CbvEWtyIDmWwuprT1EWZUBsr2YrII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkbXb8f8+oDoMQM8K49Z+nOSS68ykEA9CV3fnhrXcqX0JIbLg8HZWmRkVr+i8aMPGYc8gUhsIkB9C5q4Yeam8oJtTMpM2Mn3pgFCNFWjXRF1vRWN+dKNBZEIxXP1vJhJZgrFW475j2mojYS/v1Dk13qNQIUQRBscnFLYWv6P6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwCung4J; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwCung4J"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so14096735e9.0
        for <mptcp@lists.linux.dev>; Sat, 13 Jun 2026 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781349386; x=1781954186; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8QOOlnMRvxmfl//EENHYWi6g2FxXLw74yKxLSW4RBeo=;
        b=SwCung4JGu317H4opB2lEjSDs/6oKB/mdhtG1U8f/uRnjjX2dOCb0GDsxyRly5q0fl
         xkHFE5EnLBku8M/JPfE7akHmwFKhxTTQsGQdtU9Zer+fD5dJbc7KrW1ulSXWnQROZEF6
         PlG8i9FEfW3VpFyagLZplnRkVoberWXQqRRe6ZyeIpGavNKFIGZ7XIRivbzFQ9KfXxEs
         en/NHqVLO6d6S6GGvHKbOn+T3LC/gSFoQCskvNwJO4JrK6SbAioPhtlPlJz8CMGIpYUf
         uBUkuJdZxfEAaFIfp+oH7XHnUPMGZX6XDboQJ1q3rW9UQLVRBh2Z+xq+prOXk/nMErk5
         fGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781349386; x=1781954186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QOOlnMRvxmfl//EENHYWi6g2FxXLw74yKxLSW4RBeo=;
        b=D8eoJHqsmjiwJ8+EzQSJdGd/8FP0wuG6xTo/QgbfuXr5h7lFIBLWNxqjnwjTZTctjN
         hPgw3ALP87FpnNyuO/k0IQG0E+Lq0Nf2PEWpj2r3QAffZPdW0Z8IEztTKsshpRc2OVMd
         ZBg5UDBDi88ZEL6y7krXp+Gxdo9p+3OAM4KYQTnIu0P8RLrTxbD4yekZBOLFi9yqx3MZ
         t0OY1isgEzRXXt+KyPsZAAaeQEFIeUV5ZfmtQKBNyEcvkkdGD2M0DoiQwYKAwRamKr7Z
         2JomSwmSplDgxWNq+FNBjKf5dm5HnY12vlPG7atrh2Ddw6hRwxbnK5j8Ct4U+Rm9BJRK
         y3Lw==
X-Forwarded-Encrypted: i=1; AFNElJ+ehfamno9hUPkRNZxYEL3C1PEs/VcOV6kQyRtxCjFMGAF4F5gwYsud68ZZFA1GM9S04kqlAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YweTKtiwqoTza8pAcejO+bjJ3aVTcxrDY795TvtGH8BPJTGPKEP
	qkHU69Y6TlIitfOP3nh3rD7Vwb7PfjKSQE6r487TBaiRn2N+1a414ky8
X-Gm-Gg: Acq92OGK+QSG2NaMEnOLH78L688FcQJxlL3NQ2PzCMfID8G74CgmDCgQPo7XXSdCVql
	zqBEnaeoUQegclO1x5T/ogQ2FW9Asz4B7L3kVbXMppYwuJzBTnnnM3k3nTeSPb7YpxMuBCp+o6+
	3qxHKj1C34GVcGGSJpSChH69LUV0HPjhO+IxE4VAWvbBlz+oFc7L50eLpPci+bzQz7HAy0TWLBc
	wVBoAaBXtpC3JWOeGlU3kkm9xYgcLTtynDbPtShNZSEThLL9SY6sDk3Vnex8lXacGwbrIfTfZyu
	jL6NF9pEsPTghTfpSFUQdT0RKK9fUfz1XOnkox32TRFN/CDjKmnH30VoAV7LImxMC4xnyS7L9gp
	LmsgVYcF9i5o79g9hnyfPK3c7loqj8JSrtc9wY752xdhxAbqnXvg18PIidIr4rWxJVbtbwMfZyc
	QGej5ieuxUAMaMJBsij778/BNSCn/fcNoRgfbuteBQDhKEj1BD/Lo1qzzHgPClcZfqzVgbgAbpQ
	As2icHleWHMY9xfLlzHfj9cVVvoQSVjoy4=
X-Received: by 2002:a05:600c:3b15:b0:490:ec79:3077 with SMTP id 5b1f17b1804b1-490ec79315dmr96114205e9.16.1781349386167;
        Sat, 13 Jun 2026 04:16:26 -0700 (PDT)
Received: from gandalf.schnuecks.de (p200300c14f38df00921b0efffe889e28.dip0.t-ipconnect.de. [2003:c1:4f38:df00:921b:eff:fe88:9e28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49220207efesm59902115e9.0.2026.06.13.04.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 04:16:25 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id EF94431BC505; Sat, 13 Jun 2026 13:16:24 +0200 (CEST)
Date: Sat, 13 Jun 2026 13:16:24 +0200
From: Simon Baatz <gmbnomis@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
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
Message-ID: <ai08CJDkKzQIeCRK@gandalf.schnuecks.de>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
 <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>
 <airt3_dPSfV54Aph@gandalf.schnuecks.de>
 <8d744049-65b7-4652-ae9f-a4a159fff56c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d744049-65b7-4652-ae9f-a4a159fff56c@kernel.org>

Hi Matt,

On Thu, Jun 11, 2026 at 09:40:23PM +0200, Matthieu Baerts wrote:
> Hi Simon,
> 
> Thank you for you review.
> 
> 11 Jun 2026 19:18:29 Simon Baatz <gmbnomis@gmail.com>:
> 
> > Hi Matt,
> >
> > On Fri, Jun 05, 2026 at 07:21:49PM +1000, Matthieu Baerts (NGI0) wrote:
> >> With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
> >> taking 30 bytes, the 40-byte limit for the TCP options is reached. In
> >> this case, it is then not possible to send the address signal.
> >>
> >> The idea is to let MPTCP dropping the TCP-timestamps option for some
> >> specific packets, to be able to send some specific pure ACK carrying >28
> >> bytes of MPTCP options, like with this specific ADD_ADDR. A new
> >> parameter is passed from tcp_established_options to the MPTCP side to
> >> indicate if the TCP TS option is used, and if it should be dropped. The
> >> next commit implements the part on MPTCP side, but split into two
> >> patches to help TCP maintainers to identify the modifications on TCP
> >> side. This feature will be controlled by a new add_addr_v6_port_drop_ts
> >> MPTCP sysctl knob.
> >>
> >> It is important to keep in mind that dropping the TCP timestamps option
> >> for one packet of the connection could eventually disrupt some
> >> middleboxes: even if it should be unlikely, they could drop the packet
> >> or even block the connection. That's why this new feature will be
> >> controlled by a sysctl knob.
> >
> > RFC 7323 (which obsoletes RFC 1323) specifies an "all or nothing"
> > approach for the TS option.  Section 3.2 states:
> >
> >    Once TSopt has been successfully negotiated, that is both <SYN> and
> >    <SYN,ACK> contain TSopt, the TSopt MUST be sent in every non-<RST>
> >    segment for the duration of the connection, [...] If a
> >    non-<RST> segment is received without a TSopt, a TCP SHOULD silently
> >    drop the segment.
> >
> > So, selectively omitting the TS option on established subflows
> > appears to go against RFC 7323 at the TCP level.  Do we consider that
> > an acceptable deviation for MPTCP subflows?
> 
> Yes, to me, it is acceptable. Please note that here, TCP TS is only
> dropped on some specific packets -- ADD_ADDR with v6 + port --
> which are TCP pure ACK acking the same sequence as the previous
> one (dupack from a TCP point of view). So it is just a signalling packet,
> specific to MPTCP. If it is dropped by a middlebox, that's not nice, but
> that's OK.
> 
> Or do you think something would break when this happens?

No, I just wanted to point out that an MPTCP peer with an underlying
TCP implementation that follows RFC 7323 strictly might drop these
packets (not only middleboxes).  But given your explanation, this
sounds more like "bad luck" than a real breakage.

Thanks for the clarification.

- Simon

-- 
Simon Baatz <gmbnomis@gmail.com>
