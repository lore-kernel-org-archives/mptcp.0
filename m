Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F8DDC3
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617698; cv=none; b=mm6hKxrwBWTL2SFojKU8ZSE4c4tUMjGGI9K+N1Q8X0f58F2hUNpMlBfQLl/WLRk016+lJtiwyZsrgg7BOVB72Kw66a4VT/JUTKPXPPFqYJDawbicHa2Mvs16Jf/w4DTv3fmf+7HkmuSFeqsr9FftVuLR4wXHjvcQVNslr89038M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617698; c=relaxed/simple;
	bh=yiH2T0K5AZfLS/wNLZVoH57xHOL5iWJlwWq73lcSA6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOes3lUlPwesq7u56k/lq3ttvGh4t+tFQ7Ct4qO7VvXUWev3dc8SnXGCN61hzoSlYmJPeTDmXIe27Prc/jfPbJxSzEWud8WkyyZp4J7LuO8f/tRQsJVl6Gf19fj88nMwEooqZVF7QwyzyJ1z350xbhS4aLNgPgSbEdUVv7VT+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Y/GP8lql; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Y/GP8lql"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f753ec672so1237951e87.2
        for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1757617695; x=1758222495; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFclyJxKwln8BXL6YRryf+mAOfFTk3ejrSQldp2l5lk=;
        b=Y/GP8lqliyYveOOae0r+SIecvnEkDNxdk4BUpSLmy7ikqGTZ6mrv6oic6PS58+CZzp
         uImb+m83ooOAkCRkHFQcAbZUDp5dEgiQB3EmdB+3p8jVWDE/WHTGG+iJy+HtiseOhtCE
         M+J5oeJHGXahVL2jnlSpTSYGpjkizB7EOIC6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617695; x=1758222495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFclyJxKwln8BXL6YRryf+mAOfFTk3ejrSQldp2l5lk=;
        b=pB1bw6qNIlJ5ZZ/vUJcd7R3NnC2F66zUgiH7cyU4bXrf/UaGDI5puHXxA9VLfJ+6Rw
         MM0dm61jxLBZdVx+6J+FsF7ufIRLfRtf9X1zf/Xc8BvWViDp+O0VwSrxuX2gYzNVrjUX
         7pcTkkDvzozP8YmmKlRtuKsgPwFmVfYBduHkUn0c4jCyzM3ehaLJLPu1s/85v4vKlnGp
         mKCrBWfJzPPdBRe0g1TbzNUm2kAO6kroXMcQrlQgpvAX7gAsEtwZ1nwwGLjkv6e3Fh5c
         9qnmWg3rE4CbkRQiTlIWg4PF5fOzlIpHhLdJFkGOjL0y0v5k8DK5ydon6I/BbnQm76Pz
         SLDQ==
X-Gm-Message-State: AOJu0YzWS2EssSzO3C/BFWMvdD13oy6RtDrpgX8OGHuVgTmL/4hM8BTX
	LxhNiu+M0luypml4AhXuxMiUdkya/o3lTni4SUQVJOUqTCYSORCEXvk71XLu8Iec5h/eroJeo9k
	8HXSGjraAOv3C9QmHTK2G80227hpJQT7Y+ah8nSBrPGxKKL+A5+aMJps=
X-Gm-Gg: ASbGnctLVE6xw6EfaLtwG2l4zndM26TX0cARSJ7Gby8/NkkEinvNTd/FQzFGerm11Dj
	yiseTDWr9KVHhfH63+BjsP16LceXYfgEXP/zKKSFdObujvzQPiz1KD1fhdk3J90l0vAg72AkScI
	DEAcM3oLJQ5XT9DVqw5MZa7lC3GFi+6lfpKe3IORZTisv7pLFtJVAtOJucKIaujjUpsgVRZSCe4
	cvU0fwNWyfLWejYVJYPxibjKph/Ck6B7HI4eH3JkQcbB0aBW8w9/ZOwSWpsjmwf+S0nKORnsg==
X-Google-Smtp-Source: AGHT+IHkKBohK1vufUYw9Gd6mUzBuO3KvzPHLjZwfhHCZTqTdUjKKDCaBQiDBNo/t6F+czsW2hlii76eLRf7uwo+/0o=
X-Received: by 2002:a05:6512:2346:b0:55f:4b01:30ab with SMTP id
 2adb3069b0e04-57043af5d53mr170059e87.0.1757617694651; Thu, 11 Sep 2025
 12:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
 <20250910-sft-mptcp-disc-err-v3-1-6799fa467d77@kernel.org> <ba8c54a8-3ad8-4ae5-879b-05f6b6a45319@kernel.org>
In-Reply-To: <ba8c54a8-3ad8-4ae5-879b-05f6b6a45319@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Thu, 11 Sep 2025 12:08:03 -0700
X-Gm-Features: AS18NWAWNJSd_zaB3kn1fEyR1G6u2YbHymIibfk75C2Vna2-Pu9ztbxdA-JMBJI
Message-ID: <CADg4-L9JGT1K9pjXOtL-SjvHTz2yAW5bXAqK-6J8OJZRw+fx1w@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v3 1/5] mptcp: propagate shutdown to subflows
 when possible
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:32=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hello,
>
> On 10/09/2025 10:55, Matthieu Baerts (NGI0) wrote:
> > When the MPTCP DATA FIN have been ACKed, there is no more MPTCP related
> > metadata to exchange, and all subflows can be safely shutdown.
> >
> > Before this patch, the subflows were actually terminated at 'close()'
> > time. That's certainly fine most of the time, but not when the userspac=
e
> > 'shutdown()' a connection, without close()ing it. When doing so, the
> > subflows were staying in LAST_ACK state on one side -- and consequently
> > in FIN_WAIT2 on the other side -- until the 'close()' of the MPTCP
> > socket.
> >
> > Now, when the DATA FIN have been ACKed, all subflows are shutdown. A
> > consequence of this is that the TCP 'FIN' flag can be set earlier now,
> > but the end result is the same. This affects the packetdrill tests
> > looking at the end of the MPTCP connections, but for a good reason.
>
> FYI, I don't know if it is linked to this patch, but the CI recently
> complained about the "dss_fin_retrans_*" tests, in debug mode only:
>
> > # dss_fin_retrans_close_wait.pkt:27: error handling packet: timing erro=
r: expected outbound packet in relative time range +0.200000~+0.300000 sec =
but happened at -0.017265 sec

What is more suspicious is that the time is negative. Do you capture
pcaps when running packetdrill ?
That would allow to see the "real" timestamps independent from
packetdrill's scheduling issues.


Christoph

> > # script packet:  0.791882 . 1:1(0) ack 2 <dss dack4 3007449510 dsn8 80=
67261375896427910 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>
> > # actual packet:  0.574617 . 1:1(0) ack 2 win 1050 <dss dack4 300744951=
0 dsn8 8067261375896427910 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>
>
> > # dss_fin_retrans_established.pkt:21: error handling packet: timing err=
or: expected outbound packet in relative time range +0.200000~+0.300000 sec=
 but happened at -0.021432 sec
> > # script packet:  0.791877 . 1:1(0) ack 1 <dss dack4 3007449509 dsn8 86=
29039693965256448 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>
> > # actual packet:  0.570445 . 1:1(0) ack 1 win 1050 <dss dack4 300744950=
9 dsn8 8629039693965256448 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>
>
> > # dss_fin_retrans_close_wait.pkt:27: error handling packet: timing erro=
r: expected outbound packet in relative time range +0.200000~+0.300000 sec =
but happened at -0.095031 sec
> > # script packet:  0.745018 . 1:1(0) ack 2 <dss dack4 3007449510 dsn8 18=
052974533214962003 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>
> > # actual packet:  0.449987 . 1:1(0) ack 2 win 1050 <dss dack4 300744951=
0 dsn8 18052974533214962003 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>
>
> I'm not able to reproduce this issue on my side to get more details
> about the previous delays. Please also note that a few weeks ago, I also
> reduced the tolerance by a factor of 4.
>
> Because it is happening only in "debug" mode, I just re-increased a bit
> the tolerance on the CI side. But if you have an idea of what could
> cause the kernel to emit the retransmission faster than expected, feel
> free to share :)
>
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17638263507
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17638077933
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
>
