Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CEA3BA23E
	for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132399; cv=pass; b=AB6eXFAdmygBl1NdoILhY5+qgVV+gG48IoDPn2owNWuk5PYsTHabx376d5PJvZ1JeVFtEmBBswfxA+CesOsjSFD6FKEdBZSxlqgrgFVMx5yA8v9YIw7da1kMw6i+SdCjGUqdwqjRusWoEgSQrjMxwmLZgSZ9I9mmzzkaIRa0X28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132399; c=relaxed/simple;
	bh=RszETrACILeYN/zC7YLvxSjKCkmrXHy7cyN9O/Mz3ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWBAkAC+yKtD+Mimjb1a5rRWRdetnt5UYGeQT9Q+6zrv7nGFX+aNiNxdUXUOgGnrrwQ6/P+jz3tvChlAy7SCr0dkWq1fGCkFvpbDWohAG5f31ggNOcDdvlmzxKOgKb9DRzJuxSLWx4fdeWGPR4Oec84PAQjiZb8SuBMd+cGa0Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvgxr2Dc; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvgxr2Dc"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506362ac5f7so115700051cf.1
        for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 01:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773132396; cv=none;
        d=google.com; s=arc-20240605;
        b=T12NDGlRAyzzl3RM2BdAcN+/PKAwFDecbMB+Fe86AVWHiyEFlBdKhdEjpdKGizS8Dx
         KY9nuUjAcq+kU2wYvbsgZYHrxBln9XZDhXlEao1zytGUJp/oCGhG7QNuw9ojF24oT9bU
         VCfwTVn/kc4xgXE6vraC4P9+Mt6NZ9ryWVaaEOq1+ovvouPv7dcTXevZm3hWmXkuecVa
         kTG+gMZY1x3We/3EQq8Dfm8ApumHcl6tt8cUAq4xcKU7cIcuUaixEr93dpXgGlWiqRU1
         AkbHoZBOJ3L9EGsG58I2bDHqdhFLPGpmkBVivFbp00Fbt1V64uQPtczTdvGJimsmwwOo
         ROgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3nEimDqly9kpV/fuktlYtnq2NPSlAX7VPlv+iNqng0A=;
        fh=gwWbWMIuhoz+JBOhDszWANkKfk6i0Vo6rOnLfOvN5HQ=;
        b=Yuap7dOg1FdkCCq8JASXMAP+eOWzRJSDizKDQeN1peLYBtxRRhXfiMsJg8GM2n1+b4
         oKr/yGDhZUvuGOWAg6Z9Z9h2TKtKQs3TKeH9Dwvq52rPXTRmDJPvx9XO5Ms5U96B1TdS
         sg+Z3Tx//vXNRBYLzagQVbw2JQOq96cQFC8X984QU7lQVVOGFlvUZpT2AC/C9LrnEe3d
         dl/qhHES6ugArLsl2mTkXYd8pqk3m6C636siWstepocdPIAXUn0w0saGnQzSEWdj6ncJ
         Pqg1lrgzmRw/LcZ4876MDSfue7vcuG8Rz4g0JGvQUivMCrzTXYo1d47W14frSz/JinS5
         ++iA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773132396; x=1773737196; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nEimDqly9kpV/fuktlYtnq2NPSlAX7VPlv+iNqng0A=;
        b=fvgxr2DcRUggLbugkapr8tAklKWmoe1/chO+V9f75DmiAbeCAN3bzvqJ45CNpaCsIq
         FcPNdjuLGPOgKH0gqToWU1uB9+dVM7c1kipwUNURi+Vpqznrl2CfT0wvTuFHnvSXxMGu
         Lanr0FDb++HpFcLiANSHF3SbVJRBgtbhMDBQ7R4BRgn6M/qcsihLiLo45HmXHa/hjClY
         ZisgcrN5Ax52PNM16pszLg89ygsZjmeNJkKuy8P82MnSvm4qMbfeYYYUTZWmINkpvByO
         uVWawZ3BU++TlYbi3Ph9aKuMksAFUXEnAIHXeXURfkPppagbjf7uCIkWev8YO1zt4qnx
         LkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132396; x=1773737196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3nEimDqly9kpV/fuktlYtnq2NPSlAX7VPlv+iNqng0A=;
        b=FvhTJcIQc91eCQRBlW2L/X6iprWywMQJzFQlffxaZMRrBZ824Jxa9dApHIoNAA8NLO
         jHgutcQ2IdjrTpSRmurEaZMCikSob4L1Lx4MbxUWtSnMCmgBl/DoZ+RnwH0fkdEuBlcD
         ha/O4++6n1c1wG3gTUA9om7Fkzp53eqlWsgrYYBBy+CZ/rwTAuZ8zKBrU1XJBpWYsD83
         8yzkNBmLmiICGHCJDJDElZk4aVGdNqOcY7vpWJu7Cx5PGxC6yu7PTKzehRtigxMJT8Sq
         M1V638Hrvc+JBmPQin5Zl4IWFBlT+hTpMpPI6FafvlxkIz3S5bGlVfd5ByfAwVaZZz7d
         b2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU6g2NPWntgaPkgX2+yFHMffsRDvDErL7z4Tyu40HgvMjhlcmvzR4LeXu0cGch5ZS1NcQ9e+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDUel2TyA+N8hi94mWP/buQikUdjy5icIvEDbgWpcewDuzzJR6
	cLk6o3VHFmsd2RZwiC+7O8MdxM/AgYkUekXWU7LhJLg26Mtt0Xbvlu7Kc0AL8J+FyNvb5vcabaE
	HUkurLQMP1LTqv/DcLjbyMwo7KvJ0sHxRft0o9C9f
X-Gm-Gg: ATEYQzx7OqBqRxx9Y8YE9txi1fHdJcwA1KiqMZR/+/ihlbcAWeCISQP91vikKYRky53
	skvh5yT2uL8DeyBETJ5AMWhjtxi2hX3pvXC7C/ejPh4RsLV3j3ne6+kLSr/Jo/XBRs5v2Jmz8Sc
	VqIQ7hM60FrVrKZyo9N0Xk/L9u5WgXLDbxIpvq3x6CBfqZnp1PfSk0Mb1JSdL9pc26QQ4jjYFbV
	Ki74qkXMcK4+pSZSCPkabaYlxJz+QzmKUwI9zAoMNdtHc/uCl6QN7ZTRr5UI76uGbVTtvFjHNnr
	ishuZ3tNXa7u07l9kw==
X-Received: by 2002:a05:622a:1a84:b0:509:21f6:df9b with SMTP id
 d75a77b69052e-50921f6ea75mr47026791cf.15.1773132395635; Tue, 10 Mar 2026
 01:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com> <20260309-tcp_rfc7323_retract_wnd_rfc-v3-2-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-2-4c7f96b1ec69@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 09:46:24 +0100
X-Gm-Features: AaiRm50AVSa2QQoRJnA4Sp6RmxAkhC4YiZSP7XkFIO_4j9Qiq68pO__J-NefzKc
Message-ID: <CANn89iJU2ejyGSm-OyBeRUNZpdzds6H-bNA8KnR085ekF+W0dw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] mptcp: keep rcv_mwnd_seq in sync with
 subflow rcv_wnd
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 9:03=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> MPTCP shares a receive window across subflows and applies it at the
> subflow level by adjusting each subflow's rcv_wnd when needed.  With
> the new TCP tracking of the maximum advertised window sequence,
> rcv_mwnd_seq must stay consistent with these subflow-level rcv_wnd
> adjustments.
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
