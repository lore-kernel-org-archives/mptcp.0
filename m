Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63A63596D
	for <mptcp@lists.linux.dev>; Sun,  5 Jan 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736065970; cv=none; b=DpJ8S715cc2ZWRMhPWklTV9k15uq3MJWZmYzHdQKlbl+Ua1bm5QKOLfNPYkbUUWnTsdse7xQdNaMVr5xbpfv9M7cNByCQjUjkwoI5/BoBAUgCbKuEXLaDTn/5ZHyQSlOkB6t3SUrwkTEZr79HFugqG+60Q8GQfrVvpqebKMvjQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736065970; c=relaxed/simple;
	bh=FKhLkLaZUareZFduZSPJ/xQrSRZu2qocVNeIWlOCBy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsmU9WCSSQCUv3tEWqRWQdcy/SoG3aOOKSJKh7iddVQ5I1nhn66J/TqhainIVoR0RoPdhnNFQ/WrKkaVBOMxEcKAid41cJQRL1m4KC6oNKD9+cKNK+rO/XU0DRq/Z6x8TFJrBi/mmTt1Pip3jPFG5rg/coa5uLrJ8OZB/EwYfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FH6BA2sC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FH6BA2sC"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so19854346a12.1
        for <mptcp@lists.linux.dev>; Sun, 05 Jan 2025 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736065967; x=1736670767; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feky3fOQIBZBCqyXt7+3X9e4oX7Q5OHhgwGJckV1gq0=;
        b=FH6BA2sCuK+INjkZyFntHB1ba2KOI7+D71zEhMzLMUN7l0MLbwcPzNZl8qNziEybV4
         GkRGAGeXTfJ5LpTp5AmVgNboZqWYZPS9BEg69t7jzUjUURVqn0GYU8ybD4fTSz3d2T6O
         3A9FCwygRrMDgl9k2kXIWbH1z7JPRXtx3WbYNJbyv78ismzBIci/mf577IAelNJTHrOD
         2+zAu8OO7+MOWSL9wg5YwQiKbVKsXnfyWsHgj4m4fceAyTN4mVMhHKGMIWB879KhJVNA
         kDbxyMSj3H/AGhEu7z9VsM8Doxwta6P2CMZ1XoidDfblSuxOiFbFM0WEfqNPotTo9Hoh
         7hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736065967; x=1736670767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feky3fOQIBZBCqyXt7+3X9e4oX7Q5OHhgwGJckV1gq0=;
        b=S9KGx3P4MBfPt0Vo4DWHLRLMEP2R4LBK7Iw9F2sML5mD4oZ0TQPkTPt3ZQzbpQgiKC
         rbxi4EAsi5HXB8E46uYLSZlxpa5v9m7kL8CTy3VZvoTVB4LiXy/sb2SthXxSMIANnsCe
         5gvWgGDqvizM1zIEcOfnyokQzuJYr7AfUHZSSEzl/JbH3CjtffuUGjkDr9OJCV0kqDSu
         oRvVsTyqQYbzHv69pb5EAXvCy9XRGb+O5a9Wfzxpk3QbywaIAydAY1hibxr5rWXXLlXr
         rWwMVQjvoXJ1CzPC0Ru9uNnm+UmuebuI12Ph7pKWzpEdNENB8ZpFsKdBjIjFHIWjmpsn
         hsvw==
X-Forwarded-Encrypted: i=1; AJvYcCVPHggrIlNDPQeSFzYTRvyHXZdCEftAVjfR+X115DRaxBV1YPwrosuTxfvNmt/kAwDSyCU1gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YynFljKnwLbKfWCsbQyUMVVDJlG/AyN/0+Pf9Z6WFEywCUoDp77
	Jp6O6ak8qvzuEI4rNZiqK9VuZnmJfKeXNpSUiv0RLGav5277UQD7Qq03A2iTuLomWE3BFjo1BLk
	St/+V9tf/DZLPO7m7Y2t+yAMFHu5ClKl2Dqg5
X-Gm-Gg: ASbGnctTqO3MCjcBvpYyx6f+yoq5AvIg1HE7SLBAisjZ23PXn5BEz14x0rnMbQkHmFH
	CwXJt9tObB22l/DxOU4WV1mUHpLVb8DmqcIi4UIA=
X-Google-Smtp-Source: AGHT+IGxTAgQM1VW1kke0fyltXylhZqkT4C5ZvsfUhJY238xnt5+cxsJ2MB3kfttHW/OBdAMBhnYzQL89o/Vv7ojjkw=
X-Received: by 2002:a05:6402:5245:b0:5d3:ba42:e9fa with SMTP id
 4fb4d7f45d1cf-5d81ddc01a0mr133299931a12.16.1736065966986; Sun, 05 Jan 2025
 00:32:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <67769ecb.050a0220.3a8527.003f.GAE@google.com> <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
 <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org> <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
 <20250104190010.GF1977892@ZenIV> <89c2208c-fe23-43eb-89ef-876e55731a50@kernel.org>
 <20250104202126.GH1977892@ZenIV>
In-Reply-To: <20250104202126.GH1977892@ZenIV>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 5 Jan 2025 09:32:36 +0100
Message-ID: <CANn89i+GUGLQSFp3a2qwH+zOsR-46CyWevjhAQQMmO5K9tmkUg@mail.gmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 9:21=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Sat, Jan 04, 2025 at 08:11:49PM +0100, Matthieu Baerts wrote:
> > >> +       if (S_ISREG(file_inode(file)->i_mode))
>                 ^^^^^^^^^
> > >> +               return;
> > >
> > > ... won't help, since the file in question *is* a regular file.  IOW,=
 it's
> > > a wrong predicate here.
> >
> > On my side, it looks like I'm not able to reproduce the issue with this
> > patch. Without it, it is very easy to reproduce it. (But I don't know i=
f
> > there are other consequences that would avoid the issue to happen: when
> > looking at the logs, with the patch, I don't have heaps of "Process
> > accounting resumed" messages that I had before.)
>
> Unsurprisingly so, since it rejects all regular files due to a typo;
> fix that and you'll see that the oops is still there.
>
> The real issue (and the one that affects more than just this scenario) is
> the use of current->nsproxy->net to get to the damn thing.

According to grep, we have many other places directly reading
current->nsproxy->net_ns
For instance in net/sctp/sysctl.c
Should we change them all ?

Perhaps an alternative would be to add a generic check in
proc_sys_call_handler()

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 27a283d85a6e7df1a7edbfb513ce75832363e2e6..84968b10ce86e7fd88c6e3c43f5=
2b601394b056f
100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -576,6 +576,8 @@ static ssize_t proc_sys_call_handler(struct kiocb
*iocb, struct iov_iter *iter,
        error =3D -EINVAL;
        if (!table->proc_handler)
                goto out;
+       if (unlikely(current->flags & PF_EXITING))
+               goto out;

        /* don't even try if the size is too large */
        error =3D -ENOMEM;


Thanks.
