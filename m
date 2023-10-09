Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD03717F
	for <mptcp@lists.linux.dev>; Mon,  9 Oct 2023 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andyt.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andyt.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andyt-co.20230601.gappssmtp.com header.i=@andyt-co.20230601.gappssmtp.com header.b="Wi2PuHcz"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-79fa387fb96so204669539f.1
        for <mptcp@lists.linux.dev>; Mon, 09 Oct 2023 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andyt-co.20230601.gappssmtp.com; s=20230601; t=1696865808; x=1697470608; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ky0YFxxlseeo2UV2aregE7Sf+Nv9GyeclZoxbHB+3m4=;
        b=Wi2PuHcz9c12pWWrAq3ChTmO2pJ9IWR/cYuQOU1swWx0e2rltyKUVJB0KCA34rBgo0
         XtD7SuDf2Yg13blnDh9i8AVsSbExT5fHOSMdGbnW31Z9Hgrf7Xnr/a072+ZTZdACNHYm
         io42R4UcDE1p7hJrUaI7VrfgsG8hXjvb7cM5ksVdvJjDacZ6qAEOsPGPLT/tlD1ip+Pd
         iJyAi2qrK39sK1O4tEWvU4pOIG7Plm/SMujUaS6iOCngURekgiv/iCfVJa3q/3QbAsmp
         ZHqquFhyiVgI3cNwcaW69iRsnWzgGVfZPViH7mzWTlC19op0tHm45k5f0g9LBxIdU4mp
         vQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865808; x=1697470608;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ky0YFxxlseeo2UV2aregE7Sf+Nv9GyeclZoxbHB+3m4=;
        b=W1dyHtJyAlIP0Etr80W4+ILj+HnbkZNwmtPsjYEjDhE7fm3Qgs5m+8YtTDqfMKuSgc
         WhcPfbHyS81npPR2sQuRKCNh1y0QsBwQ6EtchwLyW7j2BuihzrSZLZBHbaPn+TQewSrL
         2sQdBIg/8KvYYM3A78wYiRz4kkpK442ncR8gRKGYe2vJGStYB9VQAYDCadEWPDDUM+Og
         F3nzLZQaUdDPvcS8fgBrzBqO6bJgQTUAEtWJtIbtPmdmMzs6aXXXEHd2YUudSTU07YAj
         Vfo9Dp5HYgkLT6mbcAz2sDzxA9Yszwh7S11YGm9SH3h50mKklxNEHbEzeD0inqzzVBOX
         2EOQ==
X-Gm-Message-State: AOJu0YxjoFOv1h4vBBKCchsx7AeOAKeAmDBOkXdaSJ6DmPoGmNEBvyXq
	u3LvuhDDCWnuCyRr0fgWigfehNEXJ3zcSS29RQ5pgIDlxy/rQemKlBE=
X-Google-Smtp-Source: AGHT+IHTNzEtS55VR4j7vc7AkoRUJu1oiX/qP9BNBrstqKcklw3XhsXMieEn69bK34sm80huYv2GY2SQM4tQFBrSV4Y=
X-Received: by 2002:a5e:8f4d:0:b0:791:2db5:c779 with SMTP id
 x13-20020a5e8f4d000000b007912db5c779mr20149392iop.10.1696865807883; Mon, 09
 Oct 2023 08:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Andy Tranter <andy@andyt.co>
Date: Tue, 10 Oct 2023 02:36:36 +1100
Message-ID: <CAGKODjrSDQ8r9_0+Kfskyj0Efx_1XQKMQO7N3LsYn2xhDGCMLQ@mail.gmail.com>
Subject: mptcp - very slow start?
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

I thought I'd give mptcp a go, but I've come across some confusing
test results that I thought I might ask about.

We have 4x residential Starlink connections, and (predictably) I've
had trouble bonding them to make one big connection. But looks like
mptcp might be useful as a basis to eventually create a similar end
result.

I have mptcp working end to end, and can see several established
messages via 'ip mptcp monitor' as soon as the connection is started.
For each test, I see the first connection running at 200-300mbit, but
the other 3 sit at around 8.5kbps. After approx 26-28 seconds they all
suddenly become active, all 4 links are utilized, presumably evenly,
and bandwidth creeps up until I think we're flooding the satellite or
base station and can't go any faster (lol).
But is this 26-28 second delay intentional?
Perhaps something is wrong with my test or environment?
Seems to me that a delay of several rtt before establishing mptcp
makes sense, no point for short lived connections, but 26-28 seconds
seems very particular and rather excessive.

I'm running 6.5.1 (Sept 2nd), so not the absolute latest but it's
pretty new I think. Do you think I need to try newer?
Various tcp options nor cubic vs bbr congestion control seem to make
any difference.

Andy..
