Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66D187567
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144786; cv=none; b=DXimWZMQgVGzOQz33vTNIkRhRN4+/BRSVpoQcyrdtlaKoMUq05i6Tkn8v3eQmIUDO2EPggqdUKvcRUcFhM2Et8WaCAwsgBeIM16G3vMJ1a9PB+S1IMfbvuGEbuYhEooYbVQzR55FHIRGoNcsA6ZRqAv4v1+DhSZz/nk0VzllUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144786; c=relaxed/simple;
	bh=w2XfFgYkNyPA7kF+exjPtMJwY4LRkbNNvFZLEyfiqt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/aLHvLu3sFeZSybWTvE4vIg1tnVxpqDcN4SSsVnZncw2OO8XXk793py/oUq1YFFi3eZOTMrs6KDJpRfkAjYQoosbW6tuaZFpiguNgxPb54erJMVou9P/0vlGbkkyis4OkEkUX6DT6G0Un2RwsMlQz1UbJVsEozgzmF5Lhhw6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1GzrPi0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1GzrPi0"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a1b122718so5803a12.1
        for <mptcp@lists.linux.dev>; Fri, 31 May 2024 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717144782; x=1717749582; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2XfFgYkNyPA7kF+exjPtMJwY4LRkbNNvFZLEyfiqt8=;
        b=d1GzrPi0ArHW0eDVK6PpOOEuLdduBOhcIhsfZ2xf+4+ZKqRwCxMCrZ8+YYiwXzlsAj
         Ij6QNw9Z7UDXoYQzHYp7hwIWsEn9s7jisfIkyJVTtGB4jY4xuF/+j/EY0Xd8jcchdpCO
         mhhZZ9uWZLwBIdSjRq4cWCcvjMpPxvLbJd0XehVAjtmFY3tX1TEs3H9+sfe57MOONUZo
         biYo7RLuTrmsmj+u5drQohJ9p3vJUCzv+wKGBg8XQeWIEDDZFlPXiglZN/pF6ZcvBfcR
         Lx7HWESDiCN8Oxt8JIXYva7oX4lEifCHkbVDAVqQzvxYTwtB0AigG61c3erp6fS/Hyyc
         5woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144782; x=1717749582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2XfFgYkNyPA7kF+exjPtMJwY4LRkbNNvFZLEyfiqt8=;
        b=AZApqFrrZsgSHuuDdJkKo5nvvD1HGAkX7lO8JQecbbA//GteHtTPrIU1nJymkfbl/v
         zjafHDV11SzYRZDbyznDIOHYVgjcobiT4VqMU8rBDqTtsKQfEQ6d85D2FNxprovd16w8
         D5J8+NuSWJXpnRkiJmWXoOOFzPvB2hNL6aw5ld9kwKM7+YMOhm8PNZumdn/DPHva7u53
         f/pnaL6xXa3NnIzbjsTgKsm+1mze/o/La/2Ud2OPqZgT+uM16V5sZKczX+cIoiC5OyBK
         LTt18+ARP3Tka/3t6mL/jcJyPUBsmkMRWtn0/CvGMW13dqoQIasxsYR9yPRmu2RyrUhn
         9STQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJs/vi7mPzdqxmvMJudJrzTPWjR7DSn530UmF+DWqHxyZJfeYURAwGpadGw2oPo0TGsYLpu/fJliltBusDsYHD4P9+Q3k=
X-Gm-Message-State: AOJu0YxXsSpa72O2a0NScVHc9iQ9j8GWMGj+Q5Ycak71Ta4yyrGz5ZYJ
	1G6DS/PK8b4Mf8JqIU2kss8Rm93FWe4ZKFqcuIgQV/QyxzN5k+1BGgQrwqaFLZ1QWR/Y4/DP/9D
	nYJ+BaXYIWrMhzex2XxiV1gvCMaxtPMLhZCOP
X-Google-Smtp-Source: AGHT+IGlC91skef0biZl0B5CqJE/E+DT3EStbl/d8M0bH8al4aAVUvkkc8cVz+c4T7kFsfNzVxOP5+mW0rVsbqTUJd4=
X-Received: by 2002:aa7:c457:0:b0:57a:1937:e2a4 with SMTP id
 4fb4d7f45d1cf-57a37857d33mr75492a12.3.1717144781580; Fri, 31 May 2024
 01:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240530233616.85897-1-kuba@kernel.org> <20240530233616.85897-3-kuba@kernel.org>
In-Reply-To: <20240530233616.85897-3-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 10:39:30 +0200
Message-ID: <CANn89iLMeZA2BAcCu8Ew6pocifddX3ddGKEZ75Zd=W6YTTcMng@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] tcp: add a helper for setting EOR on tail skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org, 
	borisp@nvidia.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> TLS (and hopefully soon PSP will) use EOR to prevent skbs
> with different decrypted state from getting merged, without
> adding new tests to the skb handling. In both cases once
> the connection switches to an "encrypted" state, all subsequent
> skbs will be encrypted, so a single "EOR fence" is sufficient
> to prevent mixing.
>
> Add a helper for setting the EOR bit, to make this arrangement
> more explicit.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
