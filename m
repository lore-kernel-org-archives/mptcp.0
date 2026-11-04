Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752190;
	b=B7wAFkYybcOoRKGo26Vsyh5fHVGGMcw7GrpngSSWQpN2So/fQLQIAlrrP6oTLngSmXXw
	 z/zKLbXwDXMiHm4qm4KA8nyRg5b9UpHiKyTkYd84ZtKIsJ2DM0KOKFYDpgb5zfEX6tmZk
	 7IxfQOLKdf7rCY6u6BXzDoKG3KW2qg30iGTjeoHeIJyehUhj6tXaxhXeg26tpaHpeGUD+
	 ifoQNez3wPQIt/4hxug5MIShkQ2qk39cNFQiE2hPGH2K1Ky44HyuNRduYCmgocZj9dElk
	 QlYetQggE7wzBsz2wYABz7ZGZVGgPbWnIQwE4y3QVssidX4P6tRvaYOaw/OhBqWPqiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=gLFQSHxO4gGr22ybqjiMEW9byafCmVvekiJO/cKrO1Q=;
	b=NppM/G6nQfM25xFzT0VpjcprK6uCjI7QA9OZH13G71RDQlOxFVbFHxv7euqwvyZiEMVl
	 kZY7LKGnAdHYqVAp7oU+10T82Wqp9a4m94t18Fy7YjfN3iDECximpMbe7zb/c9nEWa5Eg
	 eueg3Cr38m46hik3oCvv0USBt91W7GB3MeeyGc59EvNZdLhPS4JrfZhU8sZRlMMEQlWIQ
	 YSNOp58qy2h17g4tdtyRNksa5EJJsntE+RBSn+X6BGdrGVRohmw7pwAVehvwKMrl13MgD
	 ePZ+CMcdNiDM7XLzJboRKjFsGd3rQSOZg6rZVCfcL7KNHEb6FI4b3oksYkvjlpGM8wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gXec13fM;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EF0606A326
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 00:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22EF0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gXec13fM
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so58445a12.1
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 16:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752189; x=1794356989; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gLFQSHxO4gGr22ybqjiMEW9byafCmVvekiJO/cKrO1Q=;
        b=gXec13fMWshYKyl1ceYxkwQfXsz3FQlyg6ilx/W3eQlMunJd8rjsy3EBRBFFtgSv7C
         0EuG9Qqgwx5cctD9duB5wVeGuMKTbpogMVLfszWqTGbfkITKcscFgGqw92zxnrqbxzEa
         5A5LRB1GD02kGGcNh/fZPMoOhsUdgegesQwT9RJ02pe+xTiGmLGnQPgOu2l/jrlIz85F
         7NweaFahb/SpcLBdFw5mVEbgbS2B3ZyVanWpVMm+K7h8mkVrFDg3YA/jCDqSOnW3vAoh
         G2A6tzHTKlcs8+kYEI1125cmSHSn+0ye1gqMROe1tBB1f3c8MP5apkKhqee7Fjq8eefp
         wsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752189; x=1794356989;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gLFQSHxO4gGr22ybqjiMEW9byafCmVvekiJO/cKrO1Q=;
        b=GDFIencqM9gzJhvnVFgaPQ695YQ4Sb8FFCGFq7TUAhn0uCTWczMBST0xeXsmZO5/51
         zISIkGoz1NoczFD/B09H9zERNCHfOkl0bgVyxvq0cqf41wBv3Ep3m5vikbgzrhv8yYIm
         D9JrXeKtpIRyR0ODbJ3T3HnuNKkCm++xgnvNZmjSzK2CIPv3XrCA5mzFFl3U7D0WSP0E
         /tQ5EG4ZD+upOoSBYVgLenHHszF5VPU7p3ulzjuG3GKO7QIkNkxoLVXqOWAAk9pcuYeR
         vdPtsd9lJh94t4zZXAlhS2MHP6Uju5dnOBJ3iTNXyaFdfXYRtT+5asbVMD50iahYUiZJ
         R/Nw==
X-Forwarded-Encrypted: i=1; AKwUvBy/8WhX93sbXvKNOMguvL492uq0qCovZlcz3B9ug+NHw4oI7DgfLD8sLiQfE3ZjLBBLjXvrJA==@lists.linux.dev
X-Gm-Message-State: APuU4Z91yM36BeLX+sw5+agy6oiwonv4Mf0iNI6gslGW4HNkUJBKazQK
	TkV62viMq9HBhdG3sBjWf+jmTYfnNwFB3C4ZPOsFIqTA8Dhy6xNGOgM9
X-Gm-Gg: AYBFou3O3hAk5SI+jeyzlCkrxH+UtrZvoo5dj0v9V5IkMexPJEXumm+vWQgBww4AAkA
	B7TWFWdBfYP1xKxIyo8cXyN09gTZ/L4dTmOiozAuYUf2NFFu0yz4BdifH31P/LXzloRx/9RB3xJ
	OeM2awTeFhMvJaNlRTrVX6rCihExor5iQAJSAxw00Q0ZMD8h+kR0+MEe/EQXjt20TuNHX57h/b4
	+kdRSFBikZDigstJuGfkoehAUnXevXNJhMStm+7dtzG3IhxI/z83W12YILj4NPu6UiJLdhKCOJn
	eRTJgyjHuoyXNHC4cqeXljne546LBX2gx4bhUpEXoh4EpsY7MmmTfqOtxG7UqUb9OL2GH4OWO5n
	FUzOWCQVlja7+aIy3fGwd9cBEF1zruWHrPVC0crWY8ibCubBBFRkytIaqFxZlLo8RULGbU+UnMw
	tIsy5X5h/wh8hTw/Xyn4ivOEWz3JWgm3yrC+3xUk6YO76P5VdTFbVzEznVbmImWk54IT+kWiqGk
	LoW2y79BmmRNI72GuU3Ne8HMOFE3Is/4gOB+hywbNjEr5h31LgUb5CXnU7AtQhbpzirdbK3B3fn
	A9ct99Xe2YKUktEpJ1vpZ/EutEZ5YJgfMb4/cyoih7scbvYKer1V68EzA17iMDJslorKTxlROL8
	gWwTkpHZka7DMF4U96JMAGOGPyjSqPA712Q==
X-Received: by 2002:a17:90b:2006:b0:3b0:9310:b252 with SMTP id 98e67ed59e1d1-3b09310d1e7mr631008a91.30.1793752189425;
        Tue, 03 Nov 2026 16:29:49 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944ea360sm1208878a91.14.2026.11.03.16.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:29:48 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:29:48 +0000
Message-Id: <DMM02ZEK63KB.3KNTQTKEJD0G3@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 09/15] bpf, sockmap: Check the TCP state in
 recvmsg()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179374188255.488855.9131092470801455035@kernel.org>
References: <20261102072112.4160195-10-alexei.starovoitov@gmail.com> <179374188255.488855.9131092470801455035@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 01:38 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
> Would it help to mention this path, and that TCP_LISTEN is covered as
> well, in the commit message?

Not worth a respin.

> Should data that arrived on an earlier connection be kept out of the
> copied_seq update too, and not only out of __tcp_cleanup_rbuf()?

yeah. It's an old bug, not from this patch.
msg->sk == sk says that the data is from this socket. It doesn't say
from which connection.
To hit it the app has to call connect(AF_UNSPEC) and connect() with
unread data on the psock.
