Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67528F1
	for <mptcp@lists.linux.dev>; Sun, 25 Aug 2024 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724614795; cv=none; b=X6FrQh1X/VimBV8TBYtr7GCaVO9Wn8c151gn2DZyrLrexGc+jhNsBO3tiBseo8xlr/ln/Wc6lnKxlkHFNk/BvEqAxMPGw/ZNBFTPyzoDwsBOE7b7r1GiBDUiLcAJUT71SrjGxcUeDp5Hky0iP/AzFls0RvL5b2DJSfXNNIktlzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724614795; c=relaxed/simple;
	bh=tJFMf7Ox3/eoUXodySBxnPvVaHnjOizgVNRxMtWdrpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iwr2Qn9cfMQ0uCGb5MlsthoY1lm2onVmtl24YAzn5E/sEwcD46o9C15p0MNHxr1LO9VI4gi0M5VAu4v15EPNazdFWPX47B28ycR6ySBGiIqEmvhBe0+/TJCNtSr/T2srWPmdykMe4LnPRceHyUlFSeO77HZQ5JKbAXkxtCyzW30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi1E/J7Z; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi1E/J7Z"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3717ff2358eso2003542f8f.1
        for <mptcp@lists.linux.dev>; Sun, 25 Aug 2024 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724614792; x=1725219592; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJFMf7Ox3/eoUXodySBxnPvVaHnjOizgVNRxMtWdrpM=;
        b=fi1E/J7ZqFL/7FxD+huHWJBXYWoLR+NMy/1nSzSFvHlzrTr4BR90v1joiepr/vN7oz
         pZYJO1d1uLkoGkkMb4MVJxSJWZ68UW1HN5iCBvMzkNG7NWOwpaA325hNmdGPW1y8jpZp
         dKqE1GncOm3QGJO2MNFsm3tSoOWPu+23PgfCV5lFogtBJIRuh4HzQl4vhJ5pc+mnUhO0
         VH86mHZABmfZgdDRRoIvcmZehmHudC8E2PMECxIJ4N2xqDIVi1jmx3dABRsXJVwQT5cb
         9+nj1kkMc0azhV7o3zlLYo661KDfnlqONrbLC+6vqBQVSCpIFvBYMe00YNo0F3SDp75E
         3Wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724614792; x=1725219592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJFMf7Ox3/eoUXodySBxnPvVaHnjOizgVNRxMtWdrpM=;
        b=IQUxkKUS32jGZzZ8c47UEthk/8BcFKCKKxbvhg9UR+D3onWyJZwAPTxqR4P22KfftB
         UQ+Tvdj9jiIrLPqtiDjL0aLf+GqiSAZuWIGDmi2z5r+zdKrgz3SIHg7XBVbKqonRP0DQ
         jopp9HDM6XS5oIv+wBy1tqgy6wENfCyH9T+ukxEzyD1QFWI9EJ8bB77QiQ35z69Agl+l
         JcMfo89lSOFNTyLZHV6gGAij9+3pnSiBN6ERyxC2z1nQhjmGOvHV/W1r+pOmBas+3at+
         qtY/DSgXyNUtMOhMTHLs2fe3G43ip6RwlPaUQYAVSeki2MyI+l69zAfvF0ZDtytupOmq
         ZQ1g==
X-Gm-Message-State: AOJu0Yw7drtr3fjVHajHe3BzGqTxdIGLh+y/nsOCfgrjCWhisJ/NQxpC
	wvupOkLw7Y81FLli0lAMb0Hd5wfihUNzuKIz15P4SjYT6QXcxoGSU5VGKGNjBh++xpLK6GZVS45
	ROWNu8KPykaanyaiuXpfODzJ5Tck=
X-Google-Smtp-Source: AGHT+IGFbKNA4xLPSpMgdIAMRw0iydK7vN0/OI26qARJK1To1kpg2vBiPumvMtuCJAricMBw6H2GFqQcYHoRXaV2YOI=
X-Received: by 2002:a05:6000:1006:b0:371:82ec:206e with SMTP id
 ffacd0b85a97d-37311840ec0mr4673128f8f.5.1724614791663; Sun, 25 Aug 2024
 12:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
 <20240816-ups-bpf-next-selftests-use-khdr-v1-1-1e19f3d5b17a@kernel.org>
 <CAADnVQ+JBq8-6Rhi_LHX470uj2_2xxJAhgdUfg_abUxEDqpdJQ@mail.gmail.com>
 <6a693ad6-f145-48c1-b3a7-d441d3764e73@kernel.org> <CAADnVQKnEuQ4XZROLWH47mEZNwnJ9TuyTrauOnuobcLgVMrimw@mail.gmail.com>
 <41ef2c53-600a-47d6-a35f-674e1e7860f8@kernel.org>
In-Reply-To: <41ef2c53-600a-47d6-a35f-674e1e7860f8@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 25 Aug 2024 12:39:40 -0700
Message-ID: <CAADnVQKoesL+Rmp9eB6mQbU1J0yDWgFioigy6jK6XMsd3S1u=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests: bpf: use KHDR_INCLUDES for the
 UAPI headers
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 3:37=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Now that the CI runners have been updated to use Ubuntu 24.04 [1], we
> can use mptcp.h from the system headers, or do some actions via
> IPRoute2. So not having KHDR_INCLUDES is no longer blocking us for the
> moment. I think it might still be useful to add it for future use, and
> also to use the latest version of the UAPI headers that are not in
> 'tools/include/uapi', but I don't want to insist if you prefer not to
> use the latest version.

Let's not fix what is not broken. We'll add KHDR_INCLUDES when
it's actually necessary.
