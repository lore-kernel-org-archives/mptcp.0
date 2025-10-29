Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBDD2D1F6B
	for <mptcp@lists.linux.dev>; Wed, 29 Oct 2025 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745328; cv=none; b=QuiIOyYSvr8zwxHW96eXTk0dq7SilaNOpam0jH79qn5p1kUitHYVrk5Kq2DJEZXUGykAUdWqPAU4CF4OOaaTl6PJC97Jt6ab8H5ZtYG4F5a5o9deJCKNZHqvmaQtOh1zIfY7pWDEOAgO6AEva9SvdzwE2o7u4HpScazbUoazGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745328; c=relaxed/simple;
	bh=zbMOoAZx7RYNx6TmQte8UME/DXY5NFfuty2hcf87lug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFl2KdkuQhQTKuHdMHhwSM4pQRp06KFMbOzof2mK+uxrMj2+ZjcvkytnA+DPxGPJ7QPQhiRCx6koZwNH9/UNPWuEEEKgdKZcq84U4hknx7JV/w1c3sJ5Igp+MwFFvku2IMFwnUpYWCeNvl3VsfLID5OHdsToocz3DjYzuzu7UkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M7E0pV0c; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M7E0pV0c"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ecfafb92bcso314701cf.1
        for <mptcp@lists.linux.dev>; Wed, 29 Oct 2025 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761745324; x=1762350124; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR9rxo2u79GKDjnzL8I5WnLfCVj8XfqRuf1RDu5qxZQ=;
        b=M7E0pV0cfXDwKuhzFHxNfBOlkORqfTqnv6BDnKqmAWWJIiPLsAn/droUwph5WlYAyp
         ynGqSCu6Ficx/h+8se8t0wG79vb9Ci5ySY/pPg2eNSSXZx/ssuZbH11Ite7wg+ywZvVB
         MME5V7gb7KiFBJoXyW9u92VL2JL9T4VVlCSvUvcKCjBjYBhLs6pssLMvpQHvPo6febpT
         jTdx7LH6jC0sDCTB77mayC7Z5W1GGS/N1l8v4oP2yU0Q0a6YogUNhAfLeZJSizoc/XkR
         WChN+pwv+ELFg5fAwkW4XSjADgxWNewkqGT33OBIgc7tYGZ2mbNzLYxVeYpxTma+DPie
         BNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745324; x=1762350124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR9rxo2u79GKDjnzL8I5WnLfCVj8XfqRuf1RDu5qxZQ=;
        b=D+k83ewluLz2UO2ebWuc2/ZRG5Keq9JGajL5Zy10IQA3eBODjbGnGSwVKI9zNNh1cK
         glbYL17v5P+BwSw95ZxTK6bDUThxNmKasxBtjxzQhxNadqrSLyBguez8Cn0pffcipX+D
         VkOx4LHHkxw6giev8BGchWJ8xG4NJdp7F91Yt/Vb8IbJlSGaX6rQPLhKIl97wRcNM4QV
         1tbxw7TRDZrfLbsHZfbx/FVOzm2SHc2s2E7b8XPWh2D6kAkQMLXmltWz2LP2Z88gy9t9
         YfClwR6mMyML8Q5icTVk6xuEK9qOKFnEJqkDZkX/t7vKTgjwoNe3yZq+MD9EgR6cJaD9
         DsLw==
X-Forwarded-Encrypted: i=1; AJvYcCWgnVzIGz58kFo7KH6jQYdkUBlbEPVHOSUrnPXN0W/4SJdfRSaLJo8FqMlGafXTjX/NuYthQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqdAlnIYeNwcMF5JNh+er2eN3O/zZXsZkitXAKfyBonFTi8tj1
	gIv12bcwQ6UdQ6yBqCXwpUY6eZ3gDmqEtyjfsJjP/dMf+yeam6CbFYUHJshw2Eh6Us09oBbHxc7
	TjGQvDwUUv8W7+eWxqkezV/ERSyYUjpoAIspZePW2
X-Gm-Gg: ASbGncvABV4h4+53vfHn+0iUJpLhdloxc45L9I8wws/eba6trbzhfS6L53tI5MWhSGr
	UGA2t5FzIwwE6jCncTzqKASHFdiq9O2m8TsqjgX3DLY2AeA1tkWlGnl+FAQVQ1PmSlh3apNX+mB
	RMVjP8fG/GcJR9GnXlKvuL77Zuux+b06O1+9fbJhuCs9W9ZnSDCfmx11BZCETGSLAbh5vMD/fDN
	usau9Qo5cz8lzhiPzt5BOEKcq0wG9bVbnAywmSaiJ44e5saAzxLe5//KXyB4djLC+PWinmoF/jF
	VV0QM6S5rgJQM7NTL9UfC3Th/BrOuX92qlmFpqfZA+vyhbCfng==
X-Google-Smtp-Source: AGHT+IGOZDQAj/TycBpf1oLko6kxdZqBO2Sk3hT4y5SfEx6uw5mwTcmg8Z7NahmZfp18PPYf1PTqZO5h2SskSugGe9E=
X-Received: by 2002:a05:622a:5a97:b0:4b7:8de4:52d6 with SMTP id
 d75a77b69052e-4ed157cfd4cmr6757411cf.2.1761745324169; Wed, 29 Oct 2025
 06:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org> <20251028-net-tcp-recv-autotune-v3-2-74b43ba4c84c@kernel.org>
In-Reply-To: <20251028-net-tcp-recv-autotune-v3-2-74b43ba4c84c@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 29 Oct 2025 09:41:47 -0400
X-Gm-Features: AWmQ_bkzo-mReBBs6WU6490vxEeqlXsoSqmYJljmFEdRABTFs0x5o3xtvuTei8g
Message-ID: <CADVnQy=NBw3RL+yS4=4AusooKkiMx9Wr+20dj-14fK+jPNw8pw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/4] trace: tcp: add three metrics to trace_tcp_rcvbuf_grow()
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:58=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> While chasing yet another receive autotuning bug,
> I found useful to add rcv_ssthresh, window_clamp and rcv_wnd.
>
> tcp_stream 40597 [068]  2172.978198: tcp:tcp_rcvbuf_grow: time=3D50307 rt=
t_us=3D50179 copied=3D77824 inq=3D0 space=3D40960 ooo=3D0 scaling_ratio=3D2=
19 rcvbuf=3D131072 rcv_ssthresh=3D107474 window_clamp=3D112128 rcv_wnd=3D11=
0592
> tcp_stream 40597 [068]  2173.028528: tcp:tcp_rcvbuf_grow: time=3D50336 rt=
t_us=3D50206 copied=3D110592 inq=3D0 space=3D77824 ooo=3D0 scaling_ratio=3D=
219 rcvbuf=3D509444 rcv_ssthresh=3D328658 window_clamp=3D435813 rcv_wnd=3D3=
31776
> tcp_stream 40597 [068]  2173.078830: tcp:tcp_rcvbuf_grow: time=3D50305 rt=
t_us=3D50070 copied=3D270336 inq=3D0 space=3D110592 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D509444 rcv_ssthresh=3D431159 window_clamp=3D435813 rcv_wnd=
=3D434176
> tcp_stream 40597 [068]  2173.129137: tcp:tcp_rcvbuf_grow: time=3D50313 rt=
t_us=3D50118 copied=3D434176 inq=3D0 space=3D270336 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D2457847 rcv_ssthresh=3D1299511 window_clamp=3D2102611 rcv_w=
nd=3D1302528
> tcp_stream 40597 [068]  2173.179451: tcp:tcp_rcvbuf_grow: time=3D50318 rt=
t_us=3D50041 copied=3D1019904 inq=3D0 space=3D434176 ooo=3D0 scaling_ratio=
=3D219 rcvbuf=3D2457847 rcv_ssthresh=3D2087445 window_clamp=3D2102611 rcv_w=
nd=3D2088960
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric and Matthieu!

neal
