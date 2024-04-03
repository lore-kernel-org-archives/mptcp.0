Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78B15697B
	for <mptcp@lists.linux.dev>; Wed,  3 Apr 2024 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183351; cv=none; b=VTDxO4qEKW+A21uRpgVBqKVlYTfGyrtI4SHdY9GgqPLnsnk47JKp/wKqV4Beq7DfiOnAPZ2JvdNuDDOPgwgAI8qOBXDD/aAUIYJrVYBSYjTNcNZOdSFPcwWkzXolRwp3MP0qrZS3wHJETFln+rHnAqWqX44oTaQDusGJNaEt89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183351; c=relaxed/simple;
	bh=4aLkd10Lo2WhHC9i/1cfAE1l2UBmEvaje1UIW+so6jc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=p1NRLUPde2eLFWGSpeJUix8J0sCkR8w6G2eioL7R2rjPY4CHCdNfojMZkowFqm+Iu1ccQj3oSD/s07yr8iNhcUj9586i0UBMgcESJGDAldYSsH4EWrFsiaXzyM3ktEjSxadQB8uPBkc+xSZy99iCXFEsbvmYl6/FqRFT0PwU5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ea9m5x9N; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea9m5x9N"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-369dca89e26so1269165ab.2
        for <mptcp@lists.linux.dev>; Wed, 03 Apr 2024 15:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712183348; x=1712788148; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yLZU73RnPM4fYtVO+QurfgtkvmbTz6ysxGe01JcUXk=;
        b=ea9m5x9NWlkJNOxc3Jb0+OR54ODaNfJVOhmUBdzBWTRN68pbytuPD4cCKKwCj/mus4
         cdW43e1xhDjilak57w1YeedvNPazOm8sFhRilFpH8yS8nFD3TPLN+O+wG+t6JCyiydzZ
         a6s0KtKLU4DscjdFHP3jJBuqM85+n6N85lT4DYxGokwwMkHD7jrxQbB3g9s/bS8v/60Z
         Me1WGQn2DUfu8ZygklYWlyMNBlRmUOHI9Apci0GvS+4S1s7B/YV64k13lY3rDxjplMld
         6++2f5VqUMwpWK4cBpaxU4inVkiJX8N7HCvpiPZuxB5NWUm3+ere3u1Kw+GZZb6Jm3Tz
         C1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712183348; x=1712788148;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+yLZU73RnPM4fYtVO+QurfgtkvmbTz6ysxGe01JcUXk=;
        b=CeVrvN+70IZStiEyYtoGCrvboTaZXsgJbD4OBrI1DQMwKsIQCgwzquu/RZKcLrnQAf
         obvloqQ95WGxXP2SZ2/dLyB5G7PdjLhRd+iacsb9BgolXKX9MDmGW+Y+u8tJRu721Yx0
         p7ac0yekVenvYDe2KIMmUl1RfQIac4uzG0wmQEmVrbIdj4qo6FUAZqyYBxymc81sNGq4
         H1QrmpjuQaIk2QVMQLLB3CQSIHy+X+ljRu/A8h53o7Q39mUL9VI2JNEl20vIB9O2ooZf
         LKCvurQC99b8fdlDJydwKSaljI7hZfBEBHVc6nQ+C7j6Ik2l+9tOAAMlMWug5QlmSO56
         hp9g==
X-Forwarded-Encrypted: i=1; AJvYcCX47Of2lILlwIYwOXSEmVKgjxcGtxPcaEusj6T4rW8UPRT7ibP5hj4z26x3+uEvW4GEs4VhKrgaEssocL1Y1HaQVZI4e5Y=
X-Gm-Message-State: AOJu0Yws9zWmWJl1d5n1/zl3Bs6SsqEuTbx2OWks+5905fAXxBu9ZyYp
	Hm7qGbhXxEAuwxFK4OaebwbIAnAtdWkCRzWphjEtUbm4DL73mQDP
X-Google-Smtp-Source: AGHT+IGQ239+0H7dF1jVYOz+dq1I6fdbYYS0G35Vn3uTj/gsplQWSsBrOhDL3zzDweZlTcToq0cBrg==
X-Received: by 2002:a92:c241:0:b0:369:aa8f:c199 with SMTP id k1-20020a92c241000000b00369aa8fc199mr1292301ilo.2.1712183348446;
        Wed, 03 Apr 2024 15:29:08 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id k14-20020a635a4e000000b005dc832ed816sm12163575pgm.59.2024.04.03.15.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 15:29:07 -0700 (PDT)
Date: Wed, 03 Apr 2024 15:29:07 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, 
 bpf@vger.kernel.org, 
 mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org
Message-ID: <660dd833358bd_2144820881@john.notmuch>
In-Reply-To: <878r1ubq8q.fsf@cloudflare.com>
References: <b67101632c6858d281f105b5d4e1bc62dd6b7d27.1712133039.git.tanggeliang@kylinos.cn>
 <878r1ubq8q.fsf@cloudflare.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add F_SETFL for fcntl
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> Hi Geliang,
> 
> On Wed, Apr 03, 2024 at 04:32 PM +08, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >
> > Incorrect arguments are passed to fcntl() in test_sockmap.c when invoking
> > it to set file status flags. If O_NONBLOCK is used as 2nd argument and
> > passed into fcntl, -EINVAL will be returned (See do_fcntl() in fs/fcntl.c).
> > The correct approach is to use F_SETFL as 2nd argument, and O_NONBLOCK as
> > 3rd one.
> >
> > Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  tools/testing/selftests/bpf/test_sockmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> > index 024a0faafb3b..34d6a1e6f664 100644
> > --- a/tools/testing/selftests/bpf/test_sockmap.c
> > +++ b/tools/testing/selftests/bpf/test_sockmap.c
> > @@ -603,7 +603,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
> >  		struct timeval timeout;
> >  		fd_set w;
> >  
> > -		fcntl(fd, fd_flags);
> > +		fcntl(fd, F_SETFL, fd_flags);
> >  		/* Account for pop bytes noting each iteration of apply will
> >  		 * call msg_pop_data helper so we need to account for this
> >  		 * by calculating the number of apply iterations. Note user
> 
> Good catch. But we also need to figure out why some tests failing with
> this patch applied and fix them in one go:
> 
> # 6/ 7  sockmap::txmsg test skb:FAIL
> #21/ 7 sockhash::txmsg test skb:FAIL
> #36/ 7 sockhash:ktls:txmsg test skb:FAIL
> Pass: 42 Fail: 3
> 
> I'm seeing this error message when running `test_sockmap`:
> 
> detected skb data error with skb ingress update @iov[0]:0 "00 00 00 00" != "PASS"
> data verify msg failed: Unknown error -5
> rx thread exited with err 1.

I have a theory this is a real bug in the SK_SKB_STREAM_PARSER which has an
issue with wakup logic. Maybe we wakeup the poll/select logic before the
data is copied and because the recv() is actually nonblocking now we get
the error.

> 
> I'd also:
> - add an error check for fnctl, so we don't regress,
> - get rid of fd_flags, pass O_NONBLOCK flag directly to fnctl.
> 
> Thanks,
> -jkbs


