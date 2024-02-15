Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7313AA2A
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027079; cv=none; b=BQtvT/HHle7HaQFMVeRez+3aX5y5CDke0gbJ3zp39cSzumpa6l1JT0w76W6TyQ89qT5l1IHlqYcK8jBj9UE5+hh2ltRCDo7pGV6X1NoBfbdwmdJwD4tu/CkKGPQ8IcExUVT7UgLm6PqYy120kQEPaFFP/lJ0Tq0QSccoMAGx5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027079; c=relaxed/simple;
	bh=Dn/+lUnm+Dskc6cxU48td2b9NBJKmAVPJGzAU7aARwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+Rc1MeDgX62aE2EFVLz7qQiOsRudt08xSOXc+HKFCW3p0THRj0mZcOt8w7sbiGZ5hiw3bJr6XTLr4g3HMNWtEBHcbBL9f0RzLeRKXIlqneuAkBY+zKwgDYh0KlV+EdRa8xhUzjHFGSPvzLzKyqsnqqUdnB63m/acbfcHNmmAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kd6JQxUC; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kd6JQxUC"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5c257452dso477001241.0
        for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 11:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708027076; x=1708631876; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGZwULsr7/JZu7+F4XUfP0xvOqUtS8xAVSixm8qqZe8=;
        b=kd6JQxUCcvFv36gUYkIEt6Vbyn/hk6gsQfqb1OtyXvdYjf90rh4xf1nByGvpyhxjqw
         1oO+W5psiL/cXfA9WfEoGEZ84EXHsw0j3IQxtbMJu3EWppHnr0je9nfEFkS5cY+CevYY
         GIKmQ9P3eqOnzyqPilxuosILoj1ZWRLh6yWYMFepOi5hJ9qLD9RutOblzQoEuOVIwpIn
         g1p/dTukFSgcsRdx4vM0y6fLm7vuT53B6cChwRemC0MeN7nJikfTdR26EClDQjb3IWap
         BEi3qFY4V6BVokhoBomSZY/nveawE0RguUJOTMuY+oUbJVrrKmQZql7kpjF5FgBZGwOG
         8axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708027076; x=1708631876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGZwULsr7/JZu7+F4XUfP0xvOqUtS8xAVSixm8qqZe8=;
        b=LvtI4hiBOP3hW8vw0x2PNYNXERekeOQ9upEUdCj4sGz93Kb62/qjMUjEg3Wjga3FGb
         bd6nyQaTEYrjwtZQ9or8Sbv4Fm6OsmKq5pph+5scHF6nqIgQUC3I1hp+M5nXzLUb+d07
         cSIo0RC05B9Wt3RcD7SLKjxYjlfBVifWuBdDNsypzum3OkUDRJX2EOF4Kbvb/s6FJXe3
         IxZjTA2kIQkA4wwiCjaj/IceI+lF3nhG4mrykRRXVomywCCKPzHz0byebnhjlbF0xJY6
         mfYPMyJfat5x7R4ApDa+ck9/QRedW9Fs3/3nxt6DFPf2YMTunZeQ9q1PyAjyoBZBHgiT
         OkQA==
X-Forwarded-Encrypted: i=1; AJvYcCXr0RluKKBpmQHiJ6WQCRy0qz1w8wgpdjWfM8G6UphWEKstpqDXraQSq+QIF9POFKkHRK0IqFeh4ij6FMDSJXOfvzE67yk=
X-Gm-Message-State: AOJu0Yx1DCEvaZiMPIZhF+K8+AVvSGdF9NGfMwZZDrxEdaLzi2BH4ffz
	J3PwSK/XbADE67H426OR3lr4Iju70ttbzPzQKFFfsDyNantqnS5yg0OBsoxSc0HqxkFP7tnBifD
	//GQw0PEtqnTamHX7HrmXrmEAH3V74cnZgVoF
X-Google-Smtp-Source: AGHT+IH+qNqeabpjX+fGInAxnMg+7mbZ/vsNhCFlI7FcTykt+Vs1sE0er6JySes2o0SSUf1NKP0g0rU7xeoAR0Cy75U=
X-Received: by 2002:a05:6102:5f58:b0:46e:ba1f:a754 with SMTP id
 il24-20020a0561025f5800b0046eba1fa754mr2636446vsb.12.1708027075782; Thu, 15
 Feb 2024 11:57:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240213223135.85957-1-kuniyu@amazon.com>
In-Reply-To: <20240213223135.85957-1-kuniyu@amazon.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 15 Feb 2024 12:57:35 -0700
Message-ID: <CADVnQykqkpNTfO30_aswZEaeSkdu5YNuKag++h-RSguALdeohw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-s390@vger.kernel.org, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Rick Jones <jonesrick@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
> removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net:
> remove SOCK_DEBUG macro") removed the macro.
>
> Now is the time to deprecate the oldest socket option.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

I would like to kindly implore you to please not remove the
functionality of the SO_DEBUG socket option. This socket option is a
key mechanism that the Google TCP team uses for automated testing of
Linux TCP, including BBR congestion control.

Widely used tools like netperf allow users to enable the SO_DEBUG
socket option via the command line (-g in netperf). Then debugging
code in the kernel can use the SOCK_DBG bit to decide whether to take
special actions, such as logging debug information, which can be used
to generate graphs or assertions about correct internal behavior. For
example, the transperf network testing tool that our team open-sourced
- https://github.com/google/transperf - uses the netperf -g/SO_DEBUG
mechanism to trigger debug logging that we use for testing,
troubleshooting, analysis, and development.

The SO_DEBUG mechanism is nice in that it works well no matter what
policy an application or benchmarking tool uses for choosing other
attributes (like port numbers) that could conceivably be used to point
out connections that should receive debug treatment. For example, most
benchmarking or production workloads will effectively end up with
random port numbers, which makes port numbers hard to use  for
triggering debug treatment.

This mechanism is very simple and battle-tested, it works well, and
IMHO it would be a tragedy to remove it. It would cause our team
meaningful headaches to replace it. Please keep the SO_DEBUG socket
option functionality as-is. :-)

Thanks for your consideration on this!

Best regards,
neal
