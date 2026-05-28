Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ACC3F8EB7
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983997; cv=pass; b=XzWuvkPlgZqTQknReMy/8z5YvFIQBiUKRO5ZdiBLdLxddbdw0G+G6Md9sbLRwa0MmWxoAeZ+c8iSchk/MYFlUdX4+0bSiu3mM3InHClEVjDfnSVMTvDsnd8UXrIXZ0u1kzeMDGkMGbs590pbU8vrQC209y/wxcg5rCMJyyaoetU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983997; c=relaxed/simple;
	bh=LpuX2TLnyFdKbV+wo8B8ePvWG14RFMLuO/BfbhWnfcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0L0xl5TLUdHjI+Nvicwt9BsRBRlf4j1kYD5MPJ36KLSxOxvEylG3R8FZCTspJZEVRp20BZRwOVVIWyHHlUE0bgeV9PG1lYwEvD824dbwDxG8EennRDVp1R/WdsYSYqpr2alGuCtfBCe7bH+zGC/QpvXdFCRqqEUMPVWtcykzs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fww1fBK5; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fww1fBK5"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-632a055fa9fso4788744137.1
        for <mptcp@lists.linux.dev>; Thu, 28 May 2026 08:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779983995; cv=none;
        d=google.com; s=arc-20240605;
        b=Z+aTBvBixeoU6Vs2wqqjoEaWeit8sf1PlLzT/3jLHktUFXSU1Z/EOVING705IFS0xh
         plC2WLBZ6Dmc/yvXEJlYS8SvGP/SBv1+O3tI6pw1xjkIw6HWdkHAbS4zn13EOSfCMvtf
         30LFlZVDXDwo0SV+HAJ/ufQfxDEeSr8WjR/PufK7YXpNho3uL8nqndI6j/hotw7bwxhx
         cHmQkdTJnImW2/Ctyy0qlhcTfVZm+CTOcumPKwb9v1e5XNT7vJWHqPX1EFGS2gz6DMHQ
         2EwRO51GCkZNO2bGNdZlutp2N0H7FmT5fQJsKxO+mv75Ah+yayUtQkSZ+1Wtxnih8fvY
         SSTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLOOhGMIZ2zrbsUnxk+SjYvBJlyszFn/0IXfwu6m6yQ=;
        fh=T/uij7aOwSgpEPlevVz0zWcw/FW5Sn339Mt5cOn3Nmc=;
        b=WiOiqjoejGNtQkHdf4eDRpLld+ImaPkUNmg+hTK/KnGBiC/cm2nRdO10LWmIH+X4+c
         004/fpYnB1qzbDy8eT6TJHiVnA/sDO+jjlJMJkeQ0oTFkTNWqd5quqNTfuUxTaviCsJj
         SVnRZ7ANEkMX9TG3u6MrRnFG/5M3UIFvLK4Cnt4rxggzxMy+7kwMHs7epFsYSk4Zj+kN
         JRX6IbPBLURuIVXuB0vgdmfcQzU6nQun3KyVpjQX89/Unl85NtAcFP56UyvzFsW1pJn6
         q3+8DN0PZ6xDlB1Im3/Y9uSd2qZQuwFs0+YMnH3EzdEvUAP2MyGWaeAmp9JB/ifN7BHO
         +mnA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1779983995; x=1780588795; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLOOhGMIZ2zrbsUnxk+SjYvBJlyszFn/0IXfwu6m6yQ=;
        b=fww1fBK5vkkGJv9zsGkRE+ev3fZHMUBagXgw4JsPqVy0BjG0IVFt+4Hrpi7fswB/5a
         M2lCX1M9Di6fFdhZp5By4t2YahQhjkMlcfnsAdynHUmau7//dai2tu0F1Imq9SHfTO7V
         Pdc3jX3GbZYZFupsPfRrrb4FLuQf9RnpTVs2IvCo72JjMXQIrBlRQSN6ufT0XZNXem6w
         2V2uZgtkKEnqLBqUf7P/VWnU3K4mFLV6QHi9sObL+XvEYdzuN9UQ7tyQTLxq9vj4JLSR
         xfTFHK47amCrJiXtpVzW8+UT/P3g4PelhllAUa9Y/q8nahrju8RXa2F6gYpH2Gm7ixKE
         4ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779983995; x=1780588795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLOOhGMIZ2zrbsUnxk+SjYvBJlyszFn/0IXfwu6m6yQ=;
        b=WTMkQB8U+IAxL0ZcDMzrrWBalTBXBjfBrr0ZmIZpsXRT2Dko+UrXFDKej5qPZVywc7
         IfDZAw9uFaj4t/nEDqSWVp6111SMUo7915lBefsMNG6tX0rPe4pxP088cee+o4d9+qvy
         RNoYP1fr5cdyMXMNf1/0arsX6bqNh79f9UyIF6cH2GgoM9/77lUtNB3Pix40sIGNISjl
         fPJH3xc3Frf1NGIBsxmCmN4t1dPJV5ZFkFrpdXTPUG9JhUT0Kv3qchCb0Ms5xAFodL3C
         g0V6T4cDdiXk3b/lX+fLLMmXqTI835jH+lpPBymPKmeGPoLP0M3u2tIWYiB7glSADhOe
         GeRg==
X-Forwarded-Encrypted: i=1; AFNElJ9tz+GeJYou1j2Fio8L3bOkKTCCR+BCDFrLcoDGzvPBB1+OaC8VWanrfZ8cSi4PzPKbFEII8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwZwEO3qLnX4TzhR/0aMiRblpwx+qPvCHQcM+CsZJOPyurW96z
	iuDGouv1OnbWCMb6mXZsAiIRIjqQGSCyBl0HWKwNvF6Od7tdt5URkjWjA/ilqge08mKXcNtHQ1p
	CDlGDU3ARfmHDENsmkZT3oWOAWSVSRHzIHmlkskxoKw==
X-Gm-Gg: Acq92OFSIcU66FOt4e8j8T/YOcEXTc7d/hTnQbdu+2hPtJyH0QBkgYb5Q8fVfhI2h8n
	nNF4Er/F+VA1b8NgIV2webQTr5wFu3ngR6kPB8y43xAI0dp3iIM9psR31LKs9dVzHgynZZ1uCrs
	sNoNlNzNKHor2XOo1tPJGe/l/ManXk3EInn6fGQ4JO5JdAOkoaYHOGCIdYx/6J9vh91XDHfJrVM
	2vZny6GAjC4YzqNk3ZbM9CZ2qu51RpoQ7c+MwR05HgPm6wspSiKCEBhVqDh1u7g9k3cfpcrPtk7
	A3ElxGWxJBC46rukklUHMnJFLflQVFZkn5QFMTzCufPMLgiLkzlZke28b08L975LVpPaNXlrKCa
	2zELY
X-Received: by 2002:a05:6102:5709:b0:62f:39a9:ae67 with SMTP id
 ada2fe7eead31-67c7ffec833mr13509717137.17.1779983995053; Thu, 28 May 2026
 08:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org>
 <48e429f3-e29f-4eac-b4d3-3bf9e0d1c245@linux.ibm.com> <ecb30d89b67b992bfc136186f18550f9fb974baa.camel@kernel.org>
 <ffc23fb3bc82988608237be48a3eea7fdd3a4dd7.camel@kernel.org>
 <6042b928aa8116d531c5e360ba19fa077af87bcc.camel@kernel.org> <f902be73f83291b732a8e33361bfcdb7e75a0afd.camel@kernel.org>
In-Reply-To: <f902be73f83291b732a8e33361bfcdb7e75a0afd.camel@kernel.org>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 28 May 2026 08:59:43 -0700
X-Gm-Features: AVHnY4Jl8y8OPVw7gHii_tacFLLUBi7Tm1lyVtD_jOzTv6GtL7YFYvt-fktFiEo
Message-ID: <CAPpK+O0i2S-_PZ4Spo6C-MXUV+2W3PaQbfw34D4LcYfAsB13qQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe over MPTCP: Multi-Fold Acceleration for
 NVMe over TCP in Multi-NIC Environments
To: Geliang Tang <geliang@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, 
	=?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>, 
	Nilay Shroff <nilay@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>, 
	mptcp@lists.linux.dev, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:31=E2=80=AFAM Geliang Tang <geliang@kernel.org> =
wrote:
> Lossless network, comparison between TCP and MPTCP using the "queue-
> depth" policy - MPTCP and TCP show similar performance:
>
> # ./mptcp_nvme.sh tcp 4 queue-depth 0
>    READ: bw=3D456MiB/s (478MB/s), 456MiB/s-456MiB/s (478MB/s-478MB/s),
>                         io=3D4632MiB (4857MB), run=3D10169-10169msec
>   WRITE: bw=3D455MiB/s (477MB/s), 455MiB/s-455MiB/s (477MB/s-477MB/s),
>                         io=3D4666MiB (4893MB), run=3D10250-10250msec
>
> # ./mptcp_nvme.sh mptcp 4 queue-depth 0
>    READ: bw=3D446MiB/s (467MB/s), 446MiB/s-446MiB/s (467MB/s-467MB/s),
>                         io=3D4568MiB (4790MB), run=3D10249-10249msec
>   WRITE: bw=3D445MiB/s (467MB/s), 445MiB/s-445MiB/s (467MB/s-467MB/s),
>                         io=3D4563MiB (4784MB), run=3D10245-10245msec
This makes much more sense to me.  Have you tested where one path
is _not_ flaky but is slower?  (3 100GBps, 1 50GBps or something like that)

>
>
> Second set of tests: lossy network, path=3D4, loss=3D1. The tc output is =
as
> follows:
>
>   qdisc netem 8051: root refcnt 25 limit 1000 delay 5ms loss 0.5%
>                         rate 1Gbit seed 14946049878654165618
>
>
> Lossy network, comparison between TCP and MPTCP using the "queue-depth"
> policy - MPTCP is four times faster than TCP:
>
> # ./mptcp_nvme.sh tcp 4 queue-depth 1
>    READ: bw=3D168MiB/s (176MB/s), 168MiB/s-168MiB/s (176MB/s-176MB/s),
>                         io=3D2179MiB (2285MB), run=3D12965-12965msec
>   WRITE: bw=3D128MiB/s (134MB/s), 128MiB/s-128MiB/s (134MB/s-134MB/s),
>                         io=3D1590MiB (1667MB), run=3D12418-12418msec
>
> # ./mptcp_nvme.sh mptcp 4 queue-depth 1
>    READ: bw=3D425MiB/s (445MB/s), 425MiB/s-425MiB/s (445MB/s-445MB/s),
>                         io=3D4536MiB (4756MB), run=3D10677-10677msec
>   WRITE: bw=3D414MiB/s (434MB/s), 414MiB/s-414MiB/s (434MB/s-434MB/s),
>                         io=3D4447MiB (4663MB), run=3D10733-10733msec
>
>
> Conclusion: MPTCP achieves bandwidth aggregation comparable to that of
> NVMe multipath while offering better resilience against network
> interference.
This is interesting.  So, one path of 4 flaky reduces bandwidth to
1/4 bandwidth, effectively a penalty of 2 paths (I was expecting more of a
penalty), while tcpmp can shake it off. Do you have a
hypothosis/understanding of why?

I have a guess that selective retransmission might be kicking in (which
would be good), but how is that different than expected behavior for IP/NIC
bonding?  (which, I think, could be implemented without an
NVMe driver/protocol change?)  We generally point people away from
IP/NIC bonding; although, I am (personally) not sure why.

Sincerely,
Randy Jennings
