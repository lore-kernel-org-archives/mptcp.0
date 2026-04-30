Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1639DBF7
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777582133; cv=pass; b=AUqQ+d6OpiZMCyXbgZrwA/qomkcHrU5w4/bP4xZkFTJ5hJT7VszeNFN3HSmQo+FTGGHyccXYSP2Kv/yAHihytU5u6D/yYPa//y8lH/+9LWJ8pX7USUu3eUEoqJC5lLv/gFM9r5tT2677yZkI9GXaLI10FCxjsYVzcW4cm45OAxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777582133; c=relaxed/simple;
	bh=OIUawarCIvI0wPQ/kcH15ZmoQnsLqiikT3bWC8pqqOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JC4rpevFJU4UpZjd44Rv3do0Y0EDLPn8nW5Z0CLeMcH2FDlr110lbBpojyHXTxYG6iqL0ZYvgYYwLiYPQiOoKd2taSo5Jh3tbCF3Ca73Z2Jp4+7kdpMzpkr7FgWN+PugLjT7L6QD6lO7wUxqvLoYfjCJDSCRJKlyrALU3eRasDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVf7yb3Z; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVf7yb3Z"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c45281a06so2221591c88.1
        for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 13:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777582131; cv=none;
        d=google.com; s=arc-20240605;
        b=WCY7/gppyMuUiROYIv7GI6Sb/1GrIRAkWfglsGOIe5ndGLhNyQ/03pahGYsk7vV83d
         SxcLAsJ3CL4t9V9tiReALNS1yhmNS5LncoRBWaafjSHvTtL9wE/D7lrDUtkCVHL22iPy
         Go1JNT54vdrt8wbtSEhE5XN82noGvLGGCcmXg6N6lXMVnlPK5ahnTk9YpNYleB6fV8W+
         CN0LH3K32hb6M/3wlpIG6RMns8FG5vVQCrbWYOuPpQ9QRzRCLj3ek30ZXJdc1MnG4LLl
         mB0F0G2qyn92w1RbtJ9+PxylzExlVOChNGAXeutckA5dLYp77PkB+47OB3Bqn6SbFmhL
         5EuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JLwCOty3KPW0PUe7gR5ZFCrzb/gQ1BItdJB8Hz2WdtI=;
        fh=T4HTA+NGTGiJ1rviZC1ByR6q+LK0qphO7vtAGOH33g0=;
        b=KdAeZHWI+WeEB7873AU7hL70jrx+ZUq/Qqo9R5Idjpue+u5H5Nwm+EsxeHrxBghLVI
         tV5c55Sy9+xfGKD8OQk9gwEoQvyGC43bdencRb6fUPZeRR5EFOymksjWyXyMUx2K1J4Q
         ECnzRX9FidFsQ/sfSmeXv75rMHpGbBNwaSpuc1EhA41W0+ya3wXpNmmnt1vY6iYFCuS2
         ogt1cb/25V9U5LEib8iVGkJZjLzr++1sKsCabKbeTGFmEQ0JaB1cGPb5Xtp2wYQKIm1b
         hIZ6W6hYjhwe1HVf0nR/kpLdl9jpE5XQ36mKq0JwkivRYkYAHxQ4Z0o5vK08T+FOEPbq
         W7+g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777582131; x=1778186931; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLwCOty3KPW0PUe7gR5ZFCrzb/gQ1BItdJB8Hz2WdtI=;
        b=FVf7yb3ZNKslGfj5jmS3Nxg1dg/wWIC+P+0ld22ZeKjch4562JSI8iWQte38bYQTJJ
         Or8n5ob7HlSVrFNr1uIzE9/OHrCNOiaq8cQaYJ4WxeNPROO8hpzjJx846vYvDEynEXq0
         //VF8cH8JhK3RxG5v1mfhWmY49RbmZM3kNcnIWq+nOU+CRBdy0aC6d/DKtsl3rlG1xy6
         mDejq4+Jc2qfPWXv1DnNTuGOJ//3vL2AETmAsobfNfUdvijIwiYKqaT5I5hbva9IiiO5
         MLZMgUJEyInRcTlk1ET02KHW3PHMQp14v0x4ocpDLVflgsOvQN+/kkBwwYzYAgiE06Tl
         K41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777582131; x=1778186931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JLwCOty3KPW0PUe7gR5ZFCrzb/gQ1BItdJB8Hz2WdtI=;
        b=L2jC6AVplw9OBSa5Ib71uead9m+q5vXOZGpBKJcRlSRuIaydcEksGhFn/Tbc8TM6oN
         45qSRlJD4+CA0j+eYwgAXV7sDcsMa58rty4VZpPVI+zORJ2yxyhR49y1gsw6KBuhlbiI
         ct4ly6sTElmt6mpIiSTDOEvZJ0OeVP5xju136K2IeJCEC+SJaoWnnR/ndS2eoaKLVYz2
         SzB3cFk868Mgem3b+j3wENaqKXpZ+7VUEKNw4i5W0NB/PgH7xB6mNyaE6q1bppwHY5mY
         Xp/HMO/oJQDGAc8QYyCbgzdk0OZ81QVwaGv6iqcTJPO2pQe0l9J2LZupAv6RomSWHsmP
         ADJQ==
X-Gm-Message-State: AOJu0YwX5LvBrZV7zobGZVSu+MY7c7L+lOvfsVPHqfkist+FXAZpEcFh
	mqRTQhdXA8IseCb1ca2EVK5OKRYtStGn5L5ObdV3m7ljn6GkCfP6vRUiVE1r9/kP4A7hHHGUJL5
	D+1dCLRsYng4NbRV7uq3hiNezGLK0aCby3UD7Dxci
X-Gm-Gg: AeBDietw9PMWEKeM2QVMLKGD7Pn1Zgil/Rhh70JYoitI3JNS3OWv8Inz7vcom4ivomP
	/uPVrobWJt7XyjEsXfdHrjcbOByuHlWQfQqqwZeQRudn8FRvBrDdgK6HcsfEfy1tXFgcrn9MqTC
	TKh59LxIaiQYSxiTVAXtir0lHbBoKpeHVHNy3hPtLRBONzZRVFXqAvbIeEYMrXJRVeUyy2cE5Gd
	d7b3FHP7/IklxHsIsLkzlEbbVnoWGBQ8NeXq5vHO3RSsz6qtMaJIJXpPjd2QsBYNwhBBeE/DKHM
	SOC+fW4w1fOUBd8oeVAETGj+kHhKs1MnYNI1yletAs/UmXCv4PUguxtfhTebmiPRnihPshA4sj6
	k+U8OIrU6lnfrAPLiXFp43tq+HB7tKPhFwMPiACuskAtaaQhFAZ/pp5PrPPGqeXgZelRFg2dBpg
	==
X-Received: by 2002:a05:7022:100b:b0:12d:b329:987d with SMTP id
 a92af1059eb24-12deacdfe84mr1808121c88.24.1777582130352; Thu, 30 Apr 2026
 13:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260430-mptcp-bpf-mptcp-sock-type-v1-1-d2ed5cda7da9@kernel.org>
 <CAAVpQUDeJRSTympB2QqQv8Ouc+WRnM_HjVyitqngQiM3Uayh4Q@mail.gmail.com> <fb2d66e0-b2bf-484d-85e3-c325d99bbfb2@kernel.org>
In-Reply-To: <fb2d66e0-b2bf-484d-85e3-c325d99bbfb2@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Apr 2026 13:48:39 -0700
X-Gm-Features: AVHnY4KDXb6h8HlshbekIkDOgKH5UbBejyZtRa_qcSgq5INdpchtmhGcYRmrl0g
Message-ID: <CAAVpQUBUcGgqoTed8NMUMFhoe=xYPXtzktfr7Zv7yjwgVcL-Qw@mail.gmail.com>
Subject: Re: [PATCH mptcp-net] mptcp: bpf: fix type confusion in bpf_mptcp_sock_from_subflow()
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 1:45=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Kuniyuki,
>
> On 30/04/2026 22:35, Kuniyuki Iwashima wrote:
> > On Thu, Apr 30, 2026 at 1:27=E2=80=AFPM Matthieu Baerts (NGI0)
> > <matttbe@kernel.org> wrote:
> >>
> >> bpf_mptcp_sock_from_subflow() only checks if sk->sk_protocol is
> >> IPPROTO_TCP, but RAW socket can bypass it:
> >>
> >>   socket(AF_INET, SOCK_RAW, IPPROTO_TCP)
> >>
> >> In this case, it would NOT be valid to call sk_is_mptcp() which will
> >> assume sk is a pointer to a struct tcp_sock, and wrongly checks for:
> >> tcp_sk(sk)->is_mptcp.
> >>
> >> This is similar to the modification done on TCP side [1], by Kuniyuki.
> >>
> >> Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
> >> Link: https://lore.kernel.org/20260430184405.1227386-1-kuniyu@google.c=
om [1]
> >> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Thank you for the review!
>
> If you need to send a v2 of your series to the BPF ML, feel free to
> include this patch (without the last sentence, the Link and the Cc
> tags).

Sure, will include it in the series and extend the test accordingly.
(I was looking for variants but only in net/core/filter.c and
 missed mptcp one :p)

Thanks !
