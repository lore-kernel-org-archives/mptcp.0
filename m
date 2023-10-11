Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19F6AAB
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aqhz4Is3"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4053f24c900so41305e9.1
        for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 00:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697009794; x=1697614594; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3lFWh781xYY7UBYZo3gwot3jntiLV0/xMAh/ilRLeU=;
        b=Aqhz4Is3/ZsZrgG+pRsrzSstg/G1hB8N8/F+C3pizELwyiBdUNpn9JYq/eLwtrdokD
         DwLC6W8W4DWE1/I1wPL1nFjClCiImnJoX8KzIxBuZC+tSo2FptYgkWb3v3m4Xt402tHz
         SBt94EI/v07vjWCMkiGkhPXRC/bnE2U4BkAg8FKs1G1wJCpVzZbf89EhHqv3FiTA/Xol
         mzyHXFKT/QwhlfePyWXLHwDpeODd130oGA3UuKsQDwIylIEgtCwyPtbmt6cTZuOgDF6q
         Bn93Ap02Ona/Y4NmoWgPaHyVV0pBmcS/Tqylj4A6F7P4YFP+J9sGIxRdRP6WRSGFhHgN
         tQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697009794; x=1697614594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3lFWh781xYY7UBYZo3gwot3jntiLV0/xMAh/ilRLeU=;
        b=JRzxeYdcGD6nxrRwepAo12gEGHtxM46XB5uBoOy8uACrO29l13q6/SYeNODwhA3eR+
         Rd1FTyy9Va/cWkwj+KoMRjgaL1D/pu+4+Y3oT3UQedt7FH43QUs6p9tfUXOicrk8hz+j
         E+Yd1rlcO3Uk7o/YT4aFtjxuOXNcHoT57lAe0hXTY8Ohaw7syCIJ5J/v74ePQKQIRRwi
         BQoU4Gu39e/IIpoxClE0/iVp+04Ifmv82SrmjWUeKJa3IhlpBaya/KRPYUdyRLqdP5+Q
         TF6SAzitpoMIhyqN0l+Pp4imxUY9kvjvsCUdHYsWghp006KMUx8E0KJrKVYhIr+P9OZ9
         zMVw==
X-Gm-Message-State: AOJu0YxpKa5n1BqALb4WTtnUda/U0PvtBszfxA6ndcq+1cHEFf6V+b9y
	80CA5i4YzGZ+z4+VEHhnDXYYUOEuGqyCcd+vjP8VEw==
X-Google-Smtp-Source: AGHT+IHd1FC12oP8K/bhyPo57fL7dJJP0CmKIJrsD//FTJm0zEPgpb+gDmyCUoIzdC7GE18ieSCxHVGqMhnz6z6GDEA=
X-Received: by 2002:a05:600c:3b9b:b0:400:46db:1bf2 with SMTP id
 n27-20020a05600c3b9b00b0040046db1bf2mr78309wms.2.1697009794407; Wed, 11 Oct
 2023 00:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
In-Reply-To: <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Oct 2023 09:36:21 +0200
Message-ID: <CANn89iL_nbz9Cg1LP6c8amvvGbwBMFRxmtE_b6CF8WyLGt3MnA@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: allow again tcp_disconnect() when threads are waiting
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	mptcp@lists.linux.dev, Boris Pismenny <borisp@nvidia.com>, Tom Deseyn <tdeseyn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 9:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> As reported by Tom, .NET and applications build on top of it rely
> on connect(AF_UNSPEC) to async cancel pending I/O operations on TCP
> socket.
>
> The blamed commit below caused a regression, as such cancellation
> can now fail.
>
> As suggested by Eric, this change addresses the problem explicitly
> causing blocking I/O operation to terminate immediately (with an error)
> when a concurrent disconnect() is executed.
>
> Instead of tracking the number of threads blocked on a given socket,
> track the number of disconnect() issued on such socket. If such counter
> changes after a blocking operation releasing and re-acquiring the socket
> lock, error out the current operation.
>
> Fixes: 4faeee0cf8a5 ("tcp: deny tcp_disconnect() when threads are waiting=
")
> Reported-by: Tom Deseyn <tdeseyn@redhat.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1886305
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !
