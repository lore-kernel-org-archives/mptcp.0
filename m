Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51EF2D7380
	for <mptcp@lists.linux.dev>; Sun,  2 Aug 2026 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785693387; cv=pass; b=TNiFFgnVg86ybIMlOzdE69CMKc6bKGULReUKvxR31AbO8V5uKQ4mHoxr7j658hiwa/bZe0iFx1zsIArgaZ3KXdXdY0e19ltZdyctqIP8I+kxkCMWRVDJ1SPlFXpfLODTIeAe89SPxb95S6XnLj4M+5kgdIIcqb7oMoWV9I4eAOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785693387; c=relaxed/simple;
	bh=6XirpM97UKTIgJSFhHFfbm7BbmlDaRbopV0wY7RedUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NilUG2M/VCBQ/PhI3jlSg2fwCAscob5Mcv+ormaPPYw0fDwxq2OgpPhIkk6xw123JqhJ2J0/spFObZPe5d12W8kZKFQD+vsWsLTeEvraxIlTcuPXEM6nbcIitCNL/8fRN/udz30tlZ2dHw3v7MQFGKqUFNiOShYnwRRGbr/98y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiSF/BwD; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiSF/BwD"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6aae36ea5c4so1637814eaf.1
        for <mptcp@lists.linux.dev>; Sun, 02 Aug 2026 10:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785693384; cv=none;
        d=google.com; s=arc-20260327;
        b=hnV1pOrLGIGcnPXqbNJegcq5E0a5o8bFfpQbMXHP6XWySkjDNVEgy9MyiFiBAtnSnt
         kG1b0t9cdO5qAcku5fBO1icobb/Np9xdvlsLRm2XvIxJdIEqmKYAy4WFB+G1rBcnuhs6
         0ptBglFZtjpMiuupjnScqR3WfDCfyEuFpT1yfdIEc8JkT9DvXvRscrBX1bjN72l1kSMB
         KgU7IQl3u9AZ21kbADx5Kwxf2caB/lHcj3eyHL+MCyhsvBFdhYAlelBPet+8gSVpPg+m
         M68vpQmWpq3Dv5nIcuGD4BVv17NF9h7dAPmAvwd/ALRvzFdNPnLadbLNcklzQpTNP9lG
         vB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WImMqFn8VSXiDXSjd3jDpbqmd1A1VYwUZ/+Y1CyJaCA=;
        fh=T4HTA+NGTGiJ1rviZC1ByR6q+LK0qphO7vtAGOH33g0=;
        b=L+21Ni4stvvfbBvLvym4kU2YPMSf5pgptjYdAiwjEcfBGnj1LtEnA1zfqgTyEV74Nv
         fhQVhqD8Kn/Gdxx9uOd2MSzZEn1T7+yOrlk8QmlpQvFkBTyZqp8B+CdE/p3abLsxB0RW
         uVloRkeEtfba4gOD1Xwj0F7EFLI9gFHmBV1apbfJgEiZVFgAGo+JffGd3gmi4u0XCXgM
         GIAJiQQG9fEmufEEwdY7llF/JmEtJp6t8nvB4Pb9hTgvO5UDYLObI7mKUW2tZZHP8LRd
         eYZ7OUcROKFZffhlU6n3uswpJcC3dVNfH2JR2KwWOs9PxqdyjygyzfEqxOHBc6i8iBC7
         ykrQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785693384; x=1786298184; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WImMqFn8VSXiDXSjd3jDpbqmd1A1VYwUZ/+Y1CyJaCA=;
        b=OiSF/BwDL5HselPtrWtwygr6sOe7W/ZZ4RU66ZLe5yfOobBfta81lH997LiN201IVP
         EdhCQAT62ZrCtygx4E742g/OANhaK0XRUb9xITybQ3+2kzRZfHoCWd3631a29PFknlCY
         1Qh7xvursdBAKihrMHn1vgGD+7Ptnyh4WzzSgHjXOegZL3ghVBM38ldCDSjkP062eaJo
         m1CwsMdZFf2P7lcauYokl44dUMUSCYCKFYjNiE6LULVy4si3nJidZhJRhBoQF7q2xttj
         IR/89b/AsRb5NaJE9qi5TJg8wa5vILIRKpcrDj83Zjpy5Grvvjp0TBCy3/6K8msucQEr
         sVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785693384; x=1786298184;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WImMqFn8VSXiDXSjd3jDpbqmd1A1VYwUZ/+Y1CyJaCA=;
        b=IbTBq1ut6jGG1iGqfPhabz22Ye3JyhBwPyOOLxarahaQem9+jt+AZ8qZBDOrwjsdeb
         3T8bmJEHxLd0zVQlSuHk3scbXGnHVko+krBUvH6LPAAOlEZCePgvR7qVRpEx6cFXwR4r
         vfS2VCSfztGKP4c1YBwSXxd1uNCpGjRrS8bwJPPs8L9Up43WRa3fJ8ZRv1Q0TSOsfCTe
         SFv3oSC1IDvlYy1a2tvh2ZmhTXQGLPdMJiIZZ60d2J3/KyQxL7r9/CExFDusZFQ0kuhv
         ERu3cOzbCODWsdE4zf/j/kBkpQQDutzMIIP8iaU3nqg69CuDBPCFpGhRMJGPGYw9OsY3
         ESLg==
X-Gm-Message-State: AOJu0YyqG0gU210IciS5w0Jc0C6gDzNta6VIEt0bHjP5OnCLrUpYA6BP
	PDQe1N9uL9W3beqA70i7RZzXzLOcZo/PADs+UQ5qSxAuXOm78V+vOAwJrX0JGEQwGmcU+YhNMre
	A+U+2ijYoarbql302cYYpHxpuwi5Xsr6ODg==
X-Gm-Gg: AR+sD10uD/CA8y8rbwNToGGb2ko+de4ueOiKtKLtAw/uopTw8Irx1OdXryD/dBDQlog
	lwK95pHCMhozkC0N/u4bFj/r1LRDeRT7eQqxIHjTyfFO+xhxOiAkjcc96fBKhLlzETaPjLJio3F
	k4UG175Qo9RFL8xjlbtnjb3+4L48JprT42HrreKhqVu/ch7ZwPBO9R9dIoqhOGVbm5n1lfc6LvQ
	CXgGf/5fCR56go0RHXHFzd9lApqb8V4YWoMyfj9B5xEBKegnTkP6lL+2GTNHpGNwAM/Ob0b+ae1
	xku/0Xsy+1XkyjzJroYvcTR7ppOnsAi0PPSe9y9acdpSMAmbSdcosjshbgrw9p7K3z/ymAFmgmP
	/iUJb6wCj3IVpvDyAK6o=
X-Received: by 2002:a05:6820:1a0b:b0:6ac:9384:8edd with SMTP id
 006d021491bc7-6ae43326501mr11408172eaf.23.1785693384385; Sun, 02 Aug 2026
 10:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260802-mptcp-squash-sft-recverr-v1-1-df5f5e366e7a@kernel.org> <6bc62a92-766c-4551-8d7e-a6b3fd37f5a9@kernel.org>
In-Reply-To: <6bc62a92-766c-4551-8d7e-a6b3fd37f5a9@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Sun, 2 Aug 2026 18:56:12 +0100
X-Gm-Features: AUfX_mzCSchR2jx8AC6_apZNrQOFvHibcdfTBvcJGpkRcDI3kZugiPS79HZPJd8
Message-ID: <CA+XhMqwdpHqketdoTM9Xu5=WjftssO27PUXDKrDPyNCyog67LA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: cover IP_RECVERR
 sockopt propagation"
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, 2 Aug 2026 at 18:51, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hello,
>
> On 02/08/2026 19:46, Matthieu Baerts (NGI0) wrote:
> > The CI validating the latest sefltests on stable kernels reported an
> > issue with the MPTCP Sockopt selftest:
> >
> >   04 Mark v6                                           [ OK ]
> >   setsockopt recverr on: Operation not supported
> >   client exited, status=1
> >   05 SOL_MPTCP sockopt v4                              [FAIL]
> >
> > That's normal, because this feature is not supported by these kernels.
> >
> > Skip the new test when the feature is not supported by a kernel, but
> > keep failing if SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set
> > to 1.
> >
> > While at it, also set the socket option name in the error message, to
> > quicker understand it is linked to the IP(V6)_RECVERR option, and not
> > a "receive error" type.
> If there is no objection, I suggest applying the patch in our tree, to
> stop the CI to complain. Extra fixes can be added later.

No objections at all !

Cheers
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
