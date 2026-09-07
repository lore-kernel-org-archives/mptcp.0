Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498C40E8C1
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765355; cv=pass; b=DVLZV9o4mxb8EhhOL8zrtdYhS4Ohw3J6BaxIJA7rWzEOT6qV3s73dBK1YQ2fTK9/cbH3p4mQonGF4LxixJF94lxjH9XwTphCsvfLTpHcq6bVEV/H84QsdFP8GnP4hlBgDX5ZZLfUs1IwhBvV6hemY48ObbyoxNUBh1XAWmUFDqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765355; c=relaxed/simple;
	bh=leHVZXld9eH9iZDPZ6fIXvSuhv4Lo3E5ocYgQ1ebU9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jg/1Wi9Kc3SvSGgOF3bEgvuN0JuXYGd6OBjZChQGpVuXzD5b+gcYdmHpQEegArXDqFmO27k/mRKRLp9a+FOE4HAW0evMTQ7KR3n1ZOjVX1nM98eOvCBvxnAE/8Gezd64yVcAbhJVtYKajxQKI30BCSX9j4XbrZ8RPeAhmy7eMjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=ur4Z+jq9; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="ur4Z+jq9"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a468f4c547so14891511fa.0
        for <mptcp@lists.linux.dev>; Mon, 07 Sep 2026 00:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788765350; cv=none;
        d=google.com; s=arc-20260327;
        b=JOERJv99lkaB7SWyzlCxBW/BbEFudLNV7FfLQm65NRuCABqkt8RjSWrkWiykrzeEbf
         XdBxSDmjTACGxHXZyZKEpdCxy/ySA3XzLQFbcNwI9w6UP+jR7PFYiuX9WfzigQCaTIuu
         KNmLOMxSPadVql56SDNQO92NCgRt0vfufuGMzzHoWTWO8rwAEG6eWQtEV7jlqkus3yWy
         W62IzZZ0kScWjZX6uWyzd0qBS7TDuNPXOhHs90z9lZ1EZfiWmmSHKxroYKxgXzRJcNIP
         rRz5cXxXD9Fvj8iZOBLdGZyiPdA+NscttvBg6CnExCgeiWWsnsHTpVUp17ONkZ5NyAOh
         a6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WWwKXGzFB/6B7wjEdxdxzEcQwrEfUSJ8Wvetx/HvB60=;
        fh=2IJBJVuC/ZcsjNw+bSc7nUStb3/Ep3kZqxS/biwAxyA=;
        b=Wycez0zliqjwclLgE0vhyJrFLw+V4PMrYtZoiuNISDxaUWCAupDyGykF+JKAFFcc9q
         fIW5pK/zA1DAlmQ+6JU1sSprv8ve2Veyfxc7x59pT41iFAWd1ocygra6j08Xq4S6QBcG
         MU9xipCBRLkjXnkvXmbrs0rVSVM95b/tiKiRmYTO0HO09ljHAw2zHtDOs43gSSdbgvty
         a8jpCO9jmh0zjJQZUud2h7kKvDTWCTyES1/AbhEu17vP3HvRI0Sn8r49S8x4YIA1mkDS
         2BgdN0Bsm6SY8wyvQfmltMxh7uKTVZlhtbFSA73Unbj+FWYtgfiBNtmq7mMxE2NHhveS
         uZwg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788765350; x=1789370150; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WWwKXGzFB/6B7wjEdxdxzEcQwrEfUSJ8Wvetx/HvB60=;
        b=ur4Z+jq9gM367gfE9pL8yD6K21cQfp29WFKhJXz83Y09DL+CxaOO/I8tQ5jYbEQtat
         eBihhRzquWdrdlnWIbSyy1t4uNc1RSNVjCu6F+sXpmo1D0Yr1y1p2/Ml5Bz/34+ve8gp
         d5qhY91jqgxUpAwGWEcEe0LOe26XARA3zFtK0R7jtfry8xninizmOS+zEfzRhviPfXoK
         qF/+Q5X52tUYpCU8qUsnQcvs32fI4PTHZJFTPDCOggAMY+5FyGB8//064Db8V6YfleNl
         1cVzUntl20qWbiL9FAqy/Pv0Vw9tDJeQWa1oEeWyPMBLwus1Hr332AIblhlHNOTVEOWQ
         4olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765350; x=1789370150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWwKXGzFB/6B7wjEdxdxzEcQwrEfUSJ8Wvetx/HvB60=;
        b=npvqakPuONG4vjUDpPe18yeXBjvyWM9L6NuBdiO92YJLgUaYRj5XPkCkFTYN5DkSqH
         Na9KblVaCkwP8Idam3a9cf1l2kc+7PiSEUxDXoFHUCfhwkoV6FFUE6XzW2gwepVCMU1u
         UHS11B7AVSJPQ5KjrJxt0F3/HPWNiBW1is7/IzX05aaFR2QBMzqaaHqhkz85HOr9/tHo
         /Q/FDylM8NaUgjyA7VzszkRWcovPcQAx/j6U8AiYhTkiXxG7ga1PDNQC5uxuSmYzyCNh
         yQ3uJD09dEzuHMqKBGNg9f9HetNYDVBlrI0rZliFRhjkhX8urjEynyEwWB1JAdF0EXj4
         pq2A==
X-Forwarded-Encrypted: i=1; AKwUvBwZV/oSZxiERO6a8ukX4BZOc0nry6gx4YbsV5QUlxmtJUAqCZFzLmtd2Hh0t0WaPVk+1SGiyQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lombrurlUE2Rl3JHyuDMlvjdWTbhseNfxJsa6KUzcvqlEbntti
	jQ7MJvGVRvgD1KRRIZEj8UD1J5J9oO6VPn7UGX5z3/ejjy2KDOKXJGsGK3xbSBeaLaTnbfUNPdx
	oT2GMdgNA75Y23tfuOWYRYjwBL9j/K0+4yf5e3WhtvHw=
X-Gm-Gg: AYBFou3uGbxUQeHIFmUTHSpTI+LHvAfgfN2kTFal+YAv3heeOqLBtohxSXBBJsQDdb4
	qv0BZ92WoDa78EjBcZfs6uDVpkgu1NX/R4BTyed93O4bU/bOBOCQADUHFFuDGU/O/t06iZsF/md
	1YWKh2rcSbrm8rS0hhHrn/RASbHLUifR3UYC3alIy/CNkcNk9IeLB7dPnqoRh4ZLe5YuSR+pkaZ
	mxuTNhDe68hdOI8eD6MojEHWq5QqgJZgRS1gTvRJLnfX+swCJVflJpGIWey6e/fbC5GpdKyvZoY
	TMT+jkSVVExohwPdFHJ7diOCQjKIPG0jdX0p2of9eIkzelrhHFfBhTgaEQGgfJmJghYwstDsE+A
	=
X-Received: by 2002:a2e:a98e:0:b0:3a3:2a41:c0c4 with SMTP id
 38308e7fff4ca-3a371bdb9ecmr21466191fa.14.1788765349741; Mon, 07 Sep 2026
 00:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cdc628415cf10721480a51ce14837f846ec778c2.1788248601.git.zihanx@nebusec.ai>
 <178875495405.219967.5594821749566554418@kernel.org> <CAANe3eRBOQud=bMgLnPbD_yUYUkJtT=GBqtY+GR0ZtU0_kbzhg@mail.gmail.com>
 <CANn89iLn+Xi9cEphy3nR4bGnFCownrWa9rTZ=AnijArDFo2O7Q@mail.gmail.com>
In-Reply-To: <CANn89iLn+Xi9cEphy3nR4bGnFCownrWa9rTZ=AnijArDFo2O7Q@mail.gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 7 Sep 2026 15:15:37 +0800
X-Gm-Features: AcwNN1VAmgJsxlkj9OvW4LjLVIy_57TEsN_AWLvPrdkLDxAVfSNlHuWjRZ_THxg
Message-ID: <CAANe3eR=sQeTRNuewiqo0ZFwS6fk=HtxvT6TMGhq8F5Pqdxovg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: diag: bound bucket lock hold in tcp_diag_dump()
To: Eric Dumazet <edumazet@google.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, gnault@redhat.com, fw@strlen.de, stable@vger.kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 3:06=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> > - bind cursor UAF / dangling tb2: valid
> > - unconditional sock_hold() on unpublished TIME_WAIT: valid
> > - clearing s_num on cursor mismatch: valid
> > - lockless cursor-membership checks: valid as a concern
> > - commit message overstating bind/ehash fill-under-lock: valid
> > - missing note that MPTCP needs the follow-up patch: valid as a
> >   backport note
> > - endless re-scan of the same bucket head: not valid as a
> >   guaranteed livelock; duplicate output after a rejected cursor
> >   is valid
>
> I just saw your patch today. This is absolutely insane.
>
> Please limit the complexity of a filter to something reasonable.
> Absolutely no sane user is using a very complex filter.
>
> Same for UDP.

Thanks for the feedback.

We will drop the dump-cursor rewrite.

A follow-up can cap inet_diag bytecode complexity in
inet_diag_bc_audit() so TCP, UDP and MPTCP dumps share the same limit.

Please let me know if that is the direction you want.
