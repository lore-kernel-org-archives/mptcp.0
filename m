Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795568097;
	b=UQbuQbzsoeFCaYNtBAwif/jCACGG4WyUCxf77YGcozQ0UETSO7xZsq98cCHYAAF5koJN
	 3KyCTsrqTFhSBUcas2euah5egr5/Zp5ag6tK9UV8mG/Gg+X7hFjXAmEEgf/9mLObXHZ9g
	 4tZyYNmpT0j1R8AOR8RSAuZZrYeggOLYg3u/rOXl8Jv3M6Rz0/U0ehDS/wvpEyS6h1t1m
	 ZKUbQNL6FJNIFE7+HJVjulQO0oWOM7P6SoRG843lKbzfpzh2ubzO7hsfUam4I0jlPjbCd
	 +N3m3bzrwwqe1ErdyeH3iT4OD05nkB+9K9L2DbqUHn30qGlAN2CV78uT5BS0tSgiiUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795568097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OqrY6P/OIPvBETWqNv5UBHtX+h2IdAEY9f4eiNCVm1Y=;
	b=CgpAXOdlF1TfEWlwf2+VscCCgej1WN7FXin03T2qXr2oxpcEXl1gpNXlYohQJ55drG+f
	 LFMqQXHH/GWB2aJC+w3do5NQts89xbZFylYYd6ZK0pXATEEJ/q3x/4H+TKHXMqf65dIVj
	 v8SkO9Uy7kND6fiancH4gfdn5QiE4u4RJKylO6YJtNR05bfJETav3pzxTFJAyRc9QFlxK
	 eUY5tqNZU1agAQn3aRjQ9te7I8iTI6dF/0S7O8PlzCUcDRMCuxjm6j6Z5Kv3ReY6Gp78I
	 ABZXynPiRLsyeWqV8vyQuIoIPeLt0vvCzjIJ9SObi4Kqd2wIFLKGjPQzh8oQzD8MBmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sJ7WXICF;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFD5606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 00:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAFD5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sJ7WXICF
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2f04f61282dso22108065ad.1
        for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 16:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795568096; x=1796172896; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OqrY6P/OIPvBETWqNv5UBHtX+h2IdAEY9f4eiNCVm1Y=;
        b=sJ7WXICFfS5fVFxJ1LVhEe38Bkax3TIyoygp5MDAqyY2pxwiCDf7JF7CsICpRAYr4z
         ep/Etpo74K+69TPr17qoZXgLWgDMlRy4Yr0uLeWy3V2CGn3jqAQ7BW2ZvdZcgmOlUvAK
         fJqu/Xz9iRRQjZGEsGIHMdrKuwXd4K/fECBpisBpSwMe8PfoV+WEd1gckXOcsrGwMpTJ
         Obo0J+Cmfe+bX+gAyQOEcmkHci5ODHtvHzTGP5Q02UIdM6hmszjNcqDtLMfjIJ0jCpzr
         hqEK7T8FhIT3amNB0i+D3YSFHA0mADcHLpq+wSL6l9oYZsqfJn5Nxgxq9b6k55Ui0pvC
         D67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795568096; x=1796172896;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OqrY6P/OIPvBETWqNv5UBHtX+h2IdAEY9f4eiNCVm1Y=;
        b=p7ZncPuCje50aWgJ2b5TUjZRmiT333GBY85b8LjCY/apebhE5tYOl9EypwgjF7wYXX
         zQdxRKsH2pHmR3XkBYfULmAAxeIT1KahUlGXJeecsSXg2i48hZYeK+c6QZvfqZ6PfmTI
         CM0rI02gH4EX8UibBFjNVdfUZYfgveCxXny4iS/dWGEONvB6ynpnowj0H+B276EMtLkV
         keLZYeZzRvNDUbFwvO9T8RUcfLlQKqeYWDJRr+mBoVljGgtEtzCgOkNEzciN/YemICm5
         nPKjFqQzo9N2GOzPWgIEnseAhDzorttZoZQ0o6+Ds6QslKGlbQu/65/LjMn+kbSl5Gyc
         cp9A==
X-Forwarded-Encrypted: i=1; AL+hErHBXKZ/aKCMcDIhwvbrZobgpn3Nc+NbEoFM83Mt6TbruJshYS8WND69LHkxG4C0S36EW3gh5A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+yGA5MOZFuJBnhoTLm4H1/F1E1wlzdwMi/0U6SQYxBckhy1Qgz
	urk3fGMKE73uI8w4ueCI9Kj+ZJhF9yC70wPkThLK1KIoGweK2wdoeTjMsKdttDm0DSk=
X-Gm-Gg: AZFdTZdRIG1j5fn3kKZiVpOB4ND29YGLZRKsGVw1sLsqkwlKM+T5b8T917mnNSqkQ14
	QqfSt4d6b3mT2wFHmkRfXCIsdZ1iXTj0OP/68y6LlbVw7te/MZmvTZ8mrUZ83FuJHUEZFlWYBU0
	HloGh8jjJ92YEyMaYPHQ4cgQcnNBcH+wFgA4fzKgQ/3kmA9oIP41X/TRsdozgato5Lq1VrQM8Dz
	gAK+4o4SpnxsCCxMUqHK+0W8pMHP+4rnVAYnyRCA1iNQigWvoC8TXIo/zPyEvZXupnqQu9zGYzZ
	sF60befEadomoqfuGuFvht8cJynXrjllaiW+g4hA6jxXDi0XNEcgItc1GDTV3OKM1S8L1HxbB8J
	aQA/d5yNWttBv1mABWBreKUFbcEjjPNVhmyCrndehO2NP6YJep/1pncqcSpgiFSJSpwYYo20Eq6
	mj+j3Z6gUda5osIv9tiEN9JA+RPZ/dB6tnn3yj36uH+ikDbwyBOqg6wXNqwjPy3+yQ8ryREy4yg
	rqe8qZm6RnxkdbHaTQl7HLeOww0l+1ecYR4DnT5kk06MWpWrjbsLQ+cgV0lgSAKiNHGBkF+yb7c
	JxJc7I4OPAJ/wfllfNfUm0VP3IbMDxRDhj0k3jzw5C7JC/5Iv3lPi3bBZi9MPBWr501Vly/llJg
	oAXQdrWEAleqfEvsM
X-Received: by 2002:a17:903:38c8:b0:2ed:2e3a:1fa4 with SMTP id d9443c01a7336-2f03f207ea4mr168163845ad.62.1795568096305;
        Tue, 24 Nov 2026 16:54:56 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1207f1sm75703755ad.64.2026.11.24.16.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 16:54:56 -0800 (PST)
Date: Tue, 24 Nov 2026 16:54:54 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next] ss: move to its own directory and split
 up ss.c
Message-ID: <20261124165454.36367923@phoenix.local>
In-Reply-To: <7da8ca7b-f985-402d-a314-454c9094eb44@kernel.org>
References: <20261119024049.3109143-1-stephen@networkplumber.org>
	<7da8ca7b-f985-402d-a314-454c9094eb44@kernel.org>
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

On Tue, 24 Nov 2026 11:41:09 +0100
Matthieu Baerts <matttbe@kernel.org> wrote:

> I was surprised that you ended up with ~900 more lines, but I think you
> missed the removal of misc/ssfilter* files.
> 
> Cheers,
> Matt

Most of the ssfilter* files are build results from flex/bison
so not actually in the repo.
