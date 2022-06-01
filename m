Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49C362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 06:57:19 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id b4so770398iog.11
        for <mptcp@lists.linux.dev>; Tue, 31 May 2022 23:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=C8eZLl0BFpmpAf2KJUb8O9+JKjiL1U+VNK6skq2e9F4=;
        b=dD5/skgg3HajX+ViDUvkGLtiAWixusL06li5IgyFDPzLpG+0xz12XG3XypRWbj2iot
         +vNOWRo3Zdy3dwz2Zdc+nivzJRljmxpU50ItepAUuQGdj9vEI3rrVljzDfyRMcrGtMDK
         xegkic/m9b/JYwAg0jVGEjKz+q+/vYBltkJI14sGCY67SpUAbJQ+FOUBRKZmkVGzQnFP
         uNjDpDnCI5F7Jd7AQO83rTba4dPK/z7cv0Im3CqmXzvudK6d/gVhhnXoC7aZtXz73UYF
         z1bGNXsFfiMc/iItk7Ha4GvNZLYUKUAfwy3HSt87Csu8R9fts6C1eq6yQwY8KYOo8Vh/
         oFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=C8eZLl0BFpmpAf2KJUb8O9+JKjiL1U+VNK6skq2e9F4=;
        b=coVwir05lbdbVbQ4XbkbYLVkUar4XT0d5SYsZ9jIj61c5Ltkt7mpMwzsaXRETFgmIc
         ClmupXxPa1wxLcbMwh7pYUHq3Sx0ygAvwWIQiUwN1SjW7XebmTA46TETkq8cCpJ1+ief
         7m2QF6/ES7zJ65ydvBmRuMKYroZriKfO6qpjLJPx8nBG0041iajDqIlYouXHviO6tbgy
         Bu3Zuek9LpRIXNuilEVrdQNoQ0/3pkBUUioW4CWimAOFpTycI09JFhI/J94SikN6/lPe
         Cp1Tl1LtEnKdKNzCNkQEfJpfKCh/vr1YD3pxJK4Y4lRL2NyfU5mgNbLaSChiNe1KHV7R
         yG1w==
X-Gm-Message-State: AOAM531MeLa0ClzIpo3icrOKDmlexUnTd+E5l5lYLf0QOeupPxb72i+H
	4rrGk6ULBCJWib8rf45qYXNPUyxGQ8MC
X-Google-Smtp-Source: ABdhPJzG8TGSD3bie2ai05dtugHGRNHml9wfu3naKr2LEA/TvNSkEFqXOwdbwaRxamdPhZ6utcZDxQ==
X-Received: by 2002:a5d:8853:0:b0:668:5b07:6f1f with SMTP id t19-20020a5d8853000000b006685b076f1fmr9490339ios.189.1654066638486;
        Tue, 31 May 2022 23:57:18 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.120.133])
        by smtp.gmail.com with ESMTPSA id y6-20020a5e9206000000b0065a47e16f4bsm200758iop.29.2022.05.31.23.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 23:57:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <076285ed7f05ec809cfb5866c6ff2d6b8cd04e95.1654065674.git.geliang.tang@suse.com>
References:
 <076285ed7f05ec809cfb5866c6ff2d6b8cd04e95.1654065674.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: add bpf_rr test: Build Failure
Message-ID: <9ce30a18-3ba1-c714-a9cc-5c903de01b3c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jun 2022 06:57:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/076285ed7f05ec809cfb5866c6ff2d6b8cd04e95.1654065674=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/2419771412

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/f2e8aeb9dc=
5b

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
