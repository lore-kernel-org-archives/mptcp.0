Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F36C48FF6E
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453591; cv=pass; b=cAjbKVMTruwLI4PU3IJ+2iVOheyAt9rKup3m1pUc/jzu5bSFsL8zLoM0B57Aj7jNW3wrOLhBWUI2eIriTdkTfV5ReNvyIjR/f7ujsMs3GdUN2TBgpRDFDvKzriUvlYj4Zh3HPejVXL0LJ3ijBQbIQ3R3Oaz6/N7eiBKVApkzk6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453591; c=relaxed/simple;
	bh=vGEabZlK0+CeQ/pjYwF2a58KwPzkGrqiGm4U7jtESLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEAl+S3gmPu05o6q6VVOatExFu+8xye57NFzX2hVC+ve0bOCYG5lh+2v4/IEFASadQf2/s6WsfkpHR5ufmN/LbVhjLw8eGyPELZcjKGCmABx+uZ0jL7fDuVEuE5wGda7b2dA7lV3H+Wi9yVVsmQY5KieJpgD7lx8dGCRAsEHQrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ink.fish; spf=pass smtp.mailfrom=ink.fish; dkim=pass (2048-bit key) header.d=ink.fish header.i=@ink.fish header.b=g7zNeFXJ; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ink.fish
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ink.fish
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ink.fish header.i=@ink.fish header.b="g7zNeFXJ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso5211684a12.0
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 02:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791453585; cv=none;
        d=google.com; s=arc-20260327;
        b=jOfLFrNmjYnURZQArBZV01iQyCHk459+p3t0Ri/tXOAoP/Lq0wrVzy9COTww7xnaVx
         gmfSd+RsmVqL5ulhr/Z2oN1PQvsQ9tdfN5AKdh/018YMQOTpE+8lJq5C6BemOnfUoPVO
         ksjges4ppJ3pMlIQSFLSGMtpQEbePZgPyvnrnzK/Tj/pAPjpCPpsqpDV4h1Lsx04fy16
         /YcBysY4ZTBXTMAcOElLDrsU/SdgzjwrbtiG82wUm4FB5ENq/xkaze/gOAaDWmykrJdD
         bKJgJnc0wQn+IDLBCg9VNOHTiLD+TSvV/BU5JW79Xy/l3R4uRh1Z5Zp9pNIgQt09IxCo
         dXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jJXr7SMdL2O4zud2v5umGR1pHKL3RTbPRwBEIieOT0M=;
        fh=7rHppsp4VcU6DfIck89jsB0wVIJRXm44qdiPGgsj83Q=;
        b=Wem8mTSlubtKYZGNWIbqmFf/AeVCkwwQB+tUtdIWD7m04pjyEa3CqrroUtXnCDLK/J
         TCcxLAb9ju3xQo0Qz3S9KtNmIRO1D2WtflXr/Uo4S+TNYGutJRZqMkP3+TXOML6d2EzH
         mCVLfO6+sil0YXXqQGiz8wJYmoNSvvzZILDGsOD6MuH7Gb88zJPO+jskOI67isQ4wf2b
         PyiArvThBaPjhxlsPAobrkcpqNRocuuDkUB8jKIna2kyd7leelvYNip+aYeN2NUN4Qun
         ZRkJYuqrvFD9DKYlUDJy7YypDJ+eRW3fIUEwnKTBPCXzMiK/6GTKezXbxsMXOVhHDILL
         UypQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ink.fish; s=google; t=1791453585; x=1792058385; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jJXr7SMdL2O4zud2v5umGR1pHKL3RTbPRwBEIieOT0M=;
        b=g7zNeFXJfVP8Y8Iq5vimzL8EaTzMH6dgvVriA/VHkDmeM42nw15AJTHkjA1RoVK6fV
         Yj3MyEhn0wZcbMYD90hgfjiLXFdR/nCrs+1OTClt9wkb3BpIRhL0Quz604jj6qpoZswf
         nj2WQFPU33m985glWvgyGoIyX/02jqOM9U2KhG+zo3k6EXOjtM86f49rD70T78n0GW7+
         S13k0ljLHsg2kToSeVDU2B7yIQUHR+J5TBeXrNAcfqCJjxJOwWOAsFym5U7zTH+x6IkO
         9dI7PyjUOkkBhk9z//rmaxsV8/UcqyFi+uDQOvqmUHjeYSTusYASxxUtCs+P+woxE7aq
         TG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453585; x=1792058385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJXr7SMdL2O4zud2v5umGR1pHKL3RTbPRwBEIieOT0M=;
        b=ZSyLEFyNLl+zRhncebqzpNc8drBB8Ns2UPr+ej6cVaBhXmCHgLLQhdj5FI7Ga5aDYe
         EkRO+DmZ7O00i+Zx/kyGxb9wpZT0rboBup7HTkLza+xwZMj3u/OzNdhF3ZM3DVwxdMGu
         zMrdU4eaBmIbb2e0njTv3gZTlVw8Aoxi+RhjDpWuG2RqT+L+nT+NWe/2awzZUSKATZe1
         cC6/mW4CRj3C6GdSPPevFhejwbjHFAo7Pa/C0L/auyCA52CjBuZzv0/cvhQ9FAmE4ZzP
         2WnP319zcEfunq3d4tNB6bMkspEnoJZfrM6o00KhkEVn1iSLffSeFw7ZCEpVzhRfPLSe
         txvA==
X-Forwarded-Encrypted: i=1; AKwUvBxHPmG+XCEyjz88x64CODiNRnxr41RStLx0dVOBNDJC7jfClmnEwW4xZ2DEVP6vA3b4bu12rw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJd0IFlOkTfrbHrr2iFUN6YjVKeWy7y5c/AQgz2h69WXoEPT2d5
	LojSwLzuGx+1PeyzCOZDZsLoECvHjRIQPUUBZ4jP4hI91BjycGvsastPcLFoWepZWgSMD/9zqnH
	OhEq/qT2KZryXUbu3xQrWXO8fp0zecWS5AXpTCsYMoA==
X-Gm-Gg: AYBFou0PjyEnLJV0CIjwJSO/54kSRxuqwF2MxFQzzsChfjJz2iUvknaUYB3kcrwJunU
	enJUGKTcm4D3lDKe8N1A+omMvxLa+Bx7Fstk+UrjHeUN+nWcsH6U9oKvejfaZkoz1y1OR911T4K
	boHavFMtorVuEtrvj5BEfZu4LZJbD3FTBV8LcdgWYcskNrQskVzcv6vOvhtB8d/wQvdelnsIsGg
	/PJ6MRFw858H5jBe4biT+XYf1ItfAj7tJj5XrkA1lY5sxgrjJC3mdRdhM3cF/me1PEQn0r0hAAX
	XomZTd5rzj+KMShTDkIExoyK176UyYIaUkxW7QphGQRg1HCbcwA274Lt6wzV+yMh7ZYjcsSGHoJ
	9L6V0GskUmQT4rdE7u5snnG4Gm1ypze9RLlDsisQ+3rnlAEPUjt0aaGOmlzXArvk7FuaNXVR7Yg
	==
X-Received: by 2002:a05:6402:21cc:b0:6af:9d70:6d5c with SMTP id
 4fb4d7f45d1cf-6aff458b1edmr3946654a12.23.1791453585259; Thu, 08 Oct 2026
 02:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261008095231.103186-1-rameshkumar.t@phytecembedded.in>
In-Reply-To: <20261008095231.103186-1-rameshkumar.t@phytecembedded.in>
From: Petar Sakic <petar.sakic@ink.fish>
Date: Thu, 8 Oct 2026 11:59:33 +0200
X-Gm-Features: AclHuK_4uVXrewIIMOoGuldSrX8m4_JXXpcFPLw8nKMC2Hd5ZtIFNc6jpiCVS68
Message-ID: <CAFPPu1ivuG_z9Ko8VUq8Ke4Qh4vWkr4xXGZMdeouKf75qf_bpA@mail.gmail.com>
Subject: Re: [PATCH] mptcp: push queued data on passive TFO subflows becoming established
To: T S Rameshkumar <rameshsv06@gmail.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi T S,

Thanks for picking this up. One note on the Fixes tag: we reproduced
the hang on 6.8 as well as 6.12.111, 6.18.15 and 7.2.6, so it predates
e00b63056fb4 (Aug 2026). That commit is related but not the origin.

Cheers
- Petar

On Thu, Oct 8, 2026 at 11:53=E2=80=AFAM T S Rameshkumar <rameshsv06@gmail.c=
om> wrote:
>
> With TCP Fast Open on an MPTCP listener, if the server application
> writes data while the passive subflow is still in SYN_RECV (after
> consuming the client's SYN data but before the MP_CAPABLE third ACK
> arrives), __mptcp_subflow_active() refuses transmission and the data
> is queued into the msk write queue.
>
> When the MPC third ACK arrives, check_fully_established() marks the
> subflow established, but because the third ACK carries no DSS data,
> the queued bytes remain stranded until the peer sends more data.
>
> Fix this by:
> 1. Invoking __mptcp_check_push() in check_fully_established() when
>    subflow->is_mptfo is set.
> 2. Setting MPTCP_PUSH_PENDING and scheduling the MPTCP worker in
>    subflow_state_change() so that once the underlying subflow transitions
>    to TCP_ESTABLISHED, pending queued bytes are immediately flushed.
>
> Reported-by: Petar Sakic <petar.sakic@ink.fish>
> Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=3D=
X3qf6QycjfKBw+8snPg@mail.gmail.com/
> Fixes: e00b63056fb4 ("fastopen: only mark MPTFO subflows with SYN data")
> Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
> ---
>  net/mptcp/options.c | 7 +++++++
>  net/mptcp/subflow.c | 5 +++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index ce0de02f5..d5238fa11 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1042,6 +1042,13 @@ static bool check_fully_established(struct mptcp_s=
ock *msk, struct sock *ssk,
>
>         mptcp_data_lock((struct sock *)msk);
>         __mptcp_subflow_fully_established(msk, subflow, mp_opt);
> +       /* Passive TFO: the application may have written data while the
> +        * subflow was still in SYN_RECV; __mptcp_subflow_active() refuse=
d
> +        * it then and nothing else spools the msk write queue when the
> +        * MPC third ack (no DSS) arrives. Push it now.
> +        */
> +       if (subflow->is_mptfo)
> +               __mptcp_check_push((struct sock *)msk, ssk);
>         mptcp_data_unlock((struct sock *)msk);
>
>  check_notify:
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f0a6725d2..f499073a6 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1894,6 +1894,11 @@ static void subflow_state_change(struct sock *sk)
>         if (subflow->resetting)
>                 return;
>
> +       if (subflow->is_mptfo) {
> +               set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(parent)->cb_flags);
> +               mptcp_schedule_work(parent);
> +       }
> +
>         /* as recvmsg() does not acquire the subflow socket for ssk selec=
tion
>          * a fin packet carrying a DSS can be unnoticed if we don't trigg=
er
>          * the data available machinery here.
> --
> 2.34.1
>
