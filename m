Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227B08F4D
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 09:15:07 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-64d57cd373fso279438b3a.1
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 02:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686129307; x=1688721307;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6v7s/455laBVqDVX7jDY5vDBviAadSY6wCRvi1TJLU=;
        b=airIGWRlHAkz5YIuf2GVijOlWwDEwO6gBKZeuSqmFTo2uxj2pjV1fC4aJ4KW+l1qrM
         mZb/ucvh3+HZEr3pPCdrgA9jgOYGLptNWbF3nXjus7+MFa6Zk4pCl8S5E2XlqoTGhl81
         70EIcMMo48ZbJxrLnpUU8radSLl53VfJDFeOXkvgewXzbpZJubM72iyK71LTjXqgso02
         ZhrdNZpz2ty3J7lJJUxF3SpDQfNePq7pvLSbn/Vx3iRId1CmxpVIgSSOf5YKNo+AWA6o
         84zhI0sQBa2j75Us6oFY4gQHFa0Yknq5X3vfUNAb4qmhGD6uktcY7Uf1LYwS8RIfX2yr
         mLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129307; x=1688721307;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6v7s/455laBVqDVX7jDY5vDBviAadSY6wCRvi1TJLU=;
        b=YBfaAMIzY0EFmCLdQ4Tyzl1W0n8qSINt/2hYcqq10jQFREXDBTnnX/2yLjYHitIIqP
         T7JFL0XjXQej2hJJBAw6AhYsPlUM3ybg89WScGO9G52nKaWLj1ZMJzUzNggngsYMupA7
         yEEsDL4o88LMiYyIIFr6MtWEaT0r6isjQQr4ll16w5GLt0sONSLcG6pBA7Zbg0WuvVH2
         Jf+SzecALHHsoGCsQHJbV9BqLKPKjh1rzGBDSo74ZiNdwj1kvL0XA4EpB0VaqU51wbOg
         HPMGsuPWAdIBWvvlJGdG68n/5SIqDTV+NERTiRiV005ebHXJbNvBeqi6M4Q3z8gb5qe6
         2yFg==
X-Gm-Message-State: AC+VfDwDBeidhR2pdhlYdVrnbT6mMpTT2e2OSmfKW+kw4GqwZin/xXtT
	JXbDUWhYH5lwrhr4b33V+w==
X-Google-Smtp-Source: ACHHUZ4g4AHJKzADLjW8zSDyUdhHiJjCt84bRmxbhQWBW1cyKjk6xkMl9L8DdEoivo7+D4pJNhRNxg==
X-Received: by 2002:a05:6a20:72a2:b0:10c:b1b0:3ee3 with SMTP id o34-20020a056a2072a200b0010cb1b03ee3mr2496007pzk.21.1686129307124;
        Wed, 07 Jun 2023 02:15:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.99.66])
        by smtp.gmail.com with ESMTPSA id e11-20020a63544b000000b0051b9e82d6d6sm8609500pgm.40.2023.06.07.02.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:15:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c999814651073121c97f2e5c5f273d6674a6832f.1686127032.git.geliang.tang@suse.com>
References:
 <c999814651073121c97f2e5c5f273d6674a6832f.1686127032.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Build Failure
Message-ID: <d011b906-1401-8324-a66a-33785dcad988@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Jun 2023 09:15:05 +0000
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
org/project/mptcp/patch/c999814651073121c97f2e5c5f273d6674a6832f.1686127032=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5197966593

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/20fcd539d0=
88

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
