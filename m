Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687341ED21
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 10:04:40 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-76ce66110edso53990985a.0
        for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691661879; x=1692266679;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dc8l6t0SwVZYueV7ba7RHfcTLqNCSKGw8t1Sj5AC9k4=;
        b=WriarHda5DlMI7b3d4btyJnuE3HkwFvCKh3lmxJVLUnC9/oLo7rf4OxZyNzr0/Y6yX
         xl6/lmPRV1CKFz6KDxEZOQ7fpBZ9KRqOzHrV1UjGIESJVJ1xgI/do1IzOrmWzmuY1U+I
         JhCR1HVabdJ37x+jvXzG4ksmGf9pYM5S4HJq8vMvS/zXZpvY0HVy5NXW8l/j1fgGgJLm
         AkATe6WB6yM4mh79LWw6vexx319iPWL9epNNCyX6l0Dy2Ia5oXh8lZHYt08rcU/k8Qzt
         j3eJoxEYsBOCi+8qQPzmkTvmrG+8bDlatpRmA0ZIh2ByKdDuq+goPUmLK0HfZj5JOMxj
         Rvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661879; x=1692266679;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dc8l6t0SwVZYueV7ba7RHfcTLqNCSKGw8t1Sj5AC9k4=;
        b=C/MzCbvH7UcU0I8tW/1vz1UHVDVyEYiycfoWbQ3GbsS8OqgM5wRyHGdYZ+HT/OFynx
         6gEOFJ5eKblaWwFjA1doHqGmFzgxunf2thKq4oymc6TXFaK9to1CcZyIV7wq8LJEAwGP
         braBaJz7SpsJXPYsjND4q61GR+YUARE+i8hm9zElW4Jh1ijVKomF0BL1mIfrmCoH2Ltf
         H1b2NpYWbYJFrZnOzujo+O5xHrBtQ4zcbzjcwuzkr9COAJuh7zhaPISVIVOgBJGNBqkS
         QfIsfLHsqmgGwwaHu0qNI0sx1npZGdVi2aZNE/wTlrYVfNOonLs7hzzNUgcQl/QHcE02
         EgDg==
X-Gm-Message-State: AOJu0Yz9q3ixFQcqwsn8EylvyS2X+SaNzp7ZuFNDor/kX1cufquSLgBr
	Py5wVLCbKJUGxCmNJI8A2Q==
X-Google-Smtp-Source: AGHT+IEZqFgPR95ODNRnI/d3JT65b9Tu45KssnDqMCDNfv4ouFas6awDQEHTQt7rBkLbUrc0E8Flpg==
X-Received: by 2002:a05:620a:4484:b0:76c:9eab:41ad with SMTP id x4-20020a05620a448400b0076c9eab41admr2114394qkp.32.1691661879188;
        Thu, 10 Aug 2023 03:04:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.18.214])
        by smtp.gmail.com with ESMTPSA id h5-20020a05620a13e500b007684220a08csm367597qkl.70.2023.08.10.03.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:04:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230809225918.21523-1-kuniyu@amazon.com>
References: <20230809225918.21523-1-kuniyu@amazon.com>
Subject: Re: mptcp: Remove unnecessary test for __mptcp_init_sock().: Build
 Failure
Message-ID: <5f6a198d-ca0a-6325-70bf-1dd68ed2b2cf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Aug 2023 10:04:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20230809225918.21523-1-kuniyu@amazon.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/5819664427

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d9cabde674a5

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
