Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377441;
	b=fQ35XqP7U0lAoVsQvyp5XU+NNcmEyxlI6NB24bUwfgpjT6TkxSYx/n5Ri4FleiQweDi4
	 uTTuQrOGGzMohkLnN6CfFIPvsShe2gmpt8j0IskQvTLtNyO/1ssAf19Z9V/qrYXBW5c3l
	 9lKFjRelh/DqW9S8YLkQ0apd5OcFmNClktcaxgaghxyZI1JqxCDGfLyksEnRcGre9wz/o
	 RPrXSUD5iUvuBTDe9VnUyeeuhm0ws+5eV84IrJYCLU2E2afva2HJ5yLDc3ta4l7UMZrTl
	 6kNi485djqZ0Jk7eJjQLhtTezG6YJmXgAzZzyLTeE7J6vUax9VYkiGF2tSR//mYX+/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U9jFWNJ4Q4zms5lBhof3omcjmmZI2zbYwFhomCmAGl8=;
	b=ClcPC27tCGSY6OAFPjoLOu0hNaGkxIC6I3K+DrAFXvgI/HqkptlOa5ZZFxyUfOWYbv3A
	 4JqOGtUsjlts8qRVOkmW6TAz6r32H0gAN4kc/zJ9qpJucvrFHJrLnZ2HJw/m9IP8skAdo
	 u5P7nOeyNPe5ugUS0VmS7mw6EXhmx7S47K1RAIn35aUJ/NtprJv3jpzv8sQZv1de3hUlT
	 o8muax5zeUqWfRuT4mfuo8np6QleajHHoNz2co4L9UWA3TsbASXaJnhDnTo6qyM9dXDmf
	 vBK+CY9+6ALpS2O08qJZkL/KoqpWd+X3zJW475E8Ia1HwfZuu4waIFIyXb7aijIiymg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YAGNsBaB;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA90606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 16:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AA90606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YAGNsBaB
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-181516de561so839856c88.1
        for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793377441; x=1793982241; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U9jFWNJ4Q4zms5lBhof3omcjmmZI2zbYwFhomCmAGl8=;
        b=YAGNsBaBMuy2ZpIa2rUqY5gGT48dZosP+ypMImQmfLYlHU8nEs8+EloVXAIESQKnEH
         snrdtTIopxutHxS2UMU9VH8XYPKW4NHqC8nj/7qhlbVL1V7cwncJLNqfSQIvMowivoZa
         roYQneRaPASeNoasgVfp5JXHgq8GBt/s+2/v/FcpjQrn/zTdLo7PFgUiYrclp1VNhSAH
         +amz/t+r/UwFaeb4DCP7sjr+UimIdiq4GVpYglv7QMxwBWGJ9hG4GZdvqajjdO2EJUzq
         m0+nqvETVA6wg46tCtzoNhrKSpf3DsjFQ4EuR9NrST4ebkIS/WYtrhNXXkhkGu6cLjn7
         ll7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793377441; x=1793982241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U9jFWNJ4Q4zms5lBhof3omcjmmZI2zbYwFhomCmAGl8=;
        b=VV+Iq1y+6nPobYUDy3DCd9DQ89mAKFnoRRyuF7vqFIg3MEwHWtzPVJXDhmbmJmoX1s
         egK1277ttJ97G1yhkKbwtf3NzMpaCN3rRvT38w2fIpEnOh1ePK4xWTa+TkMRwofxnTBC
         Rr7cetDDJNWGK6n89Gfim3AI84LUykkzYzwTy+65lbtZchun1NKO0/tFgH2BgQY1JSnY
         DIrYk0wFOnQWO54GLRwFaAM6vzsmnnRR0Gy3r2nHLBSxuGMv2s0329Unrfx5vtPSF4Yj
         rkL+C2n+wywJ5NKMMftlEktFvAZ+8vKCPRoLDJ5sbKiHmYGDv91f/I92EP09aS3EpaYV
         zz8g==
X-Gm-Message-State: AFq9FYL3jGBuq5keb09fDiKgmsf/V6DeA0fg3PoHH4ANiquOpwkf1nvS
	IlywnjQoHR7C33yaotSAFNFhwjUX73BM6wsnnhaABV/+9SfIWW7ZhkML
X-Gm-Gg: AYBFou1uRAzrP91na0WstL+hKM+5W5gZlh7b+oUIU422D/ZibRHmNqSp/vII7jlgSQy
	Aa4F1XhdxPY/3fYsy0zQsTRM8R05mh5sEnxCj25hWErLkv3TlJEzepEGyeQ9SZiJLyuTPc9ObOm
	nJLM/haL2RgOsiDfbgCZ9JgWlKVBjuOsKvs7uZzxys1HgVAbWb4P4mIrQUtq1a7wgDvuhl8mdPd
	jmnw5izljNAX2/NmNNWlKGGevVZNM42EGJm0MFfgOU4aNhrLcFctvhev5OK8VJBJl8fKzeRvZ2u
	LD3I96JtcuzkFHDomui5XWie+kbmNfGVP1X6GJDhiKg3U42WC981zCnLGa5JEWPUAYF5M7dg3qD
	6M/6gq8oWpVlTCynIBuKdj/yIkwgYq5XCzp6qyVeWGkZ9+4jqEZJB1ySr+Ws1hbZb6ZO55EIUpp
	Kq189LL84XrsHS6cTYtxGWh++Sd6vD5JkXZP8HlJluVnCPoy02oMmEdqfzQeTcDc7rZtYrcw9qb
	CavciKUHn10ww6JhLY9Ltctmp6hw8deTCpAx2ecxGJL0Ik3n03ufun4IONEh+veKq4p72+nt+Zb
	vYCAxKSlhtGPvxM45r9sv+Be8a4ki7gZqup9Wq335ty+LXfWzUy2UPc=
X-Received: by 2002:a05:701b:4586:20b0:1ab:9742:e028 with SMTP id a92af1059eb24-1ac55960b4bmr3384983c88.3.1793377440426;
        Fri, 30 Oct 2026 09:24:00 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854d925sm13229471c88.7.2026.10.30.09.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:23:59 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	kuba@kernel.org,
	netdev-bot+sashiko@kernel.org
Subject: Re: [PATCH mptcp-next v5 2/4] mptcp: sched: penalise a slow subflow by halving its cwnd
Date: Fri, 30 Oct 2026 16:23:53 +0000
Message-ID: <20261030162353.2424988-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179332426731.3132.5154849254860151673@kernel.org>
References: <20261028-mptcp_penalise_send_v2-v5-2-32fb379ce117@mpiricsoftware.com> <179332426731.3132.5154849254860151673@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shardul,

On 30/10/2026 01:37, sashiko-bot wrote:
> Nothing here tells a slow path apart from a subflow that just has a
> small cwnd.

I hit a case where the penalty goes to the fast subflow. Two paths,
40 Mbit 10 ms and 2 Mbit 250 ms with 5% loss, CUBIC, one download. In
about 1 of 100 runs, max_pace is huge and the 40 Mbit subflow gets
flagged:

  pace=17592676 max_pace=510560401580578488 cwnd=313 penalise=1
  pace=17656286 max_pace=510560401580578488 cwnd=156 penalise=1
  pace=8813600 max_pace=510560401580578488 cwnd=78 penalise=1

It then gets halved every RTT until the end, 11 Mbit/s instead of 38
over 20 s.

I think the slow subflow's avg_pacing_rate was seeded from the initial
~0UL sk_pacing_rate, as Sashiko said on 1/4, and it only comes down
slowly since that subflow is rarely picked.

Thanks,
Abdul Wasey
