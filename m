Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599203D6F
	for <mptcp@lists.linux.dev>; Sat,  8 Nov 2025 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762639683; cv=none; b=NPBUO3ckg2QalQdwI9XQYZKLei+QPrNIdE+MGE1xVl/x3vLQ22pJSNZErmf8tKI6HN2gojXCR8seH2ayY3ITqvo9dNyDPOf/Tf6oKwc7ET1NWTb2sUuzO6j8hqTBiND9QCenKJ9BKpfBC+ce1g8g3mOHOzfFLfQ2RtQjldfFgvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762639683; c=relaxed/simple;
	bh=/x5k4d/gVyeMZ/iLr3YH+CP0n62iob41l76qy6k/iOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YRuTKONGP8q152P/SYx+Xp8NRdw8MTvXyeJxPl5dDoUME2LiSAR5CsJFpfEO5qHtVFXupOhq0TuEDyFGLPqcFfEXECYqLPmNyXSNYt3O80Dyffmh2vTzs/ELBhwEy/ey1leUxyM9nYLElzY8dgJXolQhJotbYOamYWC1jrF0z3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PwBnvWg8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwBnvWg8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762639680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzZhAyykSdIMuzJ/IUzWqA0DZIyz5tdiUmaJ5F5Cx7s=;
	b=PwBnvWg8+5ZscMrjAWX1Bo0lON/57aL1lVFnGFOu5LyZmof8q/W8Fuyp2XyD5ODDAxrMU2
	RTwxXr0q3fKvpO4h1bzplbFgbq1K+ywT57BrApF3K2mAyPKEuLs0oV9pzVSyreIx48kZl5
	CKmkX91GcKwkMiUJIy3fUxcD2YQ4ko0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-6MshgD6ZN5qLXQOXDWFGqw-1; Sat, 08 Nov 2025 17:07:58 -0500
X-MC-Unique: 6MshgD6ZN5qLXQOXDWFGqw-1
X-Mimecast-MFC-AGG-ID: 6MshgD6ZN5qLXQOXDWFGqw_1762639678
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-786a589c941so31438107b3.0
        for <mptcp@lists.linux.dev>; Sat, 08 Nov 2025 14:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762639678; x=1763244478;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XzZhAyykSdIMuzJ/IUzWqA0DZIyz5tdiUmaJ5F5Cx7s=;
        b=h8+rvmPffNoAGU9YludsGuADvxlBHuKu0Ax4LUgUcbzt6ylkqNhVxGaLtRjMM0vU48
         qPGpeT+TJjwhf7fFRXUJgaFe71FG9eYB5quYk3ahgwvyO2PeNjcRpNlbsbKLwzJ+n6Ed
         9CGa7iQJjrGZ5ND2rUCROifczpe3FTL4udeWrheAIgZ4DmJz7Poo3Ng7CExVM2dbryI/
         e505ox077Hu7D5yPlujYJyHOZZ5W015LN5iu6WFM54o1AomZ7VvBn+YAeZ12aQQ384pf
         pKYHIrggLzrqkfRrex7Kx2Y/8xotGFVpRjecG+oAU7Mr0x/9wA4NP7aBhp7jYnFrfltC
         XdQA==
X-Gm-Message-State: AOJu0Yz17rZUts83LQZSG5KiurLIcm6lIEufBRt5fKcakDwUJiZVBpPj
	C3ER1WJmDDRAaUuuw6HX6h0uJdtugeRhA/KyXfEUPjIzgQdDGy9VqkFaB2AM3hcOC2V/oywMzqC
	ZIN6Nk7JxeG0TCa96e42qVeE67uAz2/+XFW+AUSAo3AUkPyqQmH4OyygQl3HkhiPciOWq2Xzwh3
	hQj6z5i0bHgFpsk20EJ7qv7Er4ocsxqZvyl1DB6iI=
X-Gm-Gg: ASbGncsLmbB7s50gE9rwQGDYaFgfS0emVS8HfE30P7xBDg0dCtI+3OMs1ds7fhDoZva
	5HGmBaPhgX86QjS4sFK0CURLj6wH8uaMKUl9amz+9GWnXzoaJ44s6Bel29ZFSmA67gJYm/YENN8
	ofG4x4FT7SIEaEv7L/GQdioSxQqlPozircfdAGXPB96e5I5BJI2Nhco04m
X-Received: by 2002:a05:690e:d41:b0:63f:c6b3:cd02 with SMTP id 956f58d0204a3-640d452191bmr2943495d50.6.1762639677733;
        Sat, 08 Nov 2025 14:07:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLX8G5hanf104LhD37stnH5V76QspkC6NC2Xt8lQsuBcVHsnUKOjcxfGG7wc2vAFdlfSWFRtKa4xhVKarPM+Q=
X-Received: by 2002:a05:690e:d41:b0:63f:c6b3:cd02 with SMTP id
 956f58d0204a3-640d452191bmr2943485d50.6.1762639677245; Sat, 08 Nov 2025
 14:07:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f9ee505fd5da965ab78beb4d51e6f479ad8fe4f7.1762553784.git.pabeni@redhat.com>
In-Reply-To: <f9ee505fd5da965ab78beb4d51e6f479ad8fe4f7.1762553784.git.pabeni@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Sat, 8 Nov 2025 23:07:46 +0100
X-Gm-Features: AWmQ_bn23dlXXyrksxC-YYxPOySW1w-O8gAByaKl62X5Woy9eJncuK4jEO3R6jo
Message-ID: <CAF6piC+hwFLFoqWqjsm17W6Gnk8zed+-HYW5LcN3bfVsEQv2FQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: leverage the backlog for RX
 packet processing"
To: mptcp@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BjdGiq2nNWDL4IecN1BoInvbuhD6aUuestHRsdrICws_1762639678
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 11:31=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5e9325c7ea9c..7e58d35f6b13 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4082,10 +4082,12 @@ static void mptcp_graph_subflows(struct sock *sk)
>  {
>         struct mptcp_subflow_context *subflow;
>         struct mptcp_sock *msk =3D mptcp_sk(sk);
> +       struct sock *ssk;
> +       int old_amt, amt;
> +       bool slow;
>
>         mptcp_for_each_subflow(msk, subflow) {
> -               struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> -               bool slow;
> +               ssk =3D mptcp_subflow_tcp_sock(subflow);
>
>                 slow =3D lock_sock_fast(ssk);
>
> @@ -4095,8 +4097,46 @@ static void mptcp_graph_subflows(struct sock *sk)
>                 if (!ssk->sk_socket)
>                         mptcp_sock_graft(ssk, sk->sk_socket);
>
> +               if (!mem_cgroup_from_sk(sk))
> +                       continue;

Oops, the above last minute optimization is blatantly wrong: must
release the lock before continuing

/P

