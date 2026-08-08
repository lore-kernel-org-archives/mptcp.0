Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F415A86D
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 04:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786164715; cv=none; b=lkw/os3jPJE6OWtt1qXqhnK7thsX+kJgyWZWYizQELTePYtIDEJr+wCJCPpe1OtiWq3EYXNftt6avEnV8LfwgPfaTyiFcXa6dChhWG0r9K/VMi8Iqf/wEzy7gEuqQjzrG8pqWmqVs/P+LvQSzakDhVzON6SadlJCDDS5nwbD8Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786164715; c=relaxed/simple;
	bh=vkGko7RzYVWtbCOC3kUbv4YiBpZJJZAD0hHWMjR5pmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=SI7FtSgaoXh37QFoVSQa+ApG/p89vNx3tJEYsdqjVaPmLYCat8JPH3WHVAFt/UdVwje6hbYlb/dhr0z9R9njuiWHLApHUCxXE+SO/3UezcAj7nLcoeAy9Zz4EPTK32fqXneeVdins6x4kAYrZ2nkTR2THntRkJ1PD6eEnLO4SyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoNjffLL; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoNjffLL"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8143daf89c7so1890017b3.1
        for <mptcp@lists.linux.dev>; Fri, 07 Aug 2026 21:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786164713; x=1786769513; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xSgwilliFj/GesTvnvEiyLtniqGsVbGSIUL8e8ykhCk=;
        b=eoNjffLLyCfT1O2cRu36UVP0Re75ZgpzaCnsGJqB6/dltj0BNAmAiGCVVrrhbZ9Ldt
         p2E0YCFgEiRbBt3Buf9areskzq6VsrU9vAlQiZ5UqetN2wr515hmXkGhSNaVZfSSolOY
         n6PkVfGxWTM1BNIgjqT5nrCIZ9XV5/5GOnl2PIuQSuQB6fUBkVdImPr/mJxE/kqf079Z
         I6UaLG12CR8iVfXP+Nne2luChdZ6qU0qWmqnfTjmYSD8uDqOCcyLw5JS/qXhZYzWNors
         3S81UJMzgaAeMF8IM160N5HR110MOcV2PvlXb0+BEO7tMdjhj5vXJ+cQBSodRHKpkHqe
         Pyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786164713; x=1786769513;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xSgwilliFj/GesTvnvEiyLtniqGsVbGSIUL8e8ykhCk=;
        b=bXwH/YYL+YCXk5vYNIF/HSxVxhqRdt/7AhGiRNyDpjE0+JZiY9h9zBGDZe6pqU6yDb
         gdPSX8pl0SNo3YWKfnKNgofWjesSZ1xEDq/R/alhHEmSmKHVOSxOYq3KTgvq1h+I9ahE
         1VbTlku84d9q2Ggrh4HKy/hRmJxZeCbjcX2nO3Z1lrJYXYY+WwueqkFXCfc/Zu1j5RKV
         gzlv9ckbTTEcVf189VKlt0CrAvboJJfy8KUcGjC9bqqoaGZI2YGCdyxa+EY+NP0WWoLA
         Rnhp810ytVAQf8VskWFlL9qpXN2dRePyP+hYHHplXC9Dvjbv+UX8PxVwf5hBbRvZEqVS
         KZ4w==
X-Gm-Message-State: AOJu0YyFmXH5vYeTtHmQXQ8jj+Bi0kBI0WrBrpiFS6cx9mri1iD0df8f
	Wmeegr5VUo0tjFzX257qJqGQ9z54Pma/vDRsLhKvoYXSPsSrFZ/WUY+cS3bK
X-Gm-Gg: AR+sD10Op/qH0cM/ZZEy1cO+TE1zQ8FodJJNh7OMiKYNm/v1NrkOt1SGRVP9JPacAyp
	rGg8PuAz4pxJY5GmVNXdHMQkPLhl8jnsi1ZZDTiK6f0KDTbehsLKEJH+96b7ngPH7TGB1uWM71K
	d797u/T+dQwLxdIo/0xNxkbKwK5XHbpmuRO4vZrC++6j5FDw0B4/wAiBlIQ6k7hfQcdrzDcLCzA
	tTDrpmpsTnHYDH1TGbPem36wIrGv0K0gQfAll+5ufSoLCwCVHvHiw4vvKFQWVCzIHqqcCohVosw
	0KY0PXL/7g377pp65sOklB/8xZBW7TO/mhdXw0xiisYyH7Z6gj6vfWdzHMKXvmCH9MJG9C/YXDo
	WM6bOvdh3vwrG0ctgv1olBxuVROqszHgceznX7zNO0801os6YlRztEprjaE1/7+uULx723v6veT
	T3TgVWOAijw6hfiQ02sS+JF39bPEnJYDySsJKdEW8VFfP7NmyMcR3c0Opuf107GZigpmlZyNCZB
	Wg=
X-Received: by 2002:a05:690c:a94:b0:7f2:9d64:9943 with SMTP id 00721157ae682-8225ba2bf7emr82595357b3.23.1786164712818;
        Fri, 07 Aug 2026 21:51:52 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f6a0f824sm21419197b3.42.2026.08.07.21.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 21:51:52 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1786159812.git.tanggeliang@kylinos.cn>
References: <cover.1786159812.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 00/11] Fix socket options used by NVMe
 over MPTCP
Message-ID: <e1ecd957-8baf-cfdd-41ec-164972e8ddb3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 04:51:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/312384=
27573

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b9ff91daca52
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1142524


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
