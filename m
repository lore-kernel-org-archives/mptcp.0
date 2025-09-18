Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA0C2D6E41
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221294; cv=none; b=GIBA8KoeyKJwUQ/ZHfHrAkY44W0Zx78jG9o7fC2unjlPPwELSc3FSm1Rl9BET7eaYbDW3D6QJNKvRKWrX1Ni/I08lE8ctuBe4c5L48tSPgaXf1sr0bYlyEvkqw/SxrCNDHs2iep2XQ11V4Z1dTXAt6EHmyTPGW97ds6Sr8mbfXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221294; c=relaxed/simple;
	bh=3LUG8CDlFaeOAc7TmZpmAR80a/tbN4YHi+y0ePtW84I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9Yn/x+NB3ixrhl4VIRPur7Gll5HxhJI1OTl/4F83eL4O6jc+16A5Bu0TtTvpaxut7XmWJQyXywt0fsDcclwRiy5R1OO/M3yTooXGcAVXPe6w+jciA83/TiiT0AchtdhuXInA/A7T/GxwQTiURsUgN2OWAuK+NG453miJ5Y+mZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0vQGZBd4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0vQGZBd4"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24c8ef94e5dso10804575ad.1
        for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758221292; x=1758826092; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LUG8CDlFaeOAc7TmZpmAR80a/tbN4YHi+y0ePtW84I=;
        b=0vQGZBd4HDSUB3g3LtlxWicPXSJtvbwRPbZqQnHvNPl4G1f9enHSK/3pJBRmIQ3dET
         E49vtK/IuXoFAZa8xQ0cnPPJhPZJUnNfZIE/JSV6H2KSwi7nnhLa2xaBjY6jO37+vbXu
         AdfVdsG41vQSfIXYuaGFrIJlMrIAc7bP0rOYosObxayLwl5pbsu6mPWvmGK8aWsOXZ6h
         7O9K81n8aBHACwgjqx6ETai1S6YSI/nHP0inUuzQMpo4OgKBXdHeYtqT/AJXNEdjjCug
         bg65M6PbN9L8E/66ZEVoO6R2qzfQhOLseJVp58fcI9hcyyQ0mS1Qo2LDuecXSCKz+2TK
         kC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221292; x=1758826092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LUG8CDlFaeOAc7TmZpmAR80a/tbN4YHi+y0ePtW84I=;
        b=Vl/H0La5ynQChbGyPPQBl9S+d7do0X7weQhnEWB7NjaAzvkI4g6RrAQg+ZLnSfOCSW
         033VaCq+AJTC6yPVxGYsJ4SDE39CGSeKdnP33pxQxc32GcEZa5ZT7S8SyQRjJmZqWtp5
         Q2zeZRvsVX4JH6b9RW4y7sunB6MLpQRrIy/nNqSk+XxAA27r6LcHTzqNgZKMCSOTfnRU
         IZNCig04ob5RQbBtF8O2j0qUnHqgnmSnx7CvXD3vu8fqFn7LDg4A89lmXxyJF5Q6xjOK
         AmSb+nYgclQt7GJsKyt2bA1qkY9mxdbPq0S3URb6SBl01gHc0ZmTHzLdX71XT9EtvloM
         pZnA==
X-Forwarded-Encrypted: i=1; AJvYcCWfoKoB7yNfBpLqzAI1rAmP17ZiltLAuoZlMUhLXSV8CnxcaT1rqjqMujNH7bG/Pl6oVcXiNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiSy4SzY7O5VcgO/az3biFiNgP8N+/J7y7qGjr6ONgjxPiBKoW
	ich7IGDuYTlZBK7UKieX1vmB0eoxWb3c25L8VgGLCKkSVzheIVr/cv4AKs6qLFHqW1NGcuBCFeX
	1FORLi77cS4vT7fia0NNbLEnqtWZLmnzxj6/ABCw5
X-Gm-Gg: ASbGncsHmb1PGqe2Wqr70/v+iiHVn0OgqCIw3GrPkgnwYLwISJgEJeLIOy70LX4RItZ
	BRBNWh1EISO13KT6OK7oDzqp5qR3yEE2vMhbWD6yiFreQL3nPuXlPo6sXPZ3e/BoPv0qjWlcZPP
	K4ZuoJUwGsyv+gKTP9vbAjMcpJlu0GyNsz0qGfjVNnf9GSlpvSJ5anNhOAbrt2ylaBW/TO746Mu
	5tY8YdLxR5uZqZL6eaJqjIP8MN6BBlOy4J4s98Wb26VYvgdxrw2t0BVFg1bMTQJEQ==
X-Google-Smtp-Source: AGHT+IFChwu/WXFE/Bk1qPbNxzjVEQRH8mYRXcstr2vxeJXZTN7B4PXslngta4OJd71ruXQZuBfYRAqRPI1cCQdkWpQ=
X-Received: by 2002:a17:902:ce09:b0:267:c1ae:8f04 with SMTP id
 d9443c01a7336-269b92f5037mr8368235ad.20.1758221291602; Thu, 18 Sep 2025
 11:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
In-Reply-To: <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 18 Sep 2025 11:48:00 -0700
X-Gm-Features: AS18NWBIaYnWg5h64UvvqbyXa3vbYuymfJ8c7oW4xcgcAtF9AXx0O8o97REhA6I
Message-ID: <CAAVpQUCy-xurW6r9oUcDV17fS3wiJsn2QuQ1mQ4k2wXYa6L1RQ@mail.gmail.com>
Subject: Re: [PATCH net-next] mptcp: reset blackhole on success with
 non-loopback ifaces
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:51=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> When a first MPTCP connection gets successfully established after a
> blackhole period, 'active_disable_times' was supposed to be reset when
> this connection was done via any non-loopback interfaces.
>
> Unfortunately, the opposite condition was checked: only reset when the
> connection was established via a loopback interface. Fixing this by
> simply looking at the opposite.
>
> This is similar to what is done with TCP FastOpen, see
> tcp_fastopen_active_disable_ofo_check().
>
> This patch is a follow-up of a previous discussion linked to commit
> 893c49a78d9f ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in
> mptcp_active_enable()."), see [1].
>
> Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/4209a283-8822-47bd-95b7-87e96d9b7ea3@kernel=
.org [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Note: sending this fix to net-next, similar to commits 108a86c71c93
> ("mptcp: Call dst_release() in mptcp_active_enable().") and 893c49a78d9f
> ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in mptcp_active_enable().")=
.
> Also to avoid conflicts, and because we are close to the merge windows.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks for the followup!
