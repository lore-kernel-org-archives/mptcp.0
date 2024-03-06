Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC07714AAD
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 03:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696756; cv=none; b=LyuvEJx3QKviYvkCR8OibiCbSxed2g295XWyRlJin1Zlvjd7Qf30a4OVDXNpud1rXqQ6NhsVxqlk6U4bzndl9tTxazjM3dldA/DW76+8cb8e2TKMM4D/VIQqqvSX6PEA3MtxdzSLkjnUVwUM1IhuJo5CUQ79h205TtgAjxJcEqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696756; c=relaxed/simple;
	bh=cO7JmI1fGSOtIGa7Hln3gnowxPUsGEEqnL4bVjWHDJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=D+xo+Is4GicizD7iYylICPvbFVGYclDd5ZFQaDj87mWOQFrXK0Yt4zhN3fGHLNOkfnjs439OmRbH5ygzL4l0J1413CyKHrtBJ8ayc4CzeIrSW+jl8fobu7i/TrwkiJCehAH0RCLtcPeaIsabXJLsjRO3ico2RY/QW6OVatjEOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCug2gJf; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCug2gJf"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5132010e5d1so1893139e87.0
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 19:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709696752; x=1710301552; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO7JmI1fGSOtIGa7Hln3gnowxPUsGEEqnL4bVjWHDJs=;
        b=dCug2gJfGMMvA5ibluHe+s2QCKmT012xjWDI8eu999Yk4hcmr8RYX/R6Mg4VAgRBAq
         aaAQFfBojJI2p9GZJtT5GTGtJEHrYemN5b6lSxios0ziuPO6YTqwv3Je6egO5e6XPvAF
         Wpxge7YLjnHIATDRJ1Fo8RKGJQEnhizCg8sS4Ly7tl+/CL2jWTEEdYkxN4nT1SYN+C8r
         xxUm6NoXJ7BZQlN3EsPow1XnxGVJLzCLyZo/pYHCaDB5i21nXT4eVigF1kMtvA+P+o91
         5iOUiq2ETOYxBQHzWl6/0eEeBTnHDT1DOJw8p/bXbaMGmjPhh7t4VnzJRiBsjAnjD9qt
         OyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709696752; x=1710301552;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO7JmI1fGSOtIGa7Hln3gnowxPUsGEEqnL4bVjWHDJs=;
        b=LsGcHNnFS20uyz9kRJw5UnJDdey1BMbGwMSfBmweIYBT7PiCKaS+mFv5ELKcPcWlB7
         2i+0P9KTfH+iPpAy0WtBe9xcxzUakqk7puaLjscaKkqJ87bnKhjBVfwkgQyek8Jrtb/9
         bQJsmtr/ngB/sdqPnpPiU06XOddWpiIrYgVZq7P/deWxv02AlYHKq8oksETMTZVSrOHJ
         p4XicrBuaZnxF7W3V+QkzUJXkEr3XBQI6yjOoDHuYAK+DmLV5HKLJNOF0GQvaeLxSJDd
         jtuLcGGe2GQYx68doJ9/4Va7+rByJYEUB8VsWufrdm4roHjxFwwwYPrdRqPZpsg5x3kg
         1DAw==
X-Forwarded-Encrypted: i=1; AJvYcCVghlbCB2gQ9bvyfQZ/GwoF62NKKzajYBzWcVdM0EZ5qmoYNK2Wnlt1Sh00unAFc1Fq3G7Im+ndwEnfeTBkb8WAJEjmX7U=
X-Gm-Message-State: AOJu0Yzs/Y/iRTLUVNe3d60CqDmrxz62tVgZkbctR+YYzyhruJtd5XJX
	KGesUEQTvXzDXhX5OKon5y/Z9e3Jc1ZRCHFt+VUucUXwFyUrKQ9WJWaw6D/lq/87SsIoD+TEJcZ
	CQ/Vt1uQEn0CgvKW2JCOeJxWJDYvwV5sR
X-Google-Smtp-Source: AGHT+IGsGhDODHBn6Ugn7FAAVy4sL+3g4dFS7Oqs3ZnAhJ+cKyo8jj9tHh6jm6l6pxsEcohutWV6viCqaIJMDVOZ50M=
X-Received: by 2002:a05:6512:4892:b0:513:10ff:cd4c with SMTP id
 eq18-20020a056512489200b0051310ffcd4cmr2390489lfb.46.1709696752398; Tue, 05
 Mar 2024 19:45:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com>
 <724f9aa6-b66a-700c-a411-5aa19768af53@tessares.net> <8c868c93-86a0-39ab-57d6-e621c833f8bd@tessares.net>
 <20230713070345.GA19473@localhost.localdomain> <c43a99a1-72f0-7ae5-c954-6d1932a7956d@tessares.net>
 <CA+WQbwsnoGTfwc1R1svxd7fVk7_b5+6ZdT7f=X7jkRkigmRp_A@mail.gmail.com>
In-Reply-To: <CA+WQbwsnoGTfwc1R1svxd7fVk7_b5+6ZdT7f=X7jkRkigmRp_A@mail.gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 6 Mar 2024 11:45:41 +0800
Message-ID: <CA+WQbwuOGYVGmYGVtTNB4uLxH3B6HBuufQQku6rBKLoLACjZ2Q@mail.gmail.com>
Subject: Fwd: [PATCH iperf3] add MPTCPv1 support
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Geliang Tang <geliangtang@gmail.com>
Date: 2024=E5=B9=B43=E6=9C=886=E6=97=A5=E5=91=A8=E4=B8=89 11:42
Subject: Re: [PATCH iperf3] add MPTCPv1 support
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, <mptcp@lists.linux.dev>


Hi Matt,

>
> Hi Geliang,
>
> On 13/07/2023 09:03, Geliang Tang wrote:
> > On Wed, Jul 12, 2023 at 10:14:31AM +0200, Matthieu Baerts wrote:
> >> Hi Geliang,
> >>
> >> On 30/06/2023 18:03, Matthieu Baerts wrote:
> >>> Hi Geliang,
> >>>
> >>> Thank you for this, that would be helpful!
> >>>
> >>> The code looks good to me, I just have one suggestion for the commit
> >>> message, one "typo" with the alignment and one small suggestion in th=
e
> >>> code. Please see below.
> >>>
> >>> I think you can create a new PR on esnet/iperf repo (and mention it
> >>> replaces the one of Paolo).
> >>
> >> What do you plan to do with this patch?
> >>
> >> There is no hurry at all to suggest it upstream (esnet/iperf) but it i=
s
> >> mainly to know if you are expecting something from one of us, just to
> >> avoid a deadlock :)
> >
> > Hi Matt,
> >
> > Thanks for the review, a v2 will be sent later.
>
> Thank you, no hurry at all, take your time!
>
> If you prefer, you can also directly send the v2 to repo, up
> to you, I don't mind reviewing it before or after.

I sent out v2 to MPTCP ML and the iperf maintainer today. Sorry, v2
came too late. You can now update the status on patchwork.

Thanks,
-Geliang

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
