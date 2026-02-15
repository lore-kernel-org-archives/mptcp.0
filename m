Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A032472B6
	for <mptcp@lists.linux.dev>; Sun, 15 Feb 2026 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771184136; cv=pass; b=XH7LbXx6hR84h+NkkZUgkYf2XaUPF1Vo3/stDcz+IqyKsR7o1E/vm8PxJt5pirRCdJTKsIvjfGBJU+tf2jLpd7j5IytSc8G7akzlevqhyhelZqSODCSod9uDQtZldkyhDfxZsomAkgXNDMtfbnphXhwXNRdAGDzFQCYo00gqJJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771184136; c=relaxed/simple;
	bh=cjD6OYwsCT206NrUBlByI1R0EaiTAllL0w3KzWpyUxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=abxaoKc7bvaDL9NeY1eC+rK31AJFH5wehRS+9/JWgNmEGoqXMNLYQHc0j1cB9jE0gKGbSTH9YIAC8OhME8uvCSV2F9uoP2naFferv0ehkifEsRsCgfu3AnlDplLPATs0DIwXZ3q/DPpJAOhJvoD4LJxmpmSOcXEoVjY7DOhjBV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=Gg9QAEvQ; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="Gg9QAEvQ"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65c0e2cbde1so399056a12.0
        for <mptcp@lists.linux.dev>; Sun, 15 Feb 2026 11:35:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771184133; cv=none;
        d=google.com; s=arc-20240605;
        b=M/nyw/2ZBNzV/FJ5mrItl3qo4Dbu4YvOUY1VxNsZaRN1ObQbReP4XIraeVUM1/fZi/
         vCp1V/fvOuUlykl6eJSBlPTcfKoKU35MV7cI2K6MdkEFQHcT2nUBIOdctQHmihNnUbYt
         8UyzHn8dSYikm7odFy6vrGKGe3agGHKK5n5QZcXnyJ3S/RDczJFPCiywA6l+g7JZKxtG
         KHHy6DJtIt/nrKEr5xdC4sAHN4OF6PJQnwOpVaPJz++j3ECM05G/U+zWcBLR86qBFQ+j
         aA4mR+XIh/2wTrdZLwS1t+xp/I97SohzCu3FmEoQjViGtnVMAlNTVSRiLp9pclfxgnIM
         sxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cjD6OYwsCT206NrUBlByI1R0EaiTAllL0w3KzWpyUxc=;
        fh=KoOOhf6J2pokZKo/B0+oz08+WVYAFzmgcZVfHglZF2o=;
        b=Mnqr5OZOjxpILAxNzKWQPn4hXM15RjsgwSvc13RP9pD5ocE3U/fbBP64ydwhZ/Rcxa
         Ie3UGzNI4TotwFy8tNBw1HfjYBc8fljVZfXysdy4+MzVmqXYY5hfis8n5rTfb84zPELp
         F1AOHt4byLqLZdPa0FlhxCm+41dk727cF+BM9TasYkhS9oofRuVLz8gGrq8PMPQitm6L
         f+0At9OHPyT9nXdHp3+mgMiBFwEfgh6pUhmBYQB1Ixlyrs8WGh3YW21saHMOt5HffbDp
         bQug3hA7bDcG6KYVqwlygbizEJ5koMFNUg6LR2U8Bl79+FQc1Q/7AbYGL5UPh9IGCVmh
         JG9Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1771184133; x=1771788933; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjD6OYwsCT206NrUBlByI1R0EaiTAllL0w3KzWpyUxc=;
        b=Gg9QAEvQDD2+iIDd6mSf2OWOO7omwT80aBWnjuydq3B0OfOr8jw8j9n2st5BEyeuWs
         qAN3TtHMsBzs3rpsEWCc+sA+HnlV6jcM4Tg2Z6DaZWQzBwntsvIxadpwlueOBNw/7qxj
         cZiBklNt0gYxbxbmaiVNMHYTHpEwXi7U87SMEun/nqZaQXhghuLlV2BmWeoZohUOom45
         VzkY7woTK8t63qjfX5dMk7Z7yYYra2DskJW3NRNduYlBIG6bqW1v1fyJCk1kJLGZiKMt
         lT7IV3CyComntpJJuD7+6YRxMzY/Q7W4NLne4cji0g9xWzl59BPFQfWVAqIygrSrxc4N
         zK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771184133; x=1771788933;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjD6OYwsCT206NrUBlByI1R0EaiTAllL0w3KzWpyUxc=;
        b=eUOnZJrP3uD7MR/WplwnoV6opJJh6LjrLoBh7V31SWy0t8VlsJCFJNCl0/a1z15DU6
         mdrLcLDvXHXnd8AW47aMybmdqjD825l2KsRY8XQ4Vo+VzI7oX9sgDZA9Qq/qIV0A/nue
         zmkvUum/pCgfGZYueN+LWObs5bA6ySwumMZMmmQFvpbRxXxVe85DuiZHJrWpumefgTQm
         2hMFJP8YoOmeTRgMW4PnKyL2wb7ikzO6LtF4fZ04VTDTFwt3R1oycxKedeWUGMKB/NZS
         HG/9izWf2lwEgYhigCuvFzJ4YtAUBRFbgXxNL0pLVT4okrHZm0rtDDUSJ4BQRFzSxeiY
         RI7g==
X-Gm-Message-State: AOJu0YxIB6QNclEwubgJA1t2++oZhmFsYYC/kzPdUVqY6braYqFcl+1j
	KmUQIFxWatzlVsByf00dGx3xApkNjVHmPYcpELcqXY+AuaCVSiS0Z4wlCZ0g7NRFEDHAdy8p8JV
	MkCBsFGIhFzHsHZn0PvHG5i/JihuZ+UCaj1ydqdFn//kcDNboSdtMH0iZ8WFCJQI=
X-Gm-Gg: AZuq6aJP8deRr0HNO7dkcEI3EENdrQ1i8atmTa5I3WTn1IdPfMTlJLEImhWhXYkMnn/
	77fWZrXTdGYL8B5CDadxpdnVBFK69n3paM3NgSGRbzGueSOaEAiwwbmw23iQXGnwsD5Jm2cGxth
	dG81xp5bNdEo61TDpGSViIpoBNh3xRpal3btQPJD6d9o0KdaR90iqv6U6v7EGUs952vlj63VxBu
	N+Ex2YyZgRkVUWXRXBaeulC6X8f4/JjAVL/YJG2uzcNTRESkPEseQm9WEaog9WqiApG4x3Qvv5N
	DgxmJUPFPnPxJuNqVtSHO3w5rCNYzWRyYv9OA2D37vC+DDI6yw==
X-Received: by 2002:a17:906:6a05:b0:b87:117f:b6ed with SMTP id
 a640c23a62f3a-b8faccffef1mr496841166b.21.1771184132961; Sun, 15 Feb 2026
 11:35:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACNYkD4A=omPgoK+EZGuid7=xk5WH1HS8nJja5p0N86J0j4uWQ@mail.gmail.com>
 <CACNYkD5yoQ6E2-dPbAjWPdQ4zQcOip2RwKQmtX5Dv++oYH8EsA@mail.gmail.com>
In-Reply-To: <CACNYkD5yoQ6E2-dPbAjWPdQ4zQcOip2RwKQmtX5Dv++oYH8EsA@mail.gmail.com>
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Date: Mon, 16 Feb 2026 03:35:21 +0800
X-Gm-Features: AaiRm50WGWgGf6AcTDDXJAJw4F0jIHHUZjfIzDFla5tlyNCA-kkBO4FPM8sjuQ4
Message-ID: <CACNYkD4G2Tr6=UE4pJgCCyqgooKQukWbD=cP1RVDmo-ptBb-4A@mail.gmail.com>
Subject: Re: Initial work on adding MPTCP support to Firefox nightly
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

Work on MPTCP support for Firefox is completed and awaiting review.

https://bugzilla.mozilla.org/show_bug.cgi?id=3D1833182

However, this is an opt-in (disabled by default) and needs to be
enabled in `about:config`

I hope this lands soon.

Cheers,
Zaihan

On Sun, Feb 15, 2026 at 4:21=E2=80=AFPM Muhammad Nuzaihan <zaihan@unrealasi=
a.net> wrote:
>
> and here's the screenshot of it workin.
>
> Cheers!,
> Zaihan
>
> On Sun, Feb 15, 2026 at 4:18=E2=80=AFPM Muhammad Nuzaihan <zaihan@unreala=
sia.net> wrote:
> >
> > Hi,
> >
> > I had been on sabbatical from working on anything MPTCP (after getting
> > disappointed by Google for Chrome) and getting my enthusiasm back,
> > i've started working on MPTCP support for Firefox (nightly).
> >
> > https://bugzilla.mozilla.org/show_bug.cgi?id=3D1833182
> >
> > It is still a WIP, as it seems that Firefox "hardcodes" IPPROTO_TCP
> > (0) in their codebase so there might be a lot of work to change the
> > codepath to be able to toggle MPTCP feature in the UI.
> >
> > Regards,
> > Zaihan
