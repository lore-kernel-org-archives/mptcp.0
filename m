Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647F13B298
	for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115471; cv=none; b=ooF2YNB1KhlZYsK2xyjk+DQ1B2vWCbOm/hVE6pz4pVtUykKXCWkvTDSpHVH6u+f9VTE38lF6KvD0Tm3JdTlGbIFin9NnTl3tDxyuIQRVsPVKKPM75A8JhzJtX9ZnXrwHzjaDSrj3hr7c2qN2CLJx1lYG7G/J5d9SEYccvVgyPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115471; c=relaxed/simple;
	bh=DUhzpTck12VjCSqiHrdV6VqhVkIhc4yBLS1FXa70ffs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJp+DJfUfbC+ly26Zj4k0kWnCj/Q1Lfr1Biw+U5DAeGbcP1ndd1KQEtPYJQpue/PctWjSfejjF7ogqMb6jDMfNlgwruJB4DHnYfLCIxxUaiIVoGHwkWnvmcKZvUoGw6QZWBafX9FD3Rg71QRSluxBJAVDpIEuc9VN2iLsNL6Cig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vDU8BXay; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vDU8BXay"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so9045a12.0
        for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 00:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115468; x=1714720268; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUhzpTck12VjCSqiHrdV6VqhVkIhc4yBLS1FXa70ffs=;
        b=vDU8BXayyb9lZFapeuEKB59iVozK+qIAyBfULuD0g4WrDAyYslqtX0qplXJKIGUARv
         9PLLuVPg8w3yQvavbp0AibM4dKUjWHIdRW5qIsBbn1d3m8Wxtj47TnWhiUXhl6kavg67
         7LsvveT0m+yuIbmIxVMZp7C1Y+MhCHhh+Dz9fA7z49npSdW5mYm+If+vLAFgBE5zdkxy
         qOa4qzWwzID0h3PqK0RDgJqwxZEdRS/3o2QxonAJNY4ngR6zyVO3eW0/4jjyRs5eD943
         nsNF3dORc75HbRMHwrgzq4Ro2qRTaBKbx1wu80py6rYhnFhD0J0PPa9a+g5fYY17DddD
         LTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115468; x=1714720268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUhzpTck12VjCSqiHrdV6VqhVkIhc4yBLS1FXa70ffs=;
        b=xUMx9NHA5ohJPR5mOmHzPTKlVsYqkA+YhC7v/6kB1Q6+WFaLKaZjgeuvcuf+BJOefv
         bvLsH6/MpB6+JlOrTd+riVM7p0nZNRVsVqrN19VNUu7mZ5e2DWi99GyAKhVaWfLDOzdM
         H6Ez7xfG4PKlPhLFWPpzGhfg96k8sRp9mFbpajZ/WQXyUHX4gkdgkPLbShYMz2jYCmRK
         lvOEFPeGGm02CLjss6RBMvG6y1C6PU9sA5k63o7TnIaN+Wu5KSZh/gcCyJudURkg4Z+N
         6ff/U/qj/kxU0pgtv8qsid0AdYrX58A0GU300ycUtR4JbjdEqH/vNje4uNUj9NFakwFM
         Qw+w==
X-Forwarded-Encrypted: i=1; AJvYcCW3sAQcuJOYUWskYVVnJ97XzLhlxiq/4lNUVGF/vynLPG3oWiLFQvgU11lAS5tstYYhPDgkS+VH55I3VqUbdQa+TVbfRNg=
X-Gm-Message-State: AOJu0YyebokHyyPAPYK+DeuOGwMAGrXLw1a9afzu67dXE/zdq/uNasz+
	TdDsKltYExMrlBdcan/i0gzGH0uAfpTpIybZbninOQb/vSwvQhqi4bJdEXl7NCuZHZAI+k5eU62
	IarwksHFyJSD7Imvw1kGYo7AI+uAtHuZUpjuy
X-Google-Smtp-Source: AGHT+IGT6onk+BwIZ+XI6s2mJnRWIfjrCN+NeywEu5zdlZD6o0AXsRSokjeE2Rw/pj9o3mnVZIxQInsQNxEXv0d0IcI=
X-Received: by 2002:a05:6402:26cc:b0:572:57d8:4516 with SMTP id
 x12-20020a05640226cc00b0057257d84516mr43968edd.2.1714115468235; Fri, 26 Apr
 2024 00:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-4-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-4-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:10:57 +0200
Message-ID: <CANn89iKZV=jg0ebTW-c7uLJxurLd7VWo=3GAqrjpWzDEovResQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/7] rstreason: prepare for active reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Like what we did to passive reset:
> only passing possible reset reason in each active reset path.
>
> No functional changes.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
